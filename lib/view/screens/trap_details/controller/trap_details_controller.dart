import 'package:bio_trap/controller/base_controller.dart';
import 'package:bio_trap/model/body/reading_model.dart';
import 'package:bio_trap/view/screens/trap_management/services/trap_management_services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../enum/view_state.dart';

class TrapDetailsController extends BaseController {
  final service = TrapManagementServices();

  TrapDetailsController({int? id}) {
    setState(ViewState.busy);
    getTrap(trapId: id);
    setState(ViewState.idle);
  }

  final services = TrapManagementServices();
  ReadingTrapModel? reading;
  final loading = false.obs;

  getTrap({int? trapId}) async {
    try {
      var output = DateFormat('y-M-d');
      reading = await services.getTrapReading(
          id: 69, startDate: output.format(DateTime.now()));
    } catch (e) {
      print(e);
    }
  }

  final List<Readings> list = [Readings(readingTime: "0:0"),Readings(readingTime: "1:0"),Readings(readingTime: "2:0"),Readings(readingTime: "3:0"),Readings(readingTime: "4:0"),Readings(readingTime: "5:0"),Readings(readingTime: "6:0"),Readings(readingTime: "7:0"),
    Readings(readingTime: "0:0"),
  ];
}
