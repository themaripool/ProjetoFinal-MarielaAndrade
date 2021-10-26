import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final _notification = FlutterLocalNotificationsPlugin();

//SOm customizado -> https://youtu.be/X3tAGnGc_t0?t=313

Future _notificationDetails() async {
  return NotificationDetails(
    android: AndroidNotificationDetails('channel id', 'channel name',
        importance: Importance.max, 
        playSound: true),
    iOS: IOSNotificationDetails(presentSound: true),
  );
}

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future showNotification({
    int id = 0,
    String title,
    String body,
    String payload,
  }) async =>
      _notifications.show(id, title, body, await _notificationDetails(),
          payload: payload);

  static Future init({bool initSchedule = false}) async {
    final android = AndroidInitializationSettings('app_icon_not');
    final ios = IOSInitializationSettings();
    final settings = InitializationSettings(android: android, iOS: ios, macOS: null);

    await _notification.initialize(
      settings,
      onSelectNotification:
          (payload) async {}, // no clique da notificacao executa isso
    );
  }
}
