import 'dart:async';
import 'dart:io';

import 'package:bio_trap/controller/language_controller.dart';
import 'package:bio_trap/controller/theme_controller.dart';
import 'package:bio_trap/helper/local_notification.dart';
import 'package:bio_trap/model/body/fcm_model.dart';
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
import 'package:get/get.dart';

import 'helper/get_di.dart' as di;

NotificationService notificationService = NotificationService();

Future<void> messageHandler(RemoteMessage message) async {
  print(message.data);
  FcmModel notificationMessage =
      FcmModel.fromJson(message.data);
  notificationService.showNotification(
    1,
    notificationMessage.title!,
    notificationMessage.message!,
  );
  print('notification from background : ${notificationMessage.title}');
}

Future<void> firebaseMessagingListener() async {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    print(message.data);

    FcmModel notificationMessage =
        FcmModel.fromJson(message.data);
    notificationService.showNotification(
      1,
      notificationMessage.title!,
      notificationMessage.message!,
    );
  });
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
      ((X509Certificate cert, String host, int port) {
        final isValidHost =
        ["192.168.1.22"].contains(host); // <-- allow only hosts in array
        return isValidHost;
      });
  }
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await notificationService.init();
  await Firebase.initializeApp();
 var token= await FirebaseMessaging.instance.getToken();
 print(token);
  HttpOverrides.global = MyHttpOverrides();

  firebaseMessagingListener();
  Map<String, Map<String, String>> languages = await di.init();
  FirebaseMessaging.onBackgroundMessage(messageHandler);
  runApp(MyApp(
    languages: languages,
  ));
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
