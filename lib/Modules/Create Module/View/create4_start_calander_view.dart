import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Network/tost.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

import '../View Model/create_viewmodel.dart';

class SelectStartDateAndTime extends StatefulWidget {
  const SelectStartDateAndTime({super.key});

  @override
  State<SelectStartDateAndTime> createState() => _SelectStartDateAndTimeState();
}

class _SelectStartDateAndTimeState extends State<SelectStartDateAndTime> {
  // String partyType = Get.arguments[0];

  final _createEventVM = Get.find<CreateViewModel>();
  DateTime currentDate = DateTime.now();
  var currentdate = "";
  // int selectedindex = 0;

  List<String> weekDayList = ["MON", "TUS", "WED", "THU", "FRI", "SAT", "SUN"];
  List<Widget> get daysInMonth {
    List<Widget> dayWidgets = [];
    DateTime firstDayOfTheMonth =
        DateTime(currentDate.year, currentDate.month, 1);
    int dayOffset = firstDayOfTheMonth.weekday - 1;
    int totalDays = DateTime(currentDate.year, currentDate.month + 1, 0).day;

    for (int i = 0; i < dayOffset; i++) {
      dayWidgets.add(const SizedBox.shrink());
    }

    for (int i = 1; i <= totalDays; i++) {
      var selectvalue =
          '${currentDate.year}-${DateFormat("MM").format(currentDate)}-${i <= 9 ? "0$i" : i}';
      currentdate =
          DateFormat("yyyy-MM-dd").format(DateTime.now()); //dd MMMM yyyy
      dayWidgets.add(
        GestureDetector(
          onTap: () {
            setState(() {
              _createEventVM.selectedindex.value = i;
              _createEventVM.selectedDate.value =
                  "${currentDate.year}-${DateFormat("MM").format(currentDate)}-${i <= 9 ? "0$i" : i}";
              //     '$i ${DateFormat.MMMM().format(currentDate)} ${currentDate.year}';
            });
          },
          child: Container(
            decoration: _createEventVM.selectedindex.value == i
                ? BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0, 1],
                      colors: [
                        AppColors.secondary,
                        AppColors.primary,
                      ],
                    ),
                  )
                : BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: selectvalue == currentdate
                        ? AppColors.whiteText.withOpacity(0.3)
                        : AppColors.transparent,
                  ),
            alignment: Alignment.center,
            width:
                (SizeConfig.screenWidth - (SizeConfig.screenWidth * 0.05 * 2)) /
                    7,
            height: 20,
            child: AppText(
              text: '$i',
            ),
          ),
        ),
        // ),
      );
    }
    return dayWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showBackBtn:true,
      appBarTitle: "Select Date",
      body: SizedBox.expand(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [

            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _createEventVM.selectedDate.value = "";
                          _createEventVM.selectedindex.value = 0;
                          currentDate =
                              DateTime(currentDate.year, currentDate.month - 1);
                        });
                      },
                      splashRadius: 25,
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.whiteText,
                        size: SizeConfig.screenWidth * 0.05,
                      ),
                    ),
                    AppText(
                      text:
                          '${DateFormat.MMMM().format(currentDate)} ${currentDate.year}',
                      fontSize: SizeConfig.screenWidth * 0.045,
                      fontWeight: FontWeight.w500,
                      color: AppColors.whiteText,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _createEventVM.selectedDate.value = "";
                          _createEventVM.selectedindex.value = 0;
                          currentDate =
                              DateTime(currentDate.year, currentDate.month + 1);
                        });
                      },
                      splashRadius: 25,
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.whiteText,
                        size: SizeConfig.screenWidth * 0.05,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                SizedBox(
                  height: 30,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.zero,
                    itemCount: weekDayList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        color: AppColors.transparent,
                        alignment: Alignment.center,
                        width: (SizeConfig.screenWidth -
                                (SizeConfig.screenWidth * 0.05 * 2)) /
                            7,
                        child: AppText(
                          text: weekDayList[index],
                          fontSize: SizeConfig.screenWidth * 0.034,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 280,
                  width: double.infinity,
                  child: GridView.count(
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 7,
                    children: daysInMonth,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Expanded(
                  child: AppText(
                    text: "Select Start Time",
                    fontSize: SizeConfig.screenWidth * 0.04,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                timeTile(
                  title: 'Hours',
                  subtitle: _createEventVM.selectedStartHour.value <= 9
                      ? '0${_createEventVM.selectedStartHour.value}'
                      : '${_createEventVM.selectedStartHour.value}',
                  onTap: () {
                    setState(() {
                      if (_createEventVM.selectedStartHour.value == 12) {
                        _createEventVM.selectedStartHour.value = 0;
                      }
                      _createEventVM.selectedStartHour.value =
                          _createEventVM.selectedStartHour.value + 1;
                    });
                  },
                ),
                timeTile(
                  title: 'Minutes',
                  subtitle: _createEventVM.selectedStartMin.value <= 9
                      ? '0${_createEventVM.selectedStartMin.value}'
                      : '${_createEventVM.selectedStartMin.value}',
                  onTap: () {
                    setState(() {
                      int val = _createEventVM.selectedStartMin.value + 5;
                      if (val == 60) {
                        _createEventVM.selectedStartMin.value = 0;
                      } else {
                        _createEventVM.selectedStartMin.value = val;
                      }
                    });
                  },
                ),
                timeTile(
                  title: '',
                  subtitle: _createEventVM.selectedStartSlot.value,
                  onTap: () {
                    setState(() {
                      if (_createEventVM.selectedStartSlot.value == 'AM') {
                        _createEventVM.selectedStartSlot.value = 'PM';
                      } else {
                        _createEventVM.selectedStartSlot.value = 'AM';
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: AppText(
                    text: "Select End Time",
                    fontSize: SizeConfig.screenWidth * 0.04,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                timeTile(
                  title: 'Hours',
                  subtitle: _createEventVM.selectedEndHour.value <= 9
                      ? '0${_createEventVM.selectedEndHour.value}'
                      : '${_createEventVM.selectedEndHour.value}',
                  onTap: () {
                    setState(() {
                      if (_createEventVM.selectedEndHour.value == 12) {
                        _createEventVM.selectedEndHour.value = 0;
                      }
                      _createEventVM.selectedEndHour.value =
                          _createEventVM.selectedEndHour.value + 1;
                    });
                  },
                ),
                timeTile(
                  title: 'Minutes',
                  subtitle: _createEventVM.selectedEndMin.value <= 9
                      ? '0${_createEventVM.selectedEndMin.value}'
                      : '${_createEventVM.selectedEndMin.value}',
                  onTap: () {
                    setState(() {
                      int val = _createEventVM.selectedEndMin.value + 5;
                      if (val == 60) {
                        _createEventVM.selectedEndMin.value = 0;
                      } else {
                        _createEventVM.selectedEndMin.value = val;
                      }
                    });
                  },
                ),
                timeTile(
                  title: '',
                  subtitle: _createEventVM.selectedEndSlot.value,
                  onTap: () {
                    setState(() {
                      if (_createEventVM.selectedEndSlot.value == 'AM') {
                        _createEventVM.selectedEndSlot.value = 'PM';
                      } else {
                        _createEventVM.selectedEndSlot.value = 'AM';
                      }
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.02),
            Align(
              alignment: Alignment.centerLeft,
              child: AppText(
                text: "Note",
                fontSize: SizeConfig.screenWidth * 0.045,
                
                color: AppColors.whiteText,
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.01),
            Align(
              alignment: Alignment.centerLeft,
              child: AppText(
                text:
                    "Just a quick reminder that it's important to set a deadline of at least one month before your event date to finalize all the necessary details. This will ensure that everything runs smoothly and you have enough time to prepare and promote it.",
                fontSize: SizeConfig.screenWidth * 0.035,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.justify,
                color: AppColors.iconColor,
                overflow: TextOverflow.visible,
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.05),
            AppButton.mainButton(
              context,
              text: "Next",
              onPressed: () async {
                print(
                    "selectedStartHour ${_createEventVM.selectedStartHour.value}");
                print(
                    "selectedStartMin ${_createEventVM.selectedStartMin.value}");
                print(
                    "selectedStartSlot ${_createEventVM.selectedStartSlot.value}");
                print("selectedDate ${_createEventVM.selectedDate.value}");

                if (_createEventVM.selectedDate.value.isNotEmpty) {
                  _createEventVM.startTime.value = await formateMethod(
                    hours: _createEventVM.selectedStartHour.value.toString(),
                    minutes: _createEventVM.selectedStartMin.value.toString(),
                    amPm: _createEventVM.selectedStartSlot.value,
                    date: _createEventVM.selectedDate.value,
                  );
                  _createEventVM.endTime.value = await formateMethod(
                    hours: _createEventVM.selectedEndHour.value.toString(),
                    minutes: _createEventVM.selectedEndMin.value.toString(),
                    amPm: _createEventVM.selectedEndSlot.value,
                    date: _createEventVM.selectedDate.value,
                  );

                  Duration duration =
                      DateTime.parse(_createEventVM.endTime.value).difference(
                    DateTime.parse(_createEventVM.startTime.value),
                  );
                  print(duration.inHours);
                  if(DateTime.parse(_createEventVM.endTime.value).isAfter(DateTime.parse(_createEventVM.startTime.value))){
                    if (duration.inHours >= 3) {
                      DateFormat inputFormat = DateFormat('yyyy-M-d');
                      DateTime checkedTime= inputFormat.parse(_createEventVM.selectedDate.value);
                      DateTime currentTime= DateTime.now();

                      if(checkedTime.day == currentTime.day){
                        _createEventVM.selectStartPartyDateTime();
                      }else{
                        if(checkedTime.isAfter(currentTime)){
                          _createEventVM.selectStartPartyDateTime();
                        }else{
                          Toast().error(massage: "Please select future date");
                        }
                      }
                    } else {
                      Toast().error(massage: "Please select minimum 3 hours");
                    }
                  }else{
                    Toast().error(massage: "End time should greater than Start time");
                  }

                } else {
                  Toast().error(massage: "Please select Event Date");
                }
              },
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }

  String capitalizeFirstLetter(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  Widget timeTile({
    required String title,
    required String subtitle,
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: EdgeInsets.only(left: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            title.isNotEmpty
                ? AppText(
                    text: title,
                    fontSize: SizeConfig.screenWidth * 0.03,
                    fontWeight: FontWeight.w500,
                  )
                : SizedBox(
                    height: SizeConfig.screenWidth * 0.035,
                  ),
            Container(
              height: SizeConfig.screenWidth * 0.14,
              width: SizeConfig.screenWidth * 0.14,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.whiteText.withOpacity(0.3),
              ),
              child: Center(
                child: AppText(
                  text: subtitle,
                  fontSize: SizeConfig.screenWidth * 0.045,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> formateMethod({
    required String hours,
    required String minutes,
    required String amPm,
    required String date,
  }) async {
    // Convert hours to a 24-hour format
    if (amPm == 'PM') {
      int hourInt = int.parse(hours);
      hours = (hourInt + 12).toString();
    }

    // Adjust the format pattern to match the actual format
    DateFormat inputFormat = DateFormat('yyyy-M-d HH:mm:ss.SSS');

    // Create a DateTime object
    DateTime dateTime = inputFormat.parse(
        '${_createEventVM.selectedDate.value} ${hours.padLeft(2, '0')}:${minutes.padLeft(2, '0')}:00.000');

    String iso8601String =
        DateFormat('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'').format(dateTime);

    return iso8601String; // Output: 2023-05-02T10:30:00.000Z
  }
}
