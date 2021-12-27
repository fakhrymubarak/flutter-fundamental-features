import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  //Singleton pattern
  static final NotificationService _notificationService =
  NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  //instance of FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    //Initialization Settings for Android
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    //InitializationSettings for initializing settings for both platforms (Android & iOS)
    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  // Future selectNotification(String payload) async {
  //   await Navigator.push(
  //     context,
  //     MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
  //   );
  // }

  Future<void> showNotifications() async {
    AndroidNotificationDetails _androidNotificationDetails =
    const AndroidNotificationDetails(
      '0',
      'regular notification',
      playSound: true,
      priority: Priority.high,
      importance: Importance.high,
    );

    NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: _androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Regular Notification',
      'This is the Notification Body',
      platformChannelSpecifics,
      payload: 'Notification Payload',
    );
  }

}

class PushNotificationService {
  final FirebaseMessaging _fcm;

  PushNotificationService(this._fcm);

  Future initialise() async {
    String? token = await _fcm.getToken();
    print("FirebaseMessaging token: $token");
  }
}
