import 'package:flutter/material.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Common/single_checknox.dart';
import 'package:partylux/Utils/Text%20Fields/textfield.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/extensions.dart';
import 'dart:math' as math;

class PrivateAdmissionFeeTile extends StatelessWidget {
  final bool isFreeParty;
  final TextEditingController controller;
  final Function callback;
  PrivateAdmissionFeeTile({
    super.key,
    required this.isFreeParty,
    required this.controller,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.whiteText.withOpacity(0.1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: AppText(
                  text: "Want to make free entry code for your Party?",
                  fontSize: SizeConfig.screenWidth * 0.036,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.visible,
                ),
              ),
              AppText(
                text: isFreeParty ? "Yes" : "No",
                fontSize: SizeConfig.screenWidth * 0.036,
                color: isFreeParty ? AppColors.success : AppColors.error,
              ).horizontalPadding(5),
              10.pw,
              Transform.rotate(
                angle: 270 * math.pi / 180,
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.whiteText,
                  size: SizeConfig.screenWidth * 0.04,
                ),
              ),
              10.pw,
            ],
          ).verticalPadding(30),
          Divider(
            color: AppColors.whiteText.withOpacity(0.6),
            height: 2,
          ).horizontalPadding(10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              SingleCheckBox(
                title: "Yes",
                isActive: isFreeParty,
                callback: () {
                  callback(true);
                },
              ),
              Spacer(),
              SingleCheckBox(
                title: "No",
                isActive: !isFreeParty,
                callback: () {
                  callback(false);
                },
              ),
              Spacer(),
            ],
          ).verticalPadding(30),
          Visibility(
            visible: !isFreeParty,
            child: Column(
              children: [
                AppTextField().commonField(
                  context,
                  hintText: "Amount",
                  fieldHeight: SizeConfig.screenWidth * 0.02,
                  lableFontSize: SizeConfig.screenWidth * 0.028,
                  lableFontWeight: FontWeight.w400,
                  isRemoveTopHight: false,
                  keyboardType: TextInputType.number,
                  controller: controller,
                ),
                20.ph,
              ],
            ),
          ),
        ],
      ).horizontalPadding(20),
    );
  }
}

class PrivateDiscountAdmissionFeeTile extends StatelessWidget {
  final bool isFreeDiscount;
  final TextEditingController controller;
  final Function callback;
  PrivateDiscountAdmissionFeeTile({
    super.key,
    required this.isFreeDiscount,
    required this.controller,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.whiteText.withOpacity(0.1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: AppText(
                  text: "Want to make discount entry code for your Party?",
                  fontSize: SizeConfig.screenWidth * 0.036,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.visible,
                ),
              ),
              AppText(
                text: isFreeDiscount ? "Yes" : "No",
                fontSize: SizeConfig.screenWidth * 0.036,
                color: isFreeDiscount ? AppColors.success : AppColors.error,
              ).horizontalPadding(5),
              10.pw,
              Transform.rotate(
                angle: 270 * math.pi / 180,
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.whiteText,
                  size: SizeConfig.screenWidth * 0.04,
                ),
              ),
              10.pw,
            ],
          ).verticalPadding(30),
          Divider(
            color: AppColors.whiteText.withOpacity(0.6),
            height: 2,
          ).horizontalPadding(10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              SingleCheckBox(
                title: "Yes",
                isActive: isFreeDiscount,
                callback: () {
                  callback(true);
                },
              ),
              Spacer(),
              SingleCheckBox(
                title: "No",
                isActive: !isFreeDiscount,
                callback: () {
                  callback(false);
                },
              ),
              Spacer(),
            ],
          ).verticalPadding(30),
          Visibility(
            visible: isFreeDiscount,
            child: Column(
              children: [
                AppTextField().commonField(
                  context,
                  hintText: "Amount",
                  fieldHeight: SizeConfig.screenWidth * 0.02,
                  lableFontSize: SizeConfig.screenWidth * 0.028,
                  lableFontWeight: FontWeight.w400,
                  isRemoveTopHight: false,
                  keyboardType: TextInputType.number,
                  controller: controller,
                ),
                20.ph,
              ],
            ),
          ),
        ],
      ).horizontalPadding(20),
    );
  }
}
