// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:partylux/Modules/Auth%20Module/Models/usermodel.dart';
import 'package:partylux/Utils/Network/cache_handler.dart';
import '../../../Constants/color.dart';
import '../../../Utils/Theme/app_config.dart';
import '../../Profile Module/Profile Section/Service/profile_service.dart';

class NotificationSettingViewModel extends GetxController with ProfileService {

  Rx<UserModel> userData = UserModel.fromEmpty().obs;

  RxBool isLoading = false.obs;
  RxBool isPushNotification = false.obs;
  RxBool isNotifyMe = false.obs;
  RxString currentUserEmail = "".obs;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    getUserDetail();

  }

// ================================ Get UserData form Local

  void getUserDetail() async {

    currentUserEmail.value = await DatabaseHandler().getCurrentEmail();
    userData.value = await DatabaseHandler().getUserData();
    await getUserProfile().then((value) {

      isPushNotification.value = value.isPushNotification!;
      isNotifyMe.value = value.isNotifyMe!;
      print( value.isPushNotification!);
      print( value.isNotifyMe!);
    });

  }

  // ================================ Create Profile Method

  void updateNotificationSetting() async {
    EasyLoading.show(
      status: 'Please Wait . . .',
      indicator: CupertinoActivityIndicator(
        color: AppColors.whiteText,
        radius: SizeConfig.screenWidth * 0.05,
      ),
    );
    print(userData.value.sId);
    userData.value.isNotifyMe = isNotifyMe.value;
    userData.value.isPushNotification = isPushNotification.value;

    Map updatedProfile = UserModel.toJsonUpdateNotificationSetting(userData.value);
    print(updatedProfile);

    await onUpdateNotificationSetting(
      data: updatedProfile,

    ).then((value) {
      EasyLoading.dismiss();
    });

  }
}
