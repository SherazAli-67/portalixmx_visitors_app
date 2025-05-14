import 'package:flutter/material.dart';
import 'package:portalixmx_visitor_app/login_page.dart';
import 'package:portalixmx_visitor_app/res/app_colors.dart';
import 'package:portalixmx_visitor_app/res/app_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: AppConstants.appTitle,
        theme: ThemeData(
            fontFamily: AppConstants.appFontFamily,
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
            scaffoldBackgroundColor: AppColors.primaryColor,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: AppColors.primaryColor,

            )
        ),
        home: LoginPage()
    );
  }
}