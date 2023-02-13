import 'package:bio_trap/routes/app_route.dart';
import 'package:bio_trap/view/screens/add_trap/add_trap_screen.dart';
import 'package:bio_trap/view/screens/auth/sign_in_screen.dart';
import 'package:bio_trap/view/screens/home/home_screen.dart';
import 'package:bio_trap/view/screens/notification/notification_screen.dart';
import 'package:bio_trap/view/screens/splash/splash_screen.dart';
import 'package:bio_trap/view/screens/trap_details/trap_details_screen.dart';
import 'package:bio_trap/view/screens/trap_management/trap_management_screen.dart';
import 'package:bio_trap/view/screens/update_trap/update_trap_screen.dart';
import 'package:bio_trap/view/screens/users/users_screen.dart';
import 'package:bio_trap/view/screens/your_traps/your_traps_screen.dart';
import 'package:get/get.dart';

class AppScreen {
  static final screen = [
    GetPage(
      name: AppRoute.splashScreen,
      page: () => const SplashScreen(),
        transition: Transition.leftToRight
    ),
    GetPage(
      name: AppRoute.signIn,
      page: () => const SignInScreen(),
        transition: Transition.leftToRight
    ),
    GetPage(
      name: AppRoute.homeScreen,
      page: () => const HomeScreen(),
        transition: Transition.leftToRight
    ),
    GetPage(
      name: AppRoute.trapScreen,
      page: () => const TrapManagementScreen(),
        transition: Transition.leftToRight
    ),
    GetPage(
      name: AppRoute.updateTrapScreen,
      page: () => const UpdateTrapScreen(),
        transition: Transition.leftToRight
    ),
    GetPage(
      name: AppRoute.yourTrapScreen,
      page: () => const YourTrapScreen(),
        transition: Transition.leftToRight
    ),
    GetPage(
      name: AppRoute.usersScreen,
      page: () => const UsersScreen(),
        transition: Transition.leftToRight
    ),
    GetPage(
      name: AppRoute.trapDetailsScreen,
      page: () => const TrapDetailsScreen(),
        transition: Transition.leftToRight
    ),
    GetPage(
      name: AppRoute.addTrapScreen,
      page: () => const AddTrapScreen(),

        transition: Transition.leftToRight
    ),
    GetPage(
      name: AppRoute.notificationScreen,
      page: () => const NotificationScreen(),
        transition: Transition.leftToRight
    ),
  ];
}
