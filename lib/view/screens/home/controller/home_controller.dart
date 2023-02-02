import 'dart:ui' as ui;
import 'package:bio_trap/controller/base_controller.dart';
import 'package:bio_trap/enum/view_state.dart';
import 'package:bio_trap/helper/cache_helper.dart';
import 'package:bio_trap/model/body/trap_model.dart';
import 'package:bio_trap/routes/app_route.dart';
import 'package:bio_trap/util/images.dart';
import 'package:bio_trap/view/screens/users/services/user_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';

class HomeController extends BaseController {
  final services = UserService();
  final traps = <TrapModel>[].obs;
  final markers = <Marker>{}.obs;
  final currentPosition = Position(
          longitude: 0.0,
          latitude: 0.0,
          timestamp: DateTime.now(),
          accuracy: 0.0,
          altitude: 0.0,
          heading: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0)
      .obs;
  List<String> images = [
    Images.listIcon,
    Images.customerIcon,
    Images.directionsIcon
  ];
  List<String> labels = [
    "Trap Management",
    "Users",
    "Your Traps",
  ];

  @override
  onInit() async {
    super.onInit();
    setState(ViewState.busy);
    await getCurrentPosition();
    traps.value = (await services.getAllTraps())!;
    await drawAllMarkers();
    setState(ViewState.idle);
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition.value = position;
      print(currentPosition.value.latitude);
      print(currentPosition.value.longitude);
    }).catchError((e) {
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

  openMapDirection(double lat, double long) async {
    final availableMaps = await MapLauncher.installedMaps;
    for (var map in availableMaps) {
      map.showDirections(
          origin: Coords(
              currentPosition.value.latitude, currentPosition.value.longitude),
          directionsMode: DirectionsMode.driving,
          destination: Coords(lat, long),
          waypoints: []);
    }
  }

  drawAllMarkers() async {
    markers.clear();
    for (var element in traps) {
      final Uint8List markerIcon = await getBytesFromAsset(Images.pinIcon, 150);
      BitmapDescriptor markerBitmap = BitmapDescriptor.fromBytes(markerIcon);
      markers.add(Marker(
          onTap: () {
            openMapDirection(element.lat!, element.long!);
          },
          icon: markerBitmap,
          markerId: MarkerId("${element.id}"),
          position: LatLng(element.lat!, element.long!)));
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  logOut() async {
    await CacheHelper.clearData();
    Get.offAllNamed(AppRoute.signIn);
  }
}
