import 'package:flutter/material.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Common/sizer.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  final List<Color>? gradientColors;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  bool? isTransparent;
  GradientContainer({super.key, required this.child,this.gradientColors,this.onPressed,this.padding,this.margin,this.isTransparent= false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                colors: gradientColors ?? [
                  AppColors.female,
                  AppColors.primaryText,
                ]
            ),
        ),
        child: Container(
          padding: padding ?? AppSizer.getPadding(left: 16,right: 16,top: 10,bottom: 10),
          margin: AppSizer.getMargin(all: 1.2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isTransparent! ?AppColors.transparent:AppColors.midGrey,
          ),
          child: Center(child: child)
        ),
      ),
    );
  }
}
