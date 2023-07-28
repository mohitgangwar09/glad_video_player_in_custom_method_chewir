import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GMap extends StatelessWidget {
  final double lat;
  final double lng;
  final bool? myLocationEnabled;
  final bool? myLocationButtonEnabled;
  final bool? zoomControlsEnabled;
  final bool? zoomGesturesEnabled;
  final Function()? onCameraIdle;
  final Function(GoogleMapController googleMapController)? onMapCreated;
  final Function(CameraPosition position)? onCameraMove;
  final List<Marker>? markers;
  // final List<Polyline>? polyline;
  final double? height;
//  final Function ? onTap;
  final ArgumentCallback<LatLng>? onTap;
  const GMap(
      {Key? key,
      required this.lat,
      // required this.polyline,
      this.onTap,
      required this.lng,
      this.height,
      this.onCameraIdle,
      this.onMapCreated,
      this.onCameraMove,
      this.markers,
      this.myLocationEnabled = true,
      this.myLocationButtonEnabled = true,
      this.zoomControlsEnabled = true,
      this.zoomGesturesEnabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? MediaQuery.of(context).size.height,
      child: GoogleMap(
        //myLocationEnabled: true,
        onTap: (position) {
          onTap!(position);
        },
        zoomControlsEnabled: zoomControlsEnabled!,
        zoomGesturesEnabled: zoomGesturesEnabled!,
        myLocationButtonEnabled: myLocationButtonEnabled!,
        myLocationEnabled: myLocationEnabled!,
        onCameraIdle: onCameraIdle,
        onCameraMove: onCameraMove,
        markers: markers != null ? markers!.toSet() : <Marker>{},
        // polylines: Set<Polyline>.of(polyline!),
        /* initialCameraPosition:const CameraPosition(
          target: LatLng(0, 0),
          zoom: 12.0,
        ),*/
        initialCameraPosition: CameraPosition(
          target: LatLng(lat, lng),
          zoom: 11.0,
        ),
        onMapCreated: onMapCreated,
      ),
    );
  }
}
