import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/Home%20Module/View/Components/shimmer_view.dart';
import 'package:partylux/Modules/people_joined/view_model/people_joined_view_model.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/griddelegate.dart';
import '../../Constants/app_fonts.dart';
import '../../Constants/dimens.dart';
import '../../Constants/strings.dart';
import '../../Utils/Common/participant_tile.dart';
import '../../Utils/Common/sizer.dart';
import '../../Utils/Theme/app_text.dart';

class PeopleJoinedView extends GetView<PeopleJoinedViewModel> {
  PeopleJoinedView({super.key});

  int maxCount = Get.arguments[0];
  int totalCount = Get.arguments[1];
  String eventId = Get.arguments[2];
  String type = Get.arguments[3];
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isBodyPadding: true,
      showBackBtn: true,
      isLeftAlign: true,
      backgroundImage: AppImages.imgFemaleBg,
      appBarTitle: AppStrings.peopleJoined,
      basicAppTrailingIcon: Center(
        child: RichText(
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            text: totalCount.toString()+"/",
            style: TextStyle(
              fontFamily: AppFonts.copperPlate,
              overflow: TextOverflow.visible,
              fontWeight: FontWeight.w400,
              color: AppColors.whiteText,
              fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
            ),
            children: <TextSpan>[
              TextSpan(
                text: maxCount.toString(),
                style: TextStyle(
                  fontFamily: AppFonts.copperPlate,
                  overflow: TextOverflow.visible,
                  fontWeight: FontWeight.w400,
                  color: AppColors.female,
                  fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
                ),
              )
            ],
          ),
        ),
      ),
      body: SizedBox.expand(
        child: Obx(() => !controller.isLoading.value?Column(
          children: [
            SizedBox(height: 10,),
            Expanded(
              child: controller.orderModel.isNotEmpty?GridView.builder(
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                  crossAxisCount: 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  height: SizeConfig.screenWidth * 0.35,
                ),
                padding: EdgeInsets.only(top: 10, bottom: 20),
                itemCount: controller.orderModel.length,
                itemBuilder: (BuildContext context, int index) {
                  return ParticipantsTile(
                      isMaleGender: controller.orderModel[index].gender=="male"?true:false,
                      data: controller.orderModel[index]
                  );
                },
              ):Center(
                child: AppText(
                    text: AppStrings.noRecordFound),
              ),
            )
          ],
        ):viewGenderShimmer(),)
      ),
    );
  }
}
