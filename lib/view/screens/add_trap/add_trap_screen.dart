import 'package:bio_trap/util/dimensions.dart';
import 'package:bio_trap/util/images.dart';
import 'package:bio_trap/util/styles.dart';
import 'package:bio_trap/view/base/custom_button.dart';
import 'package:bio_trap/view/base/fixed_text_field.dart';
import 'package:bio_trap/view/base/multi_select_widget.dart';
import 'package:bio_trap/view/base/slider_widget.dart';
import 'package:bio_trap/view/screens/add_trap/controller/add_trap_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTrapScreen extends StatelessWidget {
  const AddTrapScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddTrapController());
    return Scaffold(
      backgroundColor: const Color(0xFFF9FEFE),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(Dimensions.height * 0.1),
          // here the desired height
          child: AppBar(
            leadingWidth: Dimensions.width * 0.12,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Builder(
                builder: (context) =>
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(Images.arrowIcon,
                          color: Theme
                              .of(context)
                              .cardColor),
                    ),
              ),
            ),
            backgroundColor: Theme
                .of(context)
                .primaryColor,
            elevation: 0,
            centerTitle: true,
            title: Image.asset(Images.logoNewIcon,
                width: Dimensions.width * 0.3,
                color: Theme
                    .of(context)
                    .cardColor),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Dimensions.height * 0.02,
              ),
              FixedTextField(
                controller: controller.textEditingControllerName,
                function: (v) {
                  print(controller.textEditingControllerName.text);
                },
                label: "Trap Name",
              ),
              SizedBox(
                height: Dimensions.height * 0.03,
              ),
              FixedTextField(
                controller: controller.textEditingControllerSerial,
                function: (v) {},
                label: "Serial",
              ),
              SizedBox(
                height: Dimensions.height * 0.03,
              ),

              FixedTextField(
                controller: controller.textEditingControllerLema,
                inputType: TextInputType.number,
                function: (v) {},
                label: "Iema",
              ),

              SizedBox(
                height: Dimensions.height * 0.03,
              ),
              Row(children: [
                Flexible(
                  child: FixedTextField(
                    controller: controller.textEditingControllerLat,
                    function: (v) {},
                    label: "Lat",
                  ),
                ),
                Flexible(
                  child: FixedTextField(
                    controller: controller.textEditingControllerLon,
                    function: (v) {},
                    label: "Lon",
                  ),
                ),
                Obx(() =>
                controller.loading.value
                    ? Center(
                  child: CircularProgressIndicator(
                    color: Theme
                        .of(context)
                        .primaryColor,
                  ),
                )
                    : CustomButton(
                  radius: 4,
                  width: Dimensions.width * 0.12,
                  height: Dimensions.height * 0.05,
                  icon: Icons.location_on,
                  onPressed: () {
                    controller.getCurrentPosition();
                  },
                )),
              ]),
              SizedBox(
                height: Dimensions.height * 0.02,
              ),
              Divider(
                  color: Theme
                      .of(context)
                      .primaryColor,
                  endIndent: 20,
                  indent: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Trap ON / OFF",
                      style: robotoMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: Theme
                              .of(context)
                              .primaryColor),
                    ),
                    Obx(() =>
                        Switch(
                          value: controller.switchValue.value,
                          onChanged: (v) {
                            controller.switchValue.value = v;
                            print(controller.switchValue.value);
                          },
                          activeColor: Theme
                              .of(context)
                              .primaryColor,
                          inactiveThumbColor:
                          Theme
                              .of(context)
                              .colorScheme
                              .error,
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.height * 0.02,
              ),
              Divider(
                  color: Theme
                      .of(context)
                      .primaryColor,
                  endIndent: 20,
                  indent: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Schedule ON / OFF",
                      style: robotoMedium.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: Theme
                              .of(context)
                              .primaryColor),
                    ),
                    Obx(() =>
                        Switch(
                          value: controller.switchScheduleValue.value,
                          onChanged: (v) {
                            controller.switchScheduleValue.value = v;
                            print(controller.switchScheduleValue.value);
                          },
                          activeColor: Theme
                              .of(context)
                              .primaryColor,
                          inactiveThumbColor:
                          Theme
                              .of(context)
                              .colorScheme
                              .error,
                        ))
                  ],
                ),
              ),

              Obx(() =>
              controller.switchScheduleValue.value
                  ? Column(
                children: [
                  CustomMultiSelect(
                    label: "Schedule Fan Times",
                    icon: Icons.timelapse,
                    list: controller.slideRangeScheduleFan,
                    onConfirm: (values) {
                      for (var element in values) {
                        bool value = element.status = !element.status;
                        controller.slideRangeScheduleFan
                            .where((element) => element.status == value);
                      }

                      print(controller.slideRangeScheduleFan.length);
                      for (var element
                      in controller.slideRangeScheduleFan) {
                        print(element.status);
                      }
                    },
                  ),
                  SizedBox(
                    height: Dimensions.height * 0.02,
                  ),
                  Divider(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      endIndent: 20,
                      indent: 20),
                  CustomMultiSelect(
                    label: "Schedule Counter Times",
                    icon: Icons.timelapse,
                    list: controller.slideRangeScheduleCounter,
                    onConfirm: (values) {
                      for (var element in values) {
                        bool value = element.status = !element.status;
                        controller.slideRangeScheduleCounter
                            .where((element) => element.status == value);
                      }

                      print(controller.slideRangeScheduleCounter.length);
                      for (var element
                      in controller.slideRangeScheduleCounter) {
                        print(element.status);
                      }
                    },
                  ),
                  SizedBox(
                    height: Dimensions.height * 0.02,
                  ),
                  Divider(
                      color: Theme
                          .of(context)
                          .primaryColor,
                      endIndent: 20,
                      indent: 20),
                  CustomMultiSelect(
                    label: "Schedule Counter Times",
                    icon: Icons.timelapse,
                    list: controller.slideRangeScheduleValueQut,
                    onConfirm: (values) {
                      for (var element in values) {
                        bool value = element.status = !element.status;
                        controller.slideRangeScheduleValueQut
                            .where((element) => element.status == value);
                      }

                      print(controller.slideRangeScheduleValueQut.length);
                      for (var element
                      in controller.slideRangeScheduleValueQut) {
                        print(element.status);
                      }
                    },
                  ),

                ],
              )
                  : const SizedBox()),
              SizedBox(
                height: Dimensions.height * 0.02,
              ),


              Divider(
                  color: Theme
                      .of(context)
                      .primaryColor,
                  endIndent: 20,
                  indent: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Text(
                        "Fan",
                        style: robotoMedium.copyWith(
                            fontSize: Dimensions.fontSizeLarge,
                            color: Theme
                                .of(context)
                                .primaryColor),
                      ),
                    ),
                    Flexible(
                        flex: 3,
                        child: Obx(() =>
                            SliderWidget(
                              onChange: (v) {
                                print(v);
                                controller.fanValue.value = v;
                              },
                              value: controller.fanValue.value,
                            ))),
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.height * 0.02,
              ),
              Divider(
                  color: Theme
                      .of(context)
                      .primaryColor,
                  endIndent: 20,
                  indent: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Text(
                        "Valve Qut",
                        style: robotoMedium.copyWith(
                            fontSize: Dimensions.fontSizeLarge,
                            color: Theme
                                .of(context)
                                .primaryColor),
                      ),
                    ),
                    Flexible(
                        flex: 3,
                        child: Obx(() =>
                            SliderWidget(
                              onChange: (v) {
                                print(v);
                                controller.qutValue.value = v;
                              },
                              value: controller.qutValue.value,
                            ))),
                  ],
                ),
              ),
              SizedBox(
                height: Dimensions.height * 0.06,
              ),
              Obx(() =>
              controller.send.value
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                radius: 8,
                width: Dimensions.width * 0.5,
                onPressed: () {
                  controller.addTrap(context);
                },
                buttonText: "Add Trap",
              ))
            ],
          ),
        ),
      ),
    );
  }
}
