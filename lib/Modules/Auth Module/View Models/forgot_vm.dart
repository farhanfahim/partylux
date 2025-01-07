import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Modules/Auth%20Module/Service/auth_service.dart';

import '../Models/usermodel.dart';

class ForgotViewModel extends GetxController with AuthService {
  Rx<TextEditingController> email = TextEditingController().obs;

  final formKey = GlobalKey<FormState>();
  RxBool isLoading = false.obs;
  void onForgotSubmit() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      UserModel result = await onForgotService(
        email: email.value.text,
      );
      if (result.email!.isNotEmpty) {
        isLoading.value = false;
        Get.toNamed(AppRoutes.OTP, arguments: [
          "forgot",
          email.value.text,
          result.userId
        ]);
      } else {
        isLoading.value = false;
      }
    }
  }
}
