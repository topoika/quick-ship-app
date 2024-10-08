import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_ship_app/firebase_options.dart';

import 'base/data/data.dart';
import 'base/data/provider/export.provider.dart';
import 'base/views/pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Storage.init();
  SytemStyle.init();
  await Firebase.initializeApp(
      name: 'quick-ship', options: DefaultFirebaseOptions.currentPlatform);
  await NotificationService.requestPermission();
  await FirebaseMessaging.instance.getInitialMessage();
  await NotificationService.initializePlugin();
  await NotificationService().setupFCMListeners();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProvider(context: context),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        theme: lightTheme,
        navigatorKey: navigatorKey,
        themeMode: ThemeMode.light,
        onGenerateRoute: RouteGenerator.generateRoute,
        home: const SplashScreen(),
      ),
    );
  }
}
