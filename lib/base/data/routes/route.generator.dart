part of "../data.dart";

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case AppRoutes.onboardingPage:
        return MaterialPageRoute(builder: (_) => const OnboadingPage());
      case AppRoutes.noInternePage:
        return MaterialPageRoute(builder: (_) => const NoInternetPage());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case AppRoutes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPassword());
      case AppRoutes.otpVerification:
        return MaterialPageRoute(builder: (_) => const OTPVerification());
      case AppRoutes.resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPassword());
      case AppRoutes.editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfile());
      case AppRoutes.myPackages:
        return MaterialPageRoute(builder: (_) => const MyPackages());
      case AppRoutes.tabs:
        return MaterialPageRoute(builder: (_) => const TabsPage());

      // activities
      case AppRoutes.createPackage:
        return MaterialPageRoute(builder: (_) => const CreatePackage());
      case AppRoutes.createTrip:
        return MaterialPageRoute(builder: (_) => const CreateTrip());
      case AppRoutes.tripDetails:
        return MaterialPageRoute(builder: (_) => const TripDetails());
      case AppRoutes.packageDetails:
        return MaterialPageRoute(builder: (_) => const PackageDetails());
      case AppRoutes.rateShipmentPage:
        return MaterialPageRoute(builder: (_) => const RateShipmentPage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: TextVariation(text: "Invalid Route"),
        ),
      );
    });
  }
}
