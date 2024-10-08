part of "../pages.dart";

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextVariation(
          text: "Chats",
          size: 15,
          weight: FontWeight.w600,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.horPad),
            child: const NotificationButton(),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: ChatFunctions().getConversations(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            List<Conversation> chats = snapshot.data?.docs.map((dynamic doc) {
                  return Conversation.fromMap(doc.data());
                }).toList() ??
                [];
            return chats.isEmpty
                ? const Center(
                    child: ErrorNoDataWidget(
                    type: "nodata",
                    message: "No chats available",
                  ))
                : ListView.builder(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 10)
                            .copyWith(bottom: 50),
                    itemCount: chats.length,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final chat = chats[index];
                      // final otherUser = chat.participants!
                      //     .firstWhere((i) => i.id != activeUser.value.id);
                      return ChatTileItem(chat: chat);
                    },
                  );
          } else {
            return const ListLoadingWidget(itemCount: 10);
          }
        },
      ),
    );
  }
}

Widget chatItem(BuildContext context, Message message, first) {
  bool mine = message.sendBy == activeUser.value.id;
  return Column(
    crossAxisAlignment:
        mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    children: [
      Visibility(
        visible: first,
        child: Center(
          child: Container(
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
            decoration: mainBoxDecoration()
                .copyWith(color: Colors.grey.withOpacity(.5)),
            child: TextVariation(
              text: getDateString(DateTime.parse(
                  message.createdAt ?? DateTime.now().toString())),
              size: 13,
              weight: FontWeight.w500,
              opacity: 0.8,
            ),
          ),
        ),
      ),
      Visibility(
        visible: message.type == "message",
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          constraints: BoxConstraints(
            maxWidth: context.width * .6,
            minWidth: 50,
          ),
          padding: const EdgeInsets.all(15),
          decoration: mine
              ? BoxDecoration(
                  color: context.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 0.5,
                      blurRadius: 5,
                      offset: const Offset(0, 1),
                    ),
                  ],
                )
              : mainBoxDecoration(),
          child: TextVariation(
            text: message.text ?? "",
            size: 13,
            weight: FontWeight.w500,
            color: mine ? Colors.white : Colors.black,
            opacity: .8,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: TextVariation(
          text: getTimeOnly(message.createdAt ?? DateTime.now().toString()),
          size: 12,
          weight: FontWeight.w500,
          opacity: .8,
        ),
      ),
      const SizedBox(height: 5),
    ],
  );
}

BoxDecoration mainBoxDecoration() => BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.4),
          spreadRadius: 0.5,
          blurRadius: 5,
          offset: const Offset(0, 1),
        ),
      ],
    );
