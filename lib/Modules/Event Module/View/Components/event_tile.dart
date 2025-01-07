import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:partylux/Constants/app_fonts.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Modules/Create%20Module/Model/create_model.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Utils/Common/cechednetworlimage.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

import '../../../../Utils/date_time_util.dart';

class MyEventTile extends StatelessWidget {
  final bool isDottedEvent;
  final bool isMyEvent;
  //final CreateEventModel data;
  final EventModel data;
  final String currentUserGender;
  final String eventType;
  final Function(EventModel event,String type)? callback;
  const MyEventTile({
    super.key,
    this.isDottedEvent = false,
    this.isMyEvent = false,
    required this.data,
    required this.currentUserGender,
    this.eventType = "myEvent",
    this.callback,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        callback!(data, eventType);
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
                data.eventProfile,
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
                                text: "by ${data.userDetail?.username}",
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
                        text:currentUserGender.toLowerCase() == "male"
                            ? data.maleFee!?"Free":"\$ ${data.maleAmount!.toStringAsFixed(2)}"
                            : data.femaleFee!?"Free":"\$ ${data.femaleAmount!.toStringAsFixed(2)}",
                        fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel18),

                      ),
               /*       data.eventType.toString() == EventModel.TYPE_PUBLIC
                          ? AppText(
                        text:currentUserGender.toLowerCase() == "male"
                            ? data.maleFee!?"Free":"\$ ${data.maleAmount}"
                            : data.femaleFee!?"Free":"\$ ${data.femaleAmount}",
                        fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel18),

                      )
                          :AppText(
                        text:currentUserGender.toLowerCase() == "male"
                            ? data.admissionFee!.male!.free!?"Free":"\$ ${data.admissionFee!.male!.amount}"
                            : data.admissionFee!.female!.free!?"Free":"\$ ${data.admissionFee!.female!.amount}",
                        fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel18),

                      ),
                          : AppText(
                        text: data.entrenceCode![0].type == "free"?"Free":"\$ ${data.entrenceCode![0].amount.toString()}",
                        fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel18),

                      ),*/
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

  Widget amountCalculate({
    required String amount,
    required bool isFree,
  }) {
    return AppText(
      text: isFree ? "Free" : amount,
      fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel18),
    );
  }
}
