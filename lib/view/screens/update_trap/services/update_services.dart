import 'package:bio_trap/helper/dio_integration.dart';
import 'package:bio_trap/model/body/update_trap.dart';
import 'package:bio_trap/util/app_constants.dart';
import 'package:bio_trap/util/utility.dart';
import 'package:bio_trap/view/base/custom_snackbar.dart';
import 'package:flutter/material.dart';

class UpdateServices {
  final dio = DioUtilNew.dio;

  updateTrap(BuildContext context, {int? id, UpdateTrapModel? model}) async {
    try {
      final response = await dio!
          .put(AppConstants.updateTrap + id.toString(), data: model!.toJson());
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        
         Utility.displaySuccessAlert("Success Updating Trap", context);
        // showCustomSnackBar(message: "Updated successfully", isError: false);
      } else {
        showCustomSnackBar(message: "Failed to update", isError: true);
      }
    } catch (e) {      print(e);
    }
  }
}
