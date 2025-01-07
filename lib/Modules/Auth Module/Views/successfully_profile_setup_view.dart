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
import '../../../Constants/strings.dart';
import '../../../Utils/Common/sizer.dart';

class SuccessfullyProfileSetupView extends StatelessWidget {
  SuccessfullyProfileSetupView({super.key});

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
              top: AppSizer.getVerticalSize(30),
              bottom:AppSizer.getVerticalSize(30)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppSizer.getVerticalSize(30)),
                  child: Image.asset(
                    AppImages.imgSuccessfullyProfileSetup
                  ),
                ),
                SizedBox(height: AppSizer.getVerticalSize(20)),
                AppText(
                    text: AppStrings.yourProfileCreated,
                    fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel20)
                ),

                SizedBox(height: AppSizer.getVerticalSize(5)),
                AppText(
                  text: AppStrings.youCanNowEnjoy,
                  overflow: TextOverflow.visible,
                  fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
                  height: 1,
                  fontWeight: FontWeight.w400,
                  color:AppColors.iconColor,
                ),
                Spacer(),
                AppButton.mainButton(
                  context,
                  text: AppStrings.proceedToHome,
                  onPressed: () async {
                    Get.offAllNamed(AppRoutes.NAV_ROOT);
                  },
                ),
                SizedBox(height: AppSizer.getVerticalSize(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
