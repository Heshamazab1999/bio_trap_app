import 'package:bio_trap/util/dimensions.dart';
import 'package:bio_trap/util/images.dart';
import 'package:bio_trap/view/base/custom_button.dart';
import 'package:bio_trap/view/base/fixed_text_field.dart';
import 'package:bio_trap/view/screens/auth/controller/signIn_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());
    return Scaffold(
      backgroundColor: const Color(0xFFF9FEFE),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Images.logoIcon, width: Dimensions.width * 0.2),
              SizedBox(
                height: Dimensions.height * 0.02,
              ),
              Image.asset(Images.logoName, width: Dimensions.width * 0.5),
              SizedBox(
                height: Dimensions.height * 0.04,
              ),
              FixedTextField(
                prefixIcon: Icon(Icons.email,
                    color: Theme.of(context).primaryColor.withOpacity(0.4)),
                label: "email".tr,
              ),
              SizedBox(
                height: Dimensions.height * 0.02,
              ),
              Obx(() => FixedTextField(
                    obSecure: controller.isSecure.value,
                    suffixIcon: IconButton(
                        onPressed: () {
                          controller.isSecure.value =
                              !controller.isSecure.value;
                        },
                        icon: Icon(
                            controller.isSecure.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.4))),
                    prefixIcon: Icon(Icons.lock,
                        color: Theme.of(context).primaryColor.withOpacity(0.4)),
                    label: "password".tr,
                  )),
              SizedBox(
                height: Dimensions.height * 0.04,
              ),
              CustomButton(
                onPressed: () {},
                width: Dimensions.width * 0.8,
                radius: Dimensions.RADIUS_DEFAULT,
                buttonText: "sign_in".tr,
              )
            ],
          ),
        ),
      ),
    );
  }
}
