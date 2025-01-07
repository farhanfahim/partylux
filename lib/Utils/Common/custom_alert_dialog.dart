import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Utils/Common/sizer.dart';

import '../../Constants/color.dart';
import '../Theme/app_text.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String? firstButtonContent;
  final String secondButtonContent;
  final Color? firstBtnColor;
  final Color? secondBtnColor;
  final VoidCallback? first;
  final VoidCallback second;

  CustomAlertDialog(
      {super.key,
      required this.content,
      required this.title,
      this.firstButtonContent,
      this.firstBtnColor,
      this.secondBtnColor,
      required this.secondButtonContent,
      this.first,
      required this.second});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
            color: AppColors.midGrey,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: AppColors.midGrey, width: 0.5)),
        height: 150,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.whiteText, width: 0.2),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    title.isNotEmpty
                        ? Container(
                            child: Center(
                              child: AppText(
                                  textAlign: TextAlign.center,
                                  text: title,
                                  fontSize: AppSizer.getFontSize(
                                      AppDimen.fontTextfieldLabel18),
                                  color: AppColors.whiteText),
                            ),
                          )
                        : Container(),
                    title.isNotEmpty ? SizedBox(height: 10) : Container(),
                    Container(
                      child: Center(
                        child: AppText(
                          textAlign: TextAlign.center,
                          text: content,
                          fontSize: AppSizer.getFontSize(
                              AppDimen.fontTextfieldLabel14),
                          color: AppColors.whiteText,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            firstButtonContent != null
                ? Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: first,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                      color: AppColors.whiteText, width: 0.2),
                                ),
                              ),
                              child: Center(
                                child: AppText(
                                  text: firstButtonContent!,
                                  fontSize: AppSizer.getFontSize(
                                      AppDimen.fontTextfieldLabel16),
                                  fontWeight: FontWeight.w400,
                                  color: firstBtnColor ?? AppColors.whiteText,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: second,
                            child: Center(
                              child: AppText(
                                text: secondButtonContent,
                                fontSize: AppSizer.getFontSize(
                                    AppDimen.fontTextfieldLabel16),
                                fontWeight: FontWeight.w400,
                                color: secondBtnColor ?? AppColors.whiteText,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: InkWell(
                      onTap: second,
                      child: Center(
                        child: AppText(
                          text: secondButtonContent,
                          fontSize: AppSizer.getFontSize(
                              AppDimen.fontTextfieldLabel16),
                          fontWeight: FontWeight.w400,
                          color: secondBtnColor ?? AppColors.whiteText,
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
