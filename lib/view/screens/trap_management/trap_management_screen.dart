import 'package:bio_trap/model/body/trap_model.dart';
import 'package:bio_trap/util/dimensions.dart';
import 'package:bio_trap/util/images.dart';
import 'package:bio_trap/view/base/fixed_card.dart';
import 'package:bio_trap/view/screens/trap_management/controller/trap_managment_controller.dart';
import 'package:bio_trap/view/screens/update_trap/update_trap_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrapManagementScreen extends StatelessWidget {
  const TrapManagementScreen({Key? key, this.traps}) : super(key: key);
  final List<TrapModel>? traps;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TrapManagementController());
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
        body: Obx(() => controller.loading.value
            ? Center(
                child: Image.asset(
                  Images.logoAnimation,
                  color: Theme.of(context).primaryColor,
                  width: Dimensions.width * 0.5,
                ),
              )
            : ListView.builder(
                itemCount: traps!.length,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, index) => Obx(() {
                      // controller.checkValue.value =
                      //     List.filled(traps!.length, false);
                      return CustomCard(
                        date: traps![index].readingDate ?? "00-00-00",
                        switchFunction: (v) {
                          // controller.checkValue[index] = v;
                        },
                        onNavigate: () async {

                          // controller.sendNotification();
                          await controller.getTrap(trapId: traps![index].id);
                          Get.to(() => UpdateTrapScreen(
                                trap: controller.trap,
                              ));
                        },
                        co2Value:
                            double.tryParse(traps![index].valveQut!)! / 100,
                        fanValue: double.tryParse(traps![index].fan!)! / 100,
                        lunchMap: () {
                          controller.openMapDirection(
                              lat: traps![index].lat!,
                              long: traps![index].long!,
                              title: traps![index].name);
                        },
                        name: traps![index].name,
                        status: traps![index].isWorking == false ? "OFF" : "ON",
                        color: traps![index].isWorking == false
                            ? Theme.of(context).errorColor
                            : Colors.green,
                        switchValue: traps![index].isWorking,
                      );
                    }))));
  }
}
