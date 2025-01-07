import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/Create%20Module/View%20Model/create_viewmodel.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

import '../../../Constants/app_images.dart';

class SelectPartyMode extends StatelessWidget {
  SelectPartyMode({super.key});

  final _createEventVM = Get.find<CreateViewModel>();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isTopPadding: SizeConfig.screenHeight * 0.08,
      body: Obx(
        () => SizedBox.expand(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: SizeConfig.screenWidth * 0.1,
                      height: SizeConfig.screenWidth * 0.1,
                      color: AppColors.transparent,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: AppColors.whiteText,
                          size: SizeConfig.screenWidth * 0.06,
                        ),
                      ),
                    ),
                  ),
                  Image.asset(
                    AppImages.imgSimpleLogo,
                    width: SizeConfig.screenWidth / 2.2,
                  ),
                  Container(
                    width: SizeConfig.screenWidth * 0.1,
                    height: SizeConfig.screenWidth * 0.1,
                  )
                ],
              ),
              SizedBox(height: 20),
              selectTileUI(
                title: 'Club',
                isActive: _createEventVM.partyMode.value == 'club',
                callback: () {
                  _createEventVM.partyMode.value = "club";
                },
              ),
              selectTileUI(
                title: 'House Party',
                isActive: _createEventVM.partyMode.value == 'houseParty',
                callback: () {
                  _createEventVM.partyMode.value = "houseParty";
                },
              ),
              selectTileUI(
                title: 'Bars',
                isActive: _createEventVM.partyMode.value == 'bars',
                callback: () {
                  _createEventVM.partyMode.value = "bars";
                },
              ),
              const Spacer(),
              AppButton.mainButton(
                context,
                text: "Select Party mode",
                onPressed: () {
                  _createEventVM.selectPartyMode();
                },
              ),
              const SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector selectTileUI({
    required String title,
    required bool isActive,
    required Function callback,
  }) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Container(
        height: SizeConfig.screenWidth * 0.14,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.whiteText.withOpacity(0.1),
        ),
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.04),
        margin: EdgeInsets.symmetric(vertical: SizeConfig.screenWidth * 0.015),
        child: Row(
          children: [
            Container(
              height: SizeConfig.screenWidth * 0.05,
              width: SizeConfig.screenWidth * 0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: isActive
                      ? AppColors.primary
                      : AppColors.whiteText.withOpacity(0.7),
                  width: 1.5,
                ),
              ),
              padding: const EdgeInsets.all(2),
              child: Container(
                height: SizeConfig.screenWidth * 0.05,
                width: SizeConfig.screenWidth * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: isActive
                      ? AppColors.primary
                      : AppColors.whiteText.withOpacity(0.7),
                ),
              ),
            ),
            SizedBox(width: SizeConfig.screenWidth * 0.05),
            Expanded(
              child: AppText(
                text: title,
                fontSize: SizeConfig.screenWidth * 0.04,
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}
