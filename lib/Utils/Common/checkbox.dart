import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

import '../../Constants/app_images.dart';

class CheckBoxField extends StatefulWidget {
  final void Function(bool val) callback;
  final bool isRichText;
  final bool initialValue;
  final String simpleTitle;
  final String richText1;
  final String richText2;
  final String richText3;
  final Function? richTextCallBack;
  final FontWeight? simpleTextFontWeight;
  final double? simpleTextSize;
  final double? centerSpace;

  CheckBoxField({
    super.key,
    required this.callback,
    this.isRichText = false,
    this.initialValue = false,
    this.simpleTitle = "Please Enter Title",
    this.richText1 = "Please Enter 1st Text",
    this.richText2 = "Please Enter 2nd Text",
    this.richText3 = "Please Enter 2nd Text",
    this.richTextCallBack,
    this.simpleTextFontWeight,
    this.simpleTextSize,
    this.centerSpace,
  });

  @override
  State<CheckBoxField> createState() => _CheckBoxFieldState();
}

class _CheckBoxFieldState extends State<CheckBoxField> {
  // RxBool isActive = false.obs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      isActive = widget.initialValue;
    });
  }

  bool isActive = false;

  void userActive(bool val) {
    setState(() {
      isActive = val;
    });
    widget.callback(val);
  }

  @override
  void didUpdateWidget(covariant CheckBoxField oldWidget) {
    isActive=widget.initialValue;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        userActive(!isActive);
      },
 /*     child:  Container(
        height: SizeConfig.screenWidth * 0.06,
        width: SizeConfig.screenWidth * 0.06,
        margin: const EdgeInsets.only(right: 10),
        color: AppColors.transparent,
        child: Center(
          child: isActive
              ? Image.asset(
            "assets/icon_assets/checkbox_select.png",
            height: SizeConfig.screenWidth * 0.05,
            width: SizeConfig.screenWidth * 0.05,
            color: AppColors.whiteText,
          )
              : Image.asset(
            "assets/icon_assets/checkbox_unselect.png",
            width: (SizeConfig.screenWidth * 0.05) - 2,
            height: (SizeConfig.screenWidth * 0.05) - 2,
            color: AppColors.whiteText,
          ),
        ),
      ),*/
      child: Container(
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: SizeConfig.screenWidth * 0.06,
              width: SizeConfig.screenWidth * 0.06,
              margin: const EdgeInsets.only(right: 10),
              color: AppColors.transparent,
              child: Center(
                child: isActive
                    ? Image.asset(
                        AppImages.imgCheckSelect,
                        height: SizeConfig.screenWidth * 0.05,
                        width: SizeConfig.screenWidth * 0.05,
                        color: AppColors.whiteText,
                      )
                    : Image.asset(
                        AppImages.imgUnCheckSelect,
                        width: (SizeConfig.screenWidth * 0.05) - 2,
                        height: (SizeConfig.screenWidth * 0.05) - 2,
                        color: AppColors.whiteText,
                      ),
              ),
            ),
            SizedBox(width: widget.centerSpace ?? 0),
            widget.isRichText
                ? Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: widget.richText1,
                        style: TextStyle(
                            overflow: TextOverflow.visible,
                            fontFamily: "Onest",
                            color: AppColors.whiteText.withOpacity(0.7),
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.screenWidth * 0.033,
                            height: 1.4),
                        children: <TextSpan>[
                          TextSpan(
                            text: " ${widget.richText2}",
                            style: TextStyle(
                              shadows: [
                                Shadow(
                                    color: Colors.blue,
                                    offset: Offset(0, -2))
                              ],
                              color: Colors.transparent,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blue,
                              decorationThickness: 2,
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.screenWidth * 0.033,
                              fontFamily: "Onest",
                              overflow: TextOverflow.visible,
                              decorationStyle: TextDecorationStyle.solid,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                if (widget.richTextCallBack != null) {
                                  widget.richTextCallBack!(widget.richText2);
                                }
                              },
                          ),
                          TextSpan(
                            text: " and ",
                            style: TextStyle(
                              overflow: TextOverflow.visible,
                              fontFamily: "Onest",
                              color: AppColors.whiteText.withOpacity(0.7),
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.screenWidth * 0.033,
                            ),
                          ),
                          TextSpan(
                            text: "${widget.richText3}",
                            style: TextStyle(
                              shadows: [
                                Shadow(
                                    color: Colors.blue,
                                    offset: Offset(0, -2))
                              ],
                              color: Colors.transparent,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.blue,
                              decorationThickness: 2,
                              fontWeight: FontWeight.w500,
                              fontSize: SizeConfig.screenWidth * 0.033,
                              fontFamily: "Onest",
                              overflow: TextOverflow.visible,
                              decorationStyle: TextDecorationStyle.solid,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                if (widget.richTextCallBack != null) {
                                  widget.richTextCallBack!(widget.richText3);
                                }
                              },
                          )
                        ],
                      ),
                    ),
                  )
                : AppText(
                    text: widget.simpleTitle,
                    fontWeight: widget.simpleTextFontWeight ?? FontWeight.w400,
                    fontSize: widget.simpleTextSize ??
                        SizeConfig.screenWidth * 0.0275,
                  ),
          ],
        ),
      ),
    );
  }
}
