import 'package:bio_trap/controller/base_controller.dart';
import 'package:bio_trap/model/body/reading_model.dart';
import 'package:bio_trap/model/body/table_model.dart';
import 'package:bio_trap/model/body/trap_model.dart';
import 'package:bio_trap/view/screens/trap_management/services/trap_management_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TrapDetailsController extends BaseController {
  final services = TrapManagementServices();
  TrapModel? trap;
  Readings? readings;
  final loading = false.obs;
  final date = "".obs;
  List<Readings> employees = <Readings>[];
  late EmployeeDataSource employeeDataSource;

  @override
  onInit() {
    super.onInit();
    employees = getEmployeeData();
    employeeDataSource = EmployeeDataSource(employeeData:employees);
  }

  List<Readings> getEmployeeData() {
    return [
      Readings(id: 1, counter: "10", lat: 30.0, long: 30.0),
      Readings(id: 1, counter: "10", lat: 30.0, long: 30.0),
      Readings(id: 1, counter: "10", lat: 30.0, long: 30.0),
      Readings(id: 1, counter: "10", lat: 30.0, long: 30.0),
    ];
  }

  getTrap({int? trapId}) async {
    try {
      loading.value = true;
      trap = await services.getTrap(id: trapId);
      readings = await services.getTrapLastRead(trapId: trapId);
      var output = DateFormat('y-M-d');
      var input = DateTime.parse(
          readings == null ? "0000-00-00" : readings!.readingDate!);
      date.value = output.format(input);
      employeeDataSource = EmployeeDataSource(employeeData:[readings!]);

      loading.value = false;
    } catch (e) {
      loading.value = false;
      print(e);
    }
  }
}
