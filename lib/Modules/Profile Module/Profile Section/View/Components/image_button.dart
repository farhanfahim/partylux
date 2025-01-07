import 'package:flutter/material.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Theme/app_config.dart';

import '../../../../../Constants/app_images.dart';
import '../../../../../Utils/Common/icons.dart';
import '../../../../../Utils/Common/sizer.dart';

Widget imageButton({
  required Function callback,
}) {
  return Positioned(
    top: SizeConfig.screenWidth * 0.28 - 25,
    child: GestureDetector(
      onTap: () {
        callback();
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: AppColors.whiteText, width: 1),
          color: AppColors.primary,
        ),
        child:  Center(
          child: CustomMonoIcon(
            icon: AppImages.icCamera,
            size: AppSizer.getSize(24),
            color: AppColors.whiteText,
          )
        ),
      ),
    ),
  );
}
