import 'package:bio_trap/controller/base_controller.dart';
import 'package:bio_trap/model/body/trap_model.dart';
import 'package:bio_trap/view/screens/trap_management/services/trap_management_services.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
  Future<void> sendNotification({String? token, String? message}) async {
    const postUrl = 'https://fcm.googleapis.com/fcm/send';
    Dio dio = Dio();

    // var token = await getDeviceToken();
    print('device token : $token');

    final data = {
      "data": {
        "message": message,
        "title": "Donation App",
      },
      "to": token
    };
// q
// git remote set-url origin https://github.com/zeinabtareek/donation_dashboard/
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] =
    'key=AAAAK77pS_M:APA91bEdjYfKufLMBKYt5tTPFD_fy06yG1ubQLPvYjEH8adE6wqMFFTGP1R4a_ZQmL4fH1xB1YT0ax5MvruunGMZZ0cm9Jv2o4ri6KGWlTySw9WD0I_RhrNhO28tG8zIIrJanxPds_Xj';

    try {
      final response = await dio.post(postUrl, data: data);

      if (response.statusCode == 200) {
        print('Request Sent To Driver');
      } else {
        print('notification sending failed');
      }
    } catch (e) {
      print('exception $e');
    }
  }

  Future<String?> getDeviceToken() async {
    print(await FirebaseMessaging.instance.getToken());
    return await FirebaseMessaging.instance.getToken();
  }

}
