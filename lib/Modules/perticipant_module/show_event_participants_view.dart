import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/Create%20Module/Model/create_model.dart';
import 'package:partylux/Modules/My%20Event%20Section/Model/event_detail_model.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/griddelegate.dart';

import '../../Constants/app_fonts.dart';
import '../../Constants/dimens.dart';
import '../../Utils/Common/sizer.dart';
import '../gender_ratios/component/participant_tile.dart';
import '../gender_ratios/view_model/gender_ratios_view_model.dart';
class ShowEventParticipantsView extends GetView<GenderRatiosViewModel> {
  ShowEventParticipantsView({super.key});

  final List<UserDetails> data = Get.arguments[0];
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isBodyPadding: true,
      showBackBtn: true,
      isLeftAlign: true,
      basicAppTrailingIcon: Center(
    child: RichText(
    maxLines: 1,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        text: "150/",
        style: TextStyle(
          fontFamily: AppFonts.copperPlate,
          overflow: TextOverflow.visible,
          fontWeight: FontWeight.w400,
          color: AppColors.whiteText,
          fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
        ),
        children: <TextSpan>[
          TextSpan(
            text: "250",
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
      appBarTitle: AppStrings.participants,
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            AppText(
              text: AppStrings.hereYouCanSeeYourParticipant,
              overflow: TextOverflow.visible,
              fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
              height: 1,
              fontWeight: FontWeight.w400,
              color:AppColors.iconColor,
            ),
            SizedBox(height: AppSizer.getVerticalSize(10)),

            Expanded(
              child: GridView.builder(
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                      crossAxisCount: 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                  height: SizeConfig.screenWidth * 0.35,
                ),
                padding: EdgeInsets.only(top: 10, bottom: 20),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container();/*ParticipantsTile(
                    isMaleGender: false,
                    data: data[index],
                  );*/
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
