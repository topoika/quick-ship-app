part of "../components.dart";

class ChatTileItem extends StatelessWidget {
  final Conversation chat;
  const ChatTileItem({
    super.key,
    required this.chat,
  });

  @override
  Widget build(BuildContext context) {
    User me = activeUser.value;
    User otherUser =
        chat.participants!.firstWhere((i) => i.id != activeUser.value.id);
    List<dynamic> myUnread = chat.unreadMessages[me.id.toString()];
    return InkWell(
      onTap: () {
        context.read<ChatCubit>().setConversation(chat);
        context.read<ChatCubit>().setOtherUser(otherUser);
        Navigator.pushNamed(context, AppRoutes.conversationPage,
            arguments: false);
        ChatFunctions().clearUnreadMessages(chat);
      },
      splashColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom:
                BorderSide(width: 1.3, color: Colors.black.withOpacity(.03)),
          ),
        ),
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: .6, color: context.primaryColor),
                image: DecorationImage(
                    image: NetworkImage(otherUser.image != null
                        ? "${otherUser.image}"
                        : "https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png"),
                    fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextVariation(
                    text: otherUser.name ?? "",
                    size: 15,
                    weight: FontWeight.w600,
                  ),
                  const SizedBox(height: 5),
                  TextVariation(
                    text: chat.lastMessage ?? "",
                    size: 12,
                    weight: FontWeight.w500,
                    opacity: .6,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextVariation(
                  text: getTimeAgo(DateTime.parse(
                      chat.updatedAt ?? DateTime.now().toString())),
                  size: 13,
                  weight: FontWeight.w500,
                  color: context.primaryColor,
                ),
                Visibility(
                    visible: myUnread.isNotEmpty,
                    child: Container(
                      height: 20,
                      width: 20,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: TextVariation(
                        text: myUnread.length.toString(),
                        size: 10,
                        weight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
