import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/constants.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

import '../../../Constants/app_images.dart';

class SuccessfullyUpdatedEvent extends StatelessWidget {
  SuccessfullyUpdatedEvent({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: CustomScaffold(
        isTopPadding: SizeConfig.screenHeight * 0.08,
        body: SizedBox.expand(
          child: Column(
            children: [
              Image.asset(
                AppImages.imgSimpleLogo,
                width: SizeConfig.screenWidth / 2.2,
              ),
              const Spacer(),
              AppText(
                text: "Successfully Updated",
                fontSize: SizeConfig.screenWidth * 0.07,
                fontWeight: FontWeight.w600,
              ),
              const Spacer(),
              const Spacer(),
              Image.asset(
                AppImages.imgCreatePost,
                width: SizeConfig.screenWidth / 1.6,
              ),
              const SizedBox(height: 20),
              AppText(
                text: "Congratulations, your event is updated\nSuccessfully",
                textAlign: TextAlign.center,
                fontSize: SizeConfig.screenWidth * 0.04,
                fontWeight: FontWeight.w500,
                height: 1.6,
                color: AppColors.whiteText.withOpacity(0.6),
              ),
              const Spacer(),
              const Spacer(),
              AppButton.mainButton(
                context,
                text: "My Event",
                onPressed: () {
                  Get.offAllNamed(AppRoutes.NAV_ROOT,arguments: {Constants.paramFrom2:0,});
                },
              ),
              const SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }
}
