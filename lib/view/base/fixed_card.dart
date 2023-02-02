import 'package:bio_trap/util/dimensions.dart';
import 'package:bio_trap/util/images.dart';
import 'package:bio_trap/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CustomCard extends StatelessWidget {
  final String? name;
  final String? status;
  final String? date;
  final bool? switchValue;
  final double? co2Value;
  final double? fanValue;
  final Function()? lunchMap;
  final Function()? onNavigate;
  final Function(bool)? switchFunction;
  final Color? color;

  const CustomCard(
      {Key? key,
      this.co2Value,
      this.status,
      this.switchValue,
      this.fanValue,
      this.color,
      this.lunchMap,
      this.date,
      this.name,
      this.onNavigate,
      this.switchFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Card(
        shadowColor: Theme.of(context).primaryColor,
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
            side: BorderSide(color: Theme.of(context).primaryColor)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: Dimensions.width * 0.3,
                height: Dimensions.width * 0.3,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                    border: Border.all(color: Theme.of(context).primaryColor)),
                child: Center(
                  child: SizedBox(
                    height: Dimensions.width * 0.15,
                    width: Dimensions.width * 0.15,
                    child: Image.asset(Images.trapIcon),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(name!,
                          style: robotoMedium.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: Dimensions.fontSizeLarge,
                          )),
                      Row(
                        children: [
                          Switch(
                            value: switchValue!,
                            onChanged: switchFunction,
                            inactiveThumbColor: Theme.of(context).errorColor,
                            activeColor: Theme.of(context).primaryColor,
                          ),
                          Text(status!,
                              style: TextStyle(
                                  color: color,
                                  fontSize: Dimensions.fontSizeDefault)),
                          const SizedBox(
                            width: 10,
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.height * 0.0001,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Text("Co2 Valve: ",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSizeDefault)),
                          const SizedBox(width: 10),
                          CircularPercentIndicator(
                            radius: 15,
                            animation: true,
                            lineWidth: 2.0,
                            percent: co2Value!,
                            center: Text("${co2Value!}%",
                                style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeExtraSmall,
                                )),
                            linearGradient: const LinearGradient(
                                colors: [
                                  Color(0xFFFFA900),
                                  Color(0xFFFF7600),
                                  Color(0xFFCD113B),
                                ],
                                begin: Alignment.topRight,
                                end: Alignment.topLeft),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text("Fan:",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSizeDefault)),
                          const SizedBox(width: 10),
                          CircularPercentIndicator(
                            radius: 15,
                            lineWidth: 2.0,
                            percent: fanValue!,
                            animation: true,
                            center: Text("${fanValue!}%",
                                style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeExtraSmall,
                                )),
                            linearGradient: const LinearGradient(
                                colors: [
                                  Color(0xFFFFA900),
                                  Color(0xFFFF7600),
                                  Color(0xFFCD113B),
                                ],
                                begin: Alignment.topRight,
                                end: Alignment.topLeft),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(date!,
                          style: robotoMedium.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontSize: Dimensions.fontSizeDefault,
                          )),
                      Image.asset(
                        Images.calendarIcon,
                        width: 25,
                        color: Theme.of(context).primaryColor,
                      )
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: lunchMap,
                        child: Material(
                          elevation: 2,
                          shadowColor: Theme.of(context).primaryColor,
                          borderRadius:
                              BorderRadius.circular(Dimensions.RADIUS_SMALL),
                          child: Container(
                            width: Dimensions.width * 0.3,
                            height: Dimensions.height * 0.04,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.RADIUS_SMALL),
                                border: Border.all(
                                    color: Theme.of(context).primaryColor)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "location".tr,
                                  style: robotoMedium.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.fontSizeSmall),
                                ),
                                const SizedBox(width: 5,),
                                Flexible(child: Image.asset(Images.map)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: onNavigate,
                        child: Image.asset(
                          Images.editIcon,
                          width: 40,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
