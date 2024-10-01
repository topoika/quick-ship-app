part of "./pages.dart";

class OnboadingPage extends StatefulWidget {
  const OnboadingPage({super.key});

  @override
  State<OnboadingPage> createState() => _OnboadingPageState();
}

class _OnboadingPageState extends State<OnboadingPage> {
  int currentIndex = 0;
  PageController controller = PageController();
  List pages = [
    const OnboadingItem(
      title: "Ship Packages from Anywhere",
      description:
          "Easily send packages from your location to any destination. Fast and reliable shipping at your fingertips.",
      imageUrl: AppStrings.onBoarding1,
    ),
    const OnboadingItem(
      title: "Track Your Shipment in Real-Time",
      description:
          "Get real-time updates on the status of your package. Know exactly where your shipment is at any moment.",
      imageUrl: AppStrings.onBoarding2,
    ),
    const OnboadingItem(
      title: "Connect with Shippers and Postmen",
      description:
          "Use in-app messaging to interact with shippers and postmen. Communicate seamlessly to ensure smooth deliveries.",
      imageUrl: AppStrings.onBoarding3,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: context.horPad, vertical: 18),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Visibility(
                    visible: currentIndex != 2,
                    child: TextButtonWidget(
                      text: "Skip",
                      textAlign: TextAlign.end,
                      onPressed: () {
                        Storage.saveData("opened", true);
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.login);
                      },
                    ),
                  ),
                ],
              ),
              Expanded(
                child: PageView.builder(
                  controller: controller,
                  itemCount: pages.length,
                  onPageChanged: (index) =>
                      setState(() => currentIndex = index),
                  itemBuilder: (context, index) => pages[index],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [0, 1, 2].map((i) {
                  bool active = i == currentIndex;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: context.width * 0.12,
                    height: 6,
                    decoration: BoxDecoration(
                      color: active ? context.primaryColor : Colors.grey[300],
                      borderRadius: BorderRadius.circular(100),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      if (currentIndex == 2) {
                        Storage.saveData("opened", true);
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.login);
                      } else {
                        controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: context.primaryColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const QImage(
                        imageUrl: AppStrings.arrowRight,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboadingItem extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  const OnboadingItem({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        QImage(
          imageUrl: imageUrl,
        ),
        const SizedBox(height: 60),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: TextVariation(
            text: title,
            align: TextAlign.center,
            size: 17,
            weight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: TextVariation(
            text: description,
            align: TextAlign.center,
            size: 13.5,
            weight: FontWeight.w400,
            opacity: 0.8,
          ),
        ),
      ],
    );
  }
}
