import 'package:bio_trap/controller/base_controller.dart';
import 'package:bio_trap/helper/cache_helper.dart';
import 'package:bio_trap/model/body/time_model.dart';
import 'package:bio_trap/model/body/update_trap.dart';
import 'package:bio_trap/util/app_constants.dart';
import 'package:bio_trap/view/base/custom_snackbar.dart';
import 'package:bio_trap/view/screens/update_trap/services/update_services.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../../../enum/view_state.dart';

class UpdateTrapController extends BaseController {
  final services = UpdateServices();
  final fanValue = 0.0.obs;
  final qutValue = 0.0.obs;
  final switchValue = false.obs;
  final switchScheduleValue = false.obs;
  final switchSimCard = false.obs;
  final slideRangeFan = const SfRangeValues(0.0, 1.0).obs;
  final slideRangeCounter = const SfRangeValues(0.0, 1.0).obs;
  final slideRangeValueQut = const SfRangeValues(0.0, 1.0).obs;
  Position? currentPosition;
  final textEditingControllerLat = TextEditingController();
  final textEditingControllerLon = TextEditingController();
  final textEditingControllerName = TextEditingController();
  final textEditingControllerSerial = TextEditingController();
  final textEditingControllerLema = TextEditingController();
  final loading = false.obs;
  final send = false.obs;
  final dateTime = DateTime.now().obs;
  final readingDate = "".obs;
  final role = "".obs;

  @override
  onInit() async {
    super.onInit();
    setState(ViewState.busy);
    role.value = await CacheHelper.getData(key: AppConstants.role);
    setState(ViewState.idle);
  }

  List<TimeModel> slideRangeScheduleFan = [
    TimeModel(scdTime: 1, status: false),
    TimeModel(scdTime: 2, status: false),
    TimeModel(scdTime: 3, status: false),
    TimeModel(scdTime: 4, status: false),
    TimeModel(scdTime: 5, status: false),
    TimeModel(scdTime: 6, status: false),
    TimeModel(scdTime: 7, status: false),
    TimeModel(scdTime: 8, status: false),
    TimeModel(scdTime: 9, status: false),
    TimeModel(scdTime: 10, status: false),
    TimeModel(scdTime: 11, status: false),
    TimeModel(scdTime: 12, status: false),
    TimeModel(scdTime: 13, status: false),
    TimeModel(scdTime: 14, status: false),
    TimeModel(scdTime: 15, status: false),
    TimeModel(scdTime: 16, status: false),
    TimeModel(scdTime: 17, status: false),
    TimeModel(scdTime: 18, status: false),
    TimeModel(scdTime: 19, status: false),
    TimeModel(scdTime: 20, status: false),
    TimeModel(scdTime: 21, status: false),
    TimeModel(scdTime: 22, status: false),
    TimeModel(scdTime: 23, status: false),
  ];
  List<TimeModel> slideRangeScheduleCounter = [
    TimeModel(scdTime: 1, status: false),
    TimeModel(scdTime: 2, status: false),
    TimeModel(scdTime: 3, status: false),
    TimeModel(scdTime: 4, status: false),
    TimeModel(scdTime: 5, status: false),
    TimeModel(scdTime: 6, status: false),
    TimeModel(scdTime: 7, status: false),
    TimeModel(scdTime: 8, status: false),
    TimeModel(scdTime: 9, status: false),
    TimeModel(scdTime: 10, status: false),
    TimeModel(scdTime: 11, status: false),
    TimeModel(scdTime: 12, status: false),
    TimeModel(scdTime: 13, status: false),
    TimeModel(scdTime: 14, status: false),
    TimeModel(scdTime: 15, status: false),
    TimeModel(scdTime: 16, status: false),
    TimeModel(scdTime: 17, status: false),
    TimeModel(scdTime: 18, status: false),
    TimeModel(scdTime: 19, status: false),
    TimeModel(scdTime: 20, status: false),
    TimeModel(scdTime: 21, status: false),
    TimeModel(scdTime: 22, status: false),
    TimeModel(scdTime: 23, status: false),
  ];
  List<TimeModel> slideRangeScheduleValueQut = [
    TimeModel(scdTime: 1, status: false),
    TimeModel(scdTime: 2, status: false),
    TimeModel(scdTime: 3, status: false),
    TimeModel(scdTime: 4, status: false),
    TimeModel(scdTime: 5, status: false),
    TimeModel(scdTime: 6, status: false),
    TimeModel(scdTime: 7, status: false),
    TimeModel(scdTime: 8, status: false),
    TimeModel(scdTime: 9, status: false),
    TimeModel(scdTime: 10, status: false),
    TimeModel(scdTime: 11, status: false),
    TimeModel(scdTime: 12, status: false),
    TimeModel(scdTime: 13, status: false),
    TimeModel(scdTime: 14, status: false),
    TimeModel(scdTime: 15, status: false),
    TimeModel(scdTime: 16, status: false),
    TimeModel(scdTime: 17, status: false),
    TimeModel(scdTime: 18, status: false),
    TimeModel(scdTime: 19, status: false),
    TimeModel(scdTime: 20, status: false),
    TimeModel(scdTime: 21, status: false),
    TimeModel(scdTime: 22, status: false),
    TimeModel(scdTime: 23, status: false),
  ];

  Future displayTimePicker(BuildContext context) async {
    var time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (time != null) {
      print("Time: ${time.hour}");
    }
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    loading.value = true;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      currentPosition = position;
      print(currentPosition!.latitude);
      print(currentPosition!.longitude);
      textEditingControllerLat.text = currentPosition!.latitude.toString();
      textEditingControllerLon.text = currentPosition!.longitude.toString();
      loading.value = false;
    }).catchError((e) {
      loading.value = false;
      debugPrint(e);
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<DateTime?> showCalender({required BuildContext context}) async =>
      await showDatePicker(
        context: context,
        lastDate: DateTime(2100),
        firstDate: CacheHelper.getData(key: AppConstants.role) == "SuperAdmin"
            ? DateTime(2000)
            : DateTime(2023, 2),
        initialDate: dateTime.value,
      );

  updateTrap(BuildContext context, {int? trapId}) async {
    try {
      if (textEditingControllerLat.text.isEmpty &&
          textEditingControllerLon.text.isEmpty) {
        showCustomSnackBar(message: "Enter Your Location", isError: true);
      } else if (textEditingControllerSerial.text.isEmpty &&
          textEditingControllerLema.text.isEmpty &&
          textEditingControllerName.text.isEmpty) {
        showCustomSnackBar(message: "Enter your Trap Details", isError: true);
      } else {
        send.value = true;
        await services.updateTrap(context,
            id: trapId,
            model: UpdateTrapModel(
              name: textEditingControllerName.text,
              serialNumber: textEditingControllerSerial.text,
              iema: 0 ,
              lat: textEditingControllerLat.text,
              long: textEditingControllerLon.text,
              isCounterOn: switchValue.isTrue,
              // isWorking: switchValue.value,
              isScheduleOn: switchScheduleValue.value,
              isCounterReadingFromSimCard: switchSimCard.value,
              readingDate: readingDate.value,
              trapFanSchedules: slideRangeScheduleFan,
              trapCounterSchedules: slideRangeScheduleCounter,
              trapValveQntSchedules: slideRangeScheduleValueQut,
              fan: fanValue.value.toString(),
              valveQut: qutValue.value.toString(),
              status: 0,
            ));
        send.value = false;
      }
    } catch (e) {
      send.value = false;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<UpdateTrapController>();
  }
}
