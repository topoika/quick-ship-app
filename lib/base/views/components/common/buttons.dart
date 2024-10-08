// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "../components.dart";

class PrimaryButton extends StatelessWidget {
  final String text;
  final String? icon;
  final bool loading;
  final bool disabled;
  final Function onPressed;
  const PrimaryButton({
    super.key,
    required this.text,
    this.icon,
    this.loading = false,
    this.disabled = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!disabled && !loading) onPressed();
      },
      child: Container(
        width: double.maxFinite,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        decoration: BoxDecoration(
          color: context.primaryColor.withOpacity(disabled ? 0.7 : 1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: loading
            ? const Padding(
                padding: EdgeInsets.all(7),
                child: CupertinoActivityIndicator(
                  color: Colors.white,
                  radius: 13,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextVariation(
                  text: text,
                  color: Colors.white,
                  size: 14,
                  weight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}

class PrimaryButtonUnfilled extends StatelessWidget {
  final String text;
  final String? icon;
  final bool loading;
  final bool disabled;
  final Function onPressed;
  final Color? color;
  const PrimaryButtonUnfilled({
    super.key,
    required this.text,
    this.icon,
    this.color,
    this.loading = false,
    this.disabled = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!disabled && !loading) onPressed();
      },
      child: Container(
        width: double.maxFinite,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: color ?? Colors.black, width: 1.5),
        ),
        child: loading
            ? Padding(
                padding: const EdgeInsets.all(7),
                child: CupertinoActivityIndicator(
                  color: context.primaryColor,
                  radius: 13,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextVariation(
                  text: text,
                  color: color ?? Colors.black,
                  size: 14,
                  weight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}

class TextButtonWidget extends StatelessWidget {
  final String text;
  final bool underlined;
  final Function onPressed;
  final bool? loading;
  final TextAlign? textAlign;
  final FontWeight fontWeight;

  const TextButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.underlined = false,
    this.loading,
    this.textAlign = TextAlign.left,
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      splashColor: Colors.transparent,
      child: Stack(
        children: [
          Text(
            text,
            textScaler: TextScaler.noScaling,
            textAlign: textAlign,
            style: TextStyle(
              color: context.primaryColor,
              fontWeight: fontWeight,
              fontSize: 12.5,
            ),
          ),
          if (underlined)
            Positioned(
              bottom: -0.3,
              left: 0,
              right: 0,
              child: Container(
                height: 1.2,
                color: context.primaryColor,
              ),
            ),
        ],
      ),
    );
  }
}

class NotificationButton extends StatelessWidget {
  final Color? color;
  const NotificationButton({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    List<int> readNotifications =
        context.watch<DetailsItemCubit>().viewedNotification;
    List<AppNotifications> notifications = context
            .read<NotificationBloc>()
            .state is NotificationsLoadedAppDataState
        ? (context.read<NotificationBloc>().state
                as NotificationsLoadedAppDataState)
            .notifications
        : [];
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.notifications);
      },
      child: Stack(
        children: [
          Icon(
            Icons.notifications,
            color: color ?? Colors.black,
          ),
          Visibility(
            visible:
                notifications.any((n) => !readNotifications.contains(n.id)),
            child: Positioned(
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
          ),
        ],
      ),
    );
  }
}
