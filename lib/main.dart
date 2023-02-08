import 'dart:async';
import 'package:bio_trap/controller/language_controller.dart';
import 'package:bio_trap/controller/theme_controller.dart';
import 'package:bio_trap/helper/cache_helper.dart';
import 'package:bio_trap/helper/dio_integration.dart';
import 'package:bio_trap/helper/local_notification.dart';
import 'package:bio_trap/model/body/notification_model.dart';
import 'package:bio_trap/routes/app_route.dart';
import 'package:bio_trap/routes/app_screen.dart';
import 'package:bio_trap/theme/dark_theme.dart';
import 'package:bio_trap/theme/light_theme.dart';
import 'package:bio_trap/util/app_constants.dart';
import 'package:bio_trap/util/messages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:workmanager/workmanager.dart';
import 'helper/get_di.dart' as di;
import 'view/screens/users/services/user_services.dart';

NotificationService notificationService = NotificationService();

Future<void> messageHandler(RemoteMessage message) async {
  NotificationModel notificationMessage =
      NotificationModel.fromJson(message.data);
  notificationService.showNotification(
    1,
    notificationMessage.title!,
    notificationMessage.message!,
  );
  print('notification from background : ${notificationMessage.title}');
}

Future<void> firebaseMessagingListener() async {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    NotificationModel notificationMessage =
        NotificationModel.fromJson(message.data);
    notificationService.showNotification(
      1,
      notificationMessage.title!,
      notificationMessage.message!,
    );
  });
}

calculateDistance() async {
  FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();
  var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
  var settings = InitializationSettings(
    android: android,
  );
  flip.initialize(settings);
  await CacheHelper.init();
  String time = await CacheHelper.getData(key: AppConstants.expireOn) ?? "";
  String token = await CacheHelper.getData(key: AppConstants.token) ?? "";
  print(token);
  print(time);
  print("time");
  double distanceInMeters =
      Geolocator.distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);
  print(distanceInMeters);
  if (time.isEmpty) {
    _showNotificationWithDefaultSound(flip);
    print("Empty time");
  } else {
    FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();
    var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var settings = InitializationSettings(
      android: android,
    );
    flip.initialize(settings);
    _showNotificationWithDefaultSound(flip);
    var output = DateFormat('MMMM d y , hh:mm a');
    var input = DateTime.parse(CacheHelper.getData(key: AppConstants.expireOn));
    print(output.format(input));
    final date2 = DateTime.now();
    final difference = input.difference(date2).inHours;
    print(difference);
    if (difference > 0) {
      DioUtilNew.setDioAgain();
      final services = UserService();
      services.getAllTraps();
      FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();
      var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
      var settings = InitializationSettings(
        android: android,
      );
      flip.initialize(settings);
      _showNotificationWithDefaultSound(flip);
    } else if (difference <= 0) {
      CacheHelper.removeData(key: AppConstants.token);
      CacheHelper.removeData(key: AppConstants.expireOn);
      Get.toNamed(AppRoute.signIn);
      DioUtilNew.setDioAgain();
    }
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await notificationService.init();
  await Firebase.initializeApp();
  firebaseMessagingListener();
  Map<String, Map<String, String>> languages = await di.init();
  FirebaseMessaging.onBackgroundMessage(messageHandler);
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  runApp(MyApp(
    languages: languages,
  ));
  await Workmanager().registerPeriodicTask(
    "2",
    "simplePeriodicTask",
    frequency: const Duration(minutes: 15),
  );
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    calculateDistance();
    // FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();
    // var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
    // var settings = InitializationSettings(
    //   android: android,
    // );
    // flip.initialize(settings);
    // _showNotificationWithDefaultSound(flip);
    return Future.value(true);
  });
}

calculateDistanceTrap() {
  double distanceInMeters =
      Geolocator.distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);
  print(distanceInMeters);

  notificationService.showNotification(
    1,
    "title",
    "body",
  );
}

Future _showNotificationWithDefaultSound(flip) async {
  var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    importance: Importance.max,
    priority: Priority.high,
    category: AndroidNotificationCategory.alarm,
  );
  var platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  await flip.show(
      0,
      'GeeksforGeeks',
      'Your are one step away to connect with GeeksforGeeks',
      platformChannelSpecifics,
      payload: 'Default_Sound');
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>>? languages;

  const MyApp({Key? key, this.languages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocalizationController>(builder: (localizeController) {
      return GetBuilder<ThemeController>(builder: (themeController) {
        return GetMaterialApp(
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          navigatorKey: Get.key,
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
          ),
          theme: themeController.darkTheme ? dark : light,
          locale: localizeController.locale,
          translations: Messages(languages: languages!),
          fallbackLocale: Locale(AppConstants.languages[0].languageCode!,
              AppConstants.languages[0].countryCode!),
// initialRoute: GetPlatform.isWeb ? RouteHelper.getInitialRoute() : RouteHelper.getSplashRoute(orderID),
          getPages: AppScreen.screen,
          initialRoute: AppRoute.splashScreen,
          defaultTransition: Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),
        );
      });
    });
  }
}
// Isolate.spawn(_isolateMain, rootIsolateToken);
// RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
// void _isolateMain(RootIsolateToken rootIsolateToken) async {
//   // Register the background isolate with the root isolate.
//   BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
//   // You can now use the shared_preferences plugin.
//   Timer.periodic(const Duration(seconds: 15), (timer) {
//     print(rootIsolateToken.toString());
//   });
// }
