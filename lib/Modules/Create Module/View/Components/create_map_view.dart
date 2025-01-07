import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:partylux/Constants/color.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:partylux/Modules/Create%20Module/View%20Model/create_viewmodel.dart';
import 'package:partylux/Modules/Create%20Module/View%20Model/google_map_vm.dart';

import '../../../../Constants/app_routes.dart';
import '../../../../Constants/strings.dart';
import '../../../../Utils/Common/custom_location_dialog.dart';

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({Key? key}) : super(key: key);

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

Future<String> _loadMapDarkModeStyle() async {
  return await rootBundle.loadString('assets/map_dark_mode.json');
}

Future<void> _setDarkModeStyle(GoogleMapController controller) async {
  String darkModeStyle = await _loadMapDarkModeStyle();
  controller.setMapStyle(darkModeStyle);
}

class _GoogleMapViewState extends State<GoogleMapView> {
  final _createEventVM = Get.find<CreateViewModel>();
  final _createEventMapController = Get.put(PlacesSearchViewModel());
  // Location location = Location();
  // LocationData? locationData;
  LocationPermission? permission;

  String darkMapStyle = "";
  dynamic image;

  void _onMapCreated(GoogleMapController controller) {
    _createEventMapController.controller = controller;
    _setDarkModeStyle(controller);
  }

  ///Markers
  // Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  // Map<CircleId, Circle> radiusCircle = <CircleId, Circle>{};

  @override
  void initState() {
    super.initState();
    getLocation();
    KeyboardVisibilityController().onChange.listen((event) {
      _createEventVM.isKeyboard.value = event;
    });
  }

  getLocation() async {
    permission = await Geolocator.checkPermission();
    if (permission != LocationPermission.denied) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print("First Time =>> ${position.latitude}  ${position.longitude}");
      // await _createEventMapController.addMarker(
      //   markerID: "My Location",
      //   latLng: LatLng(position.latitude, position.longitude),
      // );

      await _createEventMapController.moveToCameraLocation(
        latLng: LatLng(position.latitude, position.longitude),
      );
    } else {
      showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (context){
            return CustomLocationDialog(
              content: AppStrings.locationContent,
              onAccept: () async {
                permission = await Geolocator.requestPermission();
                Position position = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high);
                await _createEventMapController.moveToCameraLocation(
                  latLng: LatLng(position.latitude, position.longitude),
                );
                Get.back();
              },onReject:(){
              Get.back();
            }
            );
          });
    }
  }

  // static const LatLng _center = const LatLng(28.4212, 70.2989);
  // LatLng _center = LatLng(37.7749, -122.4194);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: FloatingActionButton(
            onPressed: () {
              initCurrentLocation();
            },
            backgroundColor: AppColors.primary,
            child: const Icon(Icons.my_location_rounded),
          ),
        ),
      ),
      body: Stack(
        children: [
          Obx(
            () => GoogleMap(
              markers: Set<Marker>.of(_createEventMapController.markers.values),
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
          Align(
            alignment: Alignment.center,
            child: IconButton(
              iconSize: MediaQuery.of(context).size.width * 0.25,
              icon: Image.asset("assets/icon_assets/currentLocation.png"),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  initCurrentLocation() async {
    permission = await Geolocator.checkPermission();

    if (permission != LocationPermission.denied) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      await _createEventMapController.moveToCameraLocation(
        latLng: LatLng(position.latitude, position.longitude),
      );
      // await _createEventMapController.addMarker(
      //   markerID: "My Location",
      //   latLng: LatLng(position.latitude, position.longitude),
      // );
    } else {
      showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (context){
            return CustomLocationDialog(
              content: AppStrings.locationContent,
              onAccept: () async {
                permission = await Geolocator.requestPermission();
                Position position = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high);
                await _createEventMapController.moveToCameraLocation(
                  latLng: LatLng(position.latitude, position.longitude),
                );
                Get.back();
              },onReject:(){
              Get.back();
            }
            );
          });

    }
  }

  // findLocation({
  //   required double lat,
  //   required double lng,
  // }) async {
  //   debugPrint("lat: $lat, lng: $lng");
  //   FocusManager.instance.primaryFocus?.unfocus();
  //   permission = await Geolocator.checkPermission();
  //   if (permission != LocationPermission.denied) {
  //     _mapController.placesListData.value = [];
  //     _sController.searchController.value.text = "";
  //     addMarker(
  //       markerID: "My Location",
  //       latLng: LatLng(lat, lng),
  //     );
  //     _mapController.addCircle(
  //       circleID: "My Location",
  //       latLng: LatLng(lat, lng),
  //     );
  //     moveToCameraLocation(
  //       latLng: LatLng(lat, lng),
  //     );
  //   }
  // }

  // moveToCameraLocation({required LatLng latLng}) {
  //   _controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
  //     target: LatLng(latLng.latitude, latLng.longitude),
  //     zoom: 16.0,
  //   )));
  // }

  // addMarker({required String markerID, required LatLng latLng}) async {
  //   final MarkerId markerId = MarkerId(markerID);
  //   // BitmapDescriptor image = await BitmapDescriptor.fromAssetImage(
  //   //     ImageConfiguration(size: Size(48, 48)), "assets/test.PNG");
  //   final Marker marker = Marker(
  //     position: latLng,
  //     markerId: markerId,
  //     icon: BitmapDescriptor.defaultMarker,
  //     infoWindow: const InfoWindow(title: "Test", snippet: "this is testing"),
  //   );
  //   setState(() {
  //     markers[markerId] = marker;
  //   });
  // }

  // addCircle({required String circleID, required LatLng latLng}) async {
  //   final CircleId circleId = CircleId(circleID);
  //   final Circle circle = Circle(
  //     circleId: circleId,
  //     center: latLng,
  //     radius: 30, // Change this to set the radius of the circle
  //     fillColor: Color.fromRGBO(255, 0, 0, 0.2),
  //     strokeWidth: 0,
  //   );
  //   setState(() {
  //     radiusCircle[circleId] = circle;
  //   });
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _createEventMapController.controller?.dispose();
  }
  // createPolyline(
  //     {required String polylineID,
  //     required LatLng fromLoc,
  //     required LatLng toLoc}) async {
  //   try {
  //     print("result");
  //     final PolylineId polylineId = PolylineId(polylineID);
  //   } catch (e) {
  //     print("e");
  //     print(e);
  //   }
  // }
}
