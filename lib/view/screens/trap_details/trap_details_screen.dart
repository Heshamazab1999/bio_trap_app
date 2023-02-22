import 'package:bio_trap/model/body/reading_model.dart';
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
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TrapDetailsScreen extends StatelessWidget {
  const TrapDetailsScreen({Key? key, this.name, this.id}) : super(key: key);
  final int? id;
  final String? name;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TrapDetailsController());
    controller.getTrap(trapId: id);

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
                              trap: controller.trap,
                            ),
                        transition: Transition.leftToRight),
                    child: Image.asset(Images.searchIcon,
                        width: 30, color: Theme.of(context).cardColor),
                  ),
                  SizedBox(width: Dimensions.width * 0.02),
                ],
                centerTitle: true,
                title: Text(
                  AppConstants.trap + name! + AppConstants.details,
                  style: robotoMedium.copyWith(
                      color: Theme.of(context).cardColor,
                      fontSize: Dimensions.fontSizeExtraLarge),
                ))),
        body: Obx(
          () => controller.loading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
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
                                      controller.trap!.isCounterOn!
                                          ? Images.checkIcon
                                          : Images.crossIcon,
                                      height: 25),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    controller.trap!.isCounterOn!
                                        ? AppConstants.oN
                                        : AppConstants.off,
                                    style: robotoMedium.copyWith(
                                        fontSize: Dimensions.fontSizeLarge,
                                        color: controller.trap!.isCounterOn!
                                            ? Colors.green
                                            : Theme.of(context)
                                                .colorScheme
                                                .error),
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
                                        controller.date.value,
                                        style: robotoMedium.copyWith(
                                            fontSize:
                                                Dimensions.fontSizeDefault),
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
                                        controller.readings == null
                                            ? AppConstants.time
                                            : controller.readings!.readingTime!,
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
                                  percentText:
                                      "${double.parse(controller.trap!.valveQut!)}%",
                                  percent:
                                      double.parse(controller.trap!.valveQut!) /
                                          100,
                                ))),
                      ),
                      SizedBox(height: Dimensions.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                              width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
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
                                            scheduleList: controller
                                                .trap!.trapFanSchedules!),
                                      ));
                                }),
                          ),
                          const SizedBox(
                              width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
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
                                            scheduleList: controller
                                                .trap!.trapValveQutSchedules!),
                                      ));
                                }),
                          ),
                          const SizedBox(
                              width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
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
                                            scheduleList: controller
                                                .trap!.trapCounterSchedules!),
                                      ));
                                }),
                          ),
                          const SizedBox(
                              width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        ],
                      ),
                      const SizedBox(
                        height: Dimensions.PADDING_SIZE_LARGE,
                      ),
                      Container(
                        height: Dimensions.height * 0.4,
                        width: Dimensions.width - 20,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor)),
                        child: CustomGoogleMap(
                          latLng: LatLng(controller.trap?.lat ?? 0.0,
                              controller.trap?.long ?? 0.0),
                          id: controller.trap?.id ?? 0,
                        ),
                      ),
                      SizedBox(height: Dimensions.height * 0.02),
                      Divider(
                        color: Theme.of(context).primaryColor,
                        endIndent: Dimensions.PADDING_SIZE_OVER_LARGE,
                        indent: Dimensions.PADDING_SIZE_OVER_LARGE,
                      ),
                      FixedChart(date: controller.date.value, dataSource: [
                        Readings(
                          readingWindSpeed: AppConstants.fixedDouble,
                          readingDate: AppConstants.fixedDate,
                          readingHumidty: AppConstants.fixedDouble,
                          readingTempOut: AppConstants.fixedDouble,
                          readingTempIn: AppConstants.fixedDouble,
                          readingLarg: controller.readings == null
                              ? AppConstants.fixedDouble
                              : controller.readings!.readingLarg ??
                                  AppConstants.fixedDouble,
                          readingFly: controller.readings == null
                              ? AppConstants.fixedDouble
                              : controller.readings!.readingFly ??
                                  AppConstants.fixedDouble,
                          readingTime: controller.readings == null
                              ? AppConstants.fixedDouble
                              : controller.readings!.readingTime ??
                                  AppConstants.fixedDate,
                          readingsmall: controller.readings == null
                              ? AppConstants.fixedDouble
                              : controller.readings!.readingsmall ??
                                  AppConstants.fixedDouble,
                          readingMosuqitoes: controller.readings == null
                              ? AppConstants.fixedDouble
                              : controller.readings!.readingMosuqitoes ??
                                  AppConstants.fixedDouble,
                        )
                      ]),
                      Divider(
                        color: Theme.of(context).primaryColor,
                        endIndent: Dimensions.PADDING_SIZE_OVER_LARGE,
                        indent: Dimensions.PADDING_SIZE_OVER_LARGE,
                      ),
                      SizedBox(height: Dimensions.height * 0.02),
                      SizedBox(
                        height: Dimensions.height * 0.2,
                        child: SfDataGrid(
                          isScrollbarAlwaysShown: true,
                          gridLinesVisibility: GridLinesVisibility.both,
                          headerGridLinesVisibility: GridLinesVisibility.both,
                          checkboxShape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Theme.of(context).primaryColor)),
                          onQueryRowHeight: (details) {
                            // Set the row height as 70.0 to the column header row.
                            return details.rowIndex == 0 ? 70.0 : 49.0;
                          },
                          source: controller.employeeDataSource,
                          columns: <GridColumn>[
                            GridColumn(
                                columnName: 'readingDate',
                                label: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'ReadingDate',
                                      overflow: TextOverflow.ellipsis,
                                    ))),
                            GridColumn(
                                columnName: 'readingTime',
                                label: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'ReadingTime',
                                      overflow: TextOverflow.ellipsis,
                                    ))),
                            GridColumn(
                                columnName: 'lat',
                                label: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Latitude ',
                                      overflow: TextOverflow.ellipsis,
                                    ))),
                            GridColumn(
                                columnName: 'long',
                                label: Container(
                                    alignment: Alignment.center,
                                    child: const Text('Longitude '))),
                            GridColumn(
                                columnName: 'counter',
                                label: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Counter ',
                                      overflow: TextOverflow.ellipsis,
                                    ))),
                            GridColumn(
                                columnName: 'mosuqitoes',
                                label: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Mosuqitoes ',
                                      overflow: TextOverflow.ellipsis,
                                    ))),
                            GridColumn(
                                columnName: 'fly',
                                label: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'fly',
                                      overflow: TextOverflow.ellipsis,
                                    ))),
                            GridColumn(
                                columnName: 'small',
                                label: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'small',
                                      overflow: TextOverflow.ellipsis,
                                    ))),
                            GridColumn(
                                columnName: 'large',
                                label: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'large',
                                      overflow: TextOverflow.ellipsis,
                                    ))),
                            GridColumn(
                                columnName: 'humidty',
                                label: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'humidty',
                                      overflow: TextOverflow.ellipsis,
                                    ))),
                            GridColumn(
                                columnName: 'co2Val',
                                label: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'co2Val',
                                      overflow: TextOverflow.ellipsis,
                                    ))),
                            GridColumn(
                                columnName: 'co2',
                                label: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'co2',
                                      overflow: TextOverflow.ellipsis,
                                    ))),
                            GridColumn(
                                columnName: 'fan',
                                label: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'Fan',
                                      overflow: TextOverflow.ellipsis,
                                    ))),
                            GridColumn(
                                columnName: 'WindSpeed',
                                label: Container(
                                    alignment: Alignment.center,
                                    child: const Text(
                                      'WindSpeed',
                                      overflow: TextOverflow.ellipsis,
                                    ))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ));
  }
}
