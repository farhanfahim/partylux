import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Utils/Common/custom_bottom_sheet.dart';
import 'package:partylux/Utils/Common/custom_time_picker.dart';
import 'package:partylux/Utils/Common/date_picker_view.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Common/time_picker_view.dart';
import 'package:partylux/Utils/Util.dart';
import 'package:partylux/Utils/navigation.dart';
import '../Modules/add_location_picker/model/local_location.dart';

class CommonMethods {
  static void showLocationPicker(void Function(LocalLocation loc) onPick) {
    Get.toNamed(AppRoutes.addLocationPicker)?.then((value) {
      if (value != null) {
        onPick(value);
      }
    });
  }

  static Future<void> copyText(String text) {
    return Clipboard.setData(ClipboardData(text: text));
  }

/*  static Future<T?> showBottomPanel<T>(
    BuildContext context,
    Widget widget,
  ) {
    var media = MediaQuery.of(Get.context!);
    return showModalBottomSheet<T>(
        context: Get.context!,
        backgroundColor: AppColors.transparent,
        enableDrag: false,
        isScrollControlled: true,
        useSafeArea: false,
        //constraints: BoxConstraints.tight(Size.fromHeight(AppSizer.getPerHeight(1))),
        builder: (con) {
          return Padding(
            padding: EdgeInsets.only(top: media.viewPadding.top),
            child: Container(child: widget),
          );
        });
  }*/

  static void showCustomDatePicker(
    BuildContext context, {
    DateTime? selectedDate,
    bool isFromDob = false,
    bool isPrev = true,
    Function(DateTime date)? onDateSelect,
  }) {
    //String formattedCalendarDate = "";
    late DateTime date;

    Util.showBottomSheet(
        context,
        showHeader:false,
        widget:DatePickerView(
          selectedDate: selectedDate,
          onDateSelect: (selectedDate) {
            date = selectedDate;
            onDateSelect?.call(date);
          },
        ));
  }

/*  static void showCustomTimePicker(BuildContext context, {void Function(String time)? onTimeSelect}) {
    String time = "";
    final double radius = AppSizer.getRadius(10);
    Util.showBottomSheet(
      context,
      showHeader: false,
      widget:CustomBottomSheet(
        title: AppStrings.selectTime,
        onDoneTap: () {
          AppNavigator.pop();
          onTimeSelect?.call(time);
        },
        child: Container(
          //  color: AppColor.white2,
          height: AppSizer.getVerticalSize(240),
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSizer.getHorizontalSize(14)),
                  child: Container(
                      height: AppSizer.getVerticalSize(44),
                      decoration: BoxDecoration(
                          color: AppColors.grey5.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(radius))),
                ),
              ),
              Center(
                child: TimePicker(
                  onSelectTime: (t) {
                    time = t;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }*/

  static void showCustomTimePicker2(BuildContext context, {
    DateTime? selectedTime,
    void Function(DateTime time)? onTimeSelect}) {
    Util.showBottomSheet(context,
        showHeader: false,
        widget: TimePickerView(
          selectedTime: selectedTime,
          onTimeSelect: (val){
            onTimeSelect?.call(val);
          },
        ));
  }

  static void vibrate(){
    HapticFeedback.vibrate();
  }
}
