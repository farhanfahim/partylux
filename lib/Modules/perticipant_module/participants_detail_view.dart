import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/state_manager.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/perticipant_module/view_model/participants_detail_view_model.dart';
import 'package:partylux/Modules/perticipant_module/view_model/participants_view_model.dart';
import 'package:partylux/Utils/Common/cechednetworlimage.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import '../../Constants/app_routes.dart';
import '../../Constants/dimens.dart';
import '../../Constants/strings.dart';
import '../../Utils/Common/glassmorphic_container.dart';
import '../../Utils/Common/sizer.dart';

class ParticipantsDetailView extends GetView<ParticipantsDetailViewModel> {
  ParticipantsDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isBodyPadding: true,
      showBackBtn: true,
      isLeftAlign: true,
      //appBarTitle: AppStrings.participantDetail,
      appBarTitle: "${Get.arguments[1]}'s profile",
      body: SizedBox.expand(
        child: Obx(() => !controller.isUserDataLoading.value?Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

/*            AppText(
              text: AppStrings.hereYouCanSeeYourParticipantDetail,
              overflow: TextOverflow.visible,
              fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
              height: 1,
              fontWeight: FontWeight.w400,
              color:AppColors.iconColor,
            ),
            SizedBox(height: AppSizer.getVerticalSize(10)),*/

            SingleChildScrollView(
              padding: EdgeInsets.only(top: 10, bottom: 20),
              child: GlassContainer(
                borderRadius: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(
                            AppRoutes.imageView,
                            arguments: [  controller.userData.value.isPrivate!
                                ? ""
                                : controller.userData.value.profileImage]
                        );
                      },
                      child: Container(
                        width:AppSizer.getSize(120),
                        height:AppSizer.getSize(120),
                        decoration: BoxDecoration(
                          color: AppColors.female.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: cachedNetworkImage(
                              controller.userData.value.isPrivate!
                                  ? ""
                                  : controller.userData.value.profileImage,
                              context: context),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    AppText(
                      text: controller.userData.value.username!,
                      color: AppColors.primary,
                      fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel24),
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(height: 15),
                    AppText(
                      text: AppStrings.aboutMe,
                      color: AppColors.whiteText,
                      fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel24),
                    ),
                    SizedBox(height: 10),
                    AppText(
                      text: controller.userData.value.description!.isNotEmpty
                          ? controller.userData.value.description!
                          : "About is Empty",
                      fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                      fontWeight: FontWeight.w400,
                      color: AppColors.iconColor,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.justify,
                    ),

                  ],
                ),
              ),
            ),
            controller.userData.value.isPrivate!
                ? SizedBox()
                : Visibility(
              visible: controller.userData.value.hobbies!.isNotEmpty,
              child: Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: AppText(
                    text: AppStrings.hobbies,
                    fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 15,
                    runSpacing: 15,
                    children: [
                      for (var item in controller.userData.value.isPrivate!
                          ? []
                          : controller.userData.value.hobbies!)
                        Container(
                          padding: AppSizer.getPadding(all: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              stops: [0, 1],
                              colors: [
                                AppColors.primary,
                                AppColors.secondary,
                              ],
                            ),
                          ),
                          child: AppText(
                            text: item,
                            textAlign: TextAlign.center,
                            fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
            controller.userData.value.isPrivate!
                ? SizedBox()
                : Visibility(
              visible:controller.userData.value.interests!.isNotEmpty,
              child: Padding(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: AppText(
                    text: AppStrings.interest,
                    fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 15,
                    runSpacing: 15,
                    children: [
                      for (var item in controller.userData.value.isPrivate!
                          ? []
                          : controller.userData.value.interests!)
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * 0.035,
                            vertical: SizeConfig.screenWidth * 0.03,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              stops: [0, 1],
                              colors: [
                                AppColors.primary,
                                AppColors.secondary,
                              ],
                            ),
                          ),
                          child: AppText(
                            text: item,
                            textAlign: TextAlign.center,
                            fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ):Center(
            child: CupertinoActivityIndicator(
          color: AppColors.whiteText,
          radius: SizeConfig.screenWidth * 0.05,
        ),)),
      ),
    );
  }
}
