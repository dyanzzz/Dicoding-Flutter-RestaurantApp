import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/ui/restaurant_detail_page.dart';
import 'package:dicoding_restaurant_app/ui/restaurant_list_page.dart';
import 'package:dicoding_restaurant_app/ui/splash_screen_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: primaryColor,
          accentColor: secondaryColor,
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: myTextTheme,
          appBarTheme: AppBarTheme(
              textTheme: myTextTheme.apply(
                bodyColor: Colors.white,
              ),
              elevation: 0),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedItemColor: secondaryColor,
              unselectedItemColor: Colors.grey),
          buttonTheme: ButtonThemeData(
              buttonColor: secondaryColor,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0))))),
      initialRoute: SplashScreenPage.routeName,
      routes: {
        SplashScreenPage.routeName: (context) => SplashScreenPage(),
        RestaurantListPage.routeName: (context) => RestaurantListPage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
            restaurant: ModalRoute.of(context).settings.arguments),
      },
    );
  }
}
