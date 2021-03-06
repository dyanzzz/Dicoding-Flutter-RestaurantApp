import 'dart:io';

import 'package:dicoding_restaurant_app/common/utils.dart';
import 'package:dicoding_restaurant_app/ui/favorites_page.dart';
import 'package:dicoding_restaurant_app/ui/restaurant_detail_page.dart';
import 'package:dicoding_restaurant_app/ui/restaurant_list_page.dart';
import 'package:dicoding_restaurant_app/ui/settings_page.dart';
import 'package:dicoding_restaurant_app/utils/background_service.dart';
import 'package:dicoding_restaurant_app/utils/notification_helper.dart';
import 'package:dicoding_restaurant_app/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  int _bottomNavIndex = 0;

  List<Widget> _listWidget = [
    RestaurantListPage(),
    FavoritesPage(),
    SettingsPage(),
  ];

  List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Platform.isIOS ? CupertinoIcons.home : Icons.restaurant,
      ),
      title: Text(AppConfig.restaurant),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Platform.isIOS ? CupertinoIcons.heart_solid : Icons.favorite,
      ),
      title: Text(AppConfig.favorite),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Platform.isIOS ? CupertinoIcons.settings : Icons.settings,
      ),
      title: Text(AppConfig.setting),
    ),
  ];

  @override
  void initState() {
    super.initState();

    port.listen((message) async {
      await _service.someTask();
    });
    _notificationHelper.configureSelectNotificationSubject(
        RestaurantDetailPage.routeName, context);
  }

  @override
  void dispose() {
    super.dispose();
    selectNotificationSubject.close();
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavBarItems,
        currentIndex: _bottomNavIndex,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: _bottomNavBarItems,
      ),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
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
