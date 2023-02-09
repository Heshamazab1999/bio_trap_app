import 'package:bio_trap/controller/base_controller.dart';
import 'package:bio_trap/model/body/reading_model.dart';
import 'package:bio_trap/view/screens/trap_management/services/trap_management_services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TrapDetailsController extends BaseController {
  final services = TrapManagementServices();
  Readings? trap;
  final loading = false.obs;
  final date = "".obs;
  final co2Val = 0.0.obs;

  TrapDetailsController({int? id}) {
    getTrap(trapId: id);
  }

  getTrap({int? trapId}) async {
    try {
      loading.value = true;
      var output = DateFormat('y-M-d');
      trap = await services.getTrapLastRead(trapId: trapId);
      var input = DateTime.parse(trap!.readingDate!);
      date.value = output.format(input);
      co2Val.value = double.parse(trap!.co2Val!);
      loading.value = false;
    } catch (e) {
      loading.value = false;

      print(e);
    }
  }

  final List<Readings> list = [
    Readings(readingTime: "0:0"),
    Readings(readingTime: "1:0"),
    Readings(readingTime: "2:0"),
    Readings(readingTime: "3:0"),
    Readings(readingTime: "4:0"),
    Readings(readingTime: "5:0"),
    Readings(readingTime: "6:0"),
    Readings(readingTime: "7:0"),
    Readings(readingTime: "0:0"),
  ];
}
