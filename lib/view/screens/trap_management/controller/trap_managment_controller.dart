import 'package:bio_trap/controller/base_controller.dart';
import 'package:bio_trap/model/body/trap_model.dart';
import 'package:bio_trap/view/screens/trap_management/services/trap_management_services.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';

class TrapManagementController extends BaseController {
  final services = TrapManagementServices();
  final checkValue = <bool>[].obs;
  final loading = false.obs;
  TrapModel? trap;

  openMapDirection({double? lat, double? long, String? title}) async {
    await MapLauncher.showMarker(
      zoom: 10,
      mapType: MapType.google,
      coords: Coords(lat!, long!),
      title: title!,
    );
  }

  getTrap({int? trapId}) async {
    try {
      trap = await services.getTrap(id: trapId);
    } catch (e) {
      print(e);
    }
  }

  Future<void> sendNotification() async {
    const postUrl = 'https://fcm.googleapis.com/fcm/send';
    Dio dio = Dio();

    var token = await getDeviceToken();
    print('device token : $token');

    final data = {
      "data": {
        "message": "message",
        "title": "Donation App",
      },
      "notification": {
        "body": "great match!",
        "title": "Portugal vs. Denmark",
        "icon": "myicon",
        "sound": "default"
      },
      "to": token
    };
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["Authorization"] =
        'key=AAAABRZSkKs:APA91bGzkWQfIcmbepO0X3rhkJKbkQzOUiYW3AJziyZ3GSqgAmlT46sdBZxLXwDqdiGjTs_uhVHAGOZ-6WWS-uZNamFh9dvokQwwgzuTQ4ppwm2vSt3e5IKVOzaGwMvijf2wA_64UxuR';

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

  deleteTrap(BuildContext context, {int? trapId}) async {
    await services.deleteTrap(context, trapId: trapId);
  }
}
