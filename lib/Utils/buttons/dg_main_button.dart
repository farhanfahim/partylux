import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Common/icons.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

import '../../Constants/app_images.dart';
import '../../Constants/dimens.dart';
import '../Common/sizer.dart';

class AppButton {
  static mainButton(
    BuildContext context, {
    required String text,
    required GestureTapCallback onPressed,
    double borderRadius = 10,
    Color? textColor,
    Color? buttonColor,
    Widget? widget,
    bool isTransparent = false,
    bool isDisable = false,
    double? fontSize,
    bool loading = false,
        String? icon,
    BorderSide border = BorderSide.none,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.fromBorderSide(border),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: !isDisable?() {
              FocusManager.instance.primaryFocus?.unfocus();
              onPressed();
            }:null,
            child: Container(
              height: SizeConfig.screenHeight * 0.060,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: isTransparent?AppColors.transparent:!isDisable?buttonColor:AppColors.grey4,
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(color:  isTransparent?AppColors.transparent:!isDisable ? AppColors.secondary : AppColors.transparent),
                gradient: buttonColor == null
                    ? isDisable
                        ? null
                        : LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            stops: [0, 1],
                            colors: [
                              AppColors.secondary,
                              AppColors.primary,
                            ],
                          )
                    : null,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: widget ?? Container(),
                  ),
                  Center(
                    child: loading
                        ? SpinKitFadingCircle(
                            color: AppColors.whiteText,
                            size: SizeConfig.screenWidth * 0.05,
                          )
                        : Row(
                          children: [
                            icon!=null?Padding(
                              padding: EdgeInsets.only(right: AppSizer.getHorizontalSize(8)),
                              child: CustomMonoIcon(icon: icon,size: AppSizer.getVerticalSize(21),),
                            ):const SizedBox.shrink(),
                            AppText(
                                text: text,
                                fontSize: AppSizer.getFontSize(fontSize??AppDimen.fontTextfieldLabel16),
                                color: textColor ?? AppColors.whiteText,
                              ),
                          ],
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static cancelButton(
    BuildContext context, {
    required String text,
    required GestureTapCallback onPressed,
    Color? textColor,
    Color backgroundColor = Colors.grey,
    bool loading = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              onPressed();
            },
            child: Container(
              height: SizeConfig.screenHeight * 0.057,
              width: double.infinity,
              decoration: BoxDecoration(
                color: backgroundColor,
              ),
              child: Center(
                child: loading
                    ? SpinKitFadingCircle(
                        color: AppColors.whiteText,
                        size: SizeConfig.screenWidth * 0.05,
                      )
                    : AppText(
                        text: text,
                        fontSize: SizeConfig.screenWidth * 0.037,
                        fontWeight: FontWeight.w500,
                        color: textColor ?? AppColors.whiteText,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static secondaryButton(
    BuildContext context, {
    required String text,
    required GestureTapCallback onPressed,
    Color? borderColor,
    Color? textColor,
    bool isFullWidth = false,
    bool loading = false,
  }) {
    return Padding(
        padding: !isFullWidth
            ? EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.1)
            : EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.0),
        child: Container(
            padding: const EdgeInsets.all(0.01),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: borderColor ?? AppColors.primary,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Material(
                  color: Colors.transparent,
                ))));
  }
}


class CustomMaterialButton extends StatelessWidget {
  final String text;
  final String? icon;
  final Color textColor, bgColor;
  final void Function()? onTap;
  final double fontsize;
  double? radius;
  final EdgeInsets? padding;
  final BorderSide border;
  final bool italic;
  final FontWeight fontWeight;
  final bool enabled;
  final bool isSvg;

  CustomMaterialButton({Key? key,
    this.text = "",
    this.textColor = AppColors.white2,
    this.bgColor = AppColors.primary,
    this.onTap,this.isSvg=false,
    this.radius,this.icon,
    this.italic = true,
    this.fontsize = AppDimen.fontTextfieldLabel16,
    this.border = BorderSide.none,
    this.fontWeight = FontWeight.w600,
    this.padding,this.enabled=true,
  }):super(key: key) {
    radius ??= AppSizer.getRadius(AppDimen.btnRadius);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius!),
        border: Border.fromBorderSide(border),
        color: enabled?bgColor:AppColors.grey1,
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: enabled?onTap:null,
          child: Padding(
            padding: padding ??
                EdgeInsets.symmetric(vertical: AppSizer.getVerticalSize(AppDimen.btnVertPadd)),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget get child {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        icon!=null?Padding(padding: EdgeInsets.only(right: AppSizer.getHorizontalSize(8)),
          child: CustomMonoIcon(icon: icon!,isSvg: isSvg,color: textColor,
            size: AppSizer.getFontSize(fontsize+4),
            //  size: AppSizer.getVerticalSize(18),
          ),):Container(),
        AppText(
          text: text,
          color: textColor,
          fontSize: fontsize,
          textAlign: TextAlign.center,
          fontWeight: fontWeight,
        ),
      ],
    );
  }
}
