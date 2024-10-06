part of "../pages.dart";

void homeSysSettings() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    homeSysSettings();
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<UserStatsBloc>().add(FetchUserStats());
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: context.height * 0.265,
                    width: context.width,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 10,
                      left: context.horPad,
                      right: context.horPad,
                    ),
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                                image: activeUser.value.image != null
                                    ? DecorationImage(
                                        image: NetworkImage(
                                            activeUser.value.image!),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                              ),
                              child: activeUser.value.image == null
                                  ? const Icon(
                                      Icons.person,
                                      size: 30,
                                    )
                                  : const SizedBox(),
                            ),
                            SizedBox(width: context.width * 0.02),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextVariation(
                                    text: greetUser(),
                                    color: Colors.white,
                                    size: 12,
                                    weight: FontWeight.w400,
                                  ),
                                  TextVariation(
                                    text: activeUser.value.name ?? "Daud David",
                                    color: Colors.white,
                                    size: 14,
                                    weight: FontWeight.w700,
                                  ),
                                ],
                              ),
                            ),
                            Stack(
                              children: [
                                const Icon(
                                  Icons.notifications,
                                  color: Colors.white,
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    height: 8,
                                    width: 8,
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: context.height * 0.025),
                        const TextVariation(
                          text: "What task are you",
                          color: Colors.white,
                          size: 14,
                          weight: FontWeight.w500,
                        ),
                        const TextVariation(
                          text: "perfoming today?",
                          color: Colors.white,
                          size: 24,
                          weight: FontWeight.w600,
                        ),
                        SizedBox(height: context.height * 0.025),
                        const TasksWidget(),
                      ],
                    ),
                  ),
                ],
              ),
              const JoinComminityWidget(),
              const HomeStatsWidget(),
              const InviteFriendsWidget(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.horPad),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextVariation(
                      text: "Recent Activities",
                      size: 16,
                      weight: FontWeight.w600,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return ShipmentItemWidget(shipment: Shipment());
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String greetUser() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning 🌞";
    } else if (hour < 17) {
      return "Good Afternoon 🌤";
    } else {
      return "Good Evening 🌙";
    }
  }
}
