
import 'package:flutter/material.dart';

//var view=WidgetsBinding.instance.platformDispatcher.views.single;

/*Size size = WidgetsBinding.instance.window.physicalSize /
    WidgetsBinding.instance.window.devicePixelRatio;*/



/*Size size = WidgetsBinding.instance.window.physicalSize /
    WidgetsBinding.instance.window.devicePixelRatio;*/
//Size size = view.physicalSize / view.devicePixelRatio;

// Caution! If you think these are static values and are used to build a static UI,  you mustn’t.
// These are the Viewport values of your Figma Design.
// These are used in the code as a reference to create your UI Responsively.
const num FIGMA_DESIGN_WIDTH = 375;
const num FIGMA_DESIGN_HEIGHT = 812;
const num FIGMA_DESIGN_STATUS_BAR = 44;

///This method is used to get device viewport height.
/*get height {
  num statusBar =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).viewPadding.top;
  num bottomBar = MediaQueryData.fromWindow(WidgetsBinding.instance.window)
      .viewPadding
      .bottom;
  num screenHeight = size.height - statusBar - bottomBar;
  return screenHeight;
}*/


class AppSizer{

  static late Size size;

  static void init(){
    var view=WidgetsBinding.instance.platformDispatcher.views.single;
    size = view.physicalSize / view.devicePixelRatio;
  }

  static void initMedia(MediaQueryData media){
    size = media.size;
  }

  static get width {
    return size.width;
  }



  static get height {
    var window=MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.single);
    num statusBar = window.viewPadding.top;
    num bottomBar = window.viewPadding.bottom;
    num screenHeight = size.height - statusBar - bottomBar;
    return screenHeight;
  }


  static double getRadius(double px){
    return px;
  }

  static double getHorizontalSize(double px) {
    return ((px * width) / FIGMA_DESIGN_WIDTH);
  }

  ///This method is used to set padding/margin (for the top and bottom side) & height of the screen or widget according to the Viewport height.
  static double getVerticalSize(double px) {
    return ((px * height) / (FIGMA_DESIGN_HEIGHT - FIGMA_DESIGN_STATUS_BAR));
  }

  ///This method is used to set smallest px in image height and width
  static double getSize(double px) {
    var height = getVerticalSize(px);
    var width = getHorizontalSize(px);
    if (height < width) {
      return height.toInt().toDouble();
    } else {
      return width.toInt().toDouble();
    }
  }

  ///This method is used to set text font size according to Viewport
  static double getFontSize(double px) {
    return getSize(px);
  }

  ///This method is used to set padding responsively
  static EdgeInsetsGeometry getPadding({
    double? all,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    return getMarginOrPadding(
      all: all,
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    );
  }

  ///This method is used to set margin responsively
  static EdgeInsetsGeometry getMargin({
    double? all,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    return getMarginOrPadding(
      all: all,
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    );
  }

  ///This method is used to get padding or margin responsively
  static EdgeInsetsGeometry getMarginOrPadding({
    double? all,
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    if (all != null) {
      left = all;
      top = all;
      right = all;
      bottom = all;
    }
    return EdgeInsets.only(
      left: getHorizontalSize(
        left ?? 0,
      ),
      top: getVerticalSize(
        top ?? 0,
      ),
      right: getHorizontalSize(
        right ?? 0,
      ),
      bottom: getVerticalSize(
        bottom ?? 0,
      ),
    );
  }

  static double getPerWidth(double value){
    return size.width*value;
  }

  static double getPerHeight(double value){
    return size.height*value;
  }

/*  static double getFontSize(double value){
    return value.sp;
  }

  static double getWidth(double value){
    return value.w;
  }

  static double getHeight(double value){
    return value.h;
  }*/

}