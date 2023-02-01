import 'package:bio_trap/controller/base_controller.dart';
import 'package:bio_trap/model/body/trap_model.dart';
import 'package:bio_trap/view/screens/trap_management/services/trap_management_services.dart';

class YourTrapController extends BaseController {
  final services = TrapManagementServices();
  TrapModel? trap;

  getTrap({int? trapId}) async {
    try {
      trap = await services.getTrap(id: trapId);
    } catch (e) {}
  }
}
