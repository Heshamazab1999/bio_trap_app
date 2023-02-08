import 'package:bio_trap/controller/base_controller.dart';
import 'package:bio_trap/model/body/reading_model.dart';
import 'package:bio_trap/model/body/trap_model.dart';
import 'package:bio_trap/view/screens/trap_management/services/trap_management_services.dart';
import 'package:get/get.dart';

class YourTrapController extends BaseController {
  YourTrapController({int? id}) {
    getTrap(trapId: id);
  }

  final services = TrapManagementServices();
  TrapModel? trap;
  ReadingTrapModel? reading;
  final loading = false.obs;

  getTrap({int? trapId}) async {
    try {
      // loading.value = true;
      trap = await services.getTrap(id: trapId);
      // reading = await services.getTrapReading(id: trapId);
      // loading.value = false;
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
  }
}
