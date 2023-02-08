import 'package:bio_trap/model/body/reading_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomChart extends StatelessWidget {
  const CustomChart({Key? key, this.data, this.label, this.yValueMapper})
      : super(key: key);
  final List<Readings>? data;
  final String? label;
  final num? Function(Readings, int)? yValueMapper;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
        title: ChartTitle(
            text: label!,
            textStyle: TextStyle(color: Theme.of(context).primaryColor)),
        enableAxisAnimation: true,
        enableSideBySideSeriesPlacement: true,
        primaryXAxis: CategoryAxis(),
        series: <ChartSeries>[
          ColumnSeries<Readings, dynamic>(
              dataSource: data!,
              animationDuration: 1.0,
              color: Theme.of(context).primaryColor,
              xValueMapper: (Readings sales, _) =>
                  num.parse(sales.readingTime!.replaceAll(":", ".")),
              yValueMapper: yValueMapper!)
        ]);
  }
}
