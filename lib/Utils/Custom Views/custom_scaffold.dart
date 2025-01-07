import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Utils/Common/icons.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

import '../../Constants/app_images.dart';
import '../Util.dart';

class CustomScaffold extends StatelessWidget {

  final Widget body;
  final bool bottom;
  final bool hideAppBar;
  final bool showBackBtn;
  final bool isBodyPadding, isVertPadding;
  final double? isTopPadding;
  final double? leadingWidth;
  final double? isBottomPadding;
  final bool showLeading;
  final bool isLeftAlign;
  final Widget? leadingWidget;
  final Widget? bottomBar;
  final Widget? floatingActionButton;
  final Widget? basicAppTrailingIcon;
  final String appBarTitle;
  final String backgroundImage;
  final Color appbarColor;
  final Color appbarTextColor;
  final bool showDivider;
  final bool hideBackgroundImage;
  final double? appBarFont;
  final bool safeTop;
  final Widget? screenTitleWidget;
  final Function? onBackPressed;

  const CustomScaffold({
    super.key,
    required this.body,
    this.bottom = true,
    this.hideAppBar = false,
    this.showBackBtn = false,
    this.isBodyPadding = true,
    this.isLeftAlign = false,
    this.showLeading = false,
    this.showDivider = false,
    this.isTopPadding,this.safeTop=false,
    this.isBottomPadding,
    this.floatingActionButton,
    this.bottomBar,
    this.leadingWidget,
    this.leadingWidth,
    this.screenTitleWidget,
    this.basicAppTrailingIcon,
    this.isVertPadding = false,
    this.appBarTitle = "",
    this.backgroundImage = AppImages.imgBg,
    this.hideBackgroundImage = false,
    this.appbarColor = AppColors.transparent,
    this.appbarTextColor = AppColors.whiteText,
    this.appBarFont,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (){
        Util.hideKeyBoard(context);
      },
      child: Container(
        decoration: hideBackgroundImage?BoxDecoration():BoxDecoration(
          color: AppColors.backgroundColor,
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          appBar: hideAppBar ? null: getBasicAppBar(context),
          body: SafeArea(
            top: safeTop,
              bottom: bottom,
            child: Padding(
                padding: isBodyPadding
                    ? EdgeInsets.fromLTRB(
                  AppSizer.getHorizontalSize(AppDimen.horzPadd),
                  isVertPadding ? AppSizer.getVerticalSize(AppDimen.vertPadd) : (isTopPadding ?? 0),
                  AppSizer.getHorizontalSize(AppDimen.horzPadd),
                  isVertPadding ? AppSizer.getVerticalSize(AppDimen.vertPadd) : (isBottomPadding ?? 0),
                )
                    : EdgeInsets.zero,
                child: body,
          )),
          floatingActionButton: floatingActionButton,
          bottomNavigationBar: bottomBar,
        ),
      ),
    );
  }

  getBasicAppBar(BuildContext context) {
    var size=AppBar().preferredSize;
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: showBackBtn,
      centerTitle: isLeftAlign ? false : true,
      backgroundColor: appbarColor,
     // toolbarHeight: size.height,
      leadingWidth: showLeading?leadingWidth:40,
      leading: showBackBtn || showLeading
          ? Row(
              children: [
                Visibility(
                    visible: showBackBtn,
                    child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          onBackPressed!=null?onBackPressed!():Get.back();
                        },
                        child: Padding(
                          padding: AppSizer.getPadding(left: 12,right: 0,top: 12,bottom: 12),
                          child: CustomMonoIcon(icon: AppImages.imgArrowLeft,
                            color: AppColors.whiteText,isSvg: false,
                            size: AppSizer.getVerticalSize(AppDimen.appBarIconSize),),
                        ))),
                showLeading ? leadingWidget ?? const SizedBox.shrink() : const SizedBox.shrink(),
              ],
            )
          : null,
      title: screenTitleWidget ?? AppText(
        text: appBarTitle,
        color: appbarTextColor,
        fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
      ),
      actions: [
        basicAppTrailingIcon != null
            ? Padding(
                padding: const EdgeInsets.only(right: 16),
                child: basicAppTrailingIcon ?? Container(),
              )
            : Container()
      ],
      flexibleSpace: Container(
        height: double.infinity,
        width: size.width,
        decoration: BoxDecoration(
            border: Border(
              bottom: showDivider ? BorderSide(width: 1, color: AppColors.primary) : BorderSide.none,
            )),
      ),
    );
  }
}
