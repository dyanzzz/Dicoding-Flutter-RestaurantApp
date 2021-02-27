import 'package:dicoding_restaurant_app/preferences/preferences_helper.dart';
import 'package:flutter/material.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({@required this.preferencesHelper}) {
    //_getTheme();
    _getDailyNotifRestaurantPreferences();
  }

  /*bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;*/

  bool _isDailyNotifRestaurantActive = false;
  bool get isDailyNotifRestaurantActive => _isDailyNotifRestaurantActive;

  /*void _getTheme() async {
    _isDarkTheme = await preferencesHelper.isDarkTheme;
    notifyListeners();
  }*/

  void _getDailyNotifRestaurantPreferences() async {
    _isDailyNotifRestaurantActive =
        await preferencesHelper.isDailyNotifRestaurantActive;
    notifyListeners();
  }

  /*void enableDarkTheme(bool value) {
    preferencesHelper.setDarkTheme(value);
    _getTheme();
  }*/

  void enableDailyNotifRestaurant(bool value) {
    preferencesHelper.setDailyNotifRestaurant(value);
    _getDailyNotifRestaurantPreferences();
  }

  //ThemeData get themeData => _isDarkTheme ? darkTheme : lightTheme;
}
