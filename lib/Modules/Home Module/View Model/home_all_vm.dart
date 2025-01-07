// ignore_for_file: unused_local_variable, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/constants.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/Auth%20Module/Models/usermodel.dart';
import 'package:partylux/Modules/BecomePartner/Model/become_partner_model.dart';
import 'package:partylux/Modules/Create%20Module/Model/create_model.dart';
import 'package:partylux/Modules/Create%20Module/View%20Model/create_viewmodel.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Modules/Home%20Module/Service/home_service.dart';
import 'package:partylux/Utils/Network/cache_handler.dart';

import '../../../Utils/Network/tost.dart';
import '../../../models/page_model.dart';
import '../../add_location_picker/model/local_location.dart';

class HomeAllViewModel extends GetxController
    with HomeService, GetTickerProviderStateMixin {
  Rx<UserModel> userData = UserModel.fromEmpty().obs;
  PageModel<EventModel>? paginatedEventsList;

  @override
  void onInit() {
    super.onInit();
    getUserDetail();
  }

  void getUserDetail() async {
    print("object");
    userData.value = await DatabaseHandler().getUserData();
    userData.refresh();
    UserModel result = await getUserProfile();
    userData.value = result;
    userData.refresh();

  }

//===========================================================================//
//==========      Get Events against eventCategory      =========//
//===========================================================================//
  Future<PageModel<EventModel>?> getPaginatedEvents({
    int length = 6,
    required String? categoryType,
    required int page,
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
    return await paginatedEvents(
        page: page,
        length: length,
        categoryType: categoryType!,
        isFilter: isFilter,
        isLocationSelected: isLocationSelected,
        isCapacitySelected: isCapacitySelected,
        distance: distance,
        minPrice: minPrice,
        maxPrice: maxPrice,
        minPeople: minPeople,
        maxPeople: maxPeople,
        gender: gender);
  }
}
