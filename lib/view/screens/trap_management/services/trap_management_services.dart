import 'dart:convert';

import 'package:bio_trap/helper/dio_integration.dart';
import 'package:bio_trap/model/body/reading_model.dart';
import 'package:bio_trap/model/body/search_reading_model.dart';
import 'package:bio_trap/model/body/trap_model.dart';
import 'package:bio_trap/util/app_constants.dart';
import 'package:bio_trap/util/utility.dart';
import 'package:bio_trap/view/base/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';

class TrapManagementServices {
  final dio = DioUtilNew.dio;

  getTrap({int? id}) async {
    try {
      final response = await dio!.get(AppConstants.getTrap + id!.toString());
      if (response.statusCode == 200) {
        TrapModel trap = TrapModel.fromJson(response.data);
        return trap;
      } else {
        showCustomSnackBar(message: "Error getting trap", isError: true);
      }
    } catch (e) {
      print(e);
    }
  }

  getTrapReadingBySearch({int? id, String? startDate, String? endDate}) async {
    try {
      // final response = await dio!.get(
      //     "${AppConstants.getTrapReading}$id?startDate=$startDate&endDate=$endDate");
      final response = await dio!.get(
          "/Traps/GetTrapReadingsGroupedByDayNew/$id?startDate=$startDate&endDate=$endDate");

      print(response.statusCode);
      if (response.statusCode == 200) {
        SearchReadingModel trap = SearchReadingModel.fromJson(response.data);
        return trap;
      } else {
        showCustomSnackBar(
            message: "Not Found Reading For Trap", isError: true);
      }
    } catch (e) {
      print(e);
    }
  }

  getTrapReading({int? id, String? startDate}) async {
    try {
      final response = await dio!
          .get("${AppConstants.getTrapReading}$id?startDate=$startDate");
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.data);
        ReadingTrapModel trap = ReadingTrapModel.fromJson(response.data);
        return trap;
      } else if (response.statusCode == 400) {
      } else {
        showCustomSnackBar(
            message: "Error Getting Trap Reading", isError: true);
      }
    } catch (e) {
      print(e);
    }
  }

  deleteTrap(BuildContext context, {int? trapId}) async {
    try {
      final response = await dio!.delete(
        "${AppConstants.deleteTrap}$trapId",
      );
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        Utility.displaySuccessAlert("Success Delete Trap", context);
      } else {
        showCustomSnackBar(message: "Failed to update", isError: true);
      }
    } catch (e) {
      print(e);
    }
  }

  getTrapLastRead({int? trapId}) async {
    try {
      final response = await dio!.get("${AppConstants.lastReadTrap}$trapId");
      print(response.data);
      print(response.statusCode);
      if (response.statusCode == 200) {
        Readings readings = Readings.fromJson(response.data);
        return readings;
      }
    } catch (e) {
      print(e);
    }
  }
}
