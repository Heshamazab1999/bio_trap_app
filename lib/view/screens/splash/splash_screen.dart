import 'dart:async';
import 'package:bio_trap/routes/app_route.dart';
import 'package:bio_trap/util/dimensions.dart';
import 'package:connectivity/connectivity.dart';
import 'package:bio_trap/controller/splash_controller.dart';
import 'package:bio_trap/util/images.dart';
import 'package:bio_trap/view/base/no_internet_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    super.key,
  });

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  final controller = Get.put(SplashController());
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
    getConnectivity();
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(AppRoute.signIn);
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
                Images.logoWhite,
                width: Dimensions.width * 0.25,
              ),
              SizedBox(
                height: Dimensions.height * 0.02,
              ),
              Image.asset(Images.logoName, width: Dimensions.width * 0.5),
              SizedBox(
                height: Dimensions.height * 0.04,
              ),
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
