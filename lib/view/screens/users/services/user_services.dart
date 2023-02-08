import 'package:bio_trap/helper/dio_integration.dart';
import 'package:bio_trap/model/body/trap_model.dart';
import 'package:bio_trap/model/body/users_model.dart';
import 'package:bio_trap/util/app_constants.dart';
import 'package:bio_trap/util/utility.dart';
import 'package:bio_trap/view/base/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';

class UserService {
  final dio = DioUtilNew.dio;

  Future<List<UsersModel>?> getAllUser() async {
    try {
      final response = await dio!.get(
        AppConstants.getAllUser,
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final mList = List<UsersModel>.from(
            (response.data).map((e) => UsersModel.fromJson(e)));
        return mList;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<TrapModel>?> getAllTraps() async {
    try {
      final response = await dio!.get(
        AppConstants.getAllTraps,
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        final mList = List<TrapModel>.from(
            (response.data).map((e) => TrapModel.fromJson(e)));
        return mList;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  updateUser(BuildContext context,
      {String? id, String? userName, String? email, List<int>? trapIds}) async {
    try {
      final response = await dio!.put(AppConstants.updateUser + id!,
          data: {"UserName": userName, "Email": email, "TrapIds": trapIds});
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        Utility.displaySuccessAlert("Updated Successfully", context);
      } else if (response.statusCode == 400) {
        showCustomSnackBar(message: "This user Is Found", isError: true);
      }
    } catch (e) {
      print(e);
    }
  }

  deleteUser(
    BuildContext context, {
    String? id,
  }) async {
    try {
      final response = await dio!.delete(AppConstants.deleteUser + id!);
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        Utility.displaySuccessAlert("Success Delete User", context);
      } else if (response.statusCode == 400) {
        showCustomSnackBar(message: "This user Is Found", isError: true);
      }
    } catch (e) {
      print(e);
    }
  }

  changePassword({
    String? id,
    String? oldPassWord,
    String? newPassWord,
    String? confirmNewPassWord,
  }) async {
    try {
      final response = await dio!.put(AppConstants.changePassword, data: {
        "user_Id": id,
        "oldPassWord": oldPassWord,
        "newPassWord": newPassWord,
        "confirmNewPassWord": confirmNewPassWord
      });
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        showCustomSnackBar(message: "Updated Successfully", isError: false);
      } else if (response.statusCode == 400) {
        showCustomSnackBar(message: "Old Password Is Correct", isError: true);
      }
    } catch (e) {
      print(e);
    }
  }

  addUser(
    BuildContext context, {
    String? userName,
    String? email,
    String? password,
    List<int>? trapIds,
  }) async {
    try {
      final response = await dio!.post(AppConstants.addUser, data: {
        "UserName": userName,
        "Email": email,
        "Password": password,
        "trapIds": trapIds
      });
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        Utility.displaySuccessAlert("Success Add User", context);
      } else if (response.statusCode == 400) {
        showCustomSnackBar(
            message: response.data["errors"][0][0], isError: true);
      } else if (response.statusCode == 500 || response.statusCode == 502) {
        showCustomSnackBar(message: "Error in Server", isError: true);
      }
    } catch (e) {
      print(e);
    }
  }
}
