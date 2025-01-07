import 'package:flutter/material.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

Widget buildFieldValue(String field, Widget value, {bool mandatory = true, Widget? option}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Row(
        children: [
          Expanded(
            child: AppText(
              text: field,color: AppColors.whiteText,
              fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
              fontWeight: FontWeight.w700,
            ),
          ),
          option ?? Container(),
        ],
      ),
      SizedBox(
        height: AppSizer.getVerticalSize(AppDimen.fieldBwSpacing),
      ),
      value,
    ],
  );
}
