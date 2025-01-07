// ignore_for_file: invalid_use_of_protected_member

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Modules/Auth%20Module/Models/usermodel.dart';
import 'package:partylux/Modules/BecomePartner/Model/become_partner_model.dart';
import 'package:partylux/Modules/Profile%20Module/Profile%20Section/Service/profile_service.dart';
import 'package:partylux/Utils/Network/cache_handler.dart';
import 'package:partylux/Utils/Theme/app_config.dart';

import '../../../../Constants/color.dart';
import '../../../../Constants/strings.dart';
import '../../../../Utils/Common/custom_info_dialog.dart';

class ProfileViewModel extends GetxController with ProfileService {
  final ScrollController scrollController = ScrollController();
  Rx<UserModel> userProfileData = UserModel.fromEmpty().obs;

  RxBool isScrollingUp = false.obs;
  RxBool isScrollingDown = false.obs;

  RxDouble imageSize = (SizeConfig.screenWidth * 0.26).obs;

  RxString currentUserEmail = "".obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    currentUserEmail.value = await DatabaseHandler().getCurrentEmail();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    scrollController.dispose();
  }


  void logout() async {
    EasyLoading.show(
      status: 'Please Wait . . .',
      indicator: CupertinoActivityIndicator(
        color: AppColors.whiteText,
        radius: SizeConfig.screenWidth * 0.05,
      ),
    );
    Map data = {};

     await onLogout(data: data).then((value) async {
       if (value) {
         EasyLoading.dismiss();

         await DatabaseHandler().setOnBoarding(false);
         await DatabaseHandler().logOut();
         BackgroundGeolocation.stop();
         Get.offAllNamed(AppRoutes.LoginSignUpView);
       }
     });

  }

  void deleteAccount() async {
    EasyLoading.show(
      status: 'Please Wait . . .',
      indicator: CupertinoActivityIndicator(
        color: AppColors.whiteText,
        radius: SizeConfig.screenWidth * 0.05,
      ),
    );

    await onDeleteAccount().then((value) async {
      EasyLoading.dismiss();
      if (value) {
        await DatabaseHandler().setOnBoarding(false);
        await DatabaseHandler().logOut();
        BackgroundGeolocation.stop();
        Get.offAllNamed(AppRoutes.LoginSignUpView);
      }
    });

  }

  void isPrivateProfile(
      {required bool isPrivate, required String userID}) async {
    bool result =
        await updatePrivateProfileStatus(isPrivate: isPrivate, userID: userID);
    if (result) {
      getUserProfile().then((value) async {
        userProfileData.value = value;
      });
    }
  }
}
