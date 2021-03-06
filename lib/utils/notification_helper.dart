import 'dart:convert';
import 'dart:math';

import 'package:dicoding_restaurant_app/common/navigation.dart';
import 'package:dicoding_restaurant_app/data/model/list_restaurant_result.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant.dart';
import 'package:dicoding_restaurant_app/provider/restaurant_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  //event awal notifikasi
  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      if (payload != null) {
        print('notification payload : ' + payload);
      }

      selectNotificationSubject.add(payload);
    });
  }

  //event ketika muncul notifikasi
  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      ListRestaurantResult listRestaurantResult) async {
    int valueRandom = listRestaurantResult.restaurants.length;
    final rand = Random().nextInt(valueRandom - 1);

    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "restaurant channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDescription,
        importance: Importance.Max,
        priority: Priority.High,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    var titleNotifications = "<b>Recomendation restaurant for you</b>";
    var titleRestaurant = listRestaurantResult.restaurants[rand].name;

    var randomRestaurant = listRestaurantResult.restaurants[rand];
    List<Restaurant> newList = [randomRestaurant];
    ListRestaurantResult newResult = ListRestaurantResult(
        count: 1, error: false, message: 'success', restaurants: newList);

    await flutterLocalNotificationsPlugin.show(
        0, titleNotifications, titleRestaurant, platformChannelSpecifics,
        payload: json.encode(newResult.toJson()));
  }

  //event ketika notif di klik
  void configureSelectNotificationSubject(String route, BuildContext context) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = ListRestaurantResult.fromJson(json.decode(payload));
        var restaurant = data.restaurants[0];

        Provider.of<RestaurantProvider>(context, listen: false)
            .getRestaurantsById(restaurant.id);

        Navigation.intentWithData(route, restaurant);
      },
    );
  }
}
