import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

class UserBusinessButton extends StatelessWidget {
  final Function callback;
  final String title;
  UserBusinessButton({
    super.key,
    required this.callback,
    required this.title,
  });

 final RxBool isUserActive = true.obs;
final  RxBool isBusinessActive = false.obs;

  void userActive(bool val) {
    isUserActive.value = val;
    isBusinessActive.value = !val;
  }

  void businessActive(bool val) {
    isBusinessActive.value = val;
    isUserActive.value = !val;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: SizeConfig.screenWidth * 0.04),
        AppText(
          text: title,
          fontSize: SizeConfig.screenWidth * 0.034,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: SizeConfig.screenWidth * 0.023),
        Container(
          height: SizeConfig.screenWidth * 0.14,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: AppColors.iconColor,
              width: 1.5,
            ),
            color: AppColors.feildBGColor.withOpacity(0.1),
          ),
          child: Obx(
            () => Row(
              children: [
                togalButton(
                  title: "User",
                  isActive: isUserActive.value,
                  callback: (val) {
                    userActive(val);
                    callback("user");
                  },
                ),
                togalButton(
                  title: "Business",
                  isActive: isBusinessActive.value,
                  callback: (val) {
                    businessActive(val);
                    callback("business");
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget togalButton({
    required String title,
    required bool isActive,
    required Function callback,
  }) {
    return GestureDetector(
      onTap: () {
        if (!isActive) {
          callback(!isActive);
        }
      },
      child: Container(
        height: SizeConfig.screenWidth * 0.14,
        width: (SizeConfig.screenWidth / 2) -
            (SizeConfig.screenWidth * 0.05 + 7.5),
        margin: const EdgeInsets.all(3),
        decoration: isActive
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: AppColors.transparent,
                  width: 1.5,
                ),
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0, 1],
                  colors: [
                    AppColors.secondary,
                    AppColors.primary,
                  ],
                ),
              )
            : const BoxDecoration(
                color: AppColors.transparent,
              ),
        child: Center(
          child: AppText(
            text: title,
            fontSize: SizeConfig.screenWidth * 0.04,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// class ControllerVM extends GetxController {
 
// }
