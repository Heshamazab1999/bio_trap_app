import 'package:bio_trap/routes/app_route.dart';
import 'package:bio_trap/view/screens/auth/sign_in_screen.dart';
import 'package:bio_trap/view/screens/home/home_screen.dart';
import 'package:bio_trap/view/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

class AppScreen {
  static final screen = [
    GetPage(
      name: AppRoute.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: AppRoute.signIn,
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: AppRoute.homeScreen,
      page: () => const HomeScreen(),
    ),
  ];
}
