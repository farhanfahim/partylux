import 'package:flutter/material.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

import '../Theme/app_config.dart';

Widget primaryAppBar({
  required BuildContext context,
  VoidCallback? callback,
  bool isShowArrow = true,
  String title = "Project",
  String subTitle =
      "We select high-quality, profitable projects for you to invest in.",
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Visibility(
        visible: isShowArrow,
        child: GestureDetector(
          onTap: callback,
          child: Container(
            width: 30,
            height: 50,
            alignment: Alignment.centerLeft,
            color: AppColors.transparent,
            margin: EdgeInsets.only(right: 10),
            child: Image.asset(
              "assets/icon_assets/right_arrow.png",
              height: 20,
              width: 20,
              color: AppColors.whiteText,
            ),
          ),
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: subTitle.isNotEmpty
                  ? EdgeInsets.zero
                  : const EdgeInsets.only(top: 8.0),
              child: AppText(
                text: title,
                height: 1.6,
                fontSize: SizeConfig.screenWidth * 0.05,
                
              ),
            ),
            Visibility(
              visible: subTitle.isNotEmpty,
              child: AppText(
                text: subTitle,
                fontSize: SizeConfig.screenWidth * 0.031,
                fontWeight: FontWeight.w400,
                color: AppColors.iconColor,
                overflow: TextOverflow.visible,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
