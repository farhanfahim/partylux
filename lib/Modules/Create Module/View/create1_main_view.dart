import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Modules/Create%20Module/View%20Model/create_viewmodel.dart';
import 'package:partylux/Modules/Home%20Module/View%20Model/home_vm.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

import '../../../Constants/app_routes.dart';
import '../../../Constants/color.dart';
import '../../../Constants/app_images.dart';

class CreatePostView extends StatelessWidget {
  CreatePostView({super.key});

  final _homeVM = Get.find<HomeViewModel>();
  final _createEventVM = Get.find<CreateViewModel>();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      hideAppBar: true,
      isTopPadding: SizeConfig.screenHeight * 0.08,
      body: SizedBox.expand(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: SizeConfig.screenWidth * 0.12,
                  height: SizeConfig.screenWidth * 0.12,
                ),
                const Spacer(),
                Image.asset(
                  AppImages.imgSimpleLogo,
                  width: SizeConfig.screenWidth / 2.1,
                ),
                const Spacer(),

                SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.notificationView);
                  },
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: SizeConfig.screenWidth * 0.12,
                    height: SizeConfig.screenWidth * 0.12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.feildBGColor.withOpacity(0.1),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(SizeConfig.screenWidth * 0.03),
                      child: Image.asset(AppImages.imgNotificationPng),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Image.asset(
              AppImages.imgCreatePost,
              width: SizeConfig.screenWidth / 1.6,
            ),
            const SizedBox(height: 20),
            AppText(
              text: "Wanna Create Your Own Club or\nHouse Party",
              textAlign: TextAlign.center,
              fontSize: SizeConfig.screenWidth * 0.04,
              fontWeight: FontWeight.w500,
            ),
            const Spacer(),
            AppButton.mainButton(
              context,
              text: "Create My Party",
              onPressed: () {
                print(_homeVM.userData.value.role);
                // if (_homeVM.userData.value.role == "user") {
                _createEventVM.eventSelectUserRole();
                // } else if (_homeVM.userData.value.role == "business") {
                //   Get.toNamed(AppRoutes.SELECTPOSTMODE);
                // }
              },
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
