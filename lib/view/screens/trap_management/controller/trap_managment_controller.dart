import 'package:bio_trap/controller/base_controller.dart';
import 'package:bio_trap/model/body/trap_model.dart';
import 'package:bio_trap/view/screens/trap_management/services/trap_management_services.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';

class TrapManagementController extends BaseController {
  final services = TrapManagementServices();
  final checkValue = <bool>[].obs;
  final loading = false.obs;
  TrapModel? trap;

  openMapDirection({double? lat, double? long, String? title}) async {
    final availableMaps = await MapLauncher.installedMaps;
    await MapLauncher.showMarker(
      zoom: 10,
      mapType: MapType.google,
      coords: Coords(lat!, long!),
      title: title!,
    );
  }

  getTrap({int? trapId}) async {
    try {
      loading.value = true;
      trap = await services.getTrap(id: trapId);
      loading.value = false;
    } catch (e) {}
  }
}
