import 'package:dicoding_restaurant_app/ui/restaurant_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../widgets/platform_widget.dart';

class SplashScreenPage extends StatefulWidget {
  static const routeName = '/splash_screen';

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          return RestaurantListPage();
        }),
      );
    });
  }

  Widget _buildWidget(BuildContext context) {
    final logo = Container(
      height: 350.0,
      width: 450.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/meal.png'),
          fit: BoxFit.cover,
        ),
      ),
    );

    return Center(child: logo);
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildWidget(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Restaurant MantApp Ios"),
        transitionBetweenRoutes: false,
      ),
      child: _buildWidget(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
