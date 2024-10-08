part of "../pages.dart";

class ConversationPage extends StatefulWidget {
  final bool isFromNotification;
  const ConversationPage({super.key, required this.isFromNotification});

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  TextEditingController textMsg = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // cubits
    final watchChat = context.watch<ChatCubit>();
    final updateChat = context.read<ChatCubit>();
    User otherUser = watchChat.otherUser ?? User();
    Conversation convo = watchChat.conversation ?? Conversation();
    String mgs = watchChat.message ?? "";

    // controller for chats
    ChatFunctions controller = ChatFunctions();
    return WillPopScope(
      onWillPop: () async {
        if (widget.isFromNotification) {
          context.read<NavigatorCubit>().setIndex(3);
          Navigator.pushReplacementNamed(context, AppRoutes.tabs);
        } else {
          Navigator.pop(context);
        }
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: commonAppBar(
          context: context,
          title: otherUser.name ?? "",
          onBack: () {
            if (widget.isFromNotification) {
              context.read<NavigatorCubit>().setIndex(3);

              Navigator.pushReplacementNamed(context, AppRoutes.tabs);
            } else {
              Navigator.pop(context);
            }
          },
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 15)
              .copyWith(top: 0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: convo.id != null
                    ? StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: controller.getMessageStream(convo.id ?? ""),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          List<Message> messages =
                              snapshot.data?.docs.map((dynamic doc) {
                                    return Message.fromMap(doc.data());
                                  }).toList() ??
                                  [];
                          messages.sort((a, b) => (b.createdAt ??
                                  DateTime.now().toString())
                              .compareTo(
                                  a.createdAt ?? DateTime.now().toString()));
                          return ListView.builder(
                            itemCount: messages.length,
                            shrinkWrap: true,
                            reverse: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (ct, i) {
                              final message = messages[i];
                              final prevMessage = messages[
                                  (i == messages.length - 1 ? i : i + 1)];
                              bool showDate = isDifferentDay(
                                  DateTime.parse(message.createdAt ??
                                      DateTime.now().toString()),
                                  DateTime.parse(prevMessage.createdAt ??
                                      DateTime.now().toString()));
                              return chatItem(ct, message, showDate);
                            },
                          );
                        },
                      )
                    : const SizedBox(),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: mainBoxDecoration(),
                child: Row(
                  children: <Widget>[
                    // Transform.rotate(
                    //   angle: 70,
                    //   child: const Icon(
                    //     Icons.attach_file_outlined,
                    //   ),
                    // ),
                    Expanded(
                      child: MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(textScaler: const TextScaler.linear(1.0)),
                        child: TextFormField(
                          controller: textMsg,
                          onChanged: (val) => updateChat.setMessage(val),
                          style: inputTextStyle(context: context),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText:
                                "Write ${convo.id != null ? "a" : "a new"} message",
                            hintStyle: hintTextStyle(context: context),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: mgs.trim().isNotEmpty,
                      child: InkWell(
                        onTap: () async {
                          Message message = Message(
                            text: mgs,
                            sendBy: activeUser.value.id,
                            type: "message",
                          );
                          convo.lastMessage = mgs;
                          if (convo.id == null) {
                            convo.id = conversationId(otherUser.id!);
                            message.convoId = convo.id;
                            convo.involved = [
                              activeUser.value.id!,
                              otherUser.id!
                            ];
                            convo.participants = [activeUser.value, otherUser];
                            showCustomToast(
                                message: "Creating new conversation",
                                type: "suc");
                            await controller.createConvo(convo, message).then(
                              (value) {
                                textMsg.clear();
                                updateChat.setConversation(value);
                                updateChat.setMessage("");
                                context.read<NotificationBloc>().add(
                                    SendNotification(
                                        notification:
                                            controller.getNotification(
                                                message, otherUser.id!)));
                              },
                            );
                          } else {
                            message.convoId = convo.id;
                            textMsg.clear();
                            await controller.addMessage(convo, message);
                            updateChat.setMessage("");
                            context.read<NotificationBloc>().add(
                                SendNotification(
                                    notification: controller.getNotification(
                                        message, otherUser.id!)));
                          }
                        },
                        splashColor: Colors.transparent,
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: context.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            AppStrings.sendIcon,
                            height: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool isDifferentDay(DateTime dateTime1, DateTime dateTime2) {
    if (dateTime1 == dateTime2) return true;
    return (dateTime2.day - dateTime1.day) < 0;
  }
}
