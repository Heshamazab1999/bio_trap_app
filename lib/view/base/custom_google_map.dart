import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatelessWidget {
  const CustomGoogleMap({Key? key, this.latLng, this.id}) : super(key: key);
  final LatLng? latLng;
  final int? id;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(

      zoomGesturesEnabled: true,
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
