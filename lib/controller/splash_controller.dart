import 'dart:async';

import 'package:bio_trap/controller/base_controller.dart';
import 'package:bio_trap/enum/view_state.dart';
import 'package:bio_trap/helper/cache_helper.dart';
import 'package:bio_trap/helper/dio_integration.dart';
import 'package:bio_trap/routes/app_route.dart';
import 'package:bio_trap/util/app_constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';

class SplashController extends BaseController {
  final hasConnected = false.obs;
  final _token = ''.obs;
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  final isAlertSet = false.obs;

  String get token => _token.value;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    setState(ViewState.busy);
   await checkTimeout();
    setState(ViewState.idle);
  }

  checkTimeout() async {
    var output = DateFormat('MMMM d y , hh:mm a');
     String date = await CacheHelper.getData(key: AppConstants.expireOn);
    if (date == null) {
      Get.toNamed(AppRoute.signIn);
    }
    else{
      var input = DateTime.parse(CacheHelper.getData(key: AppConstants.expireOn));
      print(output.format(input));
      final date2 = DateTime.now();
      final difference = input.difference(date2).inHours;
      print(difference);
      if (difference > 0) {
        _token.value = await CacheHelper.getData(key: AppConstants.token) ?? '';
        print(token);
        Get.toNamed(AppRoute.homeScreen);
        DioUtilNew.setDioAgain();
      } else if (difference <= 0) {
        CacheHelper.removeData(key: AppConstants.token);
        CacheHelper.removeData(key: AppConstants.expireOn);
        Get.toNamed(AppRoute.signIn);
        DioUtilNew.setDioAgain();
      }
    }
  }

// getConnectivity() =>
//     subscription = Connectivity().onConnectivityChanged.listen(
//           (ConnectivityResult result) async {
//         isDeviceConnected = await InternetConnectionChecker().hasConnection;
//         if (!isDeviceConnected && isAlertSet.value == false) {
//           showCupertinoDialog<String>(
//               context: Get.context!,
//               builder: (BuildContext context) => CupertinoAlertDialog(
//             title: const Text('No Connection'),
//             content: const Text('Please check your internet connectivity'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () async {
//                   Navigator.pop(context, 'Cancel');
//                    isAlertSet.value = false;
//                   isDeviceConnected =
//                   await InternetConnectionChecker().hasConnection;
//                   if (!isDeviceConnected && isAlertSet == false) {
//
//                      isAlertSet.value = true;
//                   }
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           );
//          isAlertSet.value = true;
//         }
//       },
//     );
}
