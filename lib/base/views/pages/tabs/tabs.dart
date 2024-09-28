part of "../pages.dart";

class TabsPage extends StatelessWidget {
  final int? active;
  const TabsPage({super.key, this.active});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SettingsPage(),
    );
  }
}
