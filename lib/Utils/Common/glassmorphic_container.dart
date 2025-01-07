import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Utils/Common/sizer.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final Color? color;
  final List<Color>? gradientColors;
  final EdgeInsetsGeometry? padding;
  final double? blur;
  final double? borderRadius;
  final VoidCallback? onPressed;
  const GlassContainer({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.color,
    this.gradientColors,
    this.blur,
    this.onPressed,
    this.borderRadius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double radius=borderRadius??AppSizer.getRadius(AppDimen.conRadius);
    return GestureDetector(
      onTap: onPressed,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur ?? 4, sigmaY: blur ?? 4),
          child: Container(
            width: width ?? double.maxFinite,
            height: height??null,
            padding: padding ?? AppSizer.getPadding(left: 16,right: 16,top: 8,bottom: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors ?? [
                  color?.withOpacity(0.15) ?? Colors.grey.shade600.withOpacity(0.15),
                  color?.withOpacity(0.15) ?? Colors.grey.shade600.withOpacity(0.15),
                ],
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
              ),
              borderRadius: BorderRadius.all(Radius.circular(radius)),
            ),
            child: height!=null?Center(child: child):child,
          ),
        ),
      ),
    );
  }
}