import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/people_joined/service/people_joined_service.dart';

import '../model/evrnt_participants_model.dart';
import '../model/order_model.dart';
import '../model/participants_model.dart';

class PeopleJoinedViewModel extends GetxController with GetTickerProviderStateMixin, PeopleJoinedService{


  late TabController tabController;
  RxInt selectedIndex = 0.obs;
  final List<String> titles=[AppStrings.txtMales,AppStrings.txtFemale];
  RxBool isLoading = true.obs;

  RxList<ParticipantsModel> orderModel = List<ParticipantsModel>.empty().obs;
  @override
  void onInit() {
    super.onInit();
    if(Get.arguments[3] == "event"){
      getOrders(Get.arguments[2]);
    }else{
      getBusinessOrders(Get.arguments[2]);
    }

  }


  void getOrders(String id) async {
    await getOrdersApi(eventId: id).then((value) {
      isLoading.value = false;
      orderModel.value = value;
      log(orderModel.value.toString());
    });

  }


  void getBusinessOrders(String id) async {
    await getBusinessOrdersApi(eventId: id).then((value) {
      isLoading.value = false;
      orderModel.value = value;
      log(orderModel.value.toString());
    });

  }




}