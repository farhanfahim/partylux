import 'package:flutter/material.dart';
import '../../Constants/color.dart';

class Themes {

  static final light = ThemeData.light().copyWith(
    scaffoldBackgroundColor:AppColors.whiteText,
    primaryColor: AppColors.whiteText,
    backgroundColor: AppColors.whiteText,
    indicatorColor: AppColors.whiteText,
    dividerColor: Colors.grey,
    hintColor: AppColors.whiteText,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    hoverColor: Colors.transparent,
    focusColor: Colors.transparent,
    disabledColor: Colors.grey,
    cardColor: AppColors.whiteText,
    brightness: Brightness.light,

  );

  static final dark = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.black,
    primaryColor:AppColors.black,
    backgroundColor: AppColors.black,
    indicatorColor:AppColors.whiteText,
    hintColor: AppColors.whiteText,
    highlightColor: Colors.transparent,
    splashColor: Colors.transparent,
    hoverColor: Colors.transparent,
    focusColor: Colors.transparent,
    dividerColor: Colors.grey,
    disabledColor: Colors.grey,
    cardColor: AppColors.black,
    brightness: Brightness.dark ,


  );
}

