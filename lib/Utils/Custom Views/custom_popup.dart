import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

import '../Common/custom_textfield.dart';

class AppAlerts {
  onSubScriptionPlanPopUp(BuildContext context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: AppColors.black54.withOpacity(0.5),
      builder: (BuildContext context) {
        return Dialog(

          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                child: Container(
                  height: 380,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor,
                    // gradient: LinearGradient(
                    //   begin: Alignment.topRight,
                    //   end: Alignment.bottomLeft,
                    //   stops: [0, 1],
                    //   colors: [
                    //     AppColors.secondary,
                    //     AppColors.primary,
                    //   ],
                    // ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0,horizontal: 20),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 50),
                            Align(
                              alignment: Alignment.center,
                              child: Image.asset(
                                "assets/icon_assets/LuxVIP.png",
                                height: 30,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Center(
                              child: AppText(
                                text: "Unlock all the party secrets",
                                fontSize: SizeConfig.screenWidth * 0.04,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 20),
                            pointText("Access to nearby Clubs, Bars and House Parties"),
                            const SizedBox(height: 10),
                            pointText("Purchase Tickets To Events"),
                            const SizedBox(height: 10),
                            pointText("Throw Your Own Party"),
                            const SizedBox(height: 10),
                            pointText("Gender Ratios"),
                            const SizedBox(height: 10),
                            pointText("Profile Pictures"),
                            // const SizedBox(height: 30),
                            const SizedBox(height: 20),
                            AppButton.mainButton(
                              context,
                              // buttonColor: AppColors.whiteText,
                              text: "Unlock \$9.99 / Month",
                              // textColor: AppColors.secondary,
                              onPressed: () {
                                Get.toNamed(AppRoutes.memberShipView);
                              },
                            ),
                          ],
                        ),
                        Positioned(
                          top: 5,
                          right: 0,
                          child: Material(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.whiteText.withOpacity(0.1),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(100),
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 35,
                                width: 35,
                                child: Icon(
                                  Icons.close,
                                  color: AppColors.whiteText,
                                  size: 25,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget pointText(String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 10,
          width: 10,
          margin: EdgeInsets.only(top: 4.5, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: AppColors.success,
          ),
        ),
        Expanded(
          child: AppText(
            text: title,
            color: AppColors.grey1,
            fontSize: SizeConfig.screenWidth * 0.035,
            fontWeight: FontWeight.w400,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }

  popUpPromoCode(
    BuildContext context,
    TextEditingController c,
    GestureTapCallback onSubmit,
  ) {
    showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: AppColors.black54.withOpacity(0.5),
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                child: Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundColor.withOpacity(0.6),
                    // gradient: LinearGradient(
                    //   begin: Alignment.topRight,
                    //   end: Alignment.bottomLeft,
                    //   stops: [0, 1],
                    //   colors: [
                    //     AppColors.secondary,
                    //     AppColors.primary,
                    //   ],
                    // ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AppText(
                              text: "Verify Code to join Private Party",
                              fontSize: SizeConfig.screenWidth * 0.04,
                              fontWeight: FontWeight.w600,
                            ),
                            // Spacer(),
                            CustomTextField(
                              controller: c,
                              label: "Code",
                              hintText: "Code",
                            ),

                            AppButton.mainButton(
                              context,
                              text: "Submit",
                              onPressed: onSubmit,
                            )
                          ],
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: Material(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.whiteText.withOpacity(0.1),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(100),
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                height: 35,
                                width: 35,
                                child: Icon(
                                  Icons.close,
                                  color: AppColors.whiteText,
                                  size: 25,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
