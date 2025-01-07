import 'package:partylux/Constants/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Utils/Common/sizer.dart';

class Toast {
  success({required massage}) {
    return Get.snackbar(
      "Success",
      massage,
      icon: const Icon(
        Icons.check_circle,
        color: AppColors.whiteText,
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor:
          AppColors.success.withOpacity(0.5), //.withOpacity(0.6),
      borderRadius: 20,
      margin: EdgeInsets.only(top: AppSizer.height/2.2,left: 15,right: 15),
      colorText: AppColors.whiteText,
      animationDuration:  const Duration(seconds: 0),
      duration: const Duration(seconds: 3),
    );
  }

  error({required massage}) {
    if (Get.isSnackbarOpen == false) {
      return Get.snackbar(
        "Error",
        massage.toString().trim() + "!",
        icon: const Icon(
          Icons.error,
          color: Colors.white,
        ),
        backgroundColor: AppColors.error.withOpacity(0.5), //.withOpacity(0.6),
        borderRadius: 20,
        margin: EdgeInsets.only(top: AppSizer.height/2.2,left: 15,right: 15),
        colorText: AppColors.whiteText,
        animationDuration:  const Duration(seconds: 0),
        duration: const Duration(seconds: 3),
      );
    }
  }

  warning({
    required String title,
    required String massage,
  }) {
    if (Get.isSnackbarOpen == false) {
      return Get.snackbar(
        title,
        massage,
        icon: const Icon(
          Icons.wallet_membership_rounded,
          color: Colors.white,
        ),
        snackPosition: SnackPosition.TOP,
        backgroundColor:
            AppColors.primary.withOpacity(0.5), //.withOpacity(0.6),
        borderRadius: 20,
        margin: const EdgeInsets.all(15),
        colorText: AppColors.whiteText,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
