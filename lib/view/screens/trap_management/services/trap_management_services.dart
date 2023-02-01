import 'package:bio_trap/helper/dio_integration.dart';
import 'package:bio_trap/model/body/trap_model.dart';
import 'package:bio_trap/util/app_constants.dart';
import 'package:bio_trap/view/base/custom_snackbar.dart';

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
    } catch (e) {}
  }
}
