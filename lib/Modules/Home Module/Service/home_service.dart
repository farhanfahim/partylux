import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:partylux/Modules/Auth%20Module/Models/usermodel.dart';
import 'package:partylux/Modules/BecomePartner/Model/become_partner_model.dart';
import 'package:partylux/Modules/Create%20Module/Model/create_model.dart';
import 'package:partylux/Modules/add_location_picker/model/local_location.dart';
import 'package:partylux/Utils/Network/api_client.dart';
import 'package:partylux/Utils/Network/api_urls.dart';
import 'package:partylux/Utils/Network/cache_handler.dart';
import 'package:partylux/Utils/Network/tost.dart';

import '../../../models/page_model.dart';
import '../Model/event_model.dart';

abstract class HomeService {

  Future<UserModel> getUserProfile() async {
    UserModel userData = UserModel.fromEmpty();
    try {
      var response = await API().get(ApiManager.CURRENT_USER);
      if (response.data["error"] == false) {
        userData = UserModel.fromJson(response.data["data"][0]);
        DatabaseHandler().setUserData(response.data["data"][0]);
      }
    } catch (e) {
      print("error-<<[[]][[]]->> $e");
    }
    return userData;
  }

  Future<List<BecomePartnerModel>> topLiveBusinesses(
      {String businessType = "club"}) async {
    List<BecomePartnerModel> createEventModel = [];
    print("error-topFiveEvents->>");
    try {

      LocalLocation localLocation = await DatabaseHandler().getLocation();
      double radius = await DatabaseHandler().getRadius();
      var response = await API().get(
        ApiManager.GET_BUSINESS_LIMITED +
            "businessCategory=$businessType"+
            "&page=1"+
            //"&timezone=${await FlutterTimezone.getLocalTimezone()}"+
            "&limit=5"+
            "&businessState=open"+
            "&latitude=${localLocation.coordinates![0]}"+
            "&longitude=${localLocation.coordinates![1]}"+
            "&distance=${radius.round()*1.60934}"+
            "&bussinessStatus=approved",
      );

      if (response == null) {
      } else if (response.statusCode == 200) {
        // Toast().success(massage: response.data["msg"].toString());
        debugPrint("onunuynnec>>>>  ${response.data["data"]}");
        createEventModel =
            BecomePartnerModel.fromJsonToList(response.data["data"]);
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-topFiveCLUB->> $e");
    }
    return createEventModel;
  }

  Future<List<EventModel>> events({
    required int length,
    required String categoryType,
  }) async {
    List<EventModel> createEventModel = [];
    LocalLocation localLocation = await DatabaseHandler().getLocation();
    double radius = await DatabaseHandler().getRadius();

    final Map<String, dynamic> map = {
      'limit': length,
      "eventCategory": categoryType,
      "latitude": localLocation.coordinates![0],
      "longitude": localLocation.coordinates![1],
      "distance": radius.round()*1.60934,
    };

    print("get event map: $map");

    try {

      var response = await API().get(
        ApiManager.GET_EVENTS ,
          queryParameters: map,
      );
      print("response topTENEvents -->> $response");
      if (response == null) {
      } else if (response.statusCode == 200) {
        createEventModel= EventModel.fromJsonToList(response.data["data"]);

      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return createEventModel;
  }

  Future<PageModel<EventModel>?> paginatedEvents({
    required int length,
    int? page,
    required String categoryType,
    bool? isFilter,
    bool? isLocationSelected,
    bool? isCapacitySelected,
    double? distance,
    int? minPrice,
    int? maxPrice,
    int? minPeople,
    int? maxPeople,
    String? gender,
  }) async {
    PageModel<EventModel>? events;
    LocalLocation localLocation = await DatabaseHandler().getLocation();
    double radius = await DatabaseHandler().getRadius();

    print(isLocationSelected);
    print(isCapacitySelected);
    print(isFilter);
    final Map<String, dynamic> map = {
      "page": page,
      'limit': length,
      "isPaginated": 1,
      "eventCategory": categoryType,
      if(isFilter == false)"distance": radius.round()*1.60934,
      if(isFilter == false)"latitude": localLocation.coordinates![0],
      if(isFilter == false)"longitude": localLocation.coordinates![1],
      if(isFilter == true && isLocationSelected == true)"latitude": localLocation.coordinates![0],
      if(isFilter == true && isLocationSelected == true)"longitude": localLocation.coordinates![1],
      if(isFilter == true && isLocationSelected == true)"distance": distance,
      if(isFilter == true && isCapacitySelected == true)"minParticipants":minPeople,
      if(isFilter == true && isCapacitySelected == true)"maxParticipants":maxPeople,
      if(isFilter == true)"minPrice":minPrice,
      if(isFilter == true)"maxPrice":maxPrice,
      if(isFilter == true)"gender":gender,
    };
    print("get event body: ${map}");


    try {

      var response = await API().get(
        ApiManager.GET_EVENTS ,
        queryParameters: map,
      );
      print("response -->> $response");
      if (response == null) {
      } else if (response.statusCode == 200) {
        var data=response.data["data"];
        events=PageModel.fromJson(data["data"], data, (d) {
          return EventModel.fromJson(d);
        });
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return events;
  }



  Future<List<BecomePartnerModel>> businessCategory({
    required String businessCategory,
    required String datalimit,
    required bool isOnlyOpen,
    required String srachBusiness,
  }) async {
    List<BecomePartnerModel> createBusinessModel = [];

    print("businessCategory = $businessCategory");
    print("datalimit = $datalimit");
    print("isOnlyOpen = $isOnlyOpen");

    try {
      var response = await API().get(
        ApiManager.GET_BUSINESS_LIMITED +
            "${isOnlyOpen ? "businessState=open" : ""}"
                "&limit=${datalimit}" +
            "&page=1" +
            "&businessCategory=$businessCategory" +
            "${srachBusiness.isNotEmpty ? "&searchBusiness=$srachBusiness" : ""}",
      );

      print("response Business Here -->> $response");
      if (response == null) {
      } else if (response.statusCode == 200) {
        // Toast().success(massage: response.data["msg"].toString());
        createBusinessModel = BecomePartnerModel.fromJsonToList(response.data["data"]);
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return createBusinessModel;
  }



  Future<List<CreateEventModel>> filterEvents({
    required String location,
    required String peopleAttnedance,
  }) async {
    List<CreateEventModel> createEventModel = [];
    try {
      var response = await API().get(ApiManager.GET_EVENTS +
          "eventCategory=club&distance=0.5&longitude=31.46856&latitude=74.26834");

      print("response topTENEvents -->> $response");
      if (response == null) {
      } else if (response.statusCode == 200) {
        createEventModel =
            CreateEventModel.fromJsonToList(response.data["data"]);
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return createEventModel;
  }


  onSendLocation({
    required Map data,
  }) async {
    try {
      var response = await API().post(ApiManager.SEND_ANNOUNCEMENT, data,);
      if (response == null) {
      } else if (response.data["status"] == 200) {
       // Toast().success(massage: response.data["msg"].toString());
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
  }

  /*Future<String> _getDeviceRegion() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print(androidInfo.data);
      return androidInfo.host;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print(iosInfo.data);
      return iosInfo.name!;
    } else {
      return 'Unsupported platform';
    }
  }*/

}
