import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/Auth%20Module/Models/usermodel.dart';
import 'package:partylux/Modules/create_party/create_my_party/service/create_party_service.dart';
import 'package:partylux/Modules/payment_module/stripe_connect/view/connect_view.dart';
import 'package:partylux/Utils/Network/cache_handler.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/navigation.dart';

import '../../../../Constants/constants.dart';

class PartyPromptViewModel extends GetxController with CreatePartyService{

  final Rx<UserModel> userData = UserModel.fromEmpty().obs;

  @override
  void onInit() {
    getUserDetail();
    super.onInit();
  }

  Future<void> getUserDetail() async {
    userData.value = await DatabaseHandler().getUserData();
  }

  Future<void> advance() async{
    //userData.value.connectedAccountId=null;
    void proceed(){
      if (userData.value.role == UserModel.ROLE_BUSINESS) {
        AppNavigator.navigateToNamed(AppRoutes.createCategoryParty);
      }
      else {
        AppNavigator.navigateToNamed(AppRoutes.createParty,arguments: {
          Constants.paramFrom: Constants.CATEGORY_HOUSE_PARTY,
        });

      }
    }

    if(userData.value.connectedAccountId!=null && userData.value.connectedAccountId!.isNotEmpty) {
      proceed();
    }
    else{
      EasyLoading.show(
        status: 'Please Wait . . .',
        indicator: CupertinoActivityIndicator(
          color: AppColors.whiteText,
          radius: SizeConfig.screenWidth * 0.05,
        ),
      );
      String? url=await onConnectAccount({"country":"US"});
      EasyLoading.dismiss();
      if(url!=null) {
        AppNavigator.navigateTo(ConnectView(
            url: url,
          //url: "https://partylux-admin.tekstagearea.com/return-connect-account?user_id=65f8899ec57b0024c17d26fa&account_id=acct_1OyZ0gQfF082CwRj",
          onMessage: (val) async{
            AppNavigator.pop();
            bool stat=await setConnectAccount(val);
            if(stat){
              proceed();
            }
          },
        ));
      }

    }
  }

  Future<bool> setConnectAccount(String id) async{
    print("connect id: $id");
    bool stat=false;
    EasyLoading.show(
      status: 'Please Wait . . .',
      indicator: CupertinoActivityIndicator(
        color: AppColors.whiteText,
        radius: SizeConfig.screenWidth * 0.05,
      ),
    );
    stat=await onUpdateConnectAccount({"connected_account_id":id});
    if(stat){
      userData.value.connectedAccountId=id;
      await DatabaseHandler().setUserData(userData.value.toJson());
    }
    EasyLoading.dismiss();
    return stat;
  }

}