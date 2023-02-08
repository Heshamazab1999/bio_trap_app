import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static const channelId = "1";

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationDetails _androidNotificationDetails =
      AndroidNotificationDetails(channelId, "test",
          channelDescription:
              "This channel is responsible for all the local notifications",
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          audioAttributesUsage: AudioAttributesUsage.alarm,
          enableLights: true,
          visibility: NotificationVisibility.public,
          sound: UriAndroidNotificationSound("assets/tunes/Notification.mp3"),
          icon: '@mipmap/ic_launcher');

  // static const IOSNotificationDetails _iosInitializationSetting=IOSNotificationDetails();

  final NotificationDetails notificationDetails = const NotificationDetails(
    android: _androidNotificationDetails,
    // iOS: DarwinNotificationDetails(
    //   presentAlert: true,
    //   presentSound: true,
    //   presentBadge: true,
    // ),
  );

  Future<void> init() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    // IOSInitializationSettings iosInitializationSettings =
    //     const IOSInitializationSettings(
    //   requestAlertPermission: true,
    //   requestBadgePermission: true,
    //   requestSoundPermission: true,
    // );
    InitializationSettings initializationSettings =
        const InitializationSettings(
      android: androidInitializationSettings,
      // iOS: iosInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future<void> requestIOSPermissions() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> showNotification(
    int id,
    String title,
    String body,
  ) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: 'Default_Sound',
    );
  }
}
