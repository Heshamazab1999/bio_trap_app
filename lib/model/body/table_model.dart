import 'package:bio_trap/model/body/reading_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class EmployeeDataSource extends DataGridSource {
  /// Creates the employee data source class with required details.
  EmployeeDataSource({required List<Readings> employeeData}) {
    var output = DateFormat('y-M-d');
    _employeeData = employeeData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(
                  columnName: 'readingDate',
                  value: output
                      .format(DateTime.parse(e.readingDate ?? "0000-00-00"))),
              DataGridCell<String>(
                  columnName: 'readingTime', value: e.readingTime),
              DataGridCell<double>(columnName: 'lat', value: e.lat),
              DataGridCell<double>(columnName: 'long', value: e.long),
              DataGridCell<String>(columnName: 'counter', value: e.counter),
              DataGridCell<String>(
                  columnName: 'mosuqitoes', value: e.readingMosuqitoes),
              DataGridCell<String>(columnName: 'fly', value: e.readingFly),
              DataGridCell<String>(columnName: 'small', value: e.readingsmall),
              DataGridCell<String>(columnName: 'large', value: e.readingLarg),
              DataGridCell<String>(
                  columnName: 'humidty ', value: e.readingHumidty),
              DataGridCell<String>(columnName: 'co2Val', value: e.co2Val),
              DataGridCell<String>(columnName: 'co2', value: e.co2),
              DataGridCell<String>(columnName: 'fan', value: e.fan),
              DataGridCell<String>(
                  columnName: 'WindSpeed', value: e.readingWindSpeed),
            ]))
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: Text(e.value.toString(),),
      );
    }).toList());
  }
}
