import 'package:flutter/material.dart';

import 'base/data/data.dart';
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
    return MaterialApp(
      title: AppStrings.appName,
      theme: lightTheme,
      home: const OnboadingPage(),
    );
  }
}
