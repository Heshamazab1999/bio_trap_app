import 'package:bio_trap/model/body/trap_model.dart';
import 'package:bio_trap/util/dimensions.dart';
import 'package:bio_trap/util/images.dart';
import 'package:bio_trap/util/styles.dart';
import 'package:bio_trap/util/utility.dart';
import 'package:bio_trap/view/base/custom_button.dart';
import 'package:bio_trap/view/screens/trap_details/controller/trap_details_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TrapDetailsScreen extends StatelessWidget {
  const TrapDetailsScreen({Key? key, this.trap}) : super(key: key);
  final TrapModel? trap;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TrapDetailsController());
    print(trap!.isCounterOn);
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
              title: Text(
                trap!.name!,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Working",
                    style: robotoMedium.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: Dimensions.fontSizeLarge),
                  ),
                  Row(
                    children: [
                      Switch(
                          value: trap!.isCounterOn!,
                          onChanged: (v) {},
                          activeColor: Theme.of(context).primaryColor,
                          inactiveThumbColor: Theme.of(context).errorColor),
                      Text(
                        trap!.isCounterOn! ? "ON" : "OFF",
                        style: robotoMedium.copyWith(
                            fontSize: Dimensions.fontSizeLarge,
                            color: trap!.isCounterOn!
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).errorColor),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Text(
                    "Last Reading Date :",
                    style: robotoMedium.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: Dimensions.fontSizeLarge),
                  ),
                  Row(
                    children: [
                      Text(
                        trap!.readingDate == null
                            ? "00-00-00"
                            : trap!.readingDate!.split("/").first,
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
            ),
            SizedBox(height: Dimensions.height * 0.01),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Text(
                    "Last Reading Time :",
                    style: robotoMedium.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontSize: Dimensions.fontSizeLarge),
                  ),
                  Row(
                    children: [
                      Text(
                        trap!.readingDate == null
                            ? "00-00-00"
                            : trap!.readingDate!.split("/").last,
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("Co2 Valve : ",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: Dimensions.fontSizeDefault)),
                      const SizedBox(width: 10),
                      CircularPercentIndicator(
                        radius: 15,
                        animation: true,
                        lineWidth: 2.0,
                        percent: (double.tryParse(trap!.fan!)! / 100),
                        center: Text("${(double.tryParse(trap!.fan!)! / 100)}%",
                            style: robotoMedium.copyWith(
                              fontSize: Dimensions.fontSizeExtraSmall,
                            )),
                        progressColor: (double.tryParse(trap!.fan!)! / 100) == 1
                            ? Theme.of(context).errorColor
                            : Colors.orangeAccent,
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.height * 0.05),
                  Row(
                    children: [
                      Text("Valve Qut :",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: Dimensions.fontSizeDefault)),
                      const SizedBox(width: 10),
                      CircularPercentIndicator(
                        radius: 15,
                        animation: true,
                        lineWidth: 2.0,
                        percent: double.tryParse(trap!.valveQut!)! / 100,
                        center:
                            Text("${double.tryParse(trap!.valveQut!)! / 100}%",
                                style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeExtraSmall,
                                )),
                        progressColor:
                            (double.tryParse(trap!.valveQut!)! / 100) == 1
                                ? Theme.of(context).errorColor
                                : Colors.orangeAccent,
                      ),
                    ],
                  ),
                ],
              ),
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
                      Utility.displayScheduleAlert("Schedule Fan", context,
                          widget: SizedBox(
                            height: Dimensions.height / 3,
                            width: Dimensions.width,
                            child: GridView.builder(
                              itemCount: trap!.trapFanSchedules!.length,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 30,
                                      mainAxisSpacing: 30),
                              itemBuilder: (_, index) => Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(0, 4),
                                        blurRadius: 8,
                                        color: Colors.black.withOpacity(0.3),
                                      ),
                                    ],
                                    color:
                                        trap!.trapFanSchedules![index].status!
                                            ? Theme.of(context).primaryColor
                                            : Theme.of(context).cardColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                        trap!.trapFanSchedules![index].scdTime
                                            .toString(),
                                        style: robotoMedium.copyWith(
                                            color: trap!
                                                    .trapFanSchedules![index]
                                                    .status!
                                                ? Theme.of(context).cardColor
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
                      Utility.displayScheduleAlert("Schedule  Val Qut", context,
                          widget: SizedBox(
                            height: Dimensions.height / 3,
                            width: Dimensions.width,
                            child: GridView.builder(
                              itemCount: trap!.trapValveQutSchedules!.length,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 30,
                                      mainAxisSpacing: 30),
                              itemBuilder: (_, index) => Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(0, 4),
                                        blurRadius: 8,
                                        color: Colors.black.withOpacity(0.3),
                                      ),
                                    ],
                                    color: trap!.trapValveQutSchedules![index]
                                            .status!
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).cardColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                        trap!.trapValveQutSchedules![index]
                                            .scdTime
                                            .toString(),
                                        style: robotoMedium.copyWith(
                                            color: trap!
                                                    .trapValveQutSchedules![
                                                        index]
                                                    .status!
                                                ? Theme.of(context).cardColor
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
                          itemCount: trap!.trapCounterSchedules!.length,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 30,
                                  mainAxisSpacing: 30),
                          itemBuilder: (_, index) => Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    offset: const Offset(0, 4),
                                    blurRadius: 8,
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ],
                                color:
                                    trap!.trapCounterSchedules![index].status!
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).cardColor,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                    trap!.trapCounterSchedules![index].scdTime
                                        .toString(),
                                    style: robotoMedium.copyWith(
                                        color: trap!
                                                .trapCounterSchedules![index]
                                                .status!
                                            ? Theme.of(context).cardColor
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
                  border: Border.all(color: Theme.of(context).primaryColor)),
              child: GoogleMap(
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                    target: LatLng(trap!.lat!, trap!.long!), zoom: 10),
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
            SizedBox(height: Dimensions.height * 0.02),
            Container(
                child: SfCartesianChart(
                    // Initialize category axis
                    primaryXAxis: CategoryAxis(
                      isVisible: true,
                      arrangeByIndex: true,
                    ),
                    series: <LineSeries<TrapSchedules, dynamic>>[
                  LineSeries<TrapSchedules, dynamic>(
                      // Bind data source
                      dataSource: trap!.trapValveQutSchedules!,
                      isVisible: true,
                      animationDuration: 1.0,
                      color: Colors.green,
                      xValueMapper: (TrapSchedules sales, _) => sales.scdTime,
                      yValueMapper: (TrapSchedules sales, _) => sales.id),
                  LineSeries<TrapSchedules, dynamic>(
                      // Bind data source
                      dataSource: trap!.trapCounterSchedules!,
                      isVisible: true,
                      animationDuration: 1.0,
                      color: Colors.amber,
                      xValueMapper: (TrapSchedules sales, _) => sales.scdTime,
                      yValueMapper: (TrapSchedules sales, _) => sales.id),
                  LineSeries<TrapSchedules, dynamic>(
                      // Bind data source
                      dataSource: trap!.trapFanSchedules!,
                      isVisible: true,
                      animationDuration: 1.0,
                      color: Colors.red,
                      xValueMapper: (TrapSchedules sales, _) => sales.scdTime,
                      yValueMapper: (TrapSchedules sales, _) => sales.id),
                ])),
            SizedBox(height: Dimensions.height * 0.02),
          ],
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
