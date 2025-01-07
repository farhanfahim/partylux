import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

import '../../../Constants/app_constants.dart';
import '../../../Constants/app_routes.dart';
import '../../../Constants/strings.dart';
import '../../../Utils/Common/custom_location_dialog.dart';
import '../../../Utils/Network/cache_handler.dart';
import '../model/local_location.dart';

class AddLocationPickerViewModel extends GetxController {

  Rx<TextEditingController> search=TextEditingController().obs;

  final RxSet<Circle> circles = Set<Circle>.from([]).obs;

  final Rxn<Prediction> predication=Rxn();
  final Rxn<LocalLocation> location=Rxn();
  RxDouble lat = 0.0.obs;
  RxDouble lng = 0.0.obs;
  RxString mainText = "".obs;
  RxString secondaryText = "".obs;
  RxBool showCancelBtn = false.obs;
  GoogleMapController? _controller;

  @override
  Future<void> onInit() async {
    initCurrentLocation();

    LocalLocation pr = await DatabaseHandler().getLocation();
    print(pr.toJson());
    super.onInit();
  }

  @override
  void onClose() {
    _controller?.dispose();
    super.onClose();
  }

  void selectLocation(LocalLocation loc){
    location.value=loc;
  }

  void onMapCreated(GoogleMapController controller) {
    _controller = controller;
    setDarkModeStyle(controller);
  }

  Future<String> _loadMapDarkModeStyle() async {
    return await rootBundle.loadString(AppStrings.darkMapStyle);
  }

  Future<void> setDarkModeStyle(GoogleMapController controller) async {
    String darkModeStyle = await _loadMapDarkModeStyle();
    controller.setMapStyle(darkModeStyle);
  }

  void initCurrentLocation() async {
    var permission = await Geolocator.checkPermission();
    if (permission != LocationPermission.denied) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.lowest);
      moveToCameraLocation(
        latLng: LatLng(position.latitude, position.longitude),
      );
      predication.value = null;
      mainText.value = "";
      secondaryText.value = "";

      getAddressFromLatLng(Get.context,position.latitude,position.longitude).then((value) {
        List<String> splitString =value.split(",");
        mainText.value = splitString[0];
        secondaryText.value = value;
        selectLocation(LocalLocation(
            type: "Point",
            coordinates: [
              position.latitude,
              position.longitude
            ],
            radius: "50",
            address: value
        ));
      });
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
                    desiredAccuracy: LocationAccuracy.lowest);
                moveToCameraLocation(
                  latLng: LatLng(position.latitude, position.longitude),
                );
                predication.value = null;
                mainText.value = "";
                secondaryText.value = "";

                getAddressFromLatLng(Get.context,position.latitude,position.longitude).then((value) {
                  List<String> splitString =value.split(",");
                  mainText.value = splitString[0];
                  secondaryText.value = value;
                  selectLocation(LocalLocation(
                      type: "Point",
                      coordinates: [
                        position.latitude,
                        position.longitude
                      ],
                      radius: "50",
                      address: value
                  ));
                });
                Get.back();
              },onReject:(){
              Get.back();
            }
            );
          });
    }
   // _mapVM.controller.text = "";
  }

  void moveToCameraLocation({required LatLng latLng}) {
    _controller?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(latLng.latitude, latLng.longitude),
      zoom: 16.0,
    )));
    addCircle(circleID: "1", latLng: LatLng(latLng.latitude, latLng.longitude),);
  }

  void addCircle({required String circleID, required LatLng latLng}) async {

    circles.value  = Set.from([
      Circle(
        circleId: CircleId(circleID),
        center: latLng,
        fillColor: Color.fromRGBO(174, 0, 255, 0.8),
        strokeWidth: 0,
        radius: 10,
      ),
      Circle(
        circleId: CircleId("2"),
        center: latLng,
        fillColor: Color.fromRGBO(174, 0, 255, 0.3),
        strokeWidth: 1,
        strokeColor:Color.fromRGBO(174, 0, 255, 1),

        radius: 40,
      )]);
  }


  Future<String> getAddressFromLatLng(context, double lat, double lng) async {
    String _host = 'https://maps.google.com/maps/api/geocode/json';
    final url = '$_host?key=${AppConstants.map_apikey}&language=en&latlng=$lat,$lng';
    if(lat != null && lng != null){
      var response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        String _formattedAddress = data["results"][0]["formatted_address"];
        print("response ==== $_formattedAddress");
        return _formattedAddress;
      } else return "";
    } else return "";
  }
}