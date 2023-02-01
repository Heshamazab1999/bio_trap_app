import 'package:flutter/material.dart';

class ClockRangeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ClockRangeWidget();
}

class _ClockRangeWidget extends State<ClockRangeWidget> {
  RangeValues _currentRangeValues = const RangeValues(0, 24);

  static String _valueToString(double value) {
    return value.toStringAsFixed(0);
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        inactiveTrackColor: Colors.grey[300],
        trackHeight: 6.0,
        thumbColor: Colors.green,
        inactiveTickMarkColor: Colors.grey[300],
        valueIndicatorColor: Colors.grey,
        valueIndicatorTextStyle: TextStyle(
          color: Colors.white,
        ),
      ),
      child: RangeSlider(
        values: _currentRangeValues,
        min: 0,
        max: 24,
        divisions: 24,
        labels: RangeLabels(
          _getLabel(_currentRangeValues.start),
          _getLabel(_currentRangeValues.end),
        ),
        onChanged: (RangeValues values) {
          setState(() {
            _currentRangeValues = values;
          });
        },
      ),
    );
  }

  String _getLabel(double value) {
    if (value > 12.0) {
      return "${(value - 12.0).round()} PM";
    } else {
      return "${value.round()} AM";
    }
  }
}