import 'package:flutter/material.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

import '../../Constants/color.dart';

class CustomChips extends StatelessWidget {
  final List<String> itemList;
  final List<Color>? gradientColors;
  final bool? isGradient;

  const CustomChips({Key? key, required this.itemList,this.gradientColors,this.isGradient = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      spacing: 15,
      runSpacing: 15,
      children: itemList.map((item) {
        return Visibility(
          visible: item.isNotEmpty,
          child: Container(
            padding:
                AppSizer.getPadding(left: 12, right: 12, top: 8, bottom: 8),
            decoration: isGradient == true ? BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                colors: gradientColors ??  [
                  AppColors.female,
                  AppColors.primaryText,
                ]
              )
            ) : BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.whiteText.withOpacity(0.1),
            ),
            child: AppText(
              text: item,
              textAlign: TextAlign.center,
              fontSize: AppSizer.getFontSize(14),
              color: AppColors.grey4,
              fontWeight: FontWeight.w400,
            ),
          ),
        );
      }).toList(),
    );
  }
}
