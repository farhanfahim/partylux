import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/Auth%20Module/Models/usermodel.dart';
import 'package:partylux/Utils/Common/cechednetworlimage.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/Util.dart';
import '../../../../Constants/app_images.dart';
import '../../../../Constants/constants.dart';
import '../../../../Constants/dimens.dart';
import '../../../../Utils/Common/common_image_view.dart';
import '../../../../Utils/Common/sizer.dart';
import '../../../../Utils/date_time_util.dart';
import '../../Model/event_model.dart';

class CategoriesTile extends StatelessWidget {
  final EventModel data;
  final UserModel currentUser;
  CategoriesTile({
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
        width: SizeConfig.screenWidth * 0.49,
        margin: EdgeInsets.only(right:10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: SizeConfig.screenWidth * 0.45,
                  width: SizeConfig.screenWidth * 0.45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: AppColors.primaryText,width: 0.4),
                  ),
                  child: cachedNetworkImage(
                    data.eventProfile!,
                    context: context,
                    borderRadius: 100,
                  ),
                ),

                Visibility(
                  visible: data.eventType == Constants.EVENT_PRIVATE?true:false,
                  child: Positioned(
                      top:35,
                      left:5,
                      child: CommonImageView(
                    imagePath: AppImages.imgPrivateLabel,
                    height: AppSizer.getVerticalSize(25),
                    fit: BoxFit.contain,
                  )),
                )
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(
                    0,
                    SizeConfig.screenWidth * 0.015,
                    SizeConfig.screenWidth * 0.02,
                    SizeConfig.screenWidth * 0.015),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: data.name!,
                      fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        AppText(

                          height: 0.8,
                          text: DateTimeUtil.parseDateTime(data.startDateTime!,DateTimeUtil.serverDateTimeFormat2,'EEE, d MMM y',isutc: true).toLowerCase(),
                          fontSize: AppSizer.getFontSize(11),
                          fontWeight: FontWeight.w400,
                          color: AppColors.iconColor,
                        ),
                        const SizedBox(width: 3),
                        Container(
                          height: 5,
                          width: 5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.navBarActiveColor,
                          ),
                        ),
                        const SizedBox(width: 3),
                        Expanded(
                          child: AppText(
                            height: 0.8,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            text: DateTimeUtil.parseDateTime(data.startDateTime!,DateTimeUtil.serverDateTimeFormat2,'h:mm a',isutc: true).toLowerCase(),
                            fontSize: AppSizer.getFontSize(11),
                            fontWeight: FontWeight.w400,
                            color: AppColors.iconColor,
                          ),
                        ),
                      ],
                    ),
                 SizedBox(
                        height: data.eventSubscriptions!.length>0?50:10,
                        width: SizeConfig.screenWidth,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Stack(
                            children: List.generate(
                              data.eventSubscriptions!.length,
                              (index) => Positioned(
                                left: index * SizeConfig.screenWidth * 0.08 / 2,
                                child: Container(
                                  height: SizeConfig.screenWidth * 0.08,
                                  width: SizeConfig.screenWidth * 0.08,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.iconColor,
                                    border: Border.all(
                                      color: AppColors.black54,
                                      width: 1,
                                    ),
                                  ),
                                  child: cachedNetworkImage(
                                      data.eventSubscriptions![index].participantDetails![0].profile
                                          !.profileImage!,
                                      context: context),
                                )
                              ),
                            )
                          ),
                        )
                      ),
                    Row(
                      children: [
                        Expanded(
                          child: AppText(
                            text: "${data.location?.address}",
                            fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel10),
                            color: AppColors.navBarActiveColor,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(width: 10,),
                        currentUser.profile!.gender!.isEmpty?amountCalculate(
                          amount: "\$ ${data.maleAmount!.toStringAsFixed(2)}",
                          isFree: data.maleFee!,
                        ):amountCalculate(
                          amount: currentUser.profile!.gender!.toLowerCase() == "male"
                              ? "\$ ${Util.decimalPlace(data.maleAmount!)}"
                              : "\$ ${Util.decimalPlace(data.maleAmount!)}",
                          isFree: currentUser.profile!.gender!.toLowerCase() == "male"
                              ? data.maleFee!
                              : data.femaleFee!,
                        ),
                      ],
                    ),
                  ],
                ),
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
      fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
      fontWeight: FontWeight.w700,
    );
  }
}
