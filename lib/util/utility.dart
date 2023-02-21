import 'package:bio_trap/routes/app_route.dart';
import 'package:bio_trap/util/dimensions.dart';
import 'package:bio_trap/util/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Utility {
  static displayErrorAlert(String message, BuildContext context,
      {AlertType type = AlertType.error}) async {
    final alert = Alert(
      context: context,
      type: type,
      // title: title,
      desc: message,
      style: AlertStyle(
        backgroundColor: Colors.white,
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        descStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
        isCloseButton: false,
      ),
      buttons: [
        DialogButton(
          onPressed: () {
            Navigator.pop(context);
          },
          // color: K.PRIMARY_COLOR,
          color: Colors.red,
          child: Text(
            "accepted".tr,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ],
    );
    await alert.show();
  }

  static displaySuccessAlert(String message, BuildContext context,
      {AlertType type = AlertType.none}) async {
    final alert = Alert(
      content:
          Lottie.asset(Images.successIcon, height: Dimensions.height * 0.2),
      context: context,
      type: type,
      // title: title,
      desc: message,

      style: AlertStyle(
        backgroundColor: Colors.white,
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        descStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 16,
        ),
        isCloseButton: false,
      ),
      buttons: [
        DialogButton(
          onPressed: () {
            Get.offAllNamed(AppRoute.homeScreen);
          },
          // color: K.PRIMARY_COLOR,
          color: Theme.of(context).primaryColor,
          child: Text(
            "accepted".tr,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ],
    );
    await alert.show();
  }

  static displayScheduleAlert(String message, BuildContext context,
      {AlertType type = AlertType.none, Widget? widget}) async {
    final alert = Alert(
      content: widget!,
      context: context,
      type: type,
      // title: title,
      desc: message,

      style: AlertStyle(
        backgroundColor: Colors.white,
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        descStyle: TextStyle(
          color: Theme.of(context).primaryColor,
          fontSize: 16,
        ),
        isCloseButton: false,
      ),
      buttons: [
        DialogButton(
          onPressed: () {
            Get.back();
          },
          // color: K.PRIMARY_COLOR,
          color: Theme.of(context).primaryColor,
          child: Text(
            "cancel".tr,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ],
    );
    await alert.show();
  }

  static displayLogoutAlert(
    BuildContext context,
    Function()? onConfirm, {
    String? title = "are_you_sure_to_logout",
    String? btnText = "logout",
  }) async {
    final alert = Alert(
      context: context,
      title: title,
      type: AlertType.none,
      style: AlertStyle(
        // animationDuration: const Duration(milliseconds: 800),
        animationType: AnimationType.grow,
        backgroundColor: Colors.white,
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        descStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
        isCloseButton: false,
      ),
      buttons: [
        DialogButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Theme.of(context).primaryColor,
          child: Text(
            "cancel".tr,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        DialogButton(
          onPressed: onConfirm,
          color: Colors.red,
          child: Text(
            btnText!,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ],
    );
    await alert.show();
  }

  static displayUpdateAlert(
    BuildContext context,
    Widget child, {
    Function()? onConfirm,
    bool? loading,
  }) async {
    final alert = Alert(
      context: context,
      content: child,
      type: AlertType.none,
      style: AlertStyle(
        // animationDuration: const Duration(milliseconds: 900),
        animationType: AnimationType.grow,
        backgroundColor: Colors.white,
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        descStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
        ),
        isCloseButton: false,
      ),
      buttons: [
        DialogButton(
          onPressed: onConfirm,
          color: Theme.of(context).primaryColor,
          child: loading == true
              ? Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).cardColor),
                )
              : Text(
                  "Confirmation".tr,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
        ),
        DialogButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.red,
          child: Text(
            "cancel".tr,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ],
    );
    await alert.show();
  }
}
