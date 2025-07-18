import 'package:flutter/material.dart';
import 'package:portalixmx_visitor_app/features/login_page.dart';
import 'package:portalixmx_visitor_app/features/provider/tab_change_provider.dart';
import 'package:portalixmx_visitor_app/res/app_colors.dart';
import 'package:portalixmx_visitor_app/res/app_constants.dart';
import 'package:provider/provider.dart';
import 'features/provider/locale_provider.dart';
import 'package:portalixmx_visitor_app/generated/app_localizations.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=> TabChangeProvider()),
    ChangeNotifierProvider(create: (_)=> LocaleProvider()),
  ], child: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    return MaterialApp(
        title: AppConstants.appTitle,
        locale: provider.locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
            fontFamily: AppConstants.appFontFamily,
            colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
            scaffoldBackgroundColor: AppColors.primaryColor,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: AppColors.primaryColor,)
        ),
        home: LoginPage()
    );
  }
}