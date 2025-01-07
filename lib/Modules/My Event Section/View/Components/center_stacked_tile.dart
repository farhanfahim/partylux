import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:partylux/Constants/app_fonts.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Common/cechednetworlimage.dart';
import 'package:partylux/Utils/Common/gradient_container.dart';
import 'package:partylux/Utils/Common/icons.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Common/switch_button.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/extensions.dart';

import '../../../../Constants/constants.dart';
import '../../../../Utils/date_time_util.dart';
import '../../Model/event_detail_model.dart';


class CenterStackedTile extends StatelessWidget {
  final UserDetail profileData;
  final String? eventType;
  final EventDetailModel? data;
  const CenterStackedTile({super.key,required this.profileData,this.eventType,this.data});

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      gradientColors: eventType == Constants.EVENT_PRIVATE?[AppColors.male,AppColors.male]:[AppColors.female,AppColors.primaryText],

      margin: AppSizer.getMargin(left: 14,right: 14),
      child: eventType == Constants.EVENT_MY_EVENT ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: AppText(text: data!.name!.toUpperCase(),fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.lexendDica,maxLines: 2,overflow: TextOverflow.ellipsis,)),
            /*  Row(
                children: [
                  AppText(text: "Live",fontSize: 20,fontWeight: FontWeight.bold,fontFamily: AppFonts.lexendDica,),
                  SizedBox(width: AppSizer.getHorizontalSize(10),),
                  SwitchButton(
                    isActive: true,
                    callback: (val) {
                      //isActive != isActive;
                    },
                  ),
                ],
              )*/
            ],
          ),
          5.ph,
          Row(
            children: [
              Expanded(
                child: AppText(
                  text: DateTimeUtil.parseDateTime(data!.startDateTime!,DateTimeUtil.serverDateTimeFormat2,"h:mm a",isutc: true),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontFamily: AppFonts.lexendDica,
                ),
              ),
              Expanded(
                child: AppText(
                  textAlign: TextAlign.right,
                  text:DateTimeUtil.parseDateTime(data!.startDateTime!,DateTimeUtil.serverDateTimeFormat2,'EEEE, d MMM y',isutc: true),
                  fontSize: 14,

                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontFamily: AppFonts.lexendDica,
                ),
              ),
            ],
          ),

        ],
      ) : Row(
        children: [
          cachedNetworkImage(profileData.profile!.profileImage!, context: context),
          SizedBox(width: AppSizer.getHorizontalSize(5),),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(text: profileData.username!),
                SizedBox(height: AppSizer.getVerticalSize(2),),
                AppText(text: "Hosting this event",fontSize: AppSizer.getFontSize(10),)
              ],
            ),
          ),
          Container(
            padding: AppSizer.getPadding(left: 16,right: 16,top: 6,bottom: 6),
            decoration: BoxDecoration(
                color: eventType == Constants.EVENT_RESERVED
                    ? AppColors.greenColor
                    : eventType == Constants.EVENT_PENDING
                    ? Colors.orange
                    : eventType == Constants.EVENT_PRIVATE
                    ? AppColors.male
                    :eventType == Constants.EVENT_CLOSED
                    ?AppColors.red1
                    :AppColors.transparent,
                borderRadius: BorderRadius.circular(10)
            ),
            child: Row(
              children: [
                AppText(text: eventType == Constants.EVENT_RESERVED
                    ? "Reserved"
                    : eventType == Constants.EVENT_PENDING
                    ? "Pending"
                    :eventType == Constants.EVENT_PRIVATE
                    ?"Private"
                    : eventType == Constants.EVENT_CLOSED
                    ?"Closed"
                    :"",
                  fontSize: AppSizer.getFontSize(10),color: eventType == Constants.EVENT_PRIVATE?AppColors.black:AppColors.whiteText,),
                Visibility(
                    visible: eventType == Constants.EVENT_RESERVED || eventType == Constants.EVENT_CLOSED,
                    child: Padding(
                      padding: AppSizer.getPadding(left: 10),
                      child: CustomMonoIcon(icon: AppImages.icRevote,isSvg: true,color: Colors.white,),
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
