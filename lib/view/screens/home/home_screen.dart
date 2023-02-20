import 'package:bio_trap/enum/view_state.dart';
import 'package:bio_trap/helper/cache_helper.dart';
import 'package:bio_trap/util/app_constants.dart';
import 'package:bio_trap/util/dimensions.dart';
import 'package:bio_trap/util/images.dart';
import 'package:bio_trap/util/styles.dart';
import 'package:bio_trap/util/utility.dart';
import 'package:bio_trap/view/base/custom_card_trap.dart';
import 'package:bio_trap/view/base/custom_drawer_card.dart';
import 'package:bio_trap/view/screens/home/controller/home_controller.dart';
import 'package:bio_trap/view/screens/notification/notification_screen.dart';
import 'package:bio_trap/view/screens/trap_details/trap_details_screen.dart';
import 'package:bio_trap/view/screens/trap_management/trap_management_screen.dart';
import 'package:bio_trap/view/screens/users/users_screen.dart';
import 'package:bio_trap/view/screens/your_traps/your_traps_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
                    itemBuilder: (_, index) => CustomDrawerCard(
                          onTap: () {
                            if (index == 0) {
                              Get.to(
                                  () => TrapManagementScreen(
                                        traps: controller.traps,
                                      ),
                                  transition: Transition.leftToRight);
                            } else if (index == 1) {
                              CacheHelper.getData(key: AppConstants.role) ==
                                      AppConstants.superAdmin
                                  ? Get.to(() => const UsersScreen(),
                                      transition: Transition.leftToRight)
                                  : Get.to(
                                      () => YourTrapScreen(
                                            traps: controller.traps,
                                          ),
                                      transition: Transition.leftToRight);
                            } else if (index == 2) {
                              Get.to(
                                  () => YourTrapScreen(
                                        traps: controller.traps,
                                      ),
                                  transition: Transition.leftToRight);
                            }
                          },
                          images: controller.images[index],
                          labels: controller.labels[index],
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
                // Padding(
                //     padding: const EdgeInsets.symmetric(
                //         horizontal: Dimensions.PADDING_SIZE_SMALL,
                //         vertical: Dimensions.PADDING_SIZE_SMALL),
                //     child: Stack(
                //       alignment: Alignment.topRight,
                //       children: [
                //         GestureDetector(
                //          onTap: (){
                //            Get.to(() => NotificationScreen(
                //              notifications: controller.notificationList,
                //            ));
                //            CacheHelper.saveData(
                //                key: AppConstants.seen, value: true);
                //          } ,
                //           child: const Icon(Icons.notifications,
                //               size: Dimensions.PADDING_SIZE_OVER_Extra),
                //         ),
                //         Obx(
                //           () => controller.isOpen.value
                //               ? const SizedBox()
                //               : Container(
                //                   height: Dimensions.RADIUS_EXTRA_LARGE,
                //                   width: Dimensions.RADIUS_EXTRA_LARGE,
                //                   decoration: BoxDecoration(
                //                       color: Theme.of(context)
                //                           .secondaryHeaderColor,
                //                       shape: BoxShape.circle),
                //                   child: Center(
                //                       child: Text(controller
                //                           .notificationList.length
                //                           .toString())),
                //                 ),
                //         )
                //       ],
                //     )),
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
                    Container(
                      height: Dimensions.height / 2.5,
                      width: Dimensions.width -Dimensions.PADDING_SIZE_SMALL,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Theme.of(context).primaryColor)),
                      child: GoogleMap(
                        gestureRecognizers: Set()
                          ..add(Factory<PanGestureRecognizer>(
                                  () => PanGestureRecognizer()))
                          ..add(Factory<ScaleGestureRecognizer>(
                                  () => ScaleGestureRecognizer()))
                          ..add(Factory<TapGestureRecognizer>(
                                  () => TapGestureRecognizer()))
                          ..add(Factory<VerticalDragGestureRecognizer>(
                                  () =>
                                  VerticalDragGestureRecognizer())),
                        initialCameraPosition: CameraPosition(
                            target: LatLng(
                                controller.currentPosition.value.latitude,
                                controller.currentPosition.value.longitude),
                            zoom: 15),
                        markers: controller.markers,
                        onMapCreated: (created) {},
                        zoomControlsEnabled: true,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        zoomGesturesEnabled: true,
                        mapToolbarEnabled: true,

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
                              padding: const EdgeInsets.all(2),
                              child: CustomCardTrap(
                                onTap: () async {
                                  await controller.getTrap(
                                      trapId: controller.traps[index].id);
                                  Get.to(
                                      () => TrapDetailsScreen(
                                            trap: controller.trap,
                                            readings: controller.readings,
                                          ),
                                      transition: Transition.leftToRight);
                                },
                                openMap: () {
                                  controller.openMapDirection(
                                      controller.traps[index].lat ?? 0.0,
                                      controller.traps[index].long ?? 0.0);
                                },
                                valueQut: controller.traps[index].valveQut,
                                fan: controller.traps[index].fan,
                                working: controller.traps[index].isCounterOn!,
                                name: controller.traps[index].name!,
                              ),
                            ))
                  ],
                ),
              )));
  }
}
