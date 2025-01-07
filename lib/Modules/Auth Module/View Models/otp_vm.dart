import 'dart:async';

import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/Auth%20Module/Models/usermodel.dart';
import 'package:partylux/Modules/Auth%20Module/Service/auth_service.dart';
import 'package:partylux/Utils/Network/cache_handler.dart';
import 'package:partylux/Utils/Network/tost.dart';

class OTPViewModel extends GetxController with AuthService {
  RxString otpCode = "".obs;
  RxBool isLoading = false.obs;

  RxInt sec = 15.obs;
  RxInt sec2 = 60.obs;
  RxBool showTimer = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    expiresCountDown();
  }

  void countDown() {
    print(sec.value);
    showTimer.value = true;
    if (sec.value != 0) {
      Timer.periodic(Duration(seconds: 1), (timer) {
        if (sec != 0) {
          sec = sec - 1;
        } else {
          showTimer.value = false;
          timer.cancel();
        }
      });
    } else {
      sec.value = 15;
      countDown();
    }
  }

  void expiresCountDown() {
    print(sec2.value);
    if (sec.value != 0) {
      Timer.periodic(Duration(seconds: 1), (timer) {
        if (sec2 != 0) {
          sec2 = sec2 - 1;
        } else {
          showTimer.value = false;
          timer.cancel();
        }
      });
    } else {
      sec2.value = 15;
      expiresCountDown();
    }
  }

  void onVerifyForgot(id) async {

    if (otpCode.value != "") {
      if (otpCode.value.length < 4) {
        Toast().error(massage: "Please enter valid OTP code");
      } else {
        isLoading.value = true;

        await onVerifiedService(
          userID: id!,
          otp: otpCode.value,
        ).then((value) {
          if (value) {
            isLoading.value = false;
            Get.offNamed(AppRoutes.NEW_PASSWORD);
          } else {
            isLoading.value = false;
          }
        });
      }
    } else {
      Toast().error(massage: "Please enter OTP code");
    }
  }

  void onVerifyRegister(id) async {

    if (otpCode.value != "") {
      if (otpCode.value.length < 4) {
        Toast().error(massage: "Please enter valid OTP code");
      } else {
        isLoading.value = true;
         await onVerifiedService(
          userID: id!,
          otp: otpCode.value,
        ).then((value) {
           if (value) {
             isLoading.value = false;
             Get.offAllNamed(AppRoutes.SUCCESSFULLY_REGISTER);
           } else {
             isLoading.value = false;
           }
         });

      }
    } else {
      Toast().error(massage: "Please enter OTP code");
    }
  }

  void onWithdraw() async {
    UserModel userData = await DatabaseHandler().getUserData();
    print(userData.sId);
    if (otpCode.value != "") {
      if (otpCode.value.length < 4) {
        Toast().error(massage: "Please enter valid OTP code");
      } else {
        Get.back();
      }
    } else {
      Toast().error(massage: "Please enter OTP code");
    }
  }

  void onResendOtp() async {
    UserModel userData = await DatabaseHandler().getUserData();
    print(userData.sId);
    await onResendService(
      userID: userData.sId!,
    );

  }
}
