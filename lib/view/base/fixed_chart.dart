import 'package:bio_trap/model/body/reading_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FixedChart extends StatelessWidget {
  const FixedChart({Key? key, this.dataSource}) : super(key: key);
  final List<Readings>? dataSource;

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      onLegendItemRender: (LegendRenderArgs args) {
        print(args.seriesIndex);
        double totalSmall = 0;
        double totalLarge = 0;
        double totalMosuqitoes = 0;
        double totalFly = 0;
        for (int i = 0; i < dataSource!.length; i++) {
          totalSmall += double.parse(dataSource![i].readingsmall??"0.0",);
          totalLarge += double.parse(dataSource![i].readingLarg??"0.0",);
          totalFly += double.parse(dataSource![i].readingFly??"0.0",);
          totalMosuqitoes += double.parse(dataSource![i].readingMosuqitoes??"0.0",);
        }
        switch (args.seriesIndex) {
          case 0:
            args.text = "Small (Total:$totalSmall)";
            args.color = Colors.blue;
            args.legendIconType = LegendIconType.rectangle;
            break;
          case 1:
            args.text = "Large (Total:$totalLarge)";
            args.color = Colors.blue[300];
            args.legendIconType = LegendIconType.rectangle;
            break;
          case 2:
            args.text = "Mosuqitoes (Total:$totalMosuqitoes)";
            args.color = Colors.green;
            args.legendIconType = LegendIconType.rectangle;
            break;
          case 3:
            args.text = "Fly (Total:$totalFly)";
            args.color = Colors.amber;
            args.legendIconType = LegendIconType.rectangle;
            break;
        }
      },
      legend: Legend(isVisible: true, position: LegendPosition.top),
      primaryXAxis: NumericAxis(
          interval: 2,
          minimum: 0.0,
          maximum: 23.0,
          enableAutoIntervalOnZooming: true,
          visibleMinimum: 0.0),
      primaryYAxis: NumericAxis(
        decimalPlaces: 1,
      ),
      series: <ChartSeries<Readings, double>>[
        LineSeries<Readings, double>(
            markerSettings: const MarkerSettings(isVisible: true),
            color: Colors.blue,
            dataSource: dataSource!,
            xValueMapper: (Readings data, _) =>
                double.parse(data.readingTime!.replaceAll(":", ".")),
            yValueMapper: (Readings data, _) =>
                double.parse(data.readingsmall!)),
        LineSeries<Readings, double>(
            markerSettings: const MarkerSettings(isVisible: true),
            color: Colors.blue[300],
            dataSource: dataSource!,
            xValueMapper: (Readings data, _) =>
                double.parse(data.readingTime!.replaceAll(":", ".")),
            yValueMapper: (Readings data, _) =>
                double.parse(data.readingLarg!)),
        LineSeries<Readings, double>(
            markerSettings: const MarkerSettings(isVisible: true),
            color: Colors.green,
            dataSource: dataSource!,
            xValueMapper: (Readings data, _) =>
                double.parse(data.readingTime!.replaceAll(":", ".")),
            yValueMapper: (Readings data, _) =>
                double.parse(data.readingMosuqitoes!)),
        LineSeries<Readings, double>(
            markerSettings: const MarkerSettings(isVisible: true),
            color: Colors.amber,
            dataSource: dataSource!,
            xValueMapper: (Readings data, _) =>
                double.parse(data.readingTime!.replaceAll(":", ".")),
            yValueMapper: (Readings data, _) => double.parse(data.readingFly!)),
      ],
    );
  }
}
