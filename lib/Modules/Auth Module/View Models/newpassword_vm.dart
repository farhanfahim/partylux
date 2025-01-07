import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Modules/Auth%20Module/Service/auth_service.dart';
import 'package:partylux/Utils/Network/cache_handler.dart';
import 'package:partylux/Utils/Network/tost.dart';

import '../Models/usermodel.dart';

class NewPasswordViewModel extends GetxController with AuthService {
  Rx<TextEditingController> password = TextEditingController().obs;
  Rx<TextEditingController> confirmPassword = TextEditingController().obs;
  RxBool obscureText1 = true.obs;
  RxBool obscureText2 = true.obs;

  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  void onResetPassword() async {
    UserModel userData = await DatabaseHandler().getUserData();
    if (formKey.currentState!.validate()) {
      if (password.value.text == confirmPassword.value.text) {
        isLoading.value = true;
        bool result = await onResetPasswordService(
          password: confirmPassword.value.text,
          userID: userData.sId!,
        );
        if (result == false) {
          isLoading.value = false;
          Get.offAllNamed(AppRoutes.LoginSignUpView);
        } else {
          isLoading.value = false;
        }
      } else {
        Toast()
            .error(massage: "New Password and Confirmation Password not match");
      }
    }

    //
  }
}
