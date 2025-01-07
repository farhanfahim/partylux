import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_fonts.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Modules/Notification/Model/notification_model.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import '../../../../Constants/app_routes.dart';
import '../../../../Constants/color.dart';
import '../../../../Constants/constants.dart';
import '../../../../Constants/dimens.dart';
import '../../../../Utils/Util.dart';
import '../../../../Utils/navigation.dart';

Widget notificationTile({
  required BuildContext context,
  required NotificationType data,
  required Function callback,
}) {
  return GestureDetector(
    onTap: (){

      if(data.eventName == Constants.PUSH_EVENT){
        Get.toNamed(
            AppRoutes.myEvent, arguments: [data.actionId, Constants.EVENT_UN_KNOWN]);
      }
      else if(data.eventName == Constants.PUSH_E_TICKET){
        Get.toNamed(
          AppRoutes.ticketDetailView, arguments: [data.actionId,"normal"],
        );
      }
      else if(data.eventName == Constants.PUSH_PAYMENT){
        AppNavigator.navigateToNamed(AppRoutes.paymentMethodView, arguments: {
          Constants.paramFrom: true,
          Constants.paramFrom2: data.actionId,
        });
      }else if(data.eventName == Constants.PUSH_NEARBY){
        Get.offAllNamed(AppRoutes.NAV_ROOT);
      }
      else{
        Get.back();
      }
    },
    child: Slidable(
      closeOnScroll: false,
      child: Container(
        padding: AppSizer.getPadding(left: 16,top: 10,right: 16,bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.whiteText.withOpacity(0.1),
        ),
        child: Row(
          children: [
            Container(
                height: 50,
                width: 50,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.whiteText.withOpacity(0.1),
                ),
                child:data.eventName == "order"?SvgPicture.asset(
                    AppImages.icReserve,
                    color:AppColors.secondary
                ):data.eventName == "payment"?SvgPicture.asset(
                    AppImages.icPayment,
                    color:AppColors.secondary
                ):data.eventName == "event"?SvgPicture.asset(
                    AppImages.icCalender,
                    color:AppColors.secondary
                ):SvgPicture.asset(
                    AppImages.icPayment,

                    color:AppColors.secondary
                ),

                ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: AppText(
                          text: data.title!,
                          fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                        ),
                      ),
                      AppText(
                        text: Util.timeAgo(data.createdAt!),
                        fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                        fontFamily: AppFonts.lexendDica,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  AppText(
                    text: data.content!,
                    fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey1,
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                  ),
                ],
              ),
            )
          ],
        ),
      ),

      // The start action pane is the one at the left or the top side.
      endActionPane: ActionPane(
        extentRatio: 0.2,
        motion: ScrollMotion(),
        children: [
          SizedBox(
            width: 5,
          ),
          SlidableAction(
            backgroundColor: Color(0xFFFF7438),
            foregroundColor: Colors.white,
            icon: Icons.delete_outline,
            borderRadius: BorderRadius.circular(10),
            onPressed: (h) {
              callback(data.sId);
            },
          ),
        ],
      ),
    ),
  );
}
