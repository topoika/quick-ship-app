part of "../pages.dart";

class ChatsPage extends StatelessWidget {
  const ChatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title'),
      ),
      body: Center(
        child: ErrorNoDataWidget(
          type: "error",
          message: "No chats",
          onRetry: () {},
        ),
      ),
    );
  }
}
