import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/Auth%20Module/View%20Models/register_vm.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Network/cache_handler.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

import '../../../Constants/app_images.dart';
import '../../../Constants/dimens.dart';
import '../../../Utils/Common/sizer.dart';

class SuccessfullyRegisterView extends StatelessWidget {
  SuccessfullyRegisterView({super.key});
  final _registerVM = Get.isRegistered<RegisterViewModel>()
      ? Get.find<RegisterViewModel>()
      : Get.put(RegisterViewModel());

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      hideAppBar: true,
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.screenHeight * 0.04,
              bottom: SizeConfig.screenHeight * 0.04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: "Successfully Registered",
                  fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel20)
                  
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.006),
                AppText(
                  text:
                      "Congratulations, your account is successfully registered in this application",
                  overflow: TextOverflow.visible,
                  fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                  height: 1,
                  fontWeight: FontWeight.w400,
                  color:AppColors.iconColor,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: SizeConfig.screenWidth * 0.07),
                    child: Image.asset(
                      AppImages.imgSuccessfullyRegistered
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.15),
                AppButton.mainButton(
                  context,
                  text: "Get started",
                  onPressed: () async {
                    Get.offAllNamed(AppRoutes.LoginSignUpView,);
                  },
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
