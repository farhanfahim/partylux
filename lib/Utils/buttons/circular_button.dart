import 'package:flutter/material.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Common/common.dart';
import 'package:partylux/Utils/Common/icons.dart';

class CircularButton extends StatelessWidget {
  final double diameter;
  final String? icon;
  final Color color, bgColor;
  final void Function()? onTap;
  final BorderSide border;
  final double elevation;
  final double ratio;
  final bool isSvg;

  const CircularButton({
    Key? key,
    required this.diameter,
    this.icon,
    this.bgColor = AppColors.whiteText,
    this.elevation = 0,
    this.ratio = 0.4,
    this.border = BorderSide.none,
    this.onTap,
    this.color = AppColors.black,
    this.isSvg = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShadowContainer(
        radius: diameter / 2,
        elevation: elevation,
        child: Container(
          width: diameter,
          height: diameter,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor,
              border: Border.fromBorderSide(border)),
          child: Material(
            color: AppColors.transparent,
            child: InkWell(onTap: onTap, child: Center(child: buildChild())),
          ),
        ));
  }

  Widget buildChild() {
    return icon!=null?CustomMonoIcon(
      size: diameter * ratio,
      icon: icon!,
      isSvg: isSvg,
      color: color,
    ):Container();
  }
}