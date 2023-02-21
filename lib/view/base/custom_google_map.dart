import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatelessWidget {
  const CustomGoogleMap({Key? key, this.latLng, this.id}) : super(key: key);
  final LatLng? latLng;
  final int? id;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      scrollGesturesEnabled: true,
      zoomGesturesEnabled: true,
      myLocationButtonEnabled: false,
      gestureRecognizers: Set()
        ..add( Factory<PanGestureRecognizer>(() => PanGestureRecognizer())),
      initialCameraPosition: CameraPosition(target: latLng!, zoom: 5),
      markers: <Marker>{
        Marker(
            markerId: MarkerId(
              "$id",
            ),
            position: latLng!)
      },
    );
  }
}
