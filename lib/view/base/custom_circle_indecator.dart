import 'package:bio_trap/util/dimensions.dart';
import 'package:bio_trap/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CustomCircleIndicator extends StatelessWidget {
  const CustomCircleIndicator({Key? key, this.percentText, this.percent = 0.0})
      : super(key: key);
  final String? percentText;
  final double? percent;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 20,
      animation: true,
      lineWidth: 2.0,
      linearGradient: const LinearGradient(colors: [
        Color(0xFFFFA900),
        Color(0xFFFF7600),
        Color(0xFFCD113B),
      ], begin: Alignment.topRight, end: Alignment.topLeft),
      percent: percent!,
      center: Text(percentText!,
          style: robotoMedium.copyWith(
            fontSize: Dimensions.fontSizeExtraSmall,
          )),
    );
  }
}
