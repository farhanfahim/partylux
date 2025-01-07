// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/Create%20Module/View%20Model/create_viewmodel.dart';
import 'package:partylux/Modules/Create%20Module/View%20Model/google_map_vm.dart';

class MapViewCard extends StatefulWidget {
  const MapViewCard({super.key});

  @override
  State<MapViewCard> createState() => _MapViewCardState();
}

Future<String> _loadMapDarkModeStyle() async {
  return await rootBundle.loadString('assets/map_dark_mode.json');
}

Future<void> _setDarkModeStyle(GoogleMapController controller) async {
  String darkModeStyle = await _loadMapDarkModeStyle();
  controller.setMapStyle(darkModeStyle);
}

class _MapViewCardState extends State<MapViewCard> {
  final _createEventVM = Get.find<CreateViewModel>();
  final _createEventMapController = Get.put(PlacesSearchViewModel());

  void _onMapCreated(GoogleMapController controller) {
    _createEventMapController.controller = controller;
    _setDarkModeStyle(controller);
  }

  LatLng _center = LatLng(37.7749, -122.4194);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.primary.withOpacity(0.2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Obx(
              () => GoogleMap(
                markers:
                    Set<Marker>.of(_createEventMapController.markers.values),
                onMapCreated: _onMapCreated,
                scrollGesturesEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    _createEventVM.currentLat.value,
                    _createEventVM.currentLong.value,
                  ),
                  zoom: 15.0,
                ),
                zoomGesturesEnabled: true,
                // initialCameraPosition: const CameraPosition(
                //   target: LatLng(28.4212, 70.2989),
                //   zoom: 16.0,
                // ),

                zoomControlsEnabled: true,
                myLocationEnabled: false,
                myLocationButtonEnabled: false, // set this to false
                mapType: MapType.normal,

                onCameraMove: (cameraPosition) {
                  var currentLongitude = cameraPosition.target.longitude;
                  var currentLatitude = cameraPosition.target.latitude;
                  _createEventVM.lat.value = currentLatitude;
                  _createEventVM.lng.value = currentLongitude;
                },
              ),
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
}
