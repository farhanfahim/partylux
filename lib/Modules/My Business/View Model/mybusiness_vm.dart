// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';
import 'dart:io';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/constants.dart';
import 'package:video_player/video_player.dart';
import '../../../Constants/app_routes.dart';
import '../../../Constants/color.dart';
import '../../../Utils/Common/custom_dialog.dart';
import '../../../Utils/Network/api_client.dart';
import '../../../Utils/Network/api_urls.dart';
import '../../../Utils/Network/cache_handler.dart';
import '../../../Utils/Network/tost.dart';
import '../../../Utils/Theme/app_config.dart';
import '../../../Utils/navigation.dart';
import '../../Auth Module/Models/usermodel.dart';
import '../../create_business/model/become_partner_model.dart';
import '../Model/business_detail_model.dart';
import '../Service/mybusiness_service.dart';

class MyBusinessVM extends GetxController with BecomePartnerService {
  RxBool isLoading = true.obs;
  RxBool isBtnLoading = false.obs;
  RxInt currentIndex = 0.obs;

  RxBool isFavouriteLocal = false.obs;
  Rx<BusinessDetailModel> businessDetailModel = BusinessDetailModel().obs;
  RxList<LiveMale> listOfUsers = List<LiveMale>.empty().obs;
  RxList<LiveMale> listOfMales = List<LiveMale>.empty().obs;
  RxList<LiveFemales> listOfFemales = List<LiveFemales>.empty().obs;
  final Rx<TextEditingController> partyCodeController = TextEditingController().obs;
  Rx<UserModel> userData = UserModel.fromEmpty().obs;
  RxList<BusinessWeek> currentBusinessDay = List<BusinessWeek>.empty().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    userData.value = await DatabaseHandler().getUserData();
    userData.refresh();
    getBusinessDetail(Get.arguments[0]);
  }

  openFlyer(UpcomingEvents,sec) {

    Future.delayed(Duration(seconds: sec), () {


      return showDialog(
          context: Get.context!,
          builder: (context) {
            return CustomDialog(data: UpcomingEvents);
          });
    });

  }

  CarouselController buttonCarouselController = CarouselController();
  onChangeSelectedPageIndex(int val) {
    currentIndex.value = val;
    currentIndex.refresh();
  }

  void getBusinessDetail(String id) async {
    await getBusinessDetailApi(id).then((value) {
      isLoading.value = false;
      businessDetailModel.value = value;
      DateTime now = DateTime.now();
      String dayOfWeek = getDayOfWeek(now.weekday);
      currentBusinessDay = businessDetailModel.value.businessWeek!.where((obj) => obj.bussinessDay == dayOfWeek).toList().obs;

      if (businessDetailModel.value.upcomingEvents!.isNotEmpty && Get.arguments[2] == false) {
        if (!businessDetailModel.value.upcomingEvents!.first.hidden!.contains(userData.value.sId)) {
          openFlyer(businessDetailModel.value.upcomingEvents!.first,2);
        }
      }

      if (businessDetailModel.value.isFavourite!) {
        isFavouriteLocal.value = true;
      } else {
        isFavouriteLocal.value = false;
      }
      listOfUsers.clear();
      listOfMales.clear();
      listOfFemales.clear();

      for (var item in businessDetailModel.value.liveParticipants!.profiles!.male!) {
        listOfUsers.add(item);
        listOfMales.add(item);
      }
      for (var item in businessDetailModel.value.liveParticipants!.profiles!.females!) {
        listOfUsers.add(LiveMale(profileImage: item.profileImage,profileId:item.profileId,sId:item.sId,username: item.username));
        listOfFemales.add(item);
      }

    });

    log(businessDetailModel.toJson().toString());
    businessDetailModel.refresh();
  }


  String getDayOfWeek(int day) {
    switch (day) {
      case 1:
        return "monday";
      case 2:
        return "tuesday";
      case 3:
        return "wednesday";
      case 4:
        return "thursday";
      case 5:
        return "friday";
      case 6:
        return "saturday";
      case 7:
        return "sunday";
      default:
        return "invalid day";
    }
  }

  void deleteBusiness({
    required BuildContext context,
    required String businessID,
  }) async {

    bool isDeleteEvent = await onDeleteBusiness(businessID: businessID);
    if (isDeleteEvent) {
      Navigator.pop(context);
      Navigator.pop(context, true);
    }

  }

  Future<bool> reserveEvent(bool isFree,id) async {
    EasyLoading.show(
      status: 'Please Wait . . .',
      indicator: CupertinoActivityIndicator(
        color: AppColors.whiteText,
        radius: SizeConfig.screenWidth * 0.05,
      ),
    );
    onReserveEvent(
        gender: userData.value.profile!.gender!,
        eventID: id,
        isBusiness: false,
        enteranceCode: "")
        .then((value) {

      EasyLoading.dismiss();
      if (value != null) {
        if(isFree){
          Get.toNamed(
            AppRoutes.ticketDetailView,
            arguments: [value.sId,"business"],
          );
        }else{
          AppNavigator.navigateToNamed(AppRoutes.paymentMethodView, arguments: {
            Constants.paramFrom: true,
            Constants.paramFrom2: value.sId,
          });
        }

      }
    });
    await Future.delayed(Duration(seconds: 2));
    return false;
  }

  void favouriteBusiness(String partnerId) async {
    EasyLoading.show(
      status: 'Please Wait . . .',
      indicator: CupertinoActivityIndicator(
        color: AppColors.whiteText,
        radius: SizeConfig.screenWidth * 0.05,
      ),
    );
    Map data = {"partnerId": partnerId};
    await onFavoriteBusiness(data: data).then((value) async {
      if (value) {
        if (isFavouriteLocal.value) {
          isFavouriteLocal.value = false;
        } else {
          isFavouriteLocal.value = true;
        }
        EasyLoading.dismiss();
      }
    });
  }

}
