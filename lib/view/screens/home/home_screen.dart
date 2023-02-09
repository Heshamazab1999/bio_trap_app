import 'package:bio_trap/enum/view_state.dart';
import 'package:bio_trap/helper/cache_helper.dart';
import 'package:bio_trap/util/app_constants.dart';
import 'package:bio_trap/util/dimensions.dart';
import 'package:bio_trap/util/images.dart';
import 'package:bio_trap/util/styles.dart';
import 'package:bio_trap/util/utility.dart';
import 'package:bio_trap/view/screens/home/controller/home_controller.dart';
import 'package:bio_trap/view/screens/trap_details/trap_details_screen.dart';
import 'package:bio_trap/view/screens/trap_management/trap_management_screen.dart';
import 'package:bio_trap/view/screens/users/users_screen.dart';
import 'package:bio_trap/view/screens/your_traps/your_traps_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
        drawer: SizedBox(
          height: Dimensions.height,
          child: Drawer(
            backgroundColor: Theme.of(context).primaryColor,
            child: Column(
              children: [
                SizedBox(height: Dimensions.height * 0.08),
                Material(
                  color: Theme.of(context).primaryColor,
                  shadowColor: Theme.of(context).cardColor,
                  elevation: 8,
                  child: Image.asset(Images.logoNewIcon,
                      width: Dimensions.width * 0.5,
                      height: Dimensions.height * 0.08,
                      color: Theme.of(context).cardColor),
                ),
                SizedBox(height: Dimensions.height * 0.04),
                Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.images.length,
                    itemBuilder: (_, index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: GestureDetector(
                            onTap: () {
                              if (index == 0) {
                                Get.to(() => TrapManagementScreen(
                                      traps: controller.traps,
                                    ));
                              } else if (index == 1) {
                                CacheHelper.getData(key: AppConstants.role) ==
                                        "SuperAdmin"
                                    ? Get.to(() => const UsersScreen())
                                    : Get.to(() => YourTrapScreen(
                                          traps: controller.traps,
                                        ));
                              } else if (index == 2) {
                                Get.to(() => YourTrapScreen(
                                      traps: controller.traps,
                                    ));
                              }
                            },
                            child: Container(
                              height: Dimensions.height * 0.05,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context).cardColor),
                                  borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(
                                          Dimensions.RADIUS_SMALL),
                                      topRight: Radius.circular(
                                          Dimensions.RADIUS_SMALL))),
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Image.asset(
                                    controller.images[index],
                                    color: Theme.of(context).cardColor,
                                    width: Dimensions.width * 0.06,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    controller.labels[index],
                                    style: robotoMedium.copyWith(
                                        color: Theme.of(context).cardColor,
                                        fontSize: Dimensions.fontSizeDefault),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )))
              ],
            ),
          ),
        ),
        backgroundColor: const Color(0xFFF9FEFE),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(Dimensions.height * 0.08),
            // here the desired height
            child: AppBar(
              leadingWidth: Dimensions.width * 0.12,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Builder(
                  builder: (context) => GestureDetector(
                    onTap: () => Scaffold.of(context).openDrawer(),
                    child: Image.asset(Images.listIcon,
                        color: Theme.of(context).cardColor),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      Utility.displayLogoutAlert(context, () {
                        controller.logOut();
                      });
                    },
                    child: Image.asset(
                      Images.exitIcon,
                      width: Dimensions.width * 0.08,
                    ),
                  ),
                ),
              ],
              backgroundColor: Theme.of(context).primaryColor,
              elevation: 0,
              centerTitle: true,
              title: Image.asset(Images.logoNewIcon,
                  width: Dimensions.width * 0.3,
                  color: Theme.of(context).cardColor),
            )),
        body: Obx(() => controller.state == ViewState.busy
            ? Center(
                child: Image.asset(
                  Images.logoAnimation,
                  color: Theme.of(context).primaryColor,
                  width: Dimensions.width * 0.5,
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: Dimensions.height / 2.5,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                            target: LatLng(
                                controller.currentPosition.value.latitude,
                                controller.currentPosition.value.longitude),
                            zoom: 15),
                        markers: controller.markers,
                        onMapCreated: (created) {},
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).primaryColor,
                      endIndent: 20,
                      indent: 20,
                    ),
                    ListView.builder(
                        itemCount: controller.traps.length,
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (_, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () async {
                                  await controller.getTrap(
                                      trapId: controller.traps[index].id);
                                  Get.to(() => TrapDetailsScreen(
                                        trap: controller.trap,
                                        readings: controller.readings,
                                      ));
                                },
                                child: Card(
                                  elevation: 2,
                                  shadowColor: Theme.of(context).primaryColor,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: Dimensions.width * 0.2,
                                          height: Dimensions.width * 0.2,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions
                                                          .RADIUS_DEFAULT),
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .primaryColor)),
                                          child: Center(
                                            child: SizedBox(
                                              height: Dimensions.width * 0.15,
                                              width: Dimensions.width * 0.15,
                                              child:
                                                  Image.asset(Images.trapIcon),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Dimensions.width * 0.02,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: Dimensions.height * 0.01,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(controller
                                                    .traps[index].name!),
                                                SizedBox(
                                                  width: Dimensions.width * 0.1,
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Image.asset(
                                                        controller.traps[index]
                                                                .isCounterOn!
                                                            ? Images.checkIcon
                                                            : Images.crossIcon,
                                                        height: 25),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      controller.traps[index]
                                                              .isCounterOn!
                                                          ? "ON"
                                                          : "OFF",
                                                      style: robotoMedium.copyWith(
                                                          fontSize: Dimensions
                                                              .fontSizeLarge,
                                                          color: controller
                                                                  .traps[index]
                                                                  .isCounterOn!
                                                              ? Colors.green
                                                              : Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .error),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: Dimensions.height * 0.01,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("Fan : ",
                                                        style: robotoMedium.copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontSize: Dimensions
                                                                .fontSizeLarge)),
                                                    CircularPercentIndicator(
                                                      radius: 20,
                                                      animation: true,
                                                      lineWidth: 2.0,
                                                      linearGradient:
                                                          const LinearGradient(
                                                              colors: [
                                                            Color(0xFFFFA900),
                                                            Color(0xFFFF7600),
                                                            Color(0xFFCD113B),
                                                          ],
                                                              begin: Alignment
                                                                  .topRight,
                                                              end: Alignment
                                                                  .topLeft),
                                                      percent: double.parse(
                                                              controller
                                                                      .traps[
                                                                          index]
                                                                      .fan ??
                                                                  "0.0") /
                                                          100,
                                                      center: Text(
                                                          "${double.parse(controller.traps[index].fan ?? "0.0") / 100}%",
                                                          style: robotoMedium
                                                              .copyWith(
                                                            fontSize: Dimensions
                                                                .fontSizeExtraSmall,
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: Dimensions.width * 0.1,
                                                ),
                                                Row(
                                                  children: [
                                                    Text("Valve Qut : ",
                                                        style: robotoMedium.copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontSize: Dimensions
                                                                .fontSizeLarge)),
                                                    CircularPercentIndicator(
                                                      radius: 20,
                                                      animation: true,
                                                      lineWidth: 2.0,
                                                      linearGradient:
                                                          const LinearGradient(
                                                              colors: [
                                                            Color(0xFFFFA900),
                                                            Color(0xFFFF7600),
                                                            Color(0xFFCD113B),
                                                          ],
                                                              begin: Alignment
                                                                  .topRight,
                                                              end: Alignment
                                                                  .topLeft),
                                                      percent: double.parse(
                                                              controller
                                                                      .traps[
                                                                          index]
                                                                      .valveQut ??
                                                                  "0.0") /
                                                          100,
                                                      center: Text(
                                                          "${double.parse(controller.traps[index].valveQut ?? "0.0") / 100}%",
                                                          style: robotoMedium
                                                              .copyWith(
                                                            fontSize: Dimensions
                                                                .fontSizeExtraSmall,
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: Dimensions.height * 0.01,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                controller.openMapDirection(
                                                    controller
                                                            .traps[index].lat ??
                                                        0.0,
                                                    controller.traps[index]
                                                            .long ??
                                                        0.0);
                                              },
                                              child: Material(
                                                elevation: 2,
                                                shadowColor: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions
                                                            .RADIUS_SMALL),
                                                child: Container(
                                                  width: Dimensions.width * 0.3,
                                                  height:
                                                      Dimensions.height * 0.04,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(Dimensions
                                                              .RADIUS_SMALL),
                                                      border: Border.all(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "location".tr,
                                                        style: robotoMedium.copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: Dimensions
                                                                .fontSizeSmall),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Flexible(
                                                          child: Image.asset(
                                                              Images.map)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: Dimensions.height * 0.01,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ))
                  ],
                ),
              )));
  }
}
