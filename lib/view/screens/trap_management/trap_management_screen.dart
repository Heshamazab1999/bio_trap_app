import 'package:bio_trap/helper/cache_helper.dart';
import 'package:bio_trap/model/body/trap_model.dart';
import 'package:bio_trap/routes/app_route.dart';
import 'package:bio_trap/util/app_constants.dart';
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
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Image.asset(Images.arrowIcon,
                      color: Theme.of(context).cardColor),
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 0,
              actions: [
                CacheHelper.getData(key: AppConstants.role) == "SuperAdmin"
                    ? GestureDetector(
                        onTap: () => Get.toNamed(AppRoute.addTrapScreen),
                        child: Image.asset(Images.moreIcon,
                            width: 25, color: Theme.of(context).cardColor),
                      )
                    : const SizedBox(),
                const SizedBox(width: 20),
              ],
              centerTitle: true,
              title: Image.asset(Images.logoNewIcon,
                  width: Dimensions.width * 0.3,
                  color: Theme.of(context).cardColor),
            )),
        body: ListView.builder(
            itemCount: traps!.length,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) => Obx(() {
                  return CustomCard(
                    deleteFun: () {
                      controller.deleteTrap(context, trapId: traps![index].id);
                    },
                    date: traps![index].readingDate ?? "00-00-00",
                    switchFunction: (v) {},
                    onNavigate: () async {
                      await controller.getTrap(trapId: traps![index].id);
                      Get.to(() => UpdateTrapScreen(
                            trap: controller.trap,
                          ),transition: Transition.leftToRight);
                    },
                    co2Value:0.0,
                    fanValue: double.tryParse(traps![index].fan!)! / 100,
                    lunchMap: () {
                      controller.openMapDirection(
                          lat: traps![index].lat!,
                          long: traps![index].long!,
                          title: traps![index].name);
                    },
                    name: traps![index].name,
                    status: traps![index].isCounterOn == false ? "OFF" : "ON",
                    color: traps![index].isCounterOn == false
                        ? Theme.of(context).colorScheme.error
                        : Colors.green,
                    switchValue: traps![index].isCounterOn,
                  );
                })));
  }
}
