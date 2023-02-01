import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({Key? key, this.onChange, this.value}) : super(key: key);
  final Function(dynamic value)? onChange;
  final double? value;

  @override
  Widget build(BuildContext context) {
    return SfSlider(
      min: 0.0,
      max: 100.0,
      value: value,
      interval: 25,
      showTicks: true,
      showLabels: true,
      enableTooltip: true,
      minorTicksPerInterval: 1,
      stepSize: 25.0,
      onChanged: onChange,
    );
  }
}
