import 'package:bio_trap/helper/cache_helper.dart';
import 'package:bio_trap/helper/dio_integration.dart';
import 'package:bio_trap/model/body/user_model.dart';
import 'package:bio_trap/routes/app_route.dart';
import 'package:bio_trap/util/app_constants.dart';
import 'package:get/get.dart';

class AuthServices {
  final dio = DioUtilNew.dio;

  signIn({String? email, String? password}) async {
    try {
      final response = await dio!.post(AppConstants.login,
          data: {"Email": email, "Password": password});
      print(response.statusCode);
      if (response.statusCode == 200) {
        UserModel userModel = UserModel.fromJson(response.data);
        CacheHelper.saveData(
            key: AppConstants.expireOn, value: userModel.data!.expiresOn);
        CacheHelper.saveData(
            key: AppConstants.token, value: userModel.data!.token);
        print(response.data);
        Get.offAllNamed(AppRoute.homeScreen);
        DioUtilNew.setDioAgain();
      }
    } catch (e) {}
  }
}
