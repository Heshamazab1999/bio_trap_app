import 'package:bio_trap/util/dimensions.dart';
import 'package:bio_trap/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class TimerSlider extends StatelessWidget {
  const TimerSlider({Key? key, this.value, this.onChange}) : super(key: key);
  final SfRangeValues? value;
  final Function(SfRangeValues)? onChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "AM",
          style: robotoMedium.copyWith(
              fontSize: Dimensions.fontSizeDefault,
              color: Theme.of(context).primaryColor),
        ),
        Flexible(
          child: SfRangeSlider(

              showDividers: true,
              min: 0.0,
              max: 24.0,
              interval: 2,
              showTicks: true,
              stepSize: 1,
              showLabels: true,
              values: value!,
              onChanged: onChange),
        ),
        Text(
          "PM",
          style: robotoMedium.copyWith(
              fontSize: Dimensions.fontSizeDefault,
              color: Theme.of(context).primaryColor),
        ),
      ],
    );
  }
}
