import 'dart:convert';
import 'package:bio_trap/controller/language_controller.dart';
import 'package:bio_trap/controller/theme_controller.dart';
import 'package:bio_trap/helper/cache_helper.dart';
import 'package:bio_trap/helper/dio_integration.dart';
import 'package:bio_trap/model/response/language_model.dart';
import 'package:bio_trap/util/app_constants.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


Future<Map<String, Map<String, String>>> init() async {
  // Core
  await CacheHelper.init();
  DioUtilNew.getInstance();
  Get.lazyPut(() => ThemeController(), fenix: true);
  Get.lazyPut(() => LocalizationController(), fenix: true);
  // Controller
  // Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));

  // Retrieving localized data
  Map<String, Map<String, String>> languages = {};
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);
    Map<String, String> json = {};
    mappedJson.forEach((key, value) {
      json[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        json;
  }
  return languages;
}
