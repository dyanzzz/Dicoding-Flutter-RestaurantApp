import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({@required this.sharedPreferences});

  //dark theme

  /*static const DARK_THEME = 'DARK_THEME';

  Future<bool> get isDarkTheme async {
    final prefs = await sharedPreferences;
    return prefs.getBool(DARK_THEME) ?? false;
  }

  void setDarkTheme(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(DARK_THEME, value);
  }*/

  //daily notification restaurant

  static const DAILY_NOTIF_RESTAURANT = 'DAILY_NOTIF_RESTAURANT';

  Future<bool> get isDailyNotifRestaurantActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(DAILY_NOTIF_RESTAURANT) ?? false;
  }

  void setDailyNotifRestaurant(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(DAILY_NOTIF_RESTAURANT, value);
  }
}
