import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

import '../../../Constants/app_images.dart';

class SuccessfullyCreatedBusiness extends StatelessWidget {
  SuccessfullyCreatedBusiness({super.key});

  // final _homeVM = Get.find<HomeViewModel>();
  // final _createEventVM = Get.find<CreateViewModel>();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isTopPadding: SizeConfig.screenHeight * 0.08,
      body: SizedBox.expand(
        child: Column(
          children: [
            Image.asset(
              "assets/app_assets/simplelogo.png",
              width: SizeConfig.screenWidth / 2.2,
            ),
            const Spacer(),
            AppText(
              text: "Successfully Registered",
              fontSize: SizeConfig.screenWidth * 0.07,
              fontWeight: FontWeight.w600,
            ),
            // const SizedBox(height: 20),
            AppText(
              text:
                  "Congratulations, your business details are\nsubmitted successfully",
              textAlign: TextAlign.center,
              fontSize: SizeConfig.screenWidth * 0.035,
              fontWeight: FontWeight.w400,
              height: 1.6,
              color: AppColors.whiteText.withOpacity(0.6),
            ),
            const Spacer(),
            const Spacer(),

            // Image.asset(
            //   "assets/temp_assets/createpost.png",
            //   width: SizeConfig.screenWidth / 1.6,
            // ),
            Image(
              image: AssetImage(
                AppImages.imgPartner,
              ),
              width: SizeConfig.screenWidth / 0.5,
            ),
            const Spacer(),
            const Spacer(),
            const Spacer(),

            AppButton.mainButton(
              context,
              text: "Home Page",
              onPressed: () {
                Get.offAllNamed(AppRoutes.NAV_ROOT);
                // print(_homeVM.userData.value.role);
                // // if (_homeVM.userData.value.role == "user") {
                // _createEventVM.eventSelectUserRole();
                // // } else if (_homeVM.userData.value.role == "business") {
                // //   Get.toNamed(AppRoutes.SELECTPOSTMODE);
                // // }
              },
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
