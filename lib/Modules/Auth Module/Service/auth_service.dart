import 'dart:io';
import 'package:flutter/material.dart';
import 'package:partylux/Utils/Network/api_client.dart';
import 'package:partylux/Utils/Network/api_urls.dart';
import 'package:partylux/Utils/Network/cache_handler.dart';
import 'package:partylux/Utils/Network/tost.dart';
import '../../../Utils/Network/multipart_client.dart';
import '../Models/usermodel.dart';

abstract class AuthService {

  Future<UserModel> onRegisterService({
    required String name,
    required String email,
    required String password,
    required String role,
    String? userProfileImage,
    String? userProfileId,
  }) async {
    UserModel userModel = UserModel.fromJson({});
    try {

      var data = {
        "username": name,
        "email": email,
        "password": password,
        "role": role,
        if(userProfileImage!.isNotEmpty)"profileImage": userProfileImage,
        if(userProfileId!.isNotEmpty)"profileId": userProfileId,
      };

      var response = await API().post(ApiManager.SIGNUP, data);
      print("response-->> $response");
      if (response == null) {
      } else if (response.data['error'] == false) {
        await DatabaseHandler().setUserData(response.data["data"]);
        await DatabaseHandler().setCurrentEmail(response.data["data"]["email"]);
        userModel = UserModel.fromJson(response.data["data"]);
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return userModel;
  }

  Future<UserModel> onLoginService({
    required String email,
    required String password,
    required String role,
  }) async {
    UserModel userModel = UserModel.fromJson({});
    try {
      var data = {
        "email": email,
        "password": password,
         "role": role,
      };

      var response = await API().post(ApiManager.LOGIN, data);
      print("response-->> $response");
      if (response == null) {
      } else if (response.data["error"] == false) {
        ///Toast().success(massage: response.data["msg"].toString());

        userModel = UserModel.fromJson(response.data["data"]);
        await DatabaseHandler().setUserData(response.data["data"]);
        if(userModel.isVerified!){

          if(response.data["data"]["email"]!=null){
            await DatabaseHandler().setCurrentEmail(response.data["data"]["email"]);
          }
          if(response.data["data"]["authToken"]!=null){
            await DatabaseHandler().setToken(response.data["data"]["authToken"]);
          }

        }

      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return userModel;
  }

  Future<UserModel> OnSocialLogin({
    required String uID,
    required String userName,
    required String userLoginType,
    required String email,
  }) async {
    UserModel userModel = UserModel.fromJson({});
    try {
      Map data = {
        "uid": uID,
        "userName": userName,
        "userLoginType": userLoginType,
        "email": email,
      };
      debugPrint(data.toString());
      var response = await API().post(ApiManager.SOCIALLOGIN, data);
      print("social response-->> ${response.data.toString()}");
      if (response == null) {
      } else if (response.data["error"] == false) {

        await DatabaseHandler().setUserData(response.data["data"]);
        userModel = UserModel.fromJson(response.data["data"]);
        if(response.data["data"]["email"]!=null){
          await DatabaseHandler().setCurrentEmail(response.data["data"]["email"]);
        }
        if(response.data["data"]["authToken"]!=null){
          await DatabaseHandler().setToken(response.data["data"]["authToken"]);
        }
  /*

        if (userModel.isProfile!) {
          await DatabaseHandler().setToken(response.data["data"]["authToken"]);
        } else {
          await DatabaseHandler().setTempToken(response.data["data"]["authToken"]);
        }
        print(userModel.sId.toString());*/
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return userModel;
  }

  Future<bool> onVerifiedService({
    required String userID,
    required String otp,
  }) async {
    bool isVerified = false;
    try {
      var data = {
        "userId": userID,
        "Otp": otp,
      };
      var response = await API().post(ApiManager.VARIFY, data);
      print("response-->> $response");
      if (response == null) {
      } else if (response.data["error"] == false) {
        isVerified = true;
      } else {
        isVerified = false;
      }
    } catch (e) {
      print("error-->> $e");
    }
    return isVerified;
  }

  Future<void> onResendService({
    required String userID,
  }) async {
    try {
      var data = {
        "userId": userID,
      };
      var response = await API().post(ApiManager.RESEND, data);
      print("response-->> $response");
      if (response == null) {
      } else if (response.data["error"] == false) {

      } else {
      }
    } catch (e) {
      print("error-->> $e");
    }
  }

  Future<UserModel> onForgotService({
    required String email,
  }) async {
    UserModel userModel = UserModel.fromJson({});
    try {
      var data = {
        "email": email,
      };
      var response = await API().post(ApiManager.FORGOT, data);
      print("response-->> $response");
      if (response == null) {
      } else if (response.data["error"] == false) {
        await DatabaseHandler().setUserData(response.data["data"]);
        userModel  = UserModel.fromJson(response.data["data"]);
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return userModel;
  }

  Future<bool> onResetPasswordService({
    required String password,
    required String userID,
  }) async {
    bool userModel = false;
    try {
      var data = {
        "newPassword": password,
        "userId": userID,
      };
      var response = await API().post(ApiManager.RESET_PASSWORD, data);
      print("response-->> $response");
      if (response == null) {
      } else if (response.data["error"] == false) {
        userModel = response.data["error"];
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return userModel;
  }

  Future<bool> onSetorUpdateFCMToken({
    required String fcmToken,
  }) async {
    bool userModel = false;
    try {
      var data = {
        "fcm_token": fcmToken,
      };
      var response = await API().post(ApiManager.FCM_SET_UPDATE, data);
      print("response-->> $response");
      if (response == null) {
      } else if (response.data["success"] == true) {
        print(response.data["msg"]);
      } else {
        print(response.data["msg"]);
      }
    } catch (e) {
      print("error-->> $e");
    }
    return userModel;
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

}
