import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/perticipant_module/request_participants_view.dart';
import 'package:partylux/Modules/perticipant_module/view_model/participants_view_model.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import '../../Constants/app_fonts.dart';
import '../../Constants/dimens.dart';
import '../../Utils/Common/login_signup_tile.dart';
import '../../Utils/Common/sizer.dart';
import 'joined_participants_view.dart';

class ParticipantsTabView extends GetView<ParticipantsViewModel> {
  ParticipantsTabView({super.key});

  RxBool isJoined =true.obs;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isBodyPadding: true,
      showBackBtn: true,
      isLeftAlign: true,
      basicAppTrailingIcon: Center(
    child: Obx(() => RichText(
      maxLines: 1,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        text: isJoined.value?controller.joinedCount.value.toString():controller.requestCount.value.toString()+"/",
        style: TextStyle(
          fontFamily: AppFonts.copperPlate,
          overflow: TextOverflow.visible,
          fontWeight: FontWeight.w400,
          color: AppColors.whiteText,
          fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
        ),
        children: <TextSpan>[
          TextSpan(
            text: controller.maxCount.toString(),
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
    ),)
    ),
      appBarTitle: AppStrings.participantsRequest,
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Obx(() => AppText(
            text: isJoined.value?AppStrings.hereYouCanSeeYourParticipantJoined
                :AppStrings.hereYouCanSeeYourParticipant,
            overflow: TextOverflow.visible,
            fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
            height: 1,
            fontWeight: FontWeight.w400,
            color:AppColors.iconColor,
          ),),
          SizedBox(height: AppSizer.getVerticalSize(20)),

          LoginSigupButtonTile(
            leftTitle:AppStrings.joined,
            rightTitle:AppStrings.requests,
            callback: (val) {

              if(val == AppStrings.requests){
                isJoined.value = false;
              }else{
                isJoined.value = true;
              }
            },
          ),
          Obx(() =>  Expanded(child: isJoined.value ?JoinedParticipantsView():RequestParticipantsView()),)

        ],
      )
    );
  }
}
