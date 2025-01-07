import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Utils/Common/custom_textfield.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

import '../../Constants/app_fonts.dart';
import '../../Constants/app_images.dart';

class HomeSearchScaffold extends StatelessWidget {
  final Widget body;
  final bool hideAppBar;
  final bool showBackBtn;
  final bool isBodyPadding,isVertPadding;
  final double? isTopPadding;
  final double? leadingWidth;
  final double? isBottomPadding;
  final bool showLeading;
  final bool isLeftAlign;
  final Widget? leadingWidget;
  final Widget? bottomBar;
  final Widget? basicAppTrailingIcon;
  final String appBarTitle;
  final Color appbarColor;
  final Function(String)? onnChanged;
  final TextEditingController? searchController;

  const HomeSearchScaffold({
    super.key,
    required this.body,
    this.hideAppBar = false,
    this.showBackBtn = false,
    this.isBodyPadding = true,
    this.isLeftAlign = false,
    this.showLeading = false,
    this.isTopPadding,
    this.isBottomPadding,
    this.bottomBar,
    this.leadingWidget,
    this.leadingWidth,
    this.onnChanged,
    this.searchController,
    this.basicAppTrailingIcon,this.isVertPadding=false,
    this.appBarTitle = "",this.appbarColor=AppColors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.backgroundColor,
              image: DecorationImage(
                image: AssetImage(AppImages.imgBg),
                fit: BoxFit.cover,
              ),
            ),
      child: Scaffold(
        backgroundColor: AppColors.transparent,
        body: Column(
                children: [
                  hideAppBar?Container():getBasicAppBar(),
                  Expanded(
                    child: Container(
                        padding: isBodyPadding
                            ? EdgeInsets.fromLTRB(16, isVertPadding?AppSizer.getVerticalSize(AppDimen.vertPadd):
                            (isTopPadding ?? 0), 16, isVertPadding?AppSizer.getVerticalSize(AppDimen.vertPadd):
                        (isBottomPadding ?? 0),)
                            : EdgeInsets.zero,
                        child: body),
                  ),
                ],
              ),
        bottomNavigationBar: bottomBar,
        
      ),
    );
  }

  getBasicAppBar() {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: showBackBtn,
      centerTitle: isLeftAlign?false:true,
      backgroundColor: appbarColor,
      toolbarHeight: 80,//AppBar().preferredSize.height,
      leadingWidth: leadingWidth,
      leading: showBackBtn
          ? GestureDetector(
          onTap: () {
            Get.back();
          },
          child:Padding(
            padding: const EdgeInsets.all(15),
            child: Image.asset(
                AppImages.imgArrowLeft,
                fit: BoxFit.scaleDown),
          ))
          : showLeading?leadingWidget:null,
      title: Container(
        child: CustomTextField(
          controller: searchController,
          onChanged: onnChanged??null,
            fieldStyle:TextStyle(
                fontFamily: AppFonts.copperPlate,
                fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                fontWeight: FontWeight.w400,
                color: AppColors.whiteText),
          hintStyle: TextStyle(
              fontFamily: AppFonts.copperPlate,
              fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
              fontWeight: FontWeight.w400,
              color: AppColors.iconColor),
          fillColor: AppColors.bottomsheetLogout,
          hintText: "Search Clubs, bar, parties",
            textInputAction:TextInputAction.search,
          prefix: Container(
            width: AppSizer.getSize(8),
            height: AppSizer.getSize(8),
            padding: const EdgeInsets.all(15),
            child: Image.asset(
              AppImages.imgSearch,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
      actions: [
        basicAppTrailingIcon != null
            ? basicAppTrailingIcon ?? Container()
            : Container()
      ],
    );
  }
}
