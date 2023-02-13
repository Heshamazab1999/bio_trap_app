import 'package:bio_trap/controller/base_controller.dart';
import 'package:bio_trap/model/body/valid_model.dart';
import 'package:bio_trap/view/base/custom_snackbar.dart';
import 'package:bio_trap/view/screens/auth/services/auth_services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class SignInController extends BaseController {
  final services = AuthServices();
  final isSecure = false.obs;
  final _email = Valid().obs;
  final _password = Valid().obs;
  final _loading = false.obs;

  Valid get email => _email.value;

  Valid get password => _password.value;

  bool get loading => _loading.value;

  changeUserName(String email) {
    if (email.trim().length < 6) {
      _email.value = Valid(error: "enter_your_name".tr);
    } else {
      _email.value = Valid(value: email);
    }
  }

  changePassword(String password) {
    if (password.trim().length < 6) {
      _password.value = Valid(error: "password_should_be".tr);
    } else {
      _password.value = Valid(value: password);
    }
  }

  signIn() async {
    try {
      if ((_password.value.isValid() && _email.value.isValid())) {
        _loading.value = true;
        await services.signIn(
            email: _email.value.value,
            password: _password.value.value,
            deviceId: await getDeviceToken());
        _loading.value = false;
      } else {
        _loading.value = false;
        showCustomSnackBar(
            message: "ensure_that_the_values_entered_correctly".tr,
            isError: true);
      }
    } catch (e) {
      _loading.value = false;
    }
  }

  Future<String?> getDeviceToken() async {
    print(await FirebaseMessaging.instance.getToken());
    return await FirebaseMessaging.instance.getToken();
  }
}
