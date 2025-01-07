// ignore_for_file: must_be_immutable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:partylux/Constants/app_fonts.dart';
import 'package:partylux/Constants/color.dart';

class AppText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int? maxLines;
  final String fontFamily;
  double height;
  TextDecoration? textDecoration;

  final Paint? foreground;

  AppText({
    Key? key,
    required this.text,
    this.color = AppColors.whiteText,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w700,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.visible,
    this.maxLines,
    this.height = 1.2,
    this.textDecoration,
    this.foreground,
    this.fontFamily = AppFonts.copperPlate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toString(),
      softWrap: true,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        decoration: textDecoration ?? TextDecoration.none,
        fontWeight: fontWeight,
        fontFamily: (fontWeight == FontWeight.w700 && fontFamily == AppFonts.copperPlate) ? AppFonts.copperPlate2 : fontFamily,
        height: height,
        foreground: foreground,
      ),
/*      style: GoogleFonts.inter(
        color: color,
        fontSize: fontSize,
        decoration: textDecoration ?? TextDecoration.none,
        fontWeight: fontWeight,
        height: height,
        foreground: foreground,
      ),*/
    );
  }
}

class CustomRichText extends StatelessWidget {
  //final String text1,text2;
  final double fontSize;
  final TextAlign textAlign;
  final List<TextSpan> spans;
  final double linespacing;
  final String? fontFamily;
  final bool isSp;
  final Color color;
  final int? maxlines;
  final FontWeight? fontWeight;

  const CustomRichText({
    Key? key,
    required this.spans,
    this.maxlines,
    this.fontSize = 16,
    this.linespacing = 1.2,
    this.textAlign = TextAlign.start,
    this.color = AppColors.whiteText,
    this.fontFamily = AppFonts.copperPlate,
    this.fontWeight = FontWeight.w700,
    this.isSp = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        textAlign: textAlign,
        maxLines: maxlines,
        softWrap: true,
        textScaleFactor: MediaQuery.textScaleFactorOf(context),
        text: TextSpan(
          style: TextStyle(
            color: color,
            height: linespacing,
            fontWeight: fontWeight,
            fontFamily: (fontWeight == FontWeight.w700 && fontFamily == AppFonts.copperPlate) ? AppFonts.copperPlate2 : fontFamily,
            //fontSize: isSp ? AppSizer.getFontSize(fontSize) : fontSize
            fontSize: fontSize,
          ),
          children: spans,
        ));
  }
}

class CustomSpan extends TextSpan {
  CustomSpan(
      {String text = "", double? fontSize, Color fontColor = AppColors.whiteText,
        FontWeight? fontWeight, bool isSp = true, void Function()? onTap})
      : super(
            text: text,
            style: TextStyle(
              color: fontColor,
              fontWeight: fontWeight,
              //fontSize: fontSize!=null?(isSp?AppSizer.getFontSize(fontSize) : fontSize):null,
              fontSize: fontSize,
            ),
            recognizer: TapGestureRecognizer()..onTap = onTap);
}
