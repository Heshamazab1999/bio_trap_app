import 'package:bio_trap/controller/base_controller.dart';
import 'package:bio_trap/enum/view_state.dart';
import 'package:bio_trap/model/body/trap_model.dart';
import 'package:bio_trap/model/body/users_model.dart';
import 'package:bio_trap/model/body/valid_model.dart';
import 'package:bio_trap/view/base/custom_snackbar.dart';
import 'package:bio_trap/view/screens/users/services/user_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class UsersController extends BaseController {
  final services = UserService();
  final users = <UsersModel>[].obs;
  final traps = <TrapModel>[].obs;
  final trapIds = <int>[].obs;
  TextEditingController textEditingControllerName = TextEditingController();
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerOldPassword =
      TextEditingController();
  TextEditingController textEditingControllerNewPassword =
      TextEditingController();
  TextEditingController textEditingControllerConfirmPassword =
      TextEditingController();
  final _email = Valid().obs;
  final _name = Valid().obs;
  final _oldPassword = Valid().obs;
  final _newPassword = Valid().obs;
  final _confirmPassword = Valid().obs;
  final _loading = false.obs;

  Valid get email => _email.value;

  Valid get name => _name.value;

  Valid get oldPassword => _oldPassword.value;

  Valid get newPassword => _newPassword.value;

  Valid get confirmPassword => _confirmPassword.value;

  bool get loading => _loading.value;

  changeUserEmail(String email) {
    if (email.trim().length < 6) {
      _email.value = Valid(error: "Enter Your Email");
    } else {
      _email.value = Valid(value: email);
    }
  }

  changeName(String name) {
    if (name.trim().length < 6) {
      _name.value = Valid(error: "Enter Your Name");
    } else {
      _name.value = Valid(value: name);
    }
  }

  changeOldPassword(String password) {
    if (password.trim().length < 6) {
      _oldPassword.value = Valid(error: "Your password must grater than 6");
    } else {
      _oldPassword.value = Valid(value: password);
    }
  }

  changeNewPassword(String name) {
    if (name.trim().length < 6) {
      _newPassword.value = Valid(error: "Your password must grater than 6");
    } else {
      _newPassword.value = Valid(value: name);
    }
  }

  changeConfirmPassword(String password) {
    if (password.trim().length < 6) {
      _confirmPassword.value = Valid(error: "confirm_password".tr);
    } else {
      _confirmPassword.value = Valid(value: password);
      if (_confirmPassword.value.value != _newPassword.value.value) {
        _confirmPassword.value =
            Valid(error: "confirm_password_does_not_matched".tr);
      }
    }
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    setState(ViewState.busy);
    users.value = (await services.getAllUser())!;
    traps.value = (await services.getAllTraps())!;
    print(users.length);
    print(traps.length);
    setState(ViewState.idle);
  }

  updateUser({String? id}) async {
    try {
      if ((_email.value.isValid() && _name.value.isValid())) {
        _loading.value = true;
        await services.updateUser(
            id: id,
            email: _email.value.value,
            userName: _name.value.value,
            trapIds: trapIds);
        textEditingControllerName.clear();
        textEditingControllerEmail.clear();
        _loading.value = false;
        Get.back();
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

  changePassword({String? userId}) async {
    try {
      await services.changePassword(
          id: userId,
          confirmNewPassWord: _confirmPassword.value.value,
          newPassWord: _newPassword.value.value,
          oldPassWord: _oldPassword.value.value);
      textEditingControllerConfirmPassword.clear();
      textEditingControllerNewPassword.clear();
      textEditingControllerOldPassword.clear();
      Get.back();
    } catch (e) {}
  }
}
