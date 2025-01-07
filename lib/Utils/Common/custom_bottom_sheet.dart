import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';


class CustomBottomSheet2 extends StatelessWidget {

  bool? isPadding;
  String? screenTitle;
  bool? showLeadingCrossButton = false;
  bool? showHeader = true;
  //Color? backgroundColor = AppColors.midGrey;
  bool? showDivider = true;
  VoidCallback? saveTap;
  Widget widget;

  CustomBottomSheet2({
    Key? key,
    required Widget this.widget,
    this.isPadding,
    this.showLeadingCrossButton = false,
    this.showHeader = true,
    //this.backgroundColor = AppColors.midGrey,
    this.showDivider = true,
    this.screenTitle,
  }) : super(key: key);

  void onClose() {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: showHeader!,
            child: Column(
              children: [
                Padding(
                  padding: AppSizer.getPadding(left: 16,right: 16),
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    centerTitle: true,
                    elevation: 0,
                    leadingWidth: 80,
                    leading: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Center(
                        child: AppText(
                          text: "cancel",
                          color: AppColors.iconColor,
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    title:  AppText(text:screenTitle??"",
                      overflow: TextOverflow.ellipsis,
                      color: AppColors.whiteText,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,),
                    actions: [
                      Visibility(
                        visible: saveTap!=null,
                        child: Center(
                          child: GestureDetector(
                            onTap: saveTap,
                            child: AppText(
                              text: "done",
                              color: AppColors.iconColor,
                              fontWeight: FontWeight.w400,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                    visible:showDivider!,
                    child: Divider(thickness: 0.2,)),
              ],
            ),
          ),
          widget,
        ],
      ),
    );
  }
}
