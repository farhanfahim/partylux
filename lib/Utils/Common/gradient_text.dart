import 'package:flutter/material.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

class GradientText extends StatelessWidget {
  const GradientText(
      this.text, {
        required this.gradient,
        this.fontSize
      });

  final String text;
  final Gradient gradient;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: AppText(text: text,fontSize: AppSizer.getFontSize(fontSize ?? 18),),
    );
  }
}