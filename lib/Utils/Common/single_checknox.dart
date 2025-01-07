import 'package:flutter/material.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

class SingleCheckBox extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback callback;
  const SingleCheckBox({
    super.key,
    required this.callback,
    required this.isActive,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => callback(),
          child: Container(
            height: SizeConfig.screenWidth * 0.06,
            width: SizeConfig.screenWidth * 0.06,
            margin: const EdgeInsets.only(right: 10),
            color: AppColors.transparent,
            child: Center(
              child: isActive
                  ? Image.asset(
                      AppImages.imgCheckSelect,
                      height: SizeConfig.screenWidth * 0.06,
                      width: SizeConfig.screenWidth * 0.06,
                    )
                  : Image.asset(
                      AppImages.imgUnCheckSelect,
                      width: (SizeConfig.screenWidth * 0.06) - 2,
                      height: (SizeConfig.screenWidth * 0.06) - 2,
                    ),
            ),
          ),
        ),
        AppText(
          text: title,
          fontWeight: FontWeight.w500,
          fontSize: SizeConfig.screenWidth * 0.035,
        ),
      ],
    );
  }
}
