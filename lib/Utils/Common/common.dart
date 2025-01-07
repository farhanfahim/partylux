import 'package:flutter/material.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Utils/Common/icons.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

class NoteText extends StatelessWidget {
  final bool showIcon;
  final String text;
  const NoteText({
    Key? key,
    this.showIcon = false,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double icosize = AppSizer.getVerticalSize(20);
    return Row(
      children: [
        Visibility(
            visible: showIcon,
            child: Padding(
              padding: EdgeInsets.only(right: AppSizer.getHorizontalSize(11)),
              child: CustomMonoIcon(
                icon: AppImages.icWarning,
                size: icosize,
                color: AppColors.red1,
              ),
            )),
        Flexible(
          child: AppText(
            text: text,
            color: AppColors.red1,
            fontSize: AppSizer.getFontSize(AppDimen.fontReminderNote),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class CustomDivider extends StatelessWidget {

  final double height;
  final Color color;
  const CustomDivider({Key? key,this.height=1,this.color=AppColors.grey4,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: height,color: color,);
  }
}

class ShadowContainer extends StatelessWidget {
  final double elevation;
  final Widget child;
  final double radius;
  final bool enabledPadding;
  final Color shadowColor;

  const ShadowContainer({
    Key? key,
    this.elevation = 5,
    required this.child,
    this.enabledPadding = false,this.shadowColor=AppColors.shadowGrey,
    this.radius = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(enabledPadding ? elevation : 0),
      child: Material(
        elevation: elevation,
        shadowColor: shadowColor,
        color: AppColors.transparent,
        borderRadius: BorderRadius.circular(radius),
        clipBehavior: Clip.antiAlias,
        child: child,
      ),
    );
  }
}