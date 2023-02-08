import 'package:bio_trap/enum/view_state.dart';
import 'package:bio_trap/model/body/reading_model.dart';
import 'package:bio_trap/model/body/trap_model.dart';
import 'package:bio_trap/model/body/trap_reading_model.dart';
import 'package:bio_trap/util/dimensions.dart';
import 'package:bio_trap/util/images.dart';
import 'package:bio_trap/util/styles.dart';
import 'package:bio_trap/util/utility.dart';
import 'package:bio_trap/view/base/custom_button.dart';
import 'package:bio_trap/view/base/custom_chart.dart';
import 'package:bio_trap/view/screens/search_trap/search_screen.dart';
import 'package:bio_trap/view/screens/trap_details/controller/trap_details_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TrapDetailsScreen extends StatelessWidget {
  const TrapDetailsScreen({
    Key? key,
    this.trap,
  }) : super(key: key);
  final TrapModel? trap;

  // final ReadingTrapModel? reading;

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = <ChartData>[
      ChartData(2010, 10.53),
      ChartData(2011, 9.5),
      ChartData(2012, 10),
      ChartData(2013, 9.4),
      ChartData(2014, 5.8),
      ChartData(2015, 4.9),
      ChartData(2016, 4.5),
      ChartData(2017, 3.6),
      ChartData(2018, 3.43),
    ];
    final controller = Get.put(TrapDetailsController(id: trap!.id));
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
                    onTap: () => Get.back(
                      closeOverlays: true,
                    ),
                    child: Image.asset(Images.arrowIcon,
                        color: Theme.of(context).cardColor),
                  ),
                ),
                backgroundColor: Theme.of(context).primaryColor,
                elevation: 0,
                actions: [
                  GestureDetector(
                    onTap: () => Get.to(() => SearchScreen(
                          trap: trap,
                        )),
                    child: Image.asset(Images.searchIcon,
                        width: 30, color: Theme.of(context).cardColor),
                  ),
                  SizedBox(width: Dimensions.width * 0.02),
                ],
                centerTitle: true,
                title: Text(
                  trap!.name!,
                  style: robotoMedium.copyWith(
                      color: Theme.of(context).cardColor,
                      fontSize: Dimensions.fontSizeExtraLarge),
                ))),
        body: Obx(
          () => controller.state == ViewState.busy
              ? Center(
                  child: Image.asset(
                    Images.logoAnimation,
                    color: Theme.of(context).primaryColor,
                    width: Dimensions.width * 0.5,
                  ),
                )
              : SingleChildScrollView(
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
                                "Working",
                                style: robotoMedium.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: Dimensions.fontSizeLarge),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Switch(
                                      value: trap!.isCounterOn!,
                                      onChanged: (v) {},
                                      activeColor:
                                          Theme.of(context).primaryColor,
                                      inactiveThumbColor:
                                          Theme.of(context).colorScheme.error),
                                  Text(
                                    trap!.isCounterOn! ? "ON" : "OFF",
                                    style: robotoMedium.copyWith(
                                        fontSize: Dimensions.fontSizeLarge,
                                        color: trap!.isCounterOn!
                                            ? Theme.of(context).primaryColor
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
                                "Last Reading Date :",
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
                                        trap!.readingDate == null
                                            ? "00-00-00"
                                            : trap!.readingDate!
                                                .split("/")
                                                .first,
                                        // trap!.readingDate!.split("/").first??"00-00-00",
                                        style: robotoMedium.copyWith(
                                            fontSize: Dimensions.fontSizeLarge),
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
                                "Last Reading Time :",
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
                                        trap!.readingDate == null
                                            ? "00-00-00"
                                            : trap!.readingDate!
                                                .split("/")
                                                .last,
                                        // trap!.readingDate!.split("/").first??"00-00-00",
                                        style: robotoMedium.copyWith(
                                            fontSize: Dimensions.fontSizeLarge),
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
                              title: Text("Co2 Valve : ",
                                  style: robotoMedium.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: Dimensions.fontSizeLarge)),
                              trailing: CircularPercentIndicator(
                                radius: 20,
                                animation: true,
                                lineWidth: 2.0,
                                linearGradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFFA900),
                                      Color(0xFFFF7600),
                                      Color(0xFFCD113B),
                                    ],
                                    begin: Alignment.topRight,
                                    end: Alignment.topLeft),
                                percent: (double.tryParse(trap!.fan!)! / 100),
                                center: Text(
                                    "${(double.tryParse(trap!.fan!)! / 100)}%",
                                    style: robotoMedium.copyWith(
                                      fontSize: Dimensions.fontSizeExtraSmall,
                                    )),
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
                              title: Text("Valve Qut :",
                                  style: robotoMedium.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: Dimensions.fontSizeLarge)),
                              trailing: CircularPercentIndicator(
                                radius: 20,
                                animation: true,
                                linearGradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFFFA900),
                                      Color(0xFFFF7600),
                                      Color(0xFFCD113B),
                                    ],
                                    begin: Alignment.topRight,
                                    end: Alignment.topLeft),
                                lineWidth: 2.0,
                                percent:
                                    double.tryParse(trap!.valveQut!)! / 100,
                                center: Text(
                                    "${double.tryParse(trap!.valveQut!)! / 100}%",
                                    style: robotoMedium.copyWith(
                                      fontSize: Dimensions.fontSizeExtraSmall,
                                    )),
                              ),
                            )),
                      ),
                      SizedBox(height: Dimensions.height * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 5),
                          CustomButton(
                              width: Dimensions.width * 0.4,
                              radius: 4,
                              height: Dimensions.height * 0.04,
                              buttonText: "Schedule Fan",
                              onPressed: () {
                                Utility.displayScheduleAlert(
                                    "Schedule Fan", context,
                                    widget: SizedBox(
                                      height: Dimensions.height / 3,
                                      width: Dimensions.width,
                                      child: GridView.builder(
                                        itemCount:
                                            trap!.trapFanSchedules!.length,
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4,
                                                childAspectRatio: 1.7,
                                                crossAxisSpacing: 4,
                                                mainAxisSpacing: 4),
                                        itemBuilder: (_, index) => Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: const Offset(0, 3),
                                                  blurRadius: 4,
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                ),
                                              ],
                                              color: trap!
                                                      .trapFanSchedules![index]
                                                      .status!
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Theme.of(context).cardColor,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                  trap!.trapFanSchedules![index]
                                                      .scdTime
                                                      .toString(),
                                                  style: robotoMedium.copyWith(
                                                      color: trap!
                                                              .trapFanSchedules![
                                                                  index]
                                                              .status!
                                                          ? Theme.of(context)
                                                              .cardColor
                                                          : Colors.black,
                                                      fontSize: 18)),
                                            )),
                                      ),
                                    ));
                              }),
                          const SizedBox(width: 5),
                          CustomButton(
                              radius: 4,
                              width: Dimensions.width * 0.4,
                              height: Dimensions.height * 0.04,
                              buttonText: "Schedule Val Qut",
                              onPressed: () {
                                Utility.displayScheduleAlert(
                                    "Schedule  Val Qut", context,
                                    widget: SizedBox(
                                      height: Dimensions.height / 3,
                                      width: Dimensions.width,
                                      child: GridView.builder(
                                        itemCount:
                                            trap!.trapValveQutSchedules!.length,
                                        physics: const BouncingScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4,
                                                childAspectRatio: 1.7,
                                                crossAxisSpacing: 4,
                                                mainAxisSpacing: 4),
                                        itemBuilder: (_, index) => Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: const Offset(0, 3),
                                                  blurRadius: 4,
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                ),
                                              ],
                                              color: trap!
                                                      .trapValveQutSchedules![
                                                          index]
                                                      .status!
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Theme.of(context).cardColor,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                  trap!
                                                      .trapValveQutSchedules![
                                                          index]
                                                      .scdTime
                                                      .toString(),
                                                  style: robotoMedium.copyWith(
                                                      color: trap!
                                                              .trapValveQutSchedules![
                                                                  index]
                                                              .status!
                                                          ? Theme.of(context)
                                                              .cardColor
                                                          : Colors.black,
                                                      fontSize: 18)),
                                            )),
                                      ),
                                    ));
                              }),
                          const SizedBox(width: 5),
                        ],
                      ),
                      CustomButton(
                          width: Dimensions.width * 0.4,
                          radius: 4,
                          height: Dimensions.height * 0.04,
                          buttonText: "Schedule Counter",
                          onPressed: () {
                            Utility.displayScheduleAlert("Counter Fan", context,
                                widget: SizedBox(
                                  height: Dimensions.height / 3,
                                  width: Dimensions.width,
                                  child: GridView.builder(
                                    itemCount:
                                        trap!.trapCounterSchedules!.length,
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 4,
                                            childAspectRatio: 1.7,
                                            crossAxisSpacing: 4,
                                            mainAxisSpacing: 4),
                                    itemBuilder: (_, index) => Container(
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              offset: const Offset(0, 3),
                                              blurRadius: 4,
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                            ),
                                          ],
                                          color: trap!
                                                  .trapCounterSchedules![index]
                                                  .status!
                                              ? Theme.of(context).primaryColor
                                              : Theme.of(context).cardColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                              trap!.trapCounterSchedules![index]
                                                  .scdTime
                                                  .toString(),
                                              style: robotoMedium.copyWith(
                                                  color: trap!
                                                          .trapCounterSchedules![
                                                              index]
                                                          .status!
                                                      ? Theme.of(context)
                                                          .cardColor
                                                      : Colors.black,
                                                  fontSize: 18)),
                                        )),
                                  ),
                                ));
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: Dimensions.height * 0.3,
                        width: Dimensions.width - 20,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).primaryColor)),
                        child: GoogleMap(
                          zoomControlsEnabled: false,
                          initialCameraPosition: CameraPosition(
                              target: LatLng(trap!.lat!, trap!.long!),
                              zoom: 10),
                          markers: <Marker>{
                            Marker(
                                markerId: MarkerId(
                                  "${trap!.id}",
                                ),
                                position: LatLng(trap!.lat!, trap!.long!))
                          },
                        ),
                      ),
                      SizedBox(height: Dimensions.height * 0.02),
                      Divider(
                        color: Theme.of(context).primaryColor,
                        endIndent: 40,
                        indent: 40,
                      ),
                      Container(
                          child: SfCartesianChart(
                        onLegendItemRender: (LegendRenderArgs args) {

                          args.text = "ttttt";
                        },
                        legend: Legend(
                          isVisible: true,

                          // Overflowing legend content will be wraped
                        ),
                        primaryXAxis: NumericAxis(
                            decimalPlaces: 5, anchorRangeToVisiblePoints: true),
                        primaryYAxis: NumericAxis(
                            decimalPlaces: 4,
                            rangePadding: ChartRangePadding.none),
                        series: <ChartSeries<Readings, double>>[
                          LineSeries<Readings, double>(
                              markerSettings: MarkerSettings(isVisible: true),
                              color: Colors.amber,
                              dataSource: controller.reading!.readings!,
                              xValueMapper: (Readings data, _) => double.parse(
                                  data.readingTime!.replaceAll(":", ".")),
                              yValueMapper: (Readings data, _) =>
                                  double.parse(data.readingsmall!)),
                          LineSeries<Readings, double>(
                              markerSettings: MarkerSettings(isVisible: true),
                              color: Colors.red,
                              dataSource: controller.reading!.readings!,
                              xValueMapper: (Readings data, _) => double.parse(
                                  data.readingTime!.replaceAll(":", ".")),
                              yValueMapper: (Readings data, _) =>
                                  double.parse(data.readingLarg!)),
                          LineSeries<Readings, double>(
                              markerSettings: MarkerSettings(isVisible: true),
                              color: Colors.green,
                              dataSource: controller.reading!.readings!,
                              xValueMapper: (Readings data, _) => double.parse(
                                  data.readingTime!.replaceAll(":", ".")),
                              yValueMapper: (Readings data, _) =>
                                  double.parse(data.readingMosuqitoes!)),
                          LineSeries<Readings, double>(
                              markerSettings: MarkerSettings(isVisible: true),
                              color: Colors.blue,
                              dataSource: controller.reading!.readings!,
                              xValueMapper: (Readings data, _) => double.parse(
                                  data.readingTime!.replaceAll(":", ".")),
                              yValueMapper: (Readings data, _) =>
                                  double.parse(data.readingFly!)),
                        ],
                      )),
                      // SfCartesianChart(
                      //     title: ChartTitle(
                      //         text: "gggg",
                      //         textStyle: TextStyle(
                      //             color: Theme.of(context).primaryColor)),
                      //     enableAxisAnimation: true,
                      //     enableSideBySideSeriesPlacement: true,
                      //     primaryXAxis: CategoryAxis(),
                      //     series: <ChartSeries>[
                      //       StackedLineSeries<Readings, dynamic>(
                      //         dataSource: controller.reading!.readings!,
                      //         animationDuration: 1.0,
                      //         color: Theme.of(context).primaryColor,
                      //         xValueMapper: (Readings sales, _) => num.parse(
                      //             sales.readingTime!.replaceAll(":", ".")),
                      //         yValueMapper: (Readings sales, _) =>
                      //             num.parse(sales.readingsmall!),
                      //       )
                      //     ])
                      // SizedBox(height: Dimensions.height * 0.02),
                      // CustomChart(
                      //   label: "ReadingTempIn",
                      //   data: controller.reading == null ?[Readings(
                      //     readingWindSpeed: "0.0",
                      //     readingDate: "0:0",
                      //     readingHumidty: "0.0",
                      //     readingTempOut: "0.0",
                      //     readingTempIn: "0.0",
                      //     readingLarg: "0.0",
                      //     readingFly: "0.0",
                      //     readingTime: "0:0",
                      //     readingsmall: "0.0",
                      //     readingMosuqitoes: "0.0",
                      //   )] :controller.reading!.readings,
                      //   yValueMapper: (Readings sales, _) =>
                      //       double.tryParse(sales.readingTempIn!),
                      // ),
                      // SizedBox(height: Dimensions.height * 0.02),
                      // Divider(
                      //   color: Theme
                      //       .of(context)
                      //       .primaryColor,
                      //   endIndent: 40,
                      //   indent: 40,
                      // ),
                      // CustomChart(
                      //   label: "ReadingTempOut",
                      //   data: controller.reading == null ?[Readings(
                      //     readingWindSpeed: "0.0",
                      //     readingDate: "0:0",
                      //     readingHumidty: "0.0",
                      //     readingTempOut: "0.0",
                      //     readingTempIn: "0.0",
                      //     readingLarg: "0.0",
                      //     readingFly: "0.0",
                      //     readingTime: "0:0",
                      //     readingsmall: "0.0",
                      //     readingMosuqitoes: "0.0",
                      //   )] :controller.reading!.readings,
                      //   yValueMapper: (Readings sales, _) =>
                      //       double.tryParse(sales.readingTempOut!),
                      // ),
                      // SizedBox(height: Dimensions.height * 0.02),
                      // Divider(
                      //   color: Theme
                      //       .of(context)
                      //       .primaryColor,
                      //   endIndent: 40,
                      //   indent: 40,
                      // ),
                      // CustomChart(
                      //   label: "ReadingMosuqitoes",
                      //   data: controller.reading == null ?[Readings(
                      //     readingWindSpeed: "0.0",
                      //     readingDate: "0:0",
                      //     readingHumidty: "0.0",
                      //     readingTempOut: "0.0",
                      //     readingTempIn: "0.0",
                      //     readingLarg: "0.0",
                      //     readingFly: "0.0",
                      //     readingTime: "0:0",
                      //     readingsmall: "0.0",
                      //     readingMosuqitoes: "0.0",
                      //   )] :controller.reading!.readings,
                      //   yValueMapper: (Readings sales, _) =>
                      //       double.tryParse(sales.readingMosuqitoes!),
                      // ),
                      // SizedBox(height: Dimensions.height * 0.02),
                      // Divider(
                      //   color: Theme
                      //       .of(context)
                      //       .primaryColor,
                      //   endIndent: 40,
                      //   indent: 40,
                      // ),
                      // CustomChart(
                      //   label: "ReadingWindSpeed",
                      //   data: controller.reading == null ?[Readings(
                      //     readingWindSpeed: "0.0",
                      //     readingDate: "0:0",
                      //     readingHumidty: "0.0",
                      //     readingTempOut: "0.0",
                      //     readingTempIn: "0.0",
                      //     readingLarg: "0.0",
                      //     readingFly: "0.0",
                      //     readingTime: "0:0",
                      //     readingsmall: "0.0",
                      //     readingMosuqitoes: "0.0",
                      //   )] :controller.reading!.readings,
                      //   yValueMapper: (Readings sales, _) =>
                      //       double.tryParse(sales.readingWindSpeed!),
                      // ),
                      // SizedBox(height: Dimensions.height * 0.02),
                      // Divider(
                      //   color: Theme
                      //       .of(context)
                      //       .primaryColor,
                      //   endIndent: 40,
                      //   indent: 40,
                      // ),
                      // CustomChart(
                      //   label: "Reading Humidty",
                      //   data: controller.reading == null ?[Readings(
                      //     readingWindSpeed: "0.0",
                      //     readingDate: "0:0",
                      //     readingHumidty: "0.0",
                      //     readingTempOut: "0.0",
                      //     readingTempIn: "0.0",
                      //     readingLarg: "0.0",
                      //     readingFly: "0.0",
                      //     readingTime: "0:0",
                      //     readingsmall: "0.0",
                      //     readingMosuqitoes: "0.0",
                      //   )] :controller.reading!.readings,
                      //   yValueMapper: (Readings sales, _) =>
                      //       double.tryParse(sales.readingHumidty!),
                      // ),
                      // SizedBox(height: Dimensions.height * 0.02),
                      // Divider(
                      //   color: Theme
                      //       .of(context)
                      //       .primaryColor,
                      //   endIndent: 40,
                      //   indent: 40,
                      // ),
                      // CustomChart(
                      //   label: "Reading Fly",
                      //   data: controller.reading == null ?[Readings(
                      //     readingWindSpeed: "0.0",
                      //     readingDate: "0:0",
                      //     readingHumidty: "0.0",
                      //     readingTempOut: "0.0",
                      //     readingTempIn: "0.0",
                      //     readingLarg: "0.0",
                      //     readingFly: "0.0",
                      //     readingTime: "0:0",
                      //     readingsmall: "0.0",
                      //     readingMosuqitoes: "0.0",
                      //   )] :controller.reading!.readings,
                      //   yValueMapper: (Readings sales, _) =>
                      //       double.tryParse(sales.readingFly!),
                      // ),
                      // SizedBox(height: Dimensions.height * 0.02),
                      // Divider(
                      //   color: Theme
                      //       .of(context)
                      //       .primaryColor,
                      //   endIndent: 40,
                      //   indent: 40,
                      // ),
                      // CustomChart(
                      //   label: "Reading Large",
                      //   data: controller.reading == null ?[Readings(
                      //     readingWindSpeed: "0.0",
                      //     readingDate: "0:0",
                      //     readingHumidty: "0.0",
                      //     readingTempOut: "0.0",
                      //     readingTempIn: "0.0",
                      //     readingLarg: "0.0",
                      //     readingFly: "0.0",
                      //     readingTime: "0:0",
                      //     readingsmall: "0.0",
                      //     readingMosuqitoes: "0.0",
                      //   )] :controller.reading!.readings,
                      //   yValueMapper: (Readings sales, _) =>
                      //       double.tryParse(sales.readingLarg!),
                      // ),
                      // SizedBox(height: Dimensions.height * 0.02),
                      // Divider(
                      //   color: Theme
                      //       .of(context)
                      //       .primaryColor,
                      //   endIndent: 40,
                      //   indent: 40,
                      // ),
                      // CustomChart(
                      //   label: "Reading Small",
                      //   data: controller.reading == null ?[Readings(
                      //     readingWindSpeed: "0.0",
                      //     readingDate: "0:0",
                      //     readingHumidty: "0.0",
                      //     readingTempOut: "0.0",
                      //     readingTempIn: "0.0",
                      //     readingLarg: "0.0",
                      //     readingFly: "0.0",
                      //     readingTime: "0:0",
                      //     readingsmall: "0.0",
                      //     readingMosuqitoes: "0.0",
                      //   )] :controller.reading!.readings,
                      //   yValueMapper: (Readings sales, _) =>
                      //       double.tryParse(sales.readingsmall!),
                      // ),
                      // SizedBox(height: Dimensions.height * 0.02),
                      // Divider(
                      //   color: Theme
                      //       .of(context)
                      //       .primaryColor,
                      //   endIndent: 40,
                      //   indent: 40,
                      // ),
                      // CustomChart(
                      //   label: "Reading Wind Speed",
                      //   data: controller.reading == null ?[Readings(
                      //     readingWindSpeed: "0.0",
                      //     readingDate: "0:0",
                      //     readingHumidty: "0.0",
                      //     readingTempOut: "0.0",
                      //     readingTempIn: "0.0",
                      //     readingLarg: "0.0",
                      //     readingFly: "0.0",
                      //     readingTime: "0:0",
                      //     readingsmall: "0.0",
                      //     readingMosuqitoes: "0.0",
                      //   )] :controller.reading!.readings,
                      //   yValueMapper: (Readings sales, _) =>
                      //       double.tryParse(sales.readingWindSpeed!),
                      // ),
                    ],
                  ),
                ),
        ));
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final double x;
  final double y;
}
