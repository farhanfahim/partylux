import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:partylux/Constants/app_fonts.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Modules/BecomePartner/Model/become_partner_model.dart';
import 'package:partylux/Modules/Club%20Module/Model/club_model.dart';
import 'package:partylux/Utils/Common/cechednetworlimage.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

import '../../../../Constants/app_images.dart';
import '../../../../Constants/app_routes.dart';
import '../../../../Utils/Common/gradient_text.dart';

class BusinessClubTile extends StatelessWidget {
  final BecomePartnerModel data;
  final Function? callback;
  const BusinessClubTile({
    super.key,
    required this.data,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        Get.toNamed(
            AppRoutes.showMyBusiness, arguments: [data.id, "live", true]);
      },
      child: Container(
        margin: AppSizer.getMargin(bottom: 10),
        padding: AppSizer.getPadding(left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.whiteText.withOpacity(0.1),
        ),
        child: Row(
          children: [
            Container(
              height: AppSizer.getHorizontalSize(62),
              width: AppSizer.getHorizontalSize(64),
              child: cachedNetworkImage(
                data.businessProfile!,
                context: context,
                borderRadius: 10,
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.screenWidth * 0.02),
                          child: AppText(
                            text: data.bussinessName!,
                            fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),

                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:8.0),
                        child: AppText(
                          text: DateFormat('h:mm a').format(DateTime.parse(
                              data.createdAt!.toString()).toLocal()), //"10:00 PM",
                          fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                          fontWeight: FontWeight.w400,
                          color: AppColors.iconColor,
                        ),
                      ),


                    ],
                  ),
                  SizedBox(height: 5,),
                  AppText(
                    text: DateFormat('EEEE, d MMM y').format(DateTime.parse(
                        data.createdAt.toString()).toLocal()),
                    fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                    fontWeight: FontWeight.w400,
                    color: AppColors.iconColor,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        child: Image.asset(
                          AppImages.location2,
                        ),
                      ),
                      SizedBox(width: 3,),
                      Expanded(
                        child: AppText(
                          text:data.place!,
                          maxLines: 2,
                          fontFamily: AppFonts.copperPlate,
                          overflow: TextOverflow.ellipsis,
                          color: AppColors.whiteText,
                          fontWeight: FontWeight.w400,
                          fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),

                        ),
                      ),
                      amountCalculate(
                        amount: "\$${data.admissionFee!.female!.amount}",
                        isFree: data.admissionFee!.female!.free!,
                      ),
                    ],
                  ),
                  SizedBox(height: 10,)
                ],
              ),
            ),
            SizedBox(width: 10,),
          ],
        ),
      ),
    );
  }

  Widget amountCalculate({
    required String amount,
    required bool isFree,
  }) {
    return  GradientText(
        isFree ? "Free" : amount,
        fontSize:SizeConfig.screenWidth * 0.04,
        gradient: LinearGradient(
            colors: [
              AppColors.female,
              AppColors.primaryText,
            ]
        ));
  }
}
