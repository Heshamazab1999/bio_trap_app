import 'package:bio_trap/routes/app_route.dart';
import 'package:bio_trap/view/screens/add_trap/add_trap_screen.dart';
import 'package:bio_trap/view/screens/auth/sign_in_screen.dart';
import 'package:bio_trap/view/screens/home/home_screen.dart';
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
    ),
    GetPage(
      name: AppRoute.signIn,
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: AppRoute.homeScreen,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: AppRoute.trapScreen,
      page: () => const TrapManagementScreen(),
    ),
    GetPage(
      name: AppRoute.updateTrapScreen,
      page: () => const UpdateTrapScreen(),
    ),
    GetPage(
      name: AppRoute.yourTrapScreen,
      page: () => const YourTrapScreen(),
    ),
    GetPage(
      name: AppRoute.usersScreen,
      page: () => const UsersScreen(),
    ),
    GetPage(
      name: AppRoute.trapDetailsScreen,
      page: () => const TrapDetailsScreen(),
    ),
    GetPage(
      name: AppRoute.AddTrapScreen,
      page: () => const AddTrapScreen(),
    ),
  ];
}
