import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:partylux/Modules/TicketModule/Model/ticket_model.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../Constants/app_fonts.dart';
import '../../../../Constants/app_images.dart';
import '../../../../Constants/color.dart';
import '../../../../Constants/dimens.dart';
import '../../../../Constants/strings.dart';
import '../../../../Utils/Common/cechednetworlimage.dart';
import '../../../../Utils/Common/common_image_view.dart';
import '../../../../Utils/Common/icons.dart';
import '../../../../Utils/Common/ticket_painter.dart';
import '../../../../Utils/Util.dart';
import '../../../../Utils/date_time_util.dart';

class TicketDetailTile extends StatelessWidget {
  final TicketModel data;
  final String ticketType;
  TicketDetailTile(this.data,this.ticketType,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: const EdgeInsets.all(16),
      child: CustomPaint(
        painter: TicketPainter(
          ticketType:ticketType,
          borderColor: Colors.white.withOpacity(0.1),
          startColor: AppColors.primary.withOpacity(0.25),
          endColor: AppColors.secondary.withOpacity(0.25),
    /*      bgColor: AppColors.primary.withOpacity(1),
          endColor: AppColors.primary.withOpacity(1),*/
        ),
        child: Container(

          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 16),
          child: Column(
            children: [

              SizedBox(height: AppSizer.getVerticalSize(40),),
              AppText(
                text: data.event!.name!,
                color: AppColors.whiteText,
                fontSize: AppSizer.getFontSize(24),

              ),
              SizedBox(height: 20,),
              QrImageView(
                data: data.sId!,
                backgroundColor: AppColors.white2,
                version: QrVersions.auto,
                size: AppSizer.getSize(150),
              ),

              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                      text: DateTimeUtil.parseDateTime(data.event!.startDateTime!,DateTimeUtil.serverDateTimeFormat2,'EEE, d MMM',isutc: true),
                      color: AppColors.whiteText,
                      fontSize: AppSizer.getFontSize(13),
                      fontWeight: FontWeight.w400),
                  SizedBox(width: 10,),

                  AppText(
                      text: DateTimeUtil.parseDateTime(data.event!.startDateTime!,DateTimeUtil.serverDateTimeFormat2,'hh:mm a',isutc: true),

                      color: AppColors.whiteText,
                      fontSize: AppSizer.getFontSize(13),
                      fontWeight: FontWeight.w400),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: AppText(
                        text: DateFormat('-')
                            .format(DateTime.parse(data.event!.startDateTime!)),
                        color: AppColors.whiteText,
                        fontSize: AppSizer.getFontSize(13),
                        fontWeight: FontWeight.w400),
                  ),

                  AppText(
                      text: DateTimeUtil.parseDateTime(data.event!.endDateTime!,DateTimeUtil.serverDateTimeFormat2,'hh:mm a',isutc: true),

                      color: AppColors.whiteText,
                      fontSize: AppSizer.getFontSize(13),
                      fontWeight: FontWeight.w400),
                ],
              ),

              SizedBox(height: AppSizer.getVerticalSize(30),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomMonoIcon(icon: AppImages.icWarning,color: Colors.red,size: AppSizer.getSize(16),),
                  SizedBox(width: AppSizer.getVerticalSize(5),),
                  AppText(text: Util.isDatePassed(data.event!.startDateTime!.toString(),data.event!.endDateTime!.toString()) == 1
                      ? AppStrings.thisEventStarts
                      :Util.isDatePassed(data.event!.startDateTime!.toString(),data.event!.endDateTime!.toString()) == 2
                      ? AppStrings.thisEventEnds
                      :AppStrings.thisEventPassed,
                    color: Colors.red,
                    fontSize: AppSizer.getFontSize(12),
                    fontWeight: FontWeight.w400,),

                ],
              ),
              SizedBox(height: AppSizer.getVerticalSize(10),),

              Container(
                  padding: AppSizer.getPadding(left: 16,right: 16,top: 10,bottom: 10),
                  decoration: BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.secondary,width: 0.5)
                  ),
                  child: RichText(
                    text: TextSpan(
                        text: Util.getDays(data.event!.endDateTime!.toString()),
                        style: TextStyle(
                            fontFamily: AppFonts.copperPlate,
                            fontSize: AppSizer.getFontSize(20)
                        ),
                        children: [
                          TextSpan(text: "D",
                              style: TextStyle(
                                  color: AppColors.secondary
                              )
                          ),
                          TextSpan(text: " : "),
                          TextSpan(text: Util.getHour(data.event!.endDateTime!.toString())),
                          TextSpan(text: "H",style: TextStyle(
                              color: AppColors.secondary
                          )),
                          TextSpan(text: " : "),
                          TextSpan(text: Util.getMinutes(data.event!.endDateTime!.toString())),
                          TextSpan(text: "M",style: TextStyle(
                              color: AppColors.secondary
                          )),
                        ]
                    ),
                  )
              ),

              SizedBox(height: AppSizer.getVerticalSize(10),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CommonImageView(
                    svgPath: AppImages.icLocation2,
                    width: AppSizer.getSize(12),
                    height: AppSizer.getSize(14),
                  ),
                  SizedBox(width: AppSizer.getHorizontalSize(5),),
                  AppText(text: AppStrings.location,fontSize: AppSizer.getFontSize(12),),
                ],
              ),
              SizedBox(height: AppSizer.getVerticalSize(5),),
              AppText(text: data.event!.place!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign:TextAlign.center,fontSize: AppSizer.getFontSize(12),fontWeight: FontWeight.w400,),
              SizedBox(height: AppSizer.getVerticalSize(70),),
              Container(
                height: AppSizer.getSize(36),
                width:AppSizer.getSize(36),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: cachedNetworkImage(
                  data.user!.profileImage,
                  context: context,
                ),
              ),
              SizedBox(height: AppSizer.getVerticalSize(10),),
              AppText(text: data.user!.username!,color: AppColors.whiteText,fontSize: AppSizer.getFontSize(16),),
              SizedBox(height: AppSizer.getVerticalSize(20),),
              RichText(
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: "Qty: ",
                  style: TextStyle(
                    fontFamily: AppFonts.copperPlate,
                    overflow: TextOverflow.visible,
                    color: AppColors.primaryText,
                    fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: "1 person",
                      style: TextStyle(
                        fontFamily: AppFonts.copperPlate,
                        overflow: TextOverflow.visible,
                        color: AppColors.whiteText,
                        fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: AppSizer.getVerticalSize(30),),
            /*  Visibility(
                visible: ticketType=="business"?true:false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: AppSizer.getVerticalSize(30),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppImages.imgAppleWalletRound,width: AppSizer.getHorizontalSize(120),),
                        SizedBox(width: AppSizer.getHorizontalSize(10),),
                        Image.asset(AppImages.imgGoogleWalletRound,width: AppSizer.getHorizontalSize(120),),
                      ],
                    ),
                  ],
                ),
              )*/
            ],
          ),
        ),
      ),
    );
  }
}


