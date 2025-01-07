import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/create_party/create_my_party/view/overview.dart';
import 'package:partylux/Modules/create_party/create_my_party/view/settings.dart';
import 'package:partylux/Modules/people_joined/model/evrnt_participants_model.dart';
import 'package:partylux/Modules/people_joined/service/people_joined_service.dart';

import '../../Create Module/Model/create_model.dart';
import '../../My Event Section/Model/event_detail_model.dart';
import '../../people_joined/model/order_model.dart';
import '../../people_joined/model/participants_model.dart';
import '../gender_ratios_tab_view.dart';
import '../gender_ratios_view.dart';

class GenderRatiosViewModel extends GetxController with GetTickerProviderStateMixin, PeopleJoinedService{

  late TabController tabController;
  RxInt selectedIndex = 0.obs;

  final List<String> titles=[AppStrings.txtMales,AppStrings.txtFemales];
  final List<Widget> screens=[GenderRatiosView(),GenderRatiosView()];

  RxInt maleCount = 0.obs;
  RxInt femaleCount = 0.obs;
  RxBool isLoading = true.obs;

  RxList<ParticipantsModel> maleList = List<ParticipantsModel>.empty().obs;
  RxList<ParticipantsModel> femaleList = List<ParticipantsModel>.empty().obs;

  @override
  void onInit() {
    super.onInit();
    selectedIndex.value = Get.arguments[0];
    maleCount.value = Get.arguments[1];
    femaleCount.value = Get.arguments[2];
    if(Get.arguments[4] == "event"){
      getOrders(Get.arguments[3]);
    }else{
      getBusinessOrders(Get.arguments[3]);
    }

    tabController=TabController(length: screens.length, vsync: this,);
    tabController.index = Get.arguments[0];
    tabController.addListener(() {
      selectedIndex.value = tabController.index;
    });
  }


  void getOrders(String id) async {
    await getOrdersApi(eventId: id).then((value) {
      isLoading.value = false;
      for(var item in value){
        if(item.gender! == "male"){
          maleList.add(item);
        }else{
          femaleList.add(item);
        }
      }
    });

  }

  void getBusinessOrders(String id) async {
    await getBusinessOrdersApi(eventId: id).then((value) {
      isLoading.value = false;
      for(var item in value){
        if(item.gender! == "male"){
          maleList.add(item);
        }else{
          femaleList.add(item);
        }
      }
    });

  }




}