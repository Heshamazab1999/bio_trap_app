import 'package:bio_trap/helper/cache_helper.dart';
import 'package:bio_trap/util/app_constants.dart';
import 'package:bio_trap/util/dimensions.dart';
import 'package:bio_trap/util/images.dart';
import 'package:bio_trap/util/styles.dart';
import 'package:bio_trap/view/base/custom_circle_indecator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CustomCard extends StatelessWidget {
  final String? name;
  final String? status;
  final String? date;
  final bool? switchValue;
  final String? co2Value;
  final String? fanValue;
  final Function()? lunchMap;
  final Function()? onNavigate;
  final Function()? deleteFun;
  final Function(bool)? switchFunction;
  final Color? color;

  const CustomCard(
      {Key? key,
      this.co2Value,
      this.deleteFun,
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
            Column(
              children: [
                Text(name!,
                    style: robotoMedium.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontSize: Dimensions.fontSizeLarge,
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: Dimensions.width * 0.25,
                    height: Dimensions.width * 0.25,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.RADIUS_DEFAULT),
                        border:
                            Border.all(color: Theme.of(context).primaryColor)),
                    child: Center(
                      child: SizedBox(
                        height: Dimensions.width * 0.15,
                        width: Dimensions.width * 0.15,
                        child: Image.asset(Images.trapIcon),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: Dimensions.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: onNavigate,
                            child: Image.asset(
                              Images.editIcon,
                              width: 30,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_LARGE),
                          CacheHelper.getData(key: AppConstants.role) ==
                                  "SuperAdmin"
                              ? GestureDetector(
                                  onTap: deleteFun,
                                  child: Image.asset(
                                    Images.deleteIcon,
                                    width: 25,
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                )
                              : const SizedBox(),
                          const SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_LARGE),

                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.height * 0.01,
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
                          CustomCircleIndicator(
                            percent: double.parse(co2Value ?? "0.0") / 100,
                            percentText: "${double.parse(co2Value ?? "0.0")}%",
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
                          CustomCircleIndicator(
                            percent: double.parse(fanValue ?? "0.0") / 100,
                            percentText: "${double.parse(fanValue ?? "0.0")}%",
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
                            child: Image.asset(Images.map),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Image.asset(
                              switchValue!
                                  ? Images.checkIcon
                                  : Images.crossIcon,
                              height: 25),
                          const SizedBox(width: 5),
                          Text(status!,
                              style: robotoMedium.copyWith(
                                  color: color,
                                  fontSize: Dimensions.fontSizeLarge)),
                          const SizedBox(
                            width: 10,
                          )
                        ],
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
