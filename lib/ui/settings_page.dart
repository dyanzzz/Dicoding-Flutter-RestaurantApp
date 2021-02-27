import 'dart:io';

import 'package:dicoding_restaurant_app/common/utils.dart';
import 'package:dicoding_restaurant_app/provider/preferences_provider.dart';
import 'package:dicoding_restaurant_app/provider/scheduling_provider.dart';
import 'package:dicoding_restaurant_app/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  Widget _buildWidget(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return Material(
          child: ListTile(
            title: Text('Scheduling Notif Restaurant'),
            trailing: Consumer<SchedulingProvider>(
              builder: (context, scheduled, _) {
                return Switch.adaptive(
                  value: provider.isDailyNotifRestaurantActive,
                  onChanged: (value) async {
                    if (Platform.isIOS) {
                      //customDialog(context);
                    } else {
                      scheduled.scheduledNotifRestaurant(value);
                      provider.enableDailyNotifRestaurant(value);
                    }
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConfig.setting),
      ),
      body: _buildWidget(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(AppConfig.setting),
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
