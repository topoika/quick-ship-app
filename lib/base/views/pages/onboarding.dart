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
      title: "Discover and Engage with Talent Globally",
      description:
          "Access global talent pool find the right fit and streamline your hiring process.",
      imageUrl: AppStrings.onBoarding1,
    ),
    const OnboadingItem(
      title: "Showcase Your Opportunities",
      description:
          "Create a standout profile to attract top talent. Showcase your culture, open roles, and what makes your team unique. ",
      imageUrl: AppStrings.onBoarding2,
    ),
    const OnboadingItem(
      title: "More Affordable than Traditional Hiring",
      description:
          "Streamline hiring and cut costs on ads, long cycles, and agency fees. Find candidates faster and cheaper.",
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
                        setState(() => currentIndex = 2);
                        controller.jumpToPage(2);
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
                        Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.signUp,
                        );
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
