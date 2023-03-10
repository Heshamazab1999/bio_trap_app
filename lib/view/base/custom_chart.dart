import 'package:bio_trap/model/body/search_reading_model.dart';
import 'package:bio_trap/util/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomChart extends StatelessWidget {
  const CustomChart({
    Key? key,
    this.reading,
    this.index = 0,
    this.title,
  }) : super(key: key);
  final List<ReadingsModel>? reading;
  final int index;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Dimensions.RADIUS_DEFAULT),
      child: SizedBox(
        height: Dimensions.height * 0.5,
        child: SfCartesianChart(
          onTooltipRender: (args) {
            switch (args.seriesIndex) {
              case 0:
                args.header = "Small";

                break;
              case 1:
                args.header = "Large";
                break;
              case 2:
                args.header = "Mosuqitoes";
                break;
              case 3:
                args.header = "Fly";
                break;
            }
          },
          tooltipBehavior: TooltipBehavior(
              enable: true,
              color: Colors.lightBlue),
          title: ChartTitle(
            text: title!,
          ),
          onLegendItemRender: (LegendRenderArgs args) {
            double totalSmall = 0;
            double totalLarge = 0;
            double totalMosuqitoes = 0;
            double totalFly = 0;
            for (int i = 0; i < reading![index].readingInDay!.length; i++) {
              totalSmall += double.parse(
                reading![index].readingInDay![i].readingsmall ?? "0.0",
              );
              totalLarge += double.parse(
                reading![index].readingInDay![i].readingLarg ?? "0.0",
              );
              totalFly += double.parse(
                reading![index].readingInDay![i].readingFly ?? "0.0",
              );
              totalMosuqitoes += double.parse(
                reading![index].readingInDay![i].readingMosuqitoes ?? "0.0",
              );
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
          legend: Legend(
              overflowMode: LegendItemOverflowMode.wrap,
              isVisible: true,
              position: LegendPosition.top),
          primaryXAxis: NumericAxis(
              interval: 2,
              minimum: 0.0,
              maximum: 23.0,
              enableAutoIntervalOnZooming: true,
              visibleMinimum: 0.0),
          primaryYAxis: NumericAxis(
            decimalPlaces: 1,
          ),
          series: <ChartSeries<ReadingInDay, double>>[
            LineSeries<ReadingInDay, double>(
                enableTooltip: true,
                markerSettings: const MarkerSettings(isVisible: true),
                color: Colors.blue,
                dataSource: reading![index].readingInDay!,
                xValueMapper: (ReadingInDay data, _) =>
                    double.parse(data.readingTime!.replaceAll(":", ".")),
                yValueMapper: (ReadingInDay data, _) =>
                    double.parse(data.readingsmall ?? "0.0")),
            LineSeries<ReadingInDay, double>(
                enableTooltip: true,
                markerSettings: const MarkerSettings(isVisible: true),
                color: Colors.blue[300],
                dataSource: reading![index].readingInDay!,
                xValueMapper: (ReadingInDay data, _) =>
                    double.parse(data.readingTime!.replaceAll(":", ".")),
                yValueMapper: (ReadingInDay data, _) =>
                    double.parse(data.readingLarg ?? "0.0")),
            LineSeries<ReadingInDay, double>(
                enableTooltip: true,
                markerSettings: const MarkerSettings(isVisible: true),
                color: Colors.green,
                dataSource: reading![index].readingInDay!,
                xValueMapper: (ReadingInDay data, _) =>
                    double.parse(data.readingTime!.replaceAll(":", ".")),
                yValueMapper: (ReadingInDay data, _) =>
                    double.parse(data.readingMosuqitoes ?? "0.0")),
            LineSeries<ReadingInDay, double>(
                enableTooltip: true,
                markerSettings: const MarkerSettings(isVisible: true),
                color: Colors.amber,
                dataSource: reading![index].readingInDay!,
                xValueMapper: (ReadingInDay data, _) =>
                    double.parse(data.readingTime!.replaceAll(":", ".")),
                yValueMapper: (ReadingInDay data, _) =>
                    double.parse(data.readingFly ?? "0.0")),
          ],
        ),
      ),
    );
  }
}
