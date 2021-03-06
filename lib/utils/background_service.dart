import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../data/api/api_service.dart';
import '../main.dart';
import '../utils/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService _service;
  static String _isolateName = 'isolate';
  static SendPort _uiSendPort;

  BackgroundService._createObject() {
    _service = this;
  }

  factory BackgroundService() => _service ?? BackgroundService._createObject();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  static Future<void> callback() async {
    print('Alarm Fired');
    await DotEnv().load('.env');

    final NotificationHelper _notificationHelper = NotificationHelper();
    var result = await ApiService().listRestaurants();
    await _notificationHelper.showNotification(
      flutterLocalNotificationsPlugin,
      result,
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  Future<void> someTask() async {
    print('Execute some process');
  }
}
