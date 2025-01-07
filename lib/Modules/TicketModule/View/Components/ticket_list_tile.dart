import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/TicketModule/Model/ticket_model.dart';
import 'package:partylux/Utils/Common/ticket_buttons.dart';
import 'package:partylux/Utils/Common/cechednetworlimage.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/extensions.dart';

import '../../../../Constants/dimens.dart';
import '../../../../Utils/Theme/app_config.dart';
import '../../../../Utils/date_time_util.dart';
import '../../../people_joined/model/order_model.dart';

Widget ticketListTile({
  required bool isExpired,
  required OrderModel ticketModel,
  required BuildContext context,
}) {

  return Container(
    padding: AppSizer.getPadding(all: 10),
    decoration: BoxDecoration(
      color: AppColors.whiteText.withOpacity(0.08),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      children: [

        Row(
          children: [
            Container(
              height: AppSizer.getSize(62),
              width:AppSizer.getSize(62),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: cachedNetworkImage(
                ticketModel.event!.eventProfile!,
                context: context,
              ),
            ),
            SizedBox(
              width: AppSizer.getHorizontalSize(10)
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: ticketModel.event!.eventCategory!,
                      fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      color: AppColors.iconColor,
                    ),
                   /* Expanded(
                      child: Row(
                        children: [
                          Container(
                            margin: AppSizer.getMargin(top:2,left: 5,right: 5),
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: AppColors.primaryText,
                            ),

                          ),
                          Expanded(
                            child: AppText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: ticketModel.sId!,
                              fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                              color: AppColors.iconColor,
                            ),
                          ),
                        ],
                      ),
                    ),*/
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                AppText(
                  text: ticketModel.event!.name!,
                  fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(
                  height: 15,
                ),
                AppText(
                  text: DateTimeUtil.parseDateTime(ticketModel.event!.startDateTime!,DateTimeUtil.serverDateTimeFormat2,'d MMMM yyyy, hh:mm a',isutc: true),
                  fontSize:   AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                  color: AppColors.iconColor,
                ),

              ],
            ))
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
    /*        customTicketButton(
              width: SizeConfig.screenWidth*0.3,
              text: "Direction",
              callback: () {
                if (ticketModel.event!.location!.coordinates!.isNotEmpty) {
                  Get.toNamed(AppRoutes.ticketLocationView, arguments: [
                    LatLng(
                      ticketModel.event!.location!.coordinates![0].toDouble(),
                      ticketModel.event!.location!.coordinates![1].toDouble(),
                    ),
                  ]);
                }
              },
            ),
            SizedBox(
              width: 10,
            ),*/
            Expanded(
              child: isExpired
                  ? customTicketButton(
                      text: "Expired",
                      bgColor: AppColors.redText,
                      callback: () {
                        Get.toNamed(
                          AppRoutes.ticketDetailView,
                          arguments: [ticketModel.sId,"normal"],
                        );
                      },
                    )
                  : scanButton(
                      callback: () {
                        Get.toNamed(
                          AppRoutes.ticketDetailView,
                          arguments: [ticketModel.sId,"normal"],
                        );
                      },
                    ),
            ),
          ],
        )
      ],
    ),
  );


}


