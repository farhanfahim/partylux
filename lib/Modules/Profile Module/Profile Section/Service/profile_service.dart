import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Modules/Auth%20Module/Models/usermodel.dart';
import 'package:partylux/Modules/BecomePartner/Model/become_partner_model.dart';
import 'package:partylux/Utils/Network/api_client.dart';
import 'package:partylux/Utils/Network/api_urls.dart';
import 'package:partylux/Utils/Network/cache_handler.dart';
import 'package:partylux/Utils/Network/multipart_client.dart';
import 'package:partylux/Utils/Network/tost.dart';

import '../../../../Utils/Common/custom_info_dialog.dart';

abstract class ProfileService {

  Future<UserModel> getUserProfile(
      ) async {
    UserModel userData = UserModel.fromEmpty();
    try {
      var response = await API().get(ApiManager.CURRENT_USER);
      print("prof response: $response");
       if (response.data["error"] == false) {
        userData = UserModel.fromJson(response.data["data"][0]);
        await DatabaseHandler().setUserData(response.data["data"][0]);
      }
    } catch (e) {
      print("error-<<[[]][[]]->> $e");
    }
    return userData;
  }

  Future onUploadPicture({
    required File imagefile,
  }) async {
    String userImageURL = "";
    try {
      var response = await MultiPartAPI().profileImage(
        ApiManager.UPLOAD_PHOTO,
        imagefile.path,
      );
      print(response.data.toString());
      if (response == null) {
      } else if (response.data["error"] == false) {
        userImageURL = response.data["data"];
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return userImageURL;
  }

  Future onCreateProfile({
    required Map data,
  }) async {
    UserModel userModel = UserModel.fromEmpty();
    try {
      var response =
          await API().post(ApiManager.CREATE_PROFILE, data,);

      if (response == null) {
      } else if (response.data["status"] == 200) {
        //Toast().success(massage: response.data["msg"].toString());
        userModel = await UserModel.fromJson(response.data["data"]["profile"]);
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return userModel;
  }
  Future onLogout({
    required Map data,
  }) async {
    bool isLogout = false;
    try {
      var response =
      await API().post(ApiManager.LOGOUT, data,);

      if (response == null) {
      } else if (response.data["status"] == 200) {
        isLogout = true;
      } else {
        isLogout = false;
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return isLogout;
  }

  Future onDeleteAccount() async {
    bool isDelete = false;
    try {
      var response =
      await API().delete(ApiManager.DELETE_ACCOUNT);

      if (response == null) {
      } else if (response.data["error"] == false) {
        isDelete = true;
      } else {
        isDelete = false;
        showDialog(
            context: Get.context!,
            barrierDismissible: false,
            builder: (context){
              return CustomInfoDialog(
                content: response.data["msg"],
              );
            });
      }
    } catch (e) {
      print("error-->> $e");
    }
    return isDelete;
  }


  Future<bool> updatePrivateProfileStatus({
    required bool isPrivate,
    required String userID,
  }) async {
    Map data = {"isPrivate": isPrivate};
    bool result = false;
    print(data);
    try {
      var response =
          await API().patch(ApiManager.UPDATE_PROFILE_HIDE_SHOW, data);

      if (response == null) {
      } else if (response.data["error"] == false) {
        //Toast().success(massage: response.data["msg"].toString());
        print("22-> " + response.data["data"]["profile"].toString());
        result = true;
      } else {
        Toast().error(massage: response.data["msg"].toString());
        result = false;
      }
    } catch (e) {
      print("error-->> $e");
    }
    return result;
  }

  Future onUpdateProfile({
    required Map data,
  }) async {
    UserModel userModel = UserModel.fromEmpty();
    try {
      var response = await API().put(ApiManager.GET_USER_PROFILE, data);

      if (response == null) {
      } else if (response.data["error"] == false) {
        Get.back();
        //Toast().success(massage: response.data["msg"].toString());
        await DatabaseHandler().setUserData(response.data["data"]);
        userModel = UserModel.fromJson(response.data["data"]);
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return userModel;
  }

  Future onUpdateNotificationSetting({
    required Map data,
  }) async {
    UserModel userModel = UserModel.fromEmpty();
    try {
      var response = await API().put(ApiManager.GET_USER_PROFILE, data);

      if (response == null) {
      } else if (response.data["error"] == false) {
        //Toast().success(massage: response.data["msg"].toString());
        await DatabaseHandler().setUserData(response.data["data"]);
        userModel = UserModel.fromJson(response.data["data"]);
        print(userModel.isNotifyMe);
        print(userModel.isPushNotification);
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return userModel;
  }

  Future<List<BecomePartnerModel>> onGetMyBusinesses() async {
    List<BecomePartnerModel> businessModel = [];
    try {
      var response = await API().get(ApiManager.GET_MY_BUSINESSES);

      if (response == null) {
      } else if (response.data["error"] == false) {
        businessModel = BecomePartnerModel.fromJsonToList(response.data["data"]);
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return businessModel;
  }
}
