import 'package:bio_trap/controller/base_controller.dart';
import 'package:bio_trap/helper/cache_helper.dart';
import 'package:bio_trap/model/body/search_reading_model.dart';
import 'package:bio_trap/util/app_constants.dart';
import 'package:bio_trap/view/screens/trap_management/services/trap_management_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SearchController extends BaseController {
  final services = TrapManagementServices();
  SearchReadingModel? reading;
  final dateTime = DateTime.now();
  final id = 0.obs;
  final startDate = "".obs;
  final endDate = "".obs;
  final load = false.obs;
  final readingList = <ReadingsModel>[].obs;
  late TooltipBehavior tooltipBehavior;

  @override
  onInit() {
    super.onInit();
    readingList.clear();
    tooltipBehavior = TooltipBehavior(enable: true,
    );
  }

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
      readingList.clear();
      load.value = true;
      reading = await services.getTrapReadingBySearch(
          id: id, endDate: endDate.value, startDate: startDate.value);
      reading?.readings?.forEach((element) {
        readingList.add(element);
      });
      load.value = false;
    } catch (e) {
      load.value = false;
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    readingList.clear();
  }
}
