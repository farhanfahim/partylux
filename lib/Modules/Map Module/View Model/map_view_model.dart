import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:partylux/Modules/Map%20Module/Services/map_module_service.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:widget_to_marker/widget_to_marker.dart';
import 'dart:async';
import 'package:flutter/services.dart'
    show ByteData, Color, NetworkAssetBundle, Uint8List, rootBundle;
import '../../../Constants/app_routes.dart';
import '../../../Constants/constants.dart';
import '../../../Constants/strings.dart';
import '../../../Utils/Common/custom_location_dialog.dart';
import '../../../Utils/Network/cache_handler.dart';
import '../../Auth Module/Models/usermodel.dart';
import '../../Home Module/Model/event_model.dart';
import '../../add_location_picker/model/local_location.dart';
import '../View/component/custom_window_view.dart';
import '../View/component/marker_image_view.dart';

class MapEventViewModel extends GetxController with MapModuleService {
  GoogleMapController? controller;
  LocationPermission? permission;
  String darkMapStyle = "";
  dynamic image;
  RxSet<Marker> markers = <Marker>{}.obs;
  RxInt checkActive = 0.obs;
  List<EventModel> arrOfEvent = <EventModel>[];
  Rx<UserModel> userData = UserModel.fromEmpty().obs;
  final RxSet<Circle> circles = Set<Circle>.from([]).obs;
  LocalLocation? localLocation;
  RxDouble windowWidth = 300.0.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
    checkActive.value = 5;
  }


  Future<void> onMapCreated(cntlr) async {
    controller = cntlr;
    String darkModeStyle = await _loadMapDarkModeStyle();
    controller!.setMapStyle(darkModeStyle);
    customInfoWindowController.googleMapController = cntlr;
      print("farhan: ${localLocation!.coordinates!.first}, ${localLocation!.coordinates!.last}");
      await moveToCameraLocation(
        latLng: LatLng(localLocation!.coordinates!.first, localLocation!.coordinates!.last),
      );

  }


  Future<String> _loadMapDarkModeStyle() async {
    return await rootBundle.loadString(AppStrings.darkMapStyle);
  }



  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();

  Future<void> getEvent({required String? categoryType}) async {
    await events(
      categoryType: categoryType!,
    ).then((value) {
      arrOfEvent = value;
      if(value.isNotEmpty) {
        addMarkers();
        if(controller!=null) {
          moveToCameraLocation(latLng: LatLng(
              value.first.location!.coordinates![0],
              value.first.location!.coordinates![1]));
        }
      }else{
        markers.clear();
        markers.refresh();
        initCurrentLocation();
      }
    });
  }

  addMarkers() async {
    markers.clear();
    for (int i = 0; i < arrOfEvent.length; i++) {
      print("**************************************\n${arrOfEvent[i].name}");
      final model = arrOfEvent[i];

      final Marker marker = Marker(
          position:
              LatLng(model.location!.coordinates![0], model.location!.coordinates![1]),
          markerId: MarkerId(model.name.toString() + i.toString()),
          icon: await MarkerImageView(
            markerHeight: AppSizer.getSize(40),
            markerWidth: AppSizer.getSize(45),
            height: AppSizer.getSize(29),
            width: AppSizer.getSize(29),
            image: model.eventProfile,
          ).toBitmapDescriptor(),
          onTap: () {

            Timer(Duration(seconds: 1), () {
              customInfoWindowController.addInfoWindow!(
                CustomWindowView(model: model,showAgeLimit:false,userModel:userData.value,location:localLocation,),
                LatLng(model.location!.coordinates![0], model.location!.coordinates![1]),
              );


            });
          });

      markers.add(marker);
    }

    print(markers.length);
  }

  moveToCameraLocation({required LatLng latLng}) {
    controller!.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(latLng.latitude, latLng.longitude),
      zoom: 16.0,
    )));

    if(arrOfEvent.isEmpty) {
      addCircle(circleID: "1", latLng: LatLng(latLng.latitude, latLng.longitude),);
    }
  }
  void addCircle({required String circleID, required LatLng latLng}) async {
    circles.value = Set.from([
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
        strokeColor: Color.fromRGBO(174, 0, 255, 1),

        radius: 40,
      )
    ]);
  }


  initCurrentLocation() async {
    permission = await Geolocator.checkPermission();

    if (permission != LocationPermission.denied) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.lowest);

      await moveToCameraLocation(
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
                    desiredAccuracy: LocationAccuracy.lowest);

                await moveToCameraLocation(
                  latLng: LatLng(position.latitude, position.longitude),
                );
                Get.back();
              },onReject:(){
              Get.back();
            }
            );
          });
      permission = await Geolocator.requestPermission();
    }
  }

}
