import 'package:assigment/screen/view/home_page_view.dart';
import 'package:flutter/material.dart';
import 'core/init/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assigment',
      theme: AppTheme.instance.theme,
      home: const HomePageView(),
    );
  }
}
