import 'package:bio_trap/model/body/trap_model.dart';
import 'package:bio_trap/util/dimensions.dart';
import 'package:bio_trap/util/images.dart';
import 'package:bio_trap/util/styles.dart';
import 'package:bio_trap/view/base/custom_button.dart';
import 'package:bio_trap/view/base/fixed_text_field.dart';
import 'package:bio_trap/view/base/multi_select_widget.dart';
import 'package:bio_trap/view/base/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'controller/update_trap_controller.dart';

class UpdateTrapScreen extends StatelessWidget {
  const UpdateTrapScreen({Key? key, this.trap}) : super(key: key);
  final TrapModel? trap;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateTrapController());
    controller.textEditingControllerName.text = trap!.name!;
    controller.textEditingControllerSerial.text = trap!.serialNumber!;
    controller.textEditingControllerLema.text = trap!.iema!;
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
                builder: (context) => GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset(Images.arrowIcon,
                      color: Theme.of(context).cardColor),
                ),
              ),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0,
            centerTitle: true,
            title: Image.asset(Images.logoNewIcon,
                width: Dimensions.width * 0.3,
                color: Theme.of(context).cardColor),
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
              Row(children: [
                Flexible(
                  child: FixedTextField(
                    controller: controller.textEditingControllerName,
                    function: (v) {
                      print(controller.textEditingControllerName.text);
                    },
                    label: "Trap Name",
                  ),
                ),
                Flexible(
                  child: FixedTextField(
                    controller: controller.textEditingControllerSerial,
                    function: (v) {},
                    label: "Serial",
                  ),
                ),
              ]),
              SizedBox(
                height: Dimensions.height * 0.03,
              ),
              Row(children: [
                const Spacer(),
                Flexible(
                  flex: 3,
                  child: FixedTextField(
                    controller: controller.textEditingControllerLema,
                    inputType: TextInputType.number,
                    function: (v) {},
                    label: "Iema",
                  ),
                ),
                const Spacer(),
              ]),
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
              ]),
              SizedBox(
                height: Dimensions.height * 0.02,
              ),
              Obx(() => controller.loading.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  : CustomButton(
                      radius: 4,
                      width: Dimensions.width * 0.4,
                      height: Dimensions.height * 0.04,
                      onPressed: () {
                        controller.getCurrentPosition();
                      },
                      buttonText: " Current Location",
                    )),
              SizedBox(
                height: Dimensions.height * 0.02,
              ),
              Divider(
                  color: Theme.of(context).primaryColor,
                  endIndent: 20,
                  indent: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Trap ON / OFF",
                    style: robotoMedium.copyWith(
                        fontSize: Dimensions.fontSizeLarge,
                        color: Theme.of(context).primaryColor),
                  ),
                  Obx(() => Switch(
                        value: controller.switchValue.value,
                        onChanged: (v) {
                          controller.switchValue.value = v;
                          print(controller.switchValue.value);
                        },
                        activeColor: Theme.of(context).primaryColor,
                        inactiveThumbColor: Theme.of(context).errorColor,
                      ))
                ],
              ),
              SizedBox(
                height: Dimensions.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Schedule ON / OFF",
                    style: robotoMedium.copyWith(
                        fontSize: Dimensions.fontSizeLarge,
                        color: Theme.of(context).primaryColor),
                  ),
                  Obx(() => Switch(
                        value: controller.switchScheduleValue.value,
                        onChanged: (v) {
                          controller.switchScheduleValue.value = v;
                          print(controller.switchScheduleValue.value);
                        },
                        activeColor: Theme.of(context).primaryColor,
                        inactiveThumbColor: Theme.of(context).errorColor,
                      ))
                ],
              ),
              Divider(
                  color: Theme.of(context).primaryColor,
                  endIndent: 20,
                  indent: 20),
              Obx(() => controller.switchScheduleValue.value
                  ? Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text(
                                "Fan",
                                style: robotoMedium.copyWith(
                                    fontSize: Dimensions.fontSizeLarge,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                            Flexible(
                                flex: 3,
                                child: Obx(() => SliderWidget(
                                      onChange: (v) {
                                        print(v);
                                        controller.fanValue.value = v;
                                      },
                                      value: controller.fanValue.value,
                                    ))),
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.height * 0.02,
                        ),
                        Divider(
                            color: Theme.of(context).primaryColor,
                            endIndent: 20,
                            indent: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text(
                                "Valve Qut",
                                style: robotoMedium.copyWith(
                                    fontSize: Dimensions.fontSizeLarge,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                            Flexible(
                                flex: 3,
                                child: Obx(() => SliderWidget(
                                      onChange: (v) {
                                        print(v);
                                        controller.qutValue.value = v;
                                      },
                                      value: controller.qutValue.value,
                                    ))),
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.height * 0.02,
                        ),
                        Divider(
                            color: Theme.of(context).primaryColor,
                            endIndent: 20,
                            indent: 20),
                      ],
                    )
                  : const SizedBox()),
              SizedBox(
                height: Dimensions.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Is Reading From SimCard",
                    style: robotoMedium.copyWith(
                        fontSize: Dimensions.fontSizeLarge,
                        color: Theme.of(context).primaryColor),
                  ),
                  Obx(() => Switch(
                        value: controller.switchSimCard.value,
                        onChanged: (v) {
                          controller.switchSimCard.value = v;
                          print(controller.switchSimCard.value);
                        },
                        activeColor: Theme.of(context).primaryColor,
                        inactiveThumbColor: Theme.of(context).errorColor,
                      ))
                ],
              ),
              Obx(() => controller.switchSimCard.value
                  ? CustomButton(
                      width: Dimensions.width * 0.2,
                      height: Dimensions.height * 0.05,
                      onPressed: () async {
                        final date =
                            await controller.showCalender(context: context);
                        var output = DateFormat('y-M-d/');
                        var output2 = DateFormat('hh:mm-a');
                        var time =
                            DateTime.parse(DateTime.now().toIso8601String());
                        print(output2.format(time));
                        controller.readingDate.value =
                            output.format(date!) + output2.format(time);
                        print(controller.readingDate.value);
                      },
                      icon: Icons.calendar_month_sharp,
                      buttonText: "Date",
                    )
                  : const SizedBox()),
              Divider(
                  color: Theme.of(context).primaryColor,
                  endIndent: 20,
                  indent: 20),
              SizedBox(
                height: Dimensions.height * 0.02,
              ),
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
                  for (var element in controller.slideRangeScheduleFan) {
                    print(element.status);
                  }
                },
              ),
              SizedBox(
                height: Dimensions.height * 0.02,
              ),
              Divider(
                  color: Theme.of(context).primaryColor,
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
                  for (var element in controller.slideRangeScheduleCounter) {
                    print(element.status);
                  }
                },
              ),
              SizedBox(
                height: Dimensions.height * 0.02,
              ),
              Divider(
                  color: Theme.of(context).primaryColor,
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
                  for (var element in controller.slideRangeScheduleValueQut) {
                    print(element.status);
                  }
                },
              ),
              SizedBox(
                height: Dimensions.height * 0.04,
              ),
              Obx(() => controller.send.value
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                      radius: 8,
                      width: Dimensions.width * 0.5,
                      onPressed: () {
                        print(trap!.id);
                        controller.updateTrap(context, trapId: trap!.id);
                      },
                      buttonText: "Edit",
                    ))
            ],
          ),
        ),
      ),
    );
  }
}
