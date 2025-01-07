// import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'dart:async';
// import 'package:location/local_location.dart' as loc;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:partylux/Modules/Profile%20Module/Profile%20Section/Model/google_map_model.dart';
import 'package:partylux/Modules/Profile%20Module/Profile%20Section/Service/google_map_service.dart';

class PlacesSearchViewModel extends GetxController {
  // Rx<TextEditingController> locationField = TextEditingController().obs;
  // Rx<TextEditingController> searchTextField = TextEditingController().obs;

  // RxDouble lat = 28.4212.obs;
  // RxDouble lng = 70.2989.obs;

  GoogleMapController? controller;
  RxString markerID = "".obs;
  RxMap<MarkerId, Marker> markers = <MarkerId, Marker>{}.obs;

  ///Auto Complete
  GooglePlaceHandler googlePlaceHandler = GooglePlaceHandler();
  RxList<PlaceSearch> placesListData = <PlaceSearch>[].obs;
  // RxList<NearBySearch> nearByListData = <NearBySearch>[].obs;

  Future<List<PlaceSearch>> searchPerdictions(
    String value, {
    required String lat,
    required String lng,
    String region = "",
  }) async {
    List<PlaceSearch> placesList = [];
    print("lat => $value");
    print("lat => $lat");
    print("lat => $lng");
    placesList = await googlePlaceHandler.autoCompleteSearch(
      value,
      lat: lat,
      lng: lng,
      region: region,
    );
    print(placesList.length);
    placesListData.value = placesList;
    return placesList;
  }

  moveToCameraLocation({required LatLng latLng}) {
    print("My Location calling  moveToCameraLocation-->>>");
    controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(latLng.latitude, latLng.longitude),
      zoom: 16.0,
    )));
  }

  addMarker({required String markerID, required LatLng latLng}) async {
    print("My Location calling addMarker-->>>");
    final MarkerId markerId = MarkerId(markerID);
    final Marker marker = Marker(
      position: latLng,
      markerId: markerId,
      icon: BitmapDescriptor.defaultMarker,
      infoWindow: const InfoWindow(title: "Test", snippet: "this is testing"),
    );

    markers[markerId] = marker;
    markers.refresh();
  }

  // LocationPermission? permission;
  // Future getCurrentPosition() async {
  //   print("checkPermission");
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission != LocationPermission.denied) {
  //       Position position = await Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.high);
  //       lat.value = position.latitude;
  //       lng.value = position.longitude;

  //       print("First Time =>> ${position.latitude}  ${position.longitude}");
  //     } else {
  //       // return Future.error('Location permissions are denied');
  //       permission = await Geolocator.requestPermission();
  //     }
  //   } else {
  //     print("-------------object-------------");
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);
  //     lat.value = position.latitude;
  //     lng.value = position.longitude;
  //     print("First Time =>> ${position.latitude}  ${position.longitude}");
  //   }
  // }

  // Future<bool> checkUserInArea({
  //   required String latitude,
  //   required String longitude,
  // }) async {
  //   double currentLatitude = lat.value;
  //   double currentLongitude = lng.value;
  //   double specificLatitude = double.parse(latitude);
  //   double specificLongitude = double.parse(longitude);
  //   // double specificRadius = AppConstants.checkIn_Out_Radius;

  //   double distanceInMeters = await Geolocator.distanceBetween(
  //       currentLatitude, currentLongitude, specificLatitude, specificLongitude);

  //   if (distanceInMeters <= specificRadius) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // Map<CircleId, Circle> radiusCircle = <CircleId, Circle>{};
  // addCircle(
  //     {required String circleID,
  //     required LatLng latLng,
  //     double? radius}) async {
  //   final CircleId circleId = CircleId(circleID);
  //   final Circle circle = Circle(
  //     circleId: circleId,
  //     center: latLng,
  //     radius: radius ?? 0,
  //     fillColor: Color.fromRGBO(255, 0, 0, 0.2),
  //     strokeWidth: 0,
  //   );
  //   radiusCircle[circleId] = circle;
  // }
}
