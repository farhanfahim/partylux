import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

class DatePickerView extends StatelessWidget {
  DatePickerView({
    Key? key,
    this.selectedDate,
    this.minDate,
    this.maxDate,
    required this.onDateSelect,
  }) : super(key: key);

  DateTime? selectedDate;
  DateTime? minDate;
  DateTime? maxDate;
  final void Function(DateTime) onDateSelect;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: AppSizer.getPadding(all: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () async {
                    Get.back();
                  },
                  child: AppText(
                    text: "cancel",
                    color: AppColors.iconColor,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ),
                AppText(text:"select date",
                    overflow: TextOverflow.ellipsis,
                    color: AppColors.whiteText,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,),

                GestureDetector(
                  onTap: () async {
                    Get.back();
                    onDateSelect(selectedDate ?? DateTime.now());
                  },
                  child: AppText(
                    text: "done",
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            width: double.maxFinite,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: selectedDate,
              maximumDate: maxDate,
              minimumDate: minDate ?? DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
              onDateTimeChanged: (DateTime newDate) {
                selectedDate = newDate;
              },
            ),
          ),
        ],
      ),
    );
  }
}
