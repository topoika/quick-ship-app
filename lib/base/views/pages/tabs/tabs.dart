part of "../pages.dart";

class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    int index = context.watch<NavigatorCubit>().state;
    return Scaffold(
      body: buildBody(index),
      bottomNavigationBar: MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1)),
        child: BottomNavigationBar(
          currentIndex: index,
          type: BottomNavigationBarType.fixed,
          onTap: (int val) => context.read<NavigatorCubit>().setIndex(val),
          backgroundColor: Colors.white,
          elevation: 5,
          selectedItemColor: context.primaryColor,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
          items: [
            buildBottomNavigationBarItem(
              context: context,
              icon: AppStrings.homeIcon,
              activeIcon: AppStrings.homeActive,
              label: 'Home',
            ),
            buildBottomNavigationBarItem(
              context: context,
              icon: AppStrings.tripIcon,
              activeIcon: AppStrings.tripActive,
              label: 'Trips',
            ),
            buildBottomNavigationBarItem(
              context: context,
              icon: AppStrings.shipmentIcon,
              activeIcon: AppStrings.shipmentActive,
              label: 'Shipments',
            ),
            buildBottomNavigationBarItem(
              context: context,
              icon: AppStrings.chatIcon,
              activeIcon: AppStrings.chatActive,
              label: 'Chat',
            ),
            buildBottomNavigationBarItem(
              context: context,
              icon: AppStrings.userIcon,
              activeIcon: AppStrings.userActive,
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem({
    required BuildContext context,
    required String icon,
    required String activeIcon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      activeIcon: Image.asset(
        activeIcon,
        height: 27,
        color: context.primaryColor,
      ),
      icon: QImage(
        imageUrl: icon,
        height: 27,
      ),
      label: label,
    );
  }

  Widget buildBody(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const SettingsPage();
      case 2:
        return const SettingsPage();
      case 3:
        return const ChatsPage();
      case 4:
        return const SettingsPage();
      default:
        return Center(
          child: Text(
            'Welcome Home ${activeUser.value.name}\n${activeUser.value.email}',
            textScaleFactor: 1,
            textAlign: TextAlign.center,
          ),
        );
    }
  }
}
