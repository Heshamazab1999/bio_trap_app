import 'package:bio_trap/controller/base_controller.dart';
import 'package:bio_trap/model/body/reading_model.dart';
import 'package:bio_trap/model/body/trap_model.dart';
import 'package:bio_trap/view/screens/trap_management/services/trap_management_services.dart';
import 'package:get/get.dart';

class YourTrapController extends BaseController {
  final services = TrapManagementServices();
  TrapModel? trap;
  Readings? readings;

  getTrap({int? trapId}) async {
    try {
      trap = await services.getTrap(id: trapId);
      readings = await services.getTrapLastRead(trapId: trapId);
    } catch (e) {
      print(e);
    }
  }
}
