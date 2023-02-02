import 'package:bio_trap/controller/base_controller.dart';
import 'package:bio_trap/model/response/language_model.dart';
import 'package:bio_trap/util/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/cache_helper.dart';

class LocalizationController extends BaseController {
  LocalizationController() {
    loadCurrentLanguage();
  }

  Locale _locale = Locale(AppConstants.languages[0].languageCode!,
      AppConstants.languages[0].countryCode);
  bool _isLtr = true;
  List<LanguageModel> _languages = [];

  Locale get locale => _locale;

  bool get isLtr => _isLtr;

  List<LanguageModel> get languages => _languages;

  void setLanguage(Locale locale) {
    Get.updateLocale(locale);
    _locale = locale;
    if (_locale.languageCode == 'ar') {
      _isLtr = false;
    } else {
      _isLtr = true;
    }
    // AddressModel _addressModel;
    // try {
    //   _addressModel = AddressModel.fromJson(
    //       jsonDecode(sharedPreferences.getString(AppConstants.USER_ADDRESS)));
    // } catch (e) {}
    // apiClient.updateHeader(
    //   sharedPreferences.getString(AppConstants.TOKEN),
    //   _addressModel == null ? null : _addressModel.zoneIds,
    //   locale.languageCode,
    // );
    saveLanguage(_locale);
    // if (Get.find<LocationController>().getUserAddress() != null) {
    //   HomeScreen.loadData(true);
    update();
  }

  void loadCurrentLanguage() async {
    _locale = Locale(
        CacheHelper.getData(key: AppConstants.LANGUAGE_CODE) ??
            AppConstants.languages[0].languageCode!,
        CacheHelper.getData(key: AppConstants.COUNTRY_CODE) ??
            AppConstants.languages[0].countryCode);
    _isLtr = _locale.languageCode != 'ar';
    for (int index = 0; index < AppConstants.languages.length; index++) {
      if (AppConstants.languages[index].languageCode == _locale.languageCode) {
        _selectedIndex = index;
        break;
      }
    }
    _languages = [];
    _languages.addAll(AppConstants.languages);
    update();
  }

  void saveLanguage(Locale locale) async {
    CacheHelper.saveData(
        key: AppConstants.LANGUAGE_CODE, value: locale.languageCode);
    CacheHelper.saveData(
        key: AppConstants.COUNTRY_CODE, value: locale.countryCode!);
  }

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setSelectIndex(int index) {
    _selectedIndex = index;
    update();
  }

  void searchLanguage(String query) {
    if (query.isEmpty) {
      _languages = [];
      _languages = AppConstants.languages;
    } else {
      _selectedIndex = -1;
      _languages = [];
      for (var language in AppConstants.languages)  {
        if (language.languageName!
            .toLowerCase()
            .contains(query.toLowerCase())) {
          _languages.add(language);
        }
      }
    }
    update();
  }
}
