part of "../data.dart";

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const OnboadingPage());
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
      case AppRoutes.tabs:
        return MaterialPageRoute(
            builder: (_) => TabsPage(active: args as int?));

      // activities
      case AppRoutes.createPackage:
        return MaterialPageRoute(builder: (_) => const CreatePackage());
      case AppRoutes.createTrip:
        return MaterialPageRoute(builder: (_) => const CreateTrip());
      case AppRoutes.tripDetails:
        return MaterialPageRoute(builder: (_) => const TripDetails());
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
