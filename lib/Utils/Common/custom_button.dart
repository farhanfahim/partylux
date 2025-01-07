import 'package:flutter/material.dart';
import 'package:partylux/Constants/app_fonts.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/Util.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.label,
      required this.onPressed,
      this.enabled,
      this.textColor,
      this.fontSize,
      this.fontWeight,
      this.prefix,
      this.borderColor,
      this.height,
      this.width,
      this.gradientColors,
        this.fontFamily,
      this.color})
      : super(key: key);

  final String label;
  final Color? textColor;
  final Color? borderColor;
  final bool? enabled;
  final VoidCallback onPressed;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Widget? prefix;
  final double? width;
  final double? height;
  final List<Color>? gradientColors;
  final Color? color;
  final String? fontFamily;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: 45,
      width: width ?? MediaQuery.sizeOf(context).width,
      decoration: color != null
          ? BoxDecoration(
              color: color ?? Colors.black,
              borderRadius: BorderRadius.circular(10),
            )
          : BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradientColors ??
                      [
                        Colors.black,
                        Colors.black,
                      ]),
              borderRadius: BorderRadius.circular(10),
            ),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.05),
              shadowColor: Colors.white.withOpacity(0.05),
              side: BorderSide(
                width: 0.8,
                color: enabled ?? true
                    ? borderColor ?? Colors.transparent
                    : borderColor?.withOpacity(0.5) ?? Colors.transparent,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
          onPressed: enabled ?? true
              ? () {
                  Util.hideKeyBoard(context);
                  onPressed.call();
                }
              : null,
          child: prefix != null
              ? Row(mainAxisSize: MainAxisSize.min, children: [
                  prefix ?? const SizedBox.shrink(),
                  const SizedBox(width: 8),
                  AppText(
                    text: label,
                    color: textColor ?? Colors.white,
                    fontSize: AppSizer.getFontSize(fontSize ?? 18),
                    fontWeight: fontWeight ?? FontWeight.w600,
                    fontFamily: AppFonts.lexendDica,
                  )
                ])
              : AppText(
                  text: label,
                  color: (enabled ?? true
                      ? (textColor ?? Colors.white)
                      : (textColor?.withOpacity(0.5) ??
                          Colors.white.withOpacity(0.5))),
                  fontSize: AppSizer.getFontSize(fontSize ?? 16),
                  fontWeight: fontWeight ?? FontWeight.w400,
                  fontFamily: fontFamily ?? AppFonts.lexendDica,
                )),
    );
  }
}
