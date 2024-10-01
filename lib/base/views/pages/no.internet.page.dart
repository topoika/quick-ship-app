part of "./pages.dart";

class NoInternetPage extends StatelessWidget {
  final dynamic onRetry;
  const NoInternetPage({super.key, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Image.asset(
            AppStrings.noWifiImage,
            width: 75,
            height: 75,
          ),
          const SizedBox(height: 15),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 70),
            child: TextVariation(
              text:
                  "No internet connection. Please check your connection and try again.",
              align: TextAlign.center,
              weight: FontWeight.w500,
            ),
          ),
          if (onRetry != null)
            TextButton(
              onPressed: () => onRetry!(),
              child: Text(
                "Retry",
                textAlign: TextAlign.center,
                textScaler: TextScaler.noScaling,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    ));
  }
}
