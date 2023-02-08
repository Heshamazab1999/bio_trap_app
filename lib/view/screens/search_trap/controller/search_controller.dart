import 'package:bio_trap/controller/base_controller.dart';
import 'package:bio_trap/helper/cache_helper.dart';
import 'package:bio_trap/model/body/reading_model.dart';
import 'package:bio_trap/util/app_constants.dart';
import 'package:bio_trap/view/screens/trap_management/services/trap_management_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends BaseController {
  final services = TrapManagementServices();
  ReadingTrapModel? reading;
  final dateTime = DateTime.now();
  final id = 0.obs;
  final startDate = "".obs;
  final endDate = "".obs;
  final load = false.obs;
  final readingsList = <Readings>[].obs;

  Future<DateTime?> showCalender({required BuildContext context}) async =>
      await showDatePicker(
        context: context,
        lastDate: DateTime(2100),
        firstDate: CacheHelper.getData(key: AppConstants.role) == "SuperAdmin"
            ? DateTime(2000)
            : DateTime(2023, 2),
        initialDate: dateTime,
      );

  getTrapReading({int? id}) async {
    try {
      readingsList.clear();
      load.value = true;
      reading = await services.getTrapReadingBySearch(
          id: id, endDate: endDate.value, startDate: startDate.value);
      readingsList.addAll(reading!.readings!);
      load.value = false;
    } catch (e) {
      load.value = false;
    }
  }
}
