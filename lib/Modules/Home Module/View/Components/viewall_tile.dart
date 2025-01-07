import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Utils/Common/cechednetworlimage.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import '../../../../Constants/app_fonts.dart';
import '../../../../Constants/constants.dart';
import '../../../../Constants/dimens.dart';
import '../../../../Utils/Common/sizer.dart';
import '../../../../Utils/date_time_util.dart';
import '../../../Auth Module/Models/usermodel.dart';

class ViewAllTile extends StatelessWidget {
  final EventModel data;
  final UserModel currentUser;
  const ViewAllTile({
    super.key,
    required this.data,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {

        if(currentUser.sId == data.userId) {
          Get.toNamed(
              AppRoutes.myEvent, arguments: [data.sId, Constants.EVENT_MY_EVENT])!;
        } else{
          if( data.eventType == Constants.EVENT_PRIVATE) {
            Get.toNamed(
                AppRoutes.myEvent, arguments: [data.sId, Constants.EVENT_PRIVATE])!;
          } else{
            Get.toNamed(
                AppRoutes.myEvent, arguments: [data.sId, Constants.EVENT_OTHER])!;
          }
        }
      },
      child: Container(
        margin: AppSizer.getMargin(bottom: 10),
        padding: AppSizer.getPadding(top: 5,bottom: 5,left: 5,right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppColors.whiteText.withOpacity(0.1),
        ),
        child: Row(
          children: [
            Container(
              height: AppSizer.getSize(87),
              width: AppSizer.getSize(87),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: AppColors.whiteText.withOpacity(0.1),
              ),
              child: cachedNetworkImage(
                data.eventProfile!,
                context: context,
                borderRadius: 50,
              ),
            ),
            SizedBox(width: AppSizer.getHorizontalSize(10)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: data.name!,
                    maxLines: 1,
                    fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
                    overflow: TextOverflow.ellipsis,

                  ),
                  SizedBox(height: AppSizer.getVerticalSize(2)),
                  Row(
                    children: [
                      Expanded(
                        child: AppText(
                          text: DateTimeUtil.parseDateTime(data.startDateTime!,DateTimeUtil.serverDateTimeFormat2,'EEEE, d MMM y',isutc: true),
                          fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                          fontWeight: FontWeight.w400,
                          color: AppColors.iconColor,
                        ),
                      ),
                      Container(
                        margin: AppSizer.getMargin(top:2,left: 5,right: 5),
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColors.primaryText,
                        ),
                      ),

                      AppText(
                        text: DateTimeUtil.parseDateTime(data.startDateTime!,DateTimeUtil.serverDateTimeFormat2,'h:mm a',isutc: true),
                         //"10:00 PM",
                        fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                        fontWeight: FontWeight.w400,
                        color: AppColors.iconColor,
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizer.getVerticalSize(15)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            text: "Hosted ",

                            style: TextStyle(
                              fontFamily: AppFonts.copperPlate,
                              overflow: TextOverflow.visible,
                              color: AppColors.primaryText,
                              fontWeight: FontWeight.w400,
                              fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "by "+data.userDetail!.username!,
                                style: TextStyle(
                                  fontFamily: AppFonts.copperPlate,
                                  overflow: TextOverflow.visible,
                                  color: AppColors.whiteText,
                                  fontWeight: FontWeight.w400,
                                  fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: AppSizer.getHorizontalSize(10),),
                      AppText(
                        text:currentUser.profile!.gender!.toLowerCase() == "male"
                            ? data.maleFee!?"Free":"\$ ${data.maleAmount!.toStringAsFixed(2)}"
                            : data.femaleFee!?"Free":"\$ ${data.femaleAmount!.toStringAsFixed(2)}",
                        fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel18),

                      )
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
