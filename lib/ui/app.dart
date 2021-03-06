import 'package:dicoding_restaurant_app/common/navigation.dart';

import '../common/styles.dart';
import '../common/utils.dart';
import '../ui/restaurant_detail_page.dart';
import '../ui/splash_screen_page.dart';

import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      navigatorKey: navigatorKey,
      initialRoute: SplashScreenPage.routeName,
      routes: {
        SplashScreenPage.routeName: (context) => SplashScreenPage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              restaurant: ModalRoute.of(context).settings.arguments,
            ),
      },
    );
  }
}
