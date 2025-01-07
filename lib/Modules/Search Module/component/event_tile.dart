import 'package:flutter/material.dart';
import 'package:partylux/Constants/app_fonts.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/date_time_util.dart';

import '../../../Utils/Common/cechednetworlimage.dart';

class EventTile extends StatelessWidget {
  final EventModel item;
  final void Function()? onTap;
  final String currentUserGender;
  const EventTile({
    Key? key,
    required this.item,required this.currentUserGender,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        height: SizeConfig.screenWidth * 0.25,
        width: double.infinity,
        margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.03),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.whiteText.withOpacity(0.1),
        ),
        child: Row(
          children: [
            Container(
              height: AppSizer.getSize(80),
              width: AppSizer.getSize(80),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: cachedNetworkImage(
                item.eventProfile,
                context: context,
                borderRadius: 10,
              ) ,
            ),
            SizedBox(
              width: AppSizer.getHorizontalSize(10),
            ),
            Expanded(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: AppText(
                          text: "${item.name}",
                          fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: SizeConfig.screenWidth * 0.011),
                        child: AppText(
                          //text: '10:00 PM', //"Club Party",
                          text: DateTimeUtil.parseDateTime(item.startDateTime!,DateTimeUtil.serverDateTimeFormat2,DateTimeUtil.dateTimeFormat4,isutc: true),

                          fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                          fontWeight: FontWeight.w400,
                          color: AppColors.iconColor,
                          fontFamily: AppFonts.copperPlate,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: SizeConfig.screenWidth * 0.01),
                        child: AppText(
                          text: DateTimeUtil.parseDateTime(item.startDateTime!,DateTimeUtil.serverDateTimeFormat2,DateTimeUtil.dateTimeFormat5,isutc: true),

                          fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                          fontWeight: FontWeight.w400,
                          color: AppColors.iconColor,
                          fontFamily: AppFonts.copperPlate,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                   // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        child: Image.asset(
                          AppImages.location2,
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Expanded(
                        child: AppText(
                          text: '${item.location?.address}', //"Club Party",
                          fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                          fontWeight: FontWeight.w400,
                          color: AppColors.whiteText,
                        ),
                      ),
                      AppText(
                        text:currentUserGender.toLowerCase() == "male"
                            ? item.maleFee!?"Free":"\$ ${item.maleAmount!.toStringAsFixed(2)}"
                            : item.femaleFee!?"Free":"\$ ${item.femaleAmount!.toStringAsFixed(2)}",
                        fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,

                      )
             /*         AppText(
                        text: '\$ 100', //"Club Party",
                        fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),*/
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              width: AppSizer.getHorizontalSize(5),
            ),
          ],
        ),
      ),
    );
  }
}
