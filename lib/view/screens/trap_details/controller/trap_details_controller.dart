import 'package:bio_trap/controller/base_controller.dart';
import 'package:get/get.dart';

class TrapDetailsController extends BaseController {
  final lists = <SalesData>[];

  @override
  onInit() {
    super.onInit();
    initData();
  }

  initData() {
    for (int i = 0; i < 96; i++) {
      lists.add(SalesData("$i", 10));
    }
    print(lists.length);
  }
}

class SalesData {
  SalesData(this.year, this.sales);

  final String year;
  final double sales;
}
