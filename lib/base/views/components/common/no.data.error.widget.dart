part of "../components.dart";

class ErrorNoDataWidget extends StatelessWidget {
  final String type;
  final String message;
  final Function? onRetry;
  const ErrorNoDataWidget({
    super.key,
    required this.type,
    required this.message,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Image.asset(
            type == "error" ? AppStrings.errorImage : AppStrings.noData,
            width: 75,
            height: 75,
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: Text(
              message,
              textAlign: TextAlign.center,
              textScaler: TextScaler.noScaling,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          if (onRetry != null)
            TextButton(
              onPressed: () => onRetry!(),
              child: Text(
                "Try Again",
                textAlign: TextAlign.center,
                textScaler: TextScaler.noScaling,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
