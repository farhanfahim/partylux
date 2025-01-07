import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/Create%20Module/Model/create_model.dart';
import 'package:partylux/Modules/gender_ratios/view_model/gender_ratios_view_model.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import '../../Constants/app_fonts.dart';
import '../../Constants/dimens.dart';
import '../../Constants/strings.dart';
import '../../Utils/Common/custom_tab_bar.dart';
import '../../Utils/Common/sizer.dart';

class GenderRatiosTabView extends GetView<GenderRatiosViewModel> {
  GenderRatiosTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => CustomScaffold(
      isBodyPadding: true,
      showBackBtn: true,
      isLeftAlign: true,
      backgroundImage:  controller.selectedIndex.value == 0?AppImages.imgMaleBg:AppImages.imgFemaleBg,
      appBarTitle: AppStrings.genderRatio,
      basicAppTrailingIcon: Center(
        child: RichText(
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            text: controller.selectedIndex.value == 0?controller.maleCount.toString():controller.femaleCount.toString(),
            style: TextStyle(
              fontFamily: AppFonts.copperPlate,
              overflow: TextOverflow.visible,
              fontWeight: FontWeight.w400,
              color: AppColors.whiteText,
              fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
            ),
            children: <TextSpan>[
              TextSpan(
                text: controller.selectedIndex.value == 0?"Males":"Females",
                style: TextStyle(
                  fontFamily: AppFonts.copperPlate,
                  overflow: TextOverflow.visible,
                  fontWeight: FontWeight.w400,
                  color: controller.selectedIndex.value == 0?AppColors.male:AppColors.female,
                  fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
                ),
              )
            ],
          ),
        ),
      ),
      body: SizedBox.expand(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Obx(() =>  CustomTabBar(
                fontsize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
                controller: controller.tabController,
                indicatorColor: controller.selectedIndex.value == 0? AppColors.male:AppColors.female,
                items: List.generate(controller.screens.length, (index) {
                  return CustomTabBarItem(
                    title: controller.titles[index],
                  );
                }),
                height: AppSizer.getVerticalSize(AppDimen.tabbarHeight)),),
            Expanded(
                child: TabBarView(
                  controller: controller.tabController,
                  children: controller.screens,
                ))
          ],
        ),
      ),
    ));
  }
}
