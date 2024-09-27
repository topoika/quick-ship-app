import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'base/data/data.dart';
import 'base/data/provider/export.provider.dart';
import 'base/views/pages/pages.dart';

void main() async {
  await Storage.init();
  SytemStyle.init();
  runApp(const MyApp());
}

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
        themeMode: ThemeMode.light,
        onGenerateRoute: RouteGenerator.generateRoute,
        home: const OnboadingPage(),
      ),
    );
  }
}
