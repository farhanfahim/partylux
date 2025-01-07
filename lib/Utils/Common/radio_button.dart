import 'package:flutter/material.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Theme/app_config.dart';

class RadioButton {
  single(
    bool isActive,
  ) {
    return Container(
      height: SizeConfig.screenWidth * 0.05,
      width: SizeConfig.screenWidth * 0.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color:isActive ? AppColors.primary: AppColors.whiteText, width: 1.5),
      ),
      child: Container(
        margin: EdgeInsets.all(
          SizeConfig.screenWidth * 0.005,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: isActive ? AppColors.primary : AppColors.whiteText,
        ),
      ),
    );
  }
}
