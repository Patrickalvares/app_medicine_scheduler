import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future initialize() async {
    var androidInitialze =
        const AndroidInitializationSettings('mipmap/ic_launcher');

    var initializationSettings =
        InitializationSettings(android: androidInitialze);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future showNotification(FlutterLocalNotificationsPlugin fln,
      {var id = 0,
      required String title,
      required String body,
      var payload}) async {
    AndroidNotificationDetails androidPlataformChannelSpecifics =
        const AndroidNotificationDetails(
            'Medicine_app_channel', 'Medicine_app_channel2',
            playSound: false,
            importance: Importance.max,
            priority: Priority.high);

    var not = NotificationDetails(android: androidPlataformChannelSpecifics);
    await fln.show(0, title, body, not);
  }
}
