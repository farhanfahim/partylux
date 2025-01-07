import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:partylux/Constants/app_fonts.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import '../../../../Constants/dimens.dart';
import '../../../../Utils/Common/cechednetworlimage.dart';
import '../../../Auth Module/Models/usermodel.dart';
import '../../../My Business/Model/business_detail_model.dart';

class UpcomingTile extends StatelessWidget {
  final UserModel profileData;
  final UpcomingEvents? upcomingEvents;
  const UpcomingTile({super.key,required this.profileData,this.upcomingEvents,});

  @override
  Widget build(BuildContext context) {

    return Container(
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
              profileData.profileImage,
              context: context,
              borderRadius: 50,
            ) ,
          ),
          SizedBox(width: AppSizer.getHorizontalSize(10)),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                text: upcomingEvents!.eventDetails!.length>0?upcomingEvents!.eventDetails!.first.name!:"",
                maxLines: 1,
                fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
                overflow: TextOverflow.ellipsis,

              ),
              SizedBox(height: AppSizer.getVerticalSize(2)),
              Row(
                children: [
                  Expanded(
                    child: AppText(
                      text:  "${DateFormat('EEEE, d MMM yyyy').format(DateTime.parse(upcomingEvents!.eventDate!))}",//"Saturday, 28 Dec 2022",
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
                    text:  calculateTime(upcomingEvents!.fromTime),
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
                            text: "by " +profileData.username!,
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
                    text:"\$${upcomingEvents!.admissionFee!}",
                    fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel18),

                  )
                ],
              ),
            ],
          ),)
        ],
      ),
    );
  }
}

String calculateTime(time){
  List<String> parts = time.split(":");
  int hour = int.parse(parts[0]);
  int minute = int.parse(parts[1]);

  return DateFormat('h:mm a').format(DateTime(2024, 1, 1, hour, minute));

}
