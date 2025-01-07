import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

import '../../Constants/app_images.dart';
import '../../Constants/dimens.dart';

class ProfileSectionTile extends StatelessWidget {
  final String title;
  final String iconPath;
  final bool isPng;
  final Function? onTap;

   ProfileSectionTile({
    super.key,
    required this.title,
    this.isPng = false,
    required this.iconPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        height: SizeConfig.screenWidth * 0.13,
        // height: SizeConfig.screenWidth * 0.2,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.whiteText.withOpacity(0.12),
          borderRadius: BorderRadius.circular(10),
        ),
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.03),
        margin: EdgeInsets.symmetric(vertical: SizeConfig.screenWidth * 0.015),
        child: Row(
          children: [
            isPng?Image.asset(
              iconPath,
              width: SizeConfig.screenWidth * 0.05,
              height: SizeConfig.screenWidth * 0.05,
            ):
            SvgPicture.asset(
                width: SizeConfig.screenWidth * 0.05,
                height: SizeConfig.screenWidth * 0.05,
              iconPath
            ),
            SizedBox(width: SizeConfig.screenWidth * 0.04),
            AppText(
              text: title, //"Profile",
              color: AppColors.whiteText,
              fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
              
            ),
            const Spacer(),
            Image.asset(
              AppImages.imgArrowRight,
              width: SizeConfig.screenWidth * 0.06,
              height: SizeConfig.screenWidth * 0.06,
            )
          ],
        ),
      ),
    );
  }
}
