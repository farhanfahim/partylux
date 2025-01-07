import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

class ShowModalBottomSheetView extends StatelessWidget {
  final Function callback;
  ShowModalBottomSheetView({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenWidth / 1.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: AppColors.bottomsheetLogout,
      ),
      padding: EdgeInsets.all(SizeConfig.screenWidth * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 4,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColors.whiteText,
            ),
          ),
          SizedBox(height: SizeConfig.screenWidth / 18),
          AppText(
            text: "Logout",
            fontSize: SizeConfig.screenWidth * 0.034,
          ),
          SizedBox(height: SizeConfig.screenWidth / 20),
          AppText(
            text: "Are you sure you want to logout?",
            fontSize: SizeConfig.screenWidth * 0.028,
          ),
          SizedBox(height: SizeConfig.screenWidth / 20),
          AppButton.mainButton(
            context,
            text: "Yes",
            onPressed: () {
              callback();
            },
          ),
          SizedBox(height: 15),
          AppButton.mainButton(
            context,
            text: "Cancel",
            buttonColor: AppColors.iconColor.withOpacity(0.3),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}

class ShowModalDeleteBusiness extends StatelessWidget {
  final Function callback;
  ShowModalDeleteBusiness({super.key, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenWidth / 1.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: AppColors.bottomsheetLogout,
      ),
      padding: EdgeInsets.all(SizeConfig.screenWidth * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 4,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColors.whiteText,
            ),
          ),
          SizedBox(height: SizeConfig.screenWidth / 18),
          AppText(
            text: "Delete Business",
            fontSize: SizeConfig.screenWidth * 0.04,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: SizeConfig.screenWidth / 20),
          AppText(
            text: "Are you sure you want to Delete Business?",
            fontSize: SizeConfig.screenWidth * 0.032,
          ),
          SizedBox(height: SizeConfig.screenWidth / 20),
          AppButton.mainButton(
            context,
            text: "Yes",
            onPressed: () {
              callback();
            },
          ),
          SizedBox(height: 15),
          AppButton.mainButton(
            context,
            text: "Cancel",
            buttonColor: AppColors.iconColor.withOpacity(0.3),
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
