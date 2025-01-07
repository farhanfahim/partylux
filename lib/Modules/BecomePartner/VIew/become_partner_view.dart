// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Modules/BecomePartner/View%20Model/becompartner_vm.dart';
import 'package:partylux/Utils/AppBar/primary_app_bar.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

import '../../../Constants/app_fonts.dart';
import '../../../Constants/app_routes.dart';
import '../../../Constants/color.dart';
import '../../../Constants/dimens.dart';
import '../../../Utils/Common/custom_alert_dialog.dart';
import '../../../Utils/Common/sizer.dart';
import '../../../Utils/Network/cache_handler.dart';
import '../../../Constants/app_images.dart';
import '../../../Utils/Theme/app_text.dart';

class BecomeAPartnerView extends StatelessWidget {
  BecomeAPartnerView({Key? key}) : super(key: key);


  final String isShowArrow = Get.arguments ?? "";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return CustomScaffold(
        isBodyPadding: true,
        isLeftAlign: false,
        showBackBtn: isShowArrow != "signup",
        appBarTitle: "My Business",
        body: Column(
          children: [
            Spacer(),
            Container(
              height: SizeConfig.screenWidth * 0.8,
              width: SizeConfig.screenWidth * 0.9,
              decoration: BoxDecoration(
                color: AppColors.whiteText.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                      height: SizeConfig.screenWidth * 0.4,
                      image: AssetImage(AppImages.imgMyBusiness)
                  ),
                  AppText(
                    text: "UH OH...",
                    fontSize: AppSizer.getFontSize(24),
                    color: AppColors.primaryText,
                  ),
                  SizedBox(height: 10,),
                  AppText(
                    textAlign: TextAlign.center,
                    text: "Looks like you don’t have a \nbusiness account yet!  ",
                    fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel18),
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              width: SizeConfig.screenWidth * 0.9,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: RichText(
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: "Apply ",
                  style: TextStyle(
                    fontFamily: AppFonts.copperPlate,
                    overflow: TextOverflow.visible,
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w400,
                    fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: "for a ",

                      style: TextStyle(
                        fontFamily: AppFonts.copperPlate,
                        overflow: TextOverflow.visible,
                        color: AppColors.whiteText,
                        fontWeight: FontWeight.w400,
                        fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
                      ),
                    ),
                    TextSpan(
                      text: "business account\n",

                      style: TextStyle(
                        fontFamily: AppFonts.copperPlate,
                        overflow: TextOverflow.visible,
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w400,
                        fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
                      ),
                    ),
                    TextSpan(
                      text: "if you are a business owner",

                      style: TextStyle(
                        height: 1.2,
                        fontFamily: AppFonts.copperPlate,
                        overflow: TextOverflow.visible,
                        color: AppColors.whiteText,
                        fontWeight: FontWeight.w400,
                        fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20,),
            AppButton.mainButton(
              context,
              text: "Apply",
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ct) {
                      return CustomAlertDialog(
                        title: "",
                        content: "You'll be logged out to proceed",
                        firstButtonContent: "cancel",
                        secondButtonContent: "yes",
                        first: () {
                          Get.back();
                        },
                        second: () async {
                          await DatabaseHandler().logOut();
                          Get.offAllNamed(AppRoutes.UserBusinessSignUpView);

                        },
                      );
                    });
              },
            ),
            SizedBox(height: 40),
          ],
        ));
  }
}
