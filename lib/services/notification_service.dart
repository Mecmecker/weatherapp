import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:weatherapp/models/models.dart';

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
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    //Initialization Settings for iOS
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );

    //InitializationSettings for initializing settings for both platforms (Android & iOS)
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  NotificationDetails platformChannelSpecifics = const NotificationDetails(
    android: AndroidNotificationDetails(
      'channel ID',
      'channel name',
      channelDescription: 'channel description',
      playSound: true,
      priority: Priority.high,
      importance: Importance.high,
    ),
    iOS: IOSNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: false,
        badgeNumber: 0),
  );

  Future<void> showNotifications(OneCallResponse tiempo) async {
    String body = tiempo.localizacion!.locality! +
        '   '
            '${tiempo.current.temp.round()}' +
        ' ºC';
    await flutterLocalNotificationsPlugin.show(
      0,
      body,
      tiempo.current.weather[0].description.toUpperCase() +
          '  ' +
          'Prob Lluvia '
              '${(tiempo.current.pop ?? 0) * 100}%',
      platformChannelSpecifics,
      payload: 'Notification Payload',
    );
  }
}
