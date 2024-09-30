// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "../components.dart";

class TasksWidget extends StatelessWidget {
  const TasksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
              onTap: () {
                // set trip to a new trip on trip cubit
                Navigator.pushNamed(context, AppRoutes.createTrip);
              },
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: context.primaryColor.withOpacity(.12),
                      shape: BoxShape.circle,
                    ),
                    child: const QImage(
                      imageUrl: AppStrings.itanaryIcon,
                      height: 25,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const TextVariation(
                    text: "Post a Trip",
                    size: 13,
                    weight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 90,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: VerticalDivider(
                    color: context.primaryColor,
                    thickness: 1.4,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Icon(Icons.radio_button_on_rounded,
                      color: context.primaryColor, size: 17),
                ),
                Expanded(
                  child: VerticalDivider(
                    color: context.primaryColor,
                    thickness: 1.4,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () {
                // set package to a new trip on package cubit
                Navigator.pushNamed(context, AppRoutes.createPackage);
              },
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: context.primaryColor.withOpacity(.12),
                      shape: BoxShape.circle,
                    ),
                    child: QImage(
                      imageUrl: AppStrings.boxIcon,
                      color: context.primaryColor,
                      height: 25,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const TextVariation(
                    text: "Post a Package",
                    size: 13,
                    weight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HomeStatItem extends StatelessWidget {
  final String txt;
  final String stat;
  const HomeStatItem({
    super.key,
    required this.txt,
    required this.stat,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextVariation(
            text: txt,
            color: Colors.grey,
            size: 12,
            weight: FontWeight.w500,
          ),
          TextVariation(
            text: stat,
            color: context.primaryColor,
            size: 18,
            weight: FontWeight.w700,
          )
        ],
      ),
    );
  }
}
