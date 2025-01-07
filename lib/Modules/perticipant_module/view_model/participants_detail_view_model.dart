
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:partylux/Modules/people_joined/service/people_joined_service.dart';
import '../../../Constants/color.dart';
import '../../../Utils/Theme/app_config.dart';
import '../../Auth Module/Models/usermodel.dart';
import '../../people_joined/model/order_model.dart';
import '../Model/other_user_model.dart';
class ParticipantsDetailViewModel extends GetxController with GetTickerProviderStateMixin, PeopleJoinedService{

  RxBool isLoading = true.obs;
  RxBool isUserDataLoading = true.obs;
  Rx<OtherUserModel> userData = OtherUserModel.fromEmpty().obs;

  @override
  void onInit() {
    super.onInit();
    getOtherUserData(Get.arguments[0]);

  }



  void getOtherUserData(String userID) async {
    await getUserProfile(userID).then((value) {
      userData.value = value;
      isUserDataLoading.value = false;
    });
  }




}