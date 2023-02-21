import 'package:bio_trap/model/body/trap_model.dart';
import 'package:bio_trap/util/dimensions.dart';
import 'package:bio_trap/util/images.dart';
import 'package:bio_trap/util/styles.dart';
import 'package:bio_trap/view/base/custom_chart.dart';
import 'package:bio_trap/view/base/custom_elevated_button.dart';
import 'package:bio_trap/view/screens/search_trap/controller/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key, this.trap}) : super(key: key);
  final TrapModel? trap;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchController());
    return WillPopScope(
      onWillPop: () async {
        Get.delete<SearchController>();
        return true;
      },
      child: Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(Dimensions.height * 0.1),
              child: AppBar(
                  leadingWidth: Dimensions.width * 0.12,
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.back(
                          closeOverlays: true,
                        );
                        Get.delete<SearchController>(force: true);
                      },
                      child: Image.asset(Images.arrowIcon,
                          color: Theme.of(context).cardColor),
                    ),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                  elevation: 0,
                  centerTitle: true,
                  title: Text(
                    trap!.name!,
                    style: robotoMedium.copyWith(
                        color: Theme.of(context).cardColor,
                        fontSize: Dimensions.fontSizeExtraLarge),
                  ))),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Dimensions.height * 0.04),
                Text("Search Statistics for Reading Trap",
                    style: robotoMedium.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: Dimensions.fontSizeLarge)),
                SizedBox(height: Dimensions.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomElevatedButton(
                      image: Images.calendarSelectIcon,
                      label: "Select Start Date",
                      onTap: () async {
                        final date =
                            await controller.showCalender(context: context);
                        var output = DateFormat('y-M-d');
                        controller.startDate.value = output.format(date!);
                        print(output.format(date));
                      },
                    ),
                    CustomElevatedButton(
                      image: Images.calendarSelectIcon,
                      label: "Select End Date",
                      onTap: () async {
                        final date =
                            await controller.showCalender(context: context);
                        var output = DateFormat('y-M-d');
                        controller.endDate.value = output.format(date!);
                        print(output.format(date));
                      },
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.height * 0.02),
                Obx(() => controller.load.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : CustomElevatedButton(
                        image: Images.searchIcon,
                        label: "Search",
                        onTap: () async {
                          controller.getTrapReading(id: trap!.id);
                        },
                      )),
                Obx(() => controller.load.value
                        ? Center(
                            child: Column(
                              children: [
                                SizedBox(height: Dimensions.height * 0.1),
                                Image.asset(
                                  Images.logoAnimation,
                                  color: Theme.of(context).primaryColor,
                                  width: Dimensions.width * 0.5,
                                ),
                              ],
                            ),
                          )
                        : controller.reading == null
                            ? Column(
                                children: [
                                  SizedBox(height: Dimensions.height * 0.1),
                                  Image.asset(
                                    Images.emptyIcon,
                                    color: Theme.of(context).primaryColor,
                                    height: Dimensions.height * 0.2,
                                  ),
                                  Text("No Found Reading ",
                                      style: robotoMedium.copyWith(
                                          color:
                                              Theme.of(context).primaryColor)),
                                ],
                              )
                            : ListView.separated(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                separatorBuilder: (_, items) => Divider(
                                  color: Theme.of(context).primaryColor,
                                  endIndent: 20,
                                  indent: 20,
                                ),
                                itemCount: controller.reading!.readings!.length,
                                itemBuilder: (_, index) {
                                  var output = DateFormat('y-M-d');
                                  var input = DateTime.parse(
                                      controller.reading == null
                                          ? "0000-00-00"
                                          : controller
                                              .reading!.readings![index].date!);

                                  return CustomChart(
                                    tooltipBehavior: controller.tooltipBehavior,
                                    title: output.format(input),
                                    index: index,
                                    reading: controller.readingList,
                                  );
                                },
                              )

                    )
              ],
            ),
          )),
    );
  }
}
