import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/BecomePartner/VIew/add_business_timing.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

class TimingTile extends StatefulWidget {
  final Weekdays titile;
  final bool isClose;
  final Function isOpenCallback;
  final Function startCallback;
  final Function endCallback;
  final String initialStart;
  final String initialEnd;
  TimingTile({
    super.key,
    required this.titile,
    required this.isClose,
    required this.isOpenCallback,
    required this.startCallback,
    required this.endCallback,
    required this.initialStart,
    required this.initialEnd,
  });

  @override
  State<TimingTile> createState() => _TimingTileState();
}

class _TimingTileState extends State<TimingTile> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // isSelected.value = true;
        // isSelected.refresh();
        setState(() {
          isSelected = true;
        });
      },
      child: AnimatedContainer(
        height: !isSelected
            ? 52.0
            : widget.isClose
                ? 115.0
                : 210.0,
        // widget.isClose
        //     ? 115
        //     : isSelected
        //         ? 210.0
        //         : 52.0,
        alignment: Alignment.topCenter,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        margin: EdgeInsets.only(top: 20),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.whiteText.withOpacity(0.1),
        ),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.only(top: 18, bottom: 11),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: widget.titile.name,
                    fontSize: SizeConfig.screenWidth * 0.036,
                    fontWeight: FontWeight.w500,
                  ),
                  Spacer(),
                  AppText(
                    text: !widget.isClose ? "Open" : "Close",
                    fontSize: SizeConfig.screenWidth * 0.032,
                    fontWeight: FontWeight.w500,
                    color:
                        !widget.isClose ? AppColors.success : AppColors.error,
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.whiteText,
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 2,
              color: AppColors.whiteText.withOpacity(0.1),
              height: 0,
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      widget.isOpenCallback(false);
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: !widget.isClose
                            ? AppColors.whiteText.withOpacity(0.3)
                            : AppColors.whiteText.withOpacity(0.1),
                      ),
                      child: Center(
                        child: AppText(
                          text: "Open",
                          fontSize: SizeConfig.screenWidth * 0.03,
                          
                          color: AppColors.success,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      widget.isOpenCallback(true);
                    },
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: !widget.isClose
                            ? AppColors.whiteText.withOpacity(0.1)
                            : AppColors.whiteText.withOpacity(0.3),
                      ),
                      child: Center(
                        child: AppText(
                          text: "Close",
                          fontSize: SizeConfig.screenWidth * 0.03,
                          
                          color: AppColors.error,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: timeSelecterTile(
                    hintText: "Start Time",
                    title: widget.initialStart,
                    callback: () async {
                      datepicker(
                        callback: (DateTime val) {
                          widget.startCallback(val);
                        },
                      );
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: timeSelecterTile(
                    hintText: "End Time",
                    title: widget.initialEnd,
                    callback: () async {
                      datepicker(
                        callback: (DateTime val) {
                          widget.endCallback(val);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void datepicker({
    required Function callback,
  }) async {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          height: 265,
          padding: const EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
            ),
            color: AppColors.black54,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: AppText(
                  text: "Select Time",
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 216,
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    brightness: Brightness.dark,
                  ),
                  child: CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                    mode: CupertinoDatePickerMode.time,
                    use24hFormat: false,
                    onDateTimeChanged: (DateTime newTime) {
                      callback(newTime);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget timeSelecterTile({
    required String hintText,
    required String title,
    required Function callback,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: hintText,
          fontSize: SizeConfig.screenWidth * 0.034,
          fontWeight: FontWeight.w600,
        ),
        SizedBox(height: SizeConfig.screenWidth * 0.015),
        GestureDetector(
          onTap: () {
            callback();
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.whiteText.withOpacity(0.1),
            ),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Icon(
                  Icons.access_time_filled_rounded,
                  color: AppColors.whiteText,
                ),
                SizedBox(width: 5),
                AppText(
                  text: title.isEmpty
                      ? "__ : __"
                      : DateFormat('h:mm a').format(DateTime.parse(title)),
                  fontSize: SizeConfig.screenWidth * 0.034,
                ),
                Spacer(),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.whiteText,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
