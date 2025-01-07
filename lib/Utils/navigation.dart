import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/integer.dart';

class AppNavigator{

  static Future<T?>? navigateToNamed<T>(String route,{Transition transition=Transition.native,dynamic arguments,
    int duration=AppInteger.STANDARD_DURATION_MILLI}){
    return Get.toNamed<T>(route,arguments: arguments,preventDuplicates: false,
      //transition: transition,duration: Duration(milliseconds: duration)
    );
  }

  static void navigateToNamedReplace(String route,{Transition transition=Transition.native,
    dynamic arguments,
    int duration=AppInteger.STANDARD_DURATION_MILLI}){
    Get.offAndToNamed(route,arguments: arguments,
      //transition: transition,duration: Duration(milliseconds: duration)
    );
  }
  static void navigateToNamedReplaceAll(String route,{Transition transition=Transition.native,
    dynamic arguments,
    int duration=AppInteger.STANDARD_DURATION_MILLI}){
    Get.offAllNamed(route,arguments: arguments,
      //transition: transition,duration: Duration(milliseconds: duration)
    );
  }

  static void navigateToNamedUntil(String route,{Transition transition=Transition.native,
    dynamic arguments,
    int duration=AppInteger.STANDARD_DURATION_MILLI}){
    Navigator.of(Get.context!).popUntil(ModalRoute.withName(route));
/*    Get.offNamedUntil("",
      //ModalRoute.withName(route),
      ModalRoute.withName(route),
      arguments: arguments,
      //transition: transition,duration: Duration(milliseconds: duration)
    );*/
  }

  static Future<T?>? navigateTo<T>(dynamic widget,{Transition transition=Transition.native,
    int duration=AppInteger.STANDARD_DURATION_MILLI}) {
    return Get.to<T>(widget,transition: transition,duration: Duration(milliseconds: duration),);
  }

/*  static navigateTo2(BuildContext context,Widget widget,{int duration=AppInteger.STANDARD_DURATION_MILLI}){
    //const int duration=0;
    Navigator.push(context,PageRouteBuilder(
      transitionDuration: Duration(milliseconds: duration),
      reverseTransitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) {
        return widget;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    ));
  }*/

  static void navigateToReplace(Widget Function() navigate,{Transition transition=Transition.native,
    int duration=AppInteger.STANDARD_DURATION_MILLI}){
    Get.off(navigate,transition: transition,duration: Duration(milliseconds: duration));
  }
  static void navigateToReplaceAll(Widget Function() navigate,{Transition transition=Transition.native,
    int duration=AppInteger.STANDARD_DURATION_MILLI}){
    Get.offAll(navigate,transition: transition,duration: Duration(milliseconds: duration));
  }

  static void pop<T>({T? result}){
    Get.back<T>(result: result);
  }
}