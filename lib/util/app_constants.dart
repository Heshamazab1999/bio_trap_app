import 'package:bio_trap/util/images.dart';

import '../model/response/language_model.dart';

class AppConstants {
  static const String appName = 'Bio Trap';

 // static const String baseUrl = 'https://192.168.1.22:7259/api';

   static const String baseUrl = 'https://apps.sa-counter.com/api';
  static const String login = '/Account/Login';
  static const String getAllUser = '/Account/GetAllUsers';
  static const String getAllTraps = '/Traps/GetAllTraps';
  static const String updateUser = '/Account/UpdateUser/';
  static const String addUser = '/Account/AddUser';
  static const String deleteUser = '/Account/DeleteUser/';
  static const String changePassword = '/Account/ChangePassword';
  static const String getTrap = '/Traps/GetTrap/';
  static const String updateTrap = '/Traps/EditTrap/';
  static const String addTrap = '/Traps/AddTrap';
  static const String getTrapReading = '/Traps/GetTrapReadings/';
  static const String deleteTrap = '/Traps/DeleteTrap/';
  static const String lastReadTrap = '/Traps/GetLastReadForTrap/';
  static const String searchTrap = '/Traps/GetTrapReadingsGroupedByDayNew/';
  static const String getAllNotification = '/GetAllCurrentUserNotifications';

  // Shared Key
  static const String theme = 'theme';
  static const String expireOn = 'expireOn';
  static const String role = 'role';
  static const String length = 'length';
  static const String token = 'multivendor_token';
  static const String countryCode = 'country_code';
  static const String superAdmin = 'SuperAdmin';
  static const String languageCode = 'language_code';
  static const String counterFan = "Counter Fan";
  static const String scheduleCounter = "View Schedule Counter";
  static const String valveQut = "Valve Qut : ";
  static const String working = "Working";
  static const String oN = "ON";
  static const String off = "OFF";
  static const String lastReadingDate = "Last Reading Date :";
  static const String lastReadingTime = "Last Reading Time :";
  static const String time = "00:00";
  static const String co2 = "Co2 Cylinder : ";
  static const String fixedPercent = "0.0%";
  static const String scheduleFan = "View Schedule Fan";
  static const String scheduleValQut = "View Schedule Val Qut";
  static const String fixedDouble = "0.0";
  static const String fixedDate = "0:0";
  static const String trap = "Trap:";
  static const String details = " Details";
  static const String email = "Email";
  static const String userName = "UserName";
  static const String password = "Password";
  static const String traps = "Traps";
  static const String name = "Name";
  static const String noFoundUsers = "No Found Users";
  static const String oldPassword = "Old Password";
  static const String newPassword = "New Password";
  static const String confirmPassword = "Confirm Password";
  static const String noFoundNotifications = "No Found Notifications";
  static const String counter = "counter";
  static const String seen = "seen";

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.english,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: Images.arabic,
        languageName: 'عربى',
        countryCode: 'SA',
        languageCode: 'ar'),
  ];
}
