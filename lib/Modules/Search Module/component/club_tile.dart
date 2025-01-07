import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/date_time_util.dart';

import '../../../Constants/app_routes.dart';
import '../../../Constants/constants.dart';
import '../../../Utils/Common/cechednetworlimage.dart';
import '../../Auth Module/Models/usermodel.dart';

class ClubTile extends StatelessWidget {

  final UserModel currentUser;
  final EventModel item;
  const ClubTile({Key? key,required this.currentUser,required this.item,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(currentUser.sId == item.userId) {
          Get.toNamed(
              AppRoutes.myEvent, arguments: [item.sId, Constants.EVENT_MY_EVENT])!;
        } else{
          if( item.eventType == Constants.EVENT_PRIVATE) {
            Get.toNamed(
                AppRoutes.myEvent, arguments: [item.sId, Constants.EVENT_PRIVATE])!;
          } else{
            Get.toNamed(
                AppRoutes.myEvent, arguments: [item.sId, Constants.EVENT_OTHER])!;
          }
        }
      },
      child: Container(
        height: SizeConfig.screenWidth * 0.23,
        // width: double.infinity,
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
            SizedBox(width: AppSizer.getHorizontalSize(10),),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AppText(
                          //text:  "sdsd",
                          text: "${item.name}",
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          fontWeight: FontWeight.w700,

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.screenWidth * 0.011),
                        child: AppText(
                          text: DateTimeUtil.parseDateTime(item.startDateTime!,DateTimeUtil.serverDateTimeFormat2,DateTimeUtil.dateTimeFormat4,isutc: true),

                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color:AppColors.iconColor,

                        ),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: SizeConfig.screenWidth * 0.01),
                        child: AppText(
                          text: DateTimeUtil.parseDateTime(item.startDateTime!,DateTimeUtil.serverDateTimeFormat2,DateTimeUtil.dateTimeFormat5,isutc: true),


                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color:AppColors.iconColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: AppSizer.getHorizontalSize(5),),
          ],
        ),
      ),
    );
  }
}
