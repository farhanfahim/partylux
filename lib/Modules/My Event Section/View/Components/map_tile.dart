import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Utils/Common/sizer.dart';

import '../../../../Constants/app_routes.dart';

class MapTileView extends StatefulWidget {
  final String Lat;
  final String Lng;
  const MapTileView({
    super.key,
    required this.Lat,
    required this.Lng,
  });

  @override
  State<MapTileView> createState() => _MapTileViewState();
}

Future<String> _loadMapDarkModeStyle() async {
  return await rootBundle.loadString(AppImages.mapDarkMode);
}

Future<void> _setDarkModeStyle(GoogleMapController controller) async {
  String darkModeStyle = await _loadMapDarkModeStyle();
  controller.setMapStyle(darkModeStyle);
}

class _MapTileViewState extends State<MapTileView> {
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _setDarkModeStyle(controller);
  }

  String darkMapStyle = "";
  GoogleMapController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    darkmap();
  }

  void darkmap() async {
    // await addMarker(
    //   markerID: "My Location",
    //   latLng: LatLng(widget.Lat, widget.Lng),
    // );
    await moveToCameraLocation(
      latLng: LatLng(double.parse(widget.Lat), double.parse(widget.Lng)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizer.getVerticalSize(200),
      width: double.maxFinite,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            GoogleMap(
              onTap: (v){
                Get.toNamed(AppRoutes.ticketLocationView, arguments: [
                  LatLng(double.parse(widget.Lat), double.parse(widget.Lng))
                ]);
              },
              markers: Set<Marker>.of(markers.values),
              onMapCreated: _onMapCreated,
              scrollGesturesEnabled: false,
              zoomGesturesEnabled: false,
              initialCameraPosition: CameraPosition(
                target: LatLng(double.parse(widget.Lat), double.parse(widget.Lng)),
                zoom: 17.0,
              ),
              zoomControlsEnabled: false,
              myLocationEnabled: false,
              myLocationButtonEnabled: false, // set this to false
              mapType: MapType.normal,
            ),
            Image.asset(
              "assets/icon_assets/currentLocation.png",
              width: 80,
              height: 80,
            ),
          ],
        ),
      ),
    );
  }

  addMarker({required String markerID, required LatLng latLng}) async {
    final MarkerId markerId = MarkerId(markerID);
    // BitmapDescriptor image = await BitmapDescriptor.fromAssetImage(
    //     ImageConfiguration(size: Size(25, 25)),
    //     "assets/icon_assets/currentLocation.png");

    final Marker marker = Marker(
      position: latLng,
      markerId: markerId,
      icon: BitmapDescriptor.defaultMarker,
      // icon: BitmapDescriptor.,
      // icon: image,
      infoWindow: const InfoWindow(title: "Test", snippet: "this is testing"),
    );
    setState(() {
      markers[markerId] = marker;
    });
  }

  moveToCameraLocation({required LatLng latLng}) {
    print("object---- Camera Location");
    _controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(latLng.latitude, latLng.longitude),
      zoom: 17.0,
    )));
  }
}
