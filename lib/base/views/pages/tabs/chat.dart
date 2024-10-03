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
      body: Center(
        child: ErrorNoDataWidget(
          type: "no-data",
          message: "No chats",
          onRetry: () {},
        ),
      ),
    );
  }
}
