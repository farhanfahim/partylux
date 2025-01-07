import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Common/sizer.dart';

import '../Theme/app_config.dart';

class CustomRectangleCheckbox extends StatelessWidget {
  final bool selected;
  final ValueChanged<bool> onChanged;
  final bool? isBold;
  const CustomRectangleCheckbox({required this.selected, super.key, required this.onChanged,this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onChanged(!selected),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: AppSizer.getSize(23),
        width: AppSizer.getSize(23),
        decoration: isBold! ? BoxDecoration(
          color: selected ? AppColors.primary : AppColors.midGrey,
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.grey4,
            width: 0.3,
          ),
          borderRadius: BorderRadius.circular(5),
        ): null,
        child: Padding(
          padding: AppSizer.getPadding(all: 3),
          child: Center(
            child: selected
                ? isBold!
                ? SvgPicture.asset(AppImages.icCheck, color: Colors.white)
                : Image.asset(
              AppImages.imgCheckSelect,
              height: SizeConfig.screenWidth * 0.05,
              width: SizeConfig.screenWidth * 0.05,
              color: AppColors.navBarActiveColor,
            )
                : isBold!
                ? const SizedBox.shrink()
                : Image.asset(
              AppImages.imgUnCheckSelect,
              width: (SizeConfig.screenWidth * 0.05) - 2,
              height: (SizeConfig.screenWidth * 0.05) - 2,
              color: AppColors.whiteText,
            ),
          ),
        ),
      ),
    );
  }
}
