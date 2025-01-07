
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Utils/Common/sizer.dart';

import '../../Constants/color.dart';
import '../Theme/app_text.dart';

class TimePickerView extends StatelessWidget {
  TimePickerView({
    Key? key,
    this.selectedTime,
    required this.onTimeSelect,
  }) : super(key: key);

  DateTime? selectedTime;
  final void Function(DateTime) onTimeSelect;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
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
                        onTimeSelect(selectedTime ?? DateTime.now());
                        Get.back();
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
            ],
          ),
          SizedBox(
            height: 200,
            width: double.maxFinite,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              initialDateTime: selectedTime,
              onDateTimeChanged: (DateTime dateTime) {
                selectedTime = dateTime;
              },
            ),
          ),
        ],
      ),
    );
  }
}
