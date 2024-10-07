part of "../components.dart";

class NotificationItem extends StatelessWidget {
  final AppNotifications notification;

  const NotificationItem({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (notification.type == "order") {
          context.read<MyOrderBloc>().add(FetchOrders());
          Navigator.pushNamed(context, AppRoutes.myOrders);
        } else {
          context
              .read<PackageRequestDetailsBloc>()
              .add(FetchPackageRequestDetailsEvent(id: notification.itemId!));
          context.read<DetailsItemCubit>().setRequestId(notification.itemId!);
          Navigator.pushNamed(context, AppRoutes.orderRequestPage);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        margin: const EdgeInsets.symmetric(vertical: 9),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: context.primaryColor.withOpacity(.08),
              ),
              child: QImage(
                imageUrl: notification.type == "order"
                    ? AppStrings.orderIcon
                    : AppStrings.requestIcon,
                height: 28,
                width: 28,
                radius: 5,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextVariation(
                    text: notification.title!,
                    size: 13,
                    weight: FontWeight.w600,
                  ),
                  TextVariation(
                    text: notification.body!,
                    size: 10,
                    weight: FontWeight.w500,
                    opacity: .7,
                  ),
                ],
              ),
            ),
            TextVariation(
              text: getTimeAgo(DateTime.parse(notification.createdAt!)),
              size: 10,
              weight: FontWeight.w500,
              color: Colors.grey[800],
            ),
          ],
        ),
      ),
    );
  }
}
