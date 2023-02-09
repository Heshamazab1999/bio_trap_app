import 'package:bio_trap/util/images.dart';

import '../model/response/language_model.dart';

class AppConstants {
  static const String appName = 'Bio Trap';
  static const double appVersion = 5.6;

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

  // Shared Key
  static const String theme = 'theme';
  static const String expireOn = 'expireOn';
  static const String role = 'role';
  static const String token = 'multivendor_token';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String CART_LIST = 'cart_list';
  static const String USER_PASSWORD = 'user_password';
  static const String USER_ADDRESS = 'user_address';
  static const String USER_NUMBER = 'user_number';
  static const String USER_COUNTRY_CODE = 'user_country_code';
  static const String NOTIFICATION = 'notification';
  static const String SEARCH_HISTORY = 'search_history';
  static const String INTRO = 'intro';
  static const String NOTIFICATION_COUNT = 'notification_count';
  static const String TOPIC = 'all_zone_customer';
  static const String ZONE_ID = 'zoneId';
  static const String LOCALIZATION_KEY = 'X-localization';

  // Delivery Tips
  static List<int> tips = [0, 5, 10, 15, 20, 30, 50];

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
