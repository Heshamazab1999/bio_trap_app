import 'dart:async';
import 'package:bio_trap/helper/cache_helper.dart';
import 'package:bio_trap/helper/dio_integration.dart';
import 'package:bio_trap/routes/app_route.dart';
import 'package:bio_trap/util/app_constants.dart';
import 'package:bio_trap/util/dimensions.dart';
import 'package:connectivity/connectivity.dart';
import 'package:bio_trap/util/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // final controller = Get.put(SplashController());

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void initState() {
    super.initState();
    getConnectivity();
    Future.delayed(const Duration(seconds: 5), () async {
      String time = await CacheHelper.getData(key: AppConstants.expireOn)??"";
      String token = await CacheHelper.getData(key: AppConstants.token)??"";
      print(token);
      print(time);
      print("time");
      if (time.isEmpty) {
        Get.toNamed(AppRoute.signIn);
      } else {
        var output = DateFormat('MMMM d y , hh:mm a');
        var input =
            DateTime.parse(CacheHelper.getData(key: AppConstants.expireOn));
        print(output.format(input));
        final date2 = DateTime.now();
        final difference = input.difference(date2).inHours;
        print(difference);
        if (difference > 0) {
          Get.toNamed(AppRoute.homeScreen);
          DioUtilNew.setDioAgain();
        } else if (difference <= 0) {
          CacheHelper.removeData(key: AppConstants.token);
          CacheHelper.removeData(key: AppConstants.expireOn);
          Get.toNamed(AppRoute.signIn);
          DioUtilNew.setDioAgain();
        }
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        key: _globalKey,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                Images.logoAnimation,
                width: Dimensions.width * 0.5,
              ),
              // SizedBox(
              //   height: Dimensions.height * 0.02,
              // ),
              // Image.asset(Images.logoName, width: Dimensions.width * 0.5),
              // SizedBox(
              //   height: Dimensions.height * 0.04,
              // ),
            ],
          ),
        ));
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No Connection'),
          content: const Text('Please check your internet connectivity'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
                setState(() => isAlertSet = false);
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
}
