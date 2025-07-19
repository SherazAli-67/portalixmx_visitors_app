import 'package:flutter/material.dart';
import 'package:portalixmx_visitor_app/features/login_page.dart';
import 'package:portalixmx_visitor_app/providers/auth_provider.dart';
import 'package:portalixmx_visitor_app/providers/profile_provider.dart';
import 'package:portalixmx_visitor_app/res/app_colors.dart';
import 'package:portalixmx_visitor_app/res/app_constants.dart';
import 'package:provider/provider.dart';
import 'package:portalixmx_visitor_app/generated/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/main_menu/main_menu_page.dart';
import 'providers/locale_provider.dart';
import 'providers/tab_change_provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=> TabChangeProvider()),
    ChangeNotifierProvider(create: (_)=> LocaleProvider()),
    ChangeNotifierProvider(create: (_)=> AuthProvider()),
    ChangeNotifierProvider(create: (_)=> ProfileProvider()),
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
        home: FutureBuilder(future: _isLoggedIn(), builder: (ctx, snapshot){
          if(snapshot.hasData && snapshot.requireData){
            return MainMenuPage();
          }
          return LoginPage();
        })
    );
  }

  Future<bool> _isLoggedIn()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isLoggedIn = sharedPreferences.getBool('isLoggedIn') ?? false;

    return isLoggedIn;
  }
}