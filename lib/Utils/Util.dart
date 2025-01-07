
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart' hide Notification;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart'as toast;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Constants/color.dart';
import '../Constants/dimens.dart';
import 'Common/common_image_view.dart';
import 'Theme/app_text.dart';
import 'date_time_util.dart';
class Util {

  static Future<void> launchInWebViewWithJavaScript(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        // forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  static void hideKeyBoard(BuildContext context) {
    FocusScope.of(context)
        .requestFocus(FocusNode()); //DateFormat('MMM/dd/yyyy').format(date);
  }

  static String timeAgo(String dateTime,

      {bool numericDates = true}) {


    String originalDateString = dateTime;
    DateTime originalDate = DateTime.parse(originalDateString);
    try {
      final date2 = DateTime.now().toLocal();
      final difference = date2.difference(originalDate);

      if (difference.inSeconds < 5) {
        return 'Just now';
      } else if (difference.inSeconds <= 60) {
        return '${difference.inSeconds}s ago';
      } else if (difference.inMinutes <= 1) {
        return (numericDates) ? '1m ago' : 'A minute ago';
      } else if (difference.inMinutes <= 60) {
        return '${difference.inMinutes} min';
      } else if (difference.inHours <= 1) {
        return (numericDates) ? '1h ago' : 'An hour ago';
      } else if (difference.inHours <= 60) {
        return '${difference.inHours}h';
      } else if (difference.inDays <= 1) {
        return (numericDates) ? '1d ago' : 'Yesterday';
      }
      return DateFormat("MMM d").format(originalDate);
    } catch (e) {
      return "";
    }
  }

  static String formatNumberWithCommas(double value) {
    final formatter = NumberFormat("#,###.###");
    return formatter.format(value);
  }


  static String getDay(DateTime dateTime) {
    var xxx = DateFormat("MMM d").format(dateTime);
    return xxx.toString();
  }


  static String checkDay(String dateTime) {

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final week = DateTime(now.year, now.month, now.day + 2);


    String originalDateString = dateTime;
    DateTime originalDate = DateTime.parse(originalDateString);

    // Format the DateTime object into the desired format
    String formattedDateString = DateFormat('yyyy-MM-dd').format(originalDate);
    DateTime formattedDate = DateTime.parse(formattedDateString);



    final aDate = DateTime(formattedDate.year, formattedDate.month, formattedDate.day);
    if(aDate == today) {
      print("Today");
      return "Today";
    } else if (aDate == tomorrow) {
      print("Tomorrow");
      return "Tomorrow";
    } else if (aDate.isAfter(tomorrow)) {
      print("This Week");
      return "This Week";
    } else if (aDate.isAfter(week)) {
      print("Older");
      return "Older";
    }else{
      print("Older");
      return "Older";
    }
  }


  static void showBottomSheet(context,
      {
        bool? isPadding,
        String? screenTitle,
        bool? showLeadingCrossButton = false,
        bool? isDismissible,
        bool? enableDrag,
        bool? showHeader = true,
        Color? backgroundColor = AppColors.midGrey,
        bool? isScrollControlled,
        bool? showDivider = true,
        VoidCallback? saveTap,
        required Widget widget}) {
    showModalBottomSheet(
        isScrollControlled: isScrollControlled ?? true,
        isDismissible: isDismissible ?? true,
        enableDrag: enableDrag ?? false,
        backgroundColor: backgroundColor,
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.vertical(top: Radius.circular(AppDimen.conRadius),
        // )),
        context: context,
        builder: (BuildContext bc) {
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
                          leadingWidth:100,
                          leading: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Align(
                              alignment: Alignment.centerLeft,
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
                            Center(
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
                          ],
                        ),
                    ),
                    Visibility(
                        visible:showDivider!,
                        child: Divider(thickness: 0.2,)),
                  ],
                ),
                ),

                SafeArea(child: widget),
              ],
            ),
          );
        });
  }

  static void showBottomSheet2(BuildContext context,
      {
        bool? isDismissible,
        bool? enableDrag,
        Color? backgroundColor = AppColors.midGrey,
        bool? isScrollControlled,
        required Widget child,
      }) {

    var media = MediaQuery.of(Get.context!);

    showModalBottomSheet(
        isScrollControlled: isScrollControlled ?? true,
        isDismissible: isDismissible ?? true,
        enableDrag: enableDrag ?? false,
        backgroundColor: backgroundColor,
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.only(top: media.viewPadding.top),
            child: child,
          );
        });
  }

  static void showToast(String body, {bool error = false}) {
    toast.Fluttertoast.showToast(
        msg: body,
        toastLength: toast.Toast.LENGTH_SHORT,
        gravity: toast.ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        // backgroundColor: error?colors.errorColor:colors.success,
        backgroundColor: error ? Colors.red :Colors.black,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  static String getHour(String apiTimeString) {
    final apiDateTime = DateFormat(DateTimeUtil.serverDateTimeFormat).parse(apiTimeString,true).toLocal();
    final now = DateTime.now();
    if (apiDateTime.isBefore(now)) {
      return "0";
    }

    final duration = apiDateTime.difference(now);
    final hours = duration.inHours.remainder(24).abs();

    return "$hours";
  }

  static String getDays(String apiTimeString){
    final apiDateTime = DateFormat(DateTimeUtil.serverDateTimeFormat).parse(apiTimeString,true).toLocal();
    final now = DateTime.now();

    if (apiDateTime.isBefore(now)) {
      return "0";
    }

    final duration = apiDateTime.difference(now);
    final days = duration.inDays.abs();

    return "$days";
  }

  static String getMinutes(String apiTimeString) {
    final apiDateTime = DateFormat(DateTimeUtil.serverDateTimeFormat).parse(apiTimeString,true).toLocal();
    final now = DateTime.now();

    if (apiDateTime.isBefore(now)) {
      return "0";
    }
    final duration = apiDateTime.difference(now);
    final minutes = duration.inMinutes.remainder(60).abs();

    return "$minutes";
  }

  static int isDatePassed(String apiStartTimeString,String apiEndTimeString,) {
    final apiStartDateTime = DateFormat(DateTimeUtil.serverDateTimeFormat).parse(apiStartTimeString,true).toLocal();
    final apiEndDateTime = DateFormat(DateTimeUtil.serverDateTimeFormat).parse(apiEndTimeString,true).toLocal();

    // Get the current time
    final now = DateTime.now();

    // Check if date is ahead of current date
    if (now.isBefore(apiStartDateTime)) {
      return 1;
    } else {
      if (now.isBefore(apiEndDateTime)) {
        return 2;
      } else {
        return 3;
      }
    }
  }

  static void showAlert({required String title, required String subTitle,Function()? onTap}) {
    showOverlayNotification((context) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          child: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    border: Border.all(color: Get.isDarkMode ? AppColors.whiteText.withOpacity(0.2) : Colors.black.withOpacity(0.2), width: 0.5),
                    borderRadius: BorderRadius.circular(5.0)),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: CommonImageView(
                            imagePath: AppImages.imgTick,
                            width: 24,
                            height: 24,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: AppText(
                                  text: title,
                                )
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.66,
                                child: AppText(
                                  text: subTitle,
                                  fontWeight: FontWeight.w400,
                                  fontSize: AppSizer.getFontSize(12),
                                )
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        OverlaySupportEntry.of(context)!.dismiss();
                      },
                      child: CommonImageView(
                        imagePath: AppImages.imgClose,
                        color: AppColors.whiteText,
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ],
                ),
              )),
        ),
      );
    }, duration: const Duration(milliseconds: 3000));

    Timer(const Duration(milliseconds: 3000), () {
      if (onTap != null) {
        onTap();
      }
    });
  }

  static Future<XFile?> compressFile(XFile file) async {
    final filePath = file.path;

    final lastIndex = filePath.split(".");
    print(lastIndex[0]);
    var result = await FlutterImageCompress.compressAndGetFile(
      file.path, "${file.path}.jpg",
      quality: 50,
    );

    print(file.length());

    return result;
  }

  static String decimalPlace(num currency,{int digits=2}){
    return currency.toStringAsFixed(digits);
  }

}

