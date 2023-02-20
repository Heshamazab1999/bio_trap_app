import 'package:bio_trap/model/body/reading_model.dart';
import 'package:bio_trap/model/body/trap_model.dart';
import 'package:bio_trap/util/app_constants.dart';
import 'package:bio_trap/util/dimensions.dart';
import 'package:bio_trap/util/images.dart';
import 'package:bio_trap/util/styles.dart';
import 'package:bio_trap/util/utility.dart';
import 'package:bio_trap/view/base/custom_button.dart';
import 'package:bio_trap/view/base/custom_circle_indecator.dart';
import 'package:bio_trap/view/base/custom_google_map.dart';
import 'package:bio_trap/view/base/custom_gridview_schedule.dart';
import 'package:bio_trap/view/base/fixed_chart.dart';
import 'package:bio_trap/view/screens/search_trap/search_screen.dart';
import 'package:bio_trap/view/screens/trap_details/controller/trap_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class TrapDetailsScreen extends StatelessWidget {
  const TrapDetailsScreen({
    Key? key,
    this.trap,
    this.readings,
  }) : super(key: key);
  final TrapModel? trap;
  final Readings? readings;

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(TrapDetailsController(id: trap!.id));
    var output = DateFormat('y-M-d');
    var input = DateTime.parse(
        readings == null ? "0000-00-00" : readings!.readingDate!);
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
                GestureDetector(
                  onTap: () => Get.to(
                      () => SearchScreen(
                            trap: trap,
                          ),
                      transition: Transition.leftToRight),
                  child: Image.asset(Images.searchIcon,
                      width: 30, color: Theme.of(context).cardColor),
                ),
                SizedBox(width: Dimensions.width * 0.02),
              ],
              centerTitle: true,
              title: Text(
                AppConstants.trap + trap!.name! + AppConstants.details,
                style: robotoMedium.copyWith(
                    color: Theme.of(context).cardColor,
                    fontSize: Dimensions.fontSizeExtraLarge),
              ))),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Dimensions.height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Material(
                  elevation: 1,
                  shadowColor: Theme.of(context).primaryColor,
                  child: ListTile(
                    title: Text(
                      AppConstants.working,
                      style: robotoMedium.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontSize: Dimensions.fontSizeLarge),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                            trap!.isCounterOn!
                                ? Images.checkIcon
                                : Images.crossIcon,
                            height: 25),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          trap!.isCounterOn!
                              ? AppConstants.oN
                              : AppConstants.off,
                          style: robotoMedium.copyWith(
                              fontSize: Dimensions.fontSizeLarge,
                              color: trap!.isCounterOn!
                                  ? Colors.green
                                  : Theme.of(context).colorScheme.error),
                        )
                      ],
                    ),
                  )),
            ),
            SizedBox(height: Dimensions.height * 0.01),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Material(
                  elevation: 1,
                  shadowColor: Theme.of(context).primaryColor,
                  child: ListTile(
                    title: Text(
                      AppConstants.lastReadingDate,
                      style: robotoMedium.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontSize: Dimensions.fontSizeLarge),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(
                              output.format(input),
                              style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeDefault),
                            ),
                            SizedBox(width: Dimensions.width * 0.01),
                            Image.asset(
                              Images.calendarIcon,
                              width: Dimensions.width * 0.06,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
            SizedBox(height: Dimensions.height * 0.01),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Material(
                  elevation: 1,
                  shadowColor: Theme.of(context).primaryColor,
                  child: ListTile(
                    title: Text(
                      AppConstants.lastReadingTime,
                      style: robotoMedium.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontSize: Dimensions.fontSizeLarge),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(
                              readings == null
                                  ? AppConstants.time
                                  : readings!.readingTime!,
                              style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeSmall),
                            ),
                            SizedBox(width: Dimensions.width * 0.01),
                            Image.asset(
                              Images.clockIcon,
                              width: Dimensions.width * 0.06,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
            SizedBox(height: Dimensions.height * 0.01),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Material(
                  elevation: 1,
                  shadowColor: Theme.of(context).primaryColor,
                  child: ListTile(
                      title: Text(AppConstants.co2,
                          style: robotoMedium.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontSize: Dimensions.fontSizeLarge)),
                      trailing: const CustomCircleIndicator(
                        percentText: AppConstants.fixedPercent,
                      ))),
            ),
            SizedBox(height: Dimensions.height * 0.01),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Material(
                  elevation: 1,
                  shadowColor: Theme.of(context).primaryColor,
                  child: ListTile(
                      title: Text(AppConstants.scheduleValQut,
                          style: robotoMedium.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontSize: Dimensions.fontSizeLarge)),
                      trailing: CustomCircleIndicator(
                        percentText: "${double.parse(trap!.valveQut!)}%",
                        percent: double.parse(trap!.valveQut!) / 100,
                      ))),
            ),
            SizedBox(height: Dimensions.height * 0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                Expanded(
                  child: CustomButton(
                      radius: 4,
                      height: Dimensions.height * 0.01,
                      buttonText: AppConstants.scheduleFan,
                      onPressed: () {
                        Utility.displayScheduleAlert(
                            AppConstants.scheduleFan, context,
                            widget: SizedBox(
                              height: Dimensions.height / 3,
                              width: Dimensions.width,
                              child: CustomGridViewSchedule(
                                  scheduleList: trap!.trapFanSchedules!),
                            ));
                      }),
                ),
                const SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                Expanded(
                  child: CustomButton(
                      radius: 4,
                      height: Dimensions.height * 0.04,
                      buttonText: AppConstants.scheduleValQut,
                      onPressed: () {
                        Utility.displayScheduleAlert(
                            AppConstants.scheduleValQut, context,
                            widget: SizedBox(
                              height: Dimensions.height / 3,
                              width: Dimensions.width,
                              child: CustomGridViewSchedule(
                                  scheduleList: trap!.trapValveQutSchedules!),
                            ));
                      }),
                ),
                const SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                Expanded(
                  child: CustomButton(
                      radius: 4,
                      height: Dimensions.height * 0.04,
                      buttonText: AppConstants.scheduleCounter,
                      onPressed: () {
                        Utility.displayScheduleAlert(
                            AppConstants.counterFan, context,
                            widget: SizedBox(
                              height: Dimensions.height / 3,
                              width: Dimensions.width,
                              child: CustomGridViewSchedule(
                                  scheduleList: trap!.trapCounterSchedules!),
                            ));
                      }),
                ),
                const SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              ],
            ),
            const SizedBox(
              height: Dimensions.PADDING_SIZE_LARGE,
            ),
            Container(
              height: Dimensions.height * 0.3,
              width: Dimensions.width - 20,
              decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).primaryColor)),
              child: CustomGoogleMap(
                latLng: LatLng(trap?.lat ?? 0.0, trap?.long ?? 0.0),
                id: trap?.id ?? 0,
              ),
            ),
            SizedBox(height: Dimensions.height * 0.02),
            Divider(
              color: Theme.of(context).primaryColor,
              endIndent: Dimensions.PADDING_SIZE_OVER_LARGE,
              indent: Dimensions.PADDING_SIZE_OVER_LARGE,
            ),
            FixedChart(date: output.format(input), dataSource: [
              Readings(
                readingWindSpeed: AppConstants.fixedDouble,
                readingDate: AppConstants.fixedDate,
                readingHumidty: AppConstants.fixedDouble,
                readingTempOut: AppConstants.fixedDouble,
                readingTempIn: AppConstants.fixedDouble,
                readingLarg: readings == null
                    ? AppConstants.fixedDouble
                    : readings!.readingLarg ?? AppConstants.fixedDouble,
                readingFly: readings == null
                    ? AppConstants.fixedDouble
                    : readings!.readingFly ?? AppConstants.fixedDouble,
                readingTime: readings == null
                    ? AppConstants.fixedDouble
                    : readings!.readingTime ?? AppConstants.fixedDate,
                readingsmall: readings == null
                    ? AppConstants.fixedDouble
                    : readings!.readingsmall ?? AppConstants.fixedDouble,
                readingMosuqitoes: readings == null
                    ? AppConstants.fixedDouble
                    : readings!.readingMosuqitoes ?? AppConstants.fixedDouble,
              )
            ])
          ],
        ),
      ),
    );
  }
}
