import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

import '../../../../Constants/dimens.dart';
import '../../../../Utils/Common/sizer.dart';

class LoginSigupButtonTile extends StatelessWidget {
  final Function callback;
  String? leftTitle;
  String? rightTitle;

  LoginSigupButtonTile({
    super.key,
    required this.callback,
    this.leftTitle = "user",
    this.rightTitle = "business",
  });

  final RxBool isLogin = true.obs;

  isLoginMethod(bool val) {
    print("object $val");
    isLogin.value = val;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: SizeConfig.screenWidth * 0.14,
          width: SizeConfig.screenWidth,
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.whiteText.withOpacity(0.1),
            border: Border.all(
              color: AppColors.primary,
              width: 1.5,
            ),
          ),
          child: Container(
            height: SizeConfig.screenWidth * 0.14,
            width: SizeConfig.screenWidth,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Obx(
              () => Row(
                children: [
                  Expanded(
                    child: toggleButton(
                      title: leftTitle!,
                      isActive: isLogin.value,
                      callback: (val) {
                        isLoginMethod(true);
                        callback("${leftTitle}");
                      },
                    ),
                  ), 
                  Expanded(
                    child: toggleButton(
                      title: rightTitle!,
                      isActive: !isLogin.value,
                      callback: (val) {
                        isLoginMethod(false);
                        callback("${rightTitle}");
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget toggleButton({
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
        decoration: isActive
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(8),

                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0, 1],
                  colors: [
                    AppColors.primary,
                    AppColors.secondary,
                  ],
                ),
              )
            : const BoxDecoration(
                color: AppColors.transparent,
              ),
        child: Center(
          child: AppText(
            text: title,
            fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
          ),
        ),
      ),
    );
  }
}
