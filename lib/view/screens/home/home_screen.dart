import 'package:bio_trap/util/dimensions.dart';
import 'package:bio_trap/util/images.dart';
import 'package:bio_trap/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color(0xFFF9FEFE),
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(Dimensions.height * 0.15),
              // here the desired height
              child: AppBar(
                leadingWidth: Dimensions.width * 0.13,
                leading: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset(
                    Images.exitIcon,
                  ),
                ),
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 0,
                centerTitle: true,
                title: Image.asset(Images.logoName,
                    width: Dimensions.width * 0.3,
                    color: Theme.of(context).cardColor),
                bottom: TabBar(
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8)),
                        color: Colors.white),
                    tabs: [
                      Tab(
                          child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Flexible(child: Image.asset(Images.listIcon)),
                            Flexible(
                                child: Text(
                              "trap".tr,
                              style: robotoMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Dimensions.fontSizeExtraLarge),
                            )),
                          ],
                        ),
                      )),
                      Tab(
                        child: Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Flexible(child: Image.asset(Images.map)),
                              Flexible(
                                  child: Text(
                                "location".tr,
                                style: robotoMedium.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Dimensions.fontSizeExtraLarge),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ]),
              )),
          body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ListView.builder(
                    itemCount: 3,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (_, index) => Card(
                          child: Row(
                            children: [
                              Container(
                                width: Dimensions.width * 0.35,
                                height: Dimensions.width * 0.35,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Theme.of(context).primaryColor)),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Image.asset(
                                    Images.trapIcon,
                                  ),
                                ),
                              ),
                              Text("datadata",style: robotoMedium.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontSize: Dimensions.fontSizeSmall,
                              )),
                            ],
                          ),
                        )),
                GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: LatLng(32.1, 31.0)),
                )
              ]),
        ));
  }
}
