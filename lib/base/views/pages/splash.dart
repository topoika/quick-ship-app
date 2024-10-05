part of "pages.dart";

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _initializeData(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoaded) {
              getUserData(context: context);
              _navigateBasedOnStorage(context);
            } else if (state is AuthError) {
              if (state.message.contains("internet connection")) {
                Navigator.pushReplacementNamed(context, AppRoutes.noInternePage,
                    arguments: () {
                  context.read<AuthBloc>().add(GetAuthUser());
                });
              } else {
                if (state.message.contains("User not found")) {
                  Storage.deleteData("authToken");
                }
                _navigateBasedOnStorage(context);
              }
            }
          },
        ),
      ],
      child: _buildSplashScreen(context),
    );
  }

  void _navigateBasedOnStorage(BuildContext context) {
    final bool hasOpenedBefore = Storage.getData("opened") != null;
    String routeName = AppRoutes.login;
    if (!hasOpenedBefore) {
      routeName = AppRoutes.onboardingPage;
    }
    if (context.read<AuthBloc>().state is AuthLoaded) {
      routeName = AppRoutes.tabs;
    }
    Navigator.pushReplacementNamed(context, routeName, arguments: 0);
  }

  void _initializeData(BuildContext context) {
    // get initial data
  }

  Widget _buildSplashScreen(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QImage(
              imageUrl: AppStrings.logoSquare,
              height: 300,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
            ),
            SizedBox(height: 20),
            TextVariation(
              text: "Loading...",
            ),
          ],
        ),
      ),
    );
  }
}

void getUserData({required BuildContext context}) {
  context.read<TripBloc>().add(FetchUserTripsEvent());
  context.read<PackageBloc>().add(FetchUserPackages());
}
