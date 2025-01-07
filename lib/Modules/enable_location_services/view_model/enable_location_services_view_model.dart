import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_places_flutter/model/prediction.dart';

import '../../../Constants/strings.dart';
import '../../../Utils/Common/custom_location_dialog.dart';
import '../../../Utils/Network/cache_handler.dart';
import '../../../Utils/Network/tost.dart';
import '../../add_location_picker/model/local_location.dart';

class EnableLocationServicesViewModel extends GetxController {

  onTapEnableLocation() async {

    _getCurrentPosition();
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    LocalLocation pre;

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest).then((value)   async {
        pre = LocalLocation(type: "Point",coordinates: [value.latitude,value.longitude],radius: "50",address: "");
        await DatabaseHandler().setLocation(pre.toJson());
    }).catchError((e) {
      print(e);
    });

  }



  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Toast().error(massage: 'Location services are disabled. Please enable the services');
      return false;

    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (context){
            return CustomLocationDialog(
              content: AppStrings.locationContent,
              onAccept: () async {
                permission = await Geolocator.requestPermission();
                Get.back();
              },
              onReject: (){
                Get.back();
              },
            );
          });


    }else if (permission == LocationPermission.deniedForever) {
      Toast().error(massage: 'Location permissions are permanently denied, we cannot request permissions.');

      return false;
    }else{
      Toast().success(massage: 'Locations permission already granted');
      return true;
    }
    return true;
  }

}