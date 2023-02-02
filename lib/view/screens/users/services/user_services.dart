import 'package:bio_trap/helper/dio_integration.dart';
import 'package:bio_trap/model/body/trap_model.dart';
import 'package:bio_trap/model/body/users_model.dart';
import 'package:bio_trap/util/app_constants.dart';
import 'package:bio_trap/view/base/custom_snackbar.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';

class UserService {
  final dio = DioUtilNew.dio;
  final options2 = CacheOptions(
    // A default store is required for interceptor.
    store: MemCacheStore(),

    // All subsequent fields are optional.

    // Default.
    policy: CachePolicy.request,
    // Returns a cached response on error but for statuses 401 & 403.
    // Also allows to return a cached response on network errors (e.g. offline usage).
    // Defaults to [null].
    hitCacheOnErrorExcept: [401, 403],
    // Overrides any HTTP directive to delete entry past this duration.
    // Useful only when origin server has no cache config or custom behaviour is desired.
    // Defaults to [null].
    maxStale: const Duration(days: 7),
    // Default. Allows 3 cache sets and ease cleanup.
    priority: CachePriority.normal,
    // Default. Body and headers encryption with your own algorithm.
    cipher: null,
    // Default. Key builder to retrieve requests.
    keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    // Default. Allows to cache POST requests.
    // Overriding [keyBuilder] is strongly recommended when [true].
    allowPostMethod: false,
  );

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
        options: options2.copyWith(policy: CachePolicy.refresh).toOptions(),
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

  updateUser(
      {String? id, String? userName, String? email, List<int>? trapIds}) async {
    try {
      final response = await dio!.put(AppConstants.updateUser + id!,
          data: {"UserName": userName, "Email": email, "TrapIds": trapIds});
      print(response.statusCode);
      print(response.data);
      if (response.statusCode == 200) {
        showCustomSnackBar(message: "Updated Successfully", isError: false);
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
}
