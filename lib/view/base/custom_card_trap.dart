import 'package:bio_trap/util/app_constants.dart';
import 'package:bio_trap/util/dimensions.dart';
import 'package:bio_trap/util/images.dart';
import 'package:bio_trap/util/styles.dart';
import 'package:bio_trap/view/base/custom_circle_indecator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCardTrap extends StatelessWidget {
  const CustomCardTrap({Key? key, this.onTap, this.name, this.working,this.fan,this.valueQut,this.openMap})
      : super(key: key);
  final Function()? onTap;
  final Function()? openMap;
  final String? name;
  final bool? working;
  final String?fan;
  final String?valueQut;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
            SizedBox(
              width: Dimensions.width * 0.02,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Dimensions.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(name!),
                      SizedBox(
                        width: Dimensions.width * 0.1,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                             working!
                                  ? Images.checkIcon
                                  : Images.crossIcon,
                              height: 25),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                           working!
                                ? AppConstants.oN
                                : AppConstants.off,
                            style: robotoMedium.copyWith(
                                fontSize: Dimensions.fontSizeLarge,
                                color: working!
                                    ? Colors.green
                                    : Theme.of(context).colorScheme.error),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text("Fan : ",
                              style: robotoMedium.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSizeLarge)),
                          CustomCircleIndicator(
                            percent: double.parse(
                                  fan  ?? "0.0") /
                                100,
                            percentText:
                                "${double.parse(fan ?? "0.0") / 100}%",
                          ),
                        ],
                      ),
                      SizedBox(
                        width: Dimensions.width * 0.1,
                      ),
                      Row(
                        children: [
                          Text(AppConstants.valveQut,
                              style: robotoMedium.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: Dimensions.fontSizeLarge)),
                          CustomCircleIndicator(
                            percent: double.parse(
                                  valueQut   ?? "0.0") /
                                100,
                            percentText:
                                "${double.parse(valueQut ?? "0.0") / 100}%",
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.height * 0.01,
                  ),
                  GestureDetector(
                    onTap: openMap,
                    child: Material(
                      elevation: 2,
                      shadowColor: Theme.of(context).primaryColor,
                      borderRadius:
                          BorderRadius.circular(Dimensions.RADIUS_SMALL),
                      child: Container(
                        width: Dimensions.width * 0.3,
                        height: Dimensions.height * 0.04,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.RADIUS_SMALL),
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
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(child: Image.asset(Images.map)),
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
    );
  }
}
