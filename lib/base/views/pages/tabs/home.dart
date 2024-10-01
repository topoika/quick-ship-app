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
      body: SingleChildScrollView(
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
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 30,
                            ),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.horPad),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextVariation(
                    text: "Statistics",
                    size: 16,
                    weight: FontWeight.w600,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: context.primaryColor.withOpacity(.09),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            HomeStatItem(
                              txt: "Available for withdrawal",
                              stat: formatCurrency(value: 12000),
                            ),
                            HomeStatItem(
                              txt: "Total earnings",
                              stat: formatCurrency(value: 20000),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            HomeStatItem(
                              txt: "Active orders",
                              stat: "2",
                            ),
                            HomeStatItem(
                              txt: "Complete orders",
                              stat: "24",
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const InviteFriendsWidget(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.horPad),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TextVariation(
                    text: "Recent Orders",
                    size: 16,
                    weight: FontWeight.w600,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: context.primaryColor.withOpacity(.09),
                              spreadRadius: .4,
                              blurRadius: .5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Text("Home"),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
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
