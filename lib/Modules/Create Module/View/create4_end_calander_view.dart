// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:partylux/Constants/app_routes.dart';
// import 'package:partylux/Constants/color.dart';
// import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
// import 'package:partylux/Utils/Network/tost.dart';
// import 'package:partylux/Utils/Theme/app_config.dart';
// import 'package:partylux/Utils/Theme/app_text.dart';
// import 'package:partylux/Utils/buttons/dg_main_button.dart';

// import '../View_model/create_viewmodel.dart';

// class SelectEndDateAndTime extends StatefulWidget {
//   const SelectEndDateAndTime({super.key});

//   @override
//   State<SelectEndDateAndTime> createState() => _SelectEndDateAndTimeState();
// }

// class _SelectEndDateAndTimeState extends State<SelectEndDateAndTime> {
//   final _createEventVM = Get.find<CreateViewModel>();
//   DateTime currentDate = DateTime.now();
//   var currentdate = "";
//   var selectedDate = "";
//   int selectedindex = 0;

//   /* Event End time */
//   int selectedEndHour = 1;
//   int selectedEndMin = 0;
//   String selectedEndSlot = "AM";

//   List<String> weekDayList = ["MON", "TUS", "WED", "THU", "FRI", "SAT", "SUN"];
//   List<Widget> get daysInMonth {
//     List<Widget> dayWidgets = [];
//     DateTime firstDayOfTheMonth =
//         DateTime(currentDate.year, currentDate.month, 1);
//     int dayOffset = firstDayOfTheMonth.weekday - 1;
//     int totalDays = DateTime(currentDate.year, currentDate.month + 1, 0).day;

//     for (int i = 0; i < dayOffset; i++) {
//       dayWidgets.add(const SizedBox.shrink());
//     }

//     for (int i = 1; i <= totalDays; i++) {
//       var selectvalue =
//           '${currentDate.year}-${DateFormat("MM").format(currentDate)}-${i <= 9 ? "0$i" : i}';
//       currentdate =
//           DateFormat("yyyy-MM-dd").format(DateTime.now()); //dd MMMM yyyy
//       dayWidgets.add(
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               selectedindex = i;
//               selectedDate =
//                   "${currentDate.year}-${DateFormat("MM").format(currentDate)}-${i <= 9 ? "0$i" : i}";
//               //     '$i ${DateFormat.MMMM().format(currentDate)} ${currentDate.year}';
//             });
//           },
//           child: Container(
//             decoration: selectedindex == i
//                 ? BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     gradient: const LinearGradient(
//                       begin: Alignment.topRight,
//                       end: Alignment.bottomLeft,
//                       stops: [0, 1],
//                       colors: [
//                         AppColors.secondary,
//                         AppColors.primary,
//                       ],
//                     ),
//                   )
//                 : BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     color: selectvalue == currentdate
//                         ? AppColors.whiteText.withOpacity(0.3)
//                         : AppColors.transparent,
//                   ),
//             alignment: Alignment.center,
//             width:
//                 (SizeConfig.screenWidth - (SizeConfig.screenWidth * 0.05 * 2)) /
//                     7,
//             height: 20,
//             child: AppText(
//               text: '$i',
//             ),
//           ),
//         ),
//         // ),
//       );
//     }
//     return dayWidgets;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffold(
//       isBGTransparant: false,
//       isShowBackground: true,
//       isTopPadding: SizeConfig.screenHeight * 0.08,
//       body: SizedBox.expand(
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   width: SizeConfig.screenWidth * 0.1,
//                   height: SizeConfig.screenWidth * 0.1,
//                   color: AppColors.transparent,
//                   child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: Icon(
//                       Icons.arrow_back_ios,
//                       color: AppColors.whiteText,
//                       size: SizeConfig.screenWidth * 0.06,
//                     ),
//                   ),
//                 ),
//                 Image.asset(
//                   "assets/app_assets/simplelogo.png",
//                   width: SizeConfig.screenWidth / 2.2,
//                 ),
//                 Container(
//                   width: SizeConfig.screenWidth * 0.1,
//                   height: SizeConfig.screenWidth * 0.1,
//                 )
//               ],
//             ),
//             Expanded(
//               child: ListView(
//                 padding: EdgeInsets.zero,
//                 children: [
//                   SizedBox(height: SizeConfig.screenHeight * 0.03),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: AppText(
//                       text: "Select End Event Date",
//                       fontSize: SizeConfig.screenWidth * 0.05,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   SizedBox(height: SizeConfig.screenHeight * 0.025),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: AppText(
//                       text: "Event Start Date",
//                       fontSize: SizeConfig.screenWidth * 0.04,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   SizedBox(height: SizeConfig.screenHeight * 0.005),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: AppText(
//                       text: DateFormat("EEEE  dd-MMMM-yyyy  hh:mm:ss a").format(
//                         DateTime.parse(
//                           // _createEventVM.eventStartDateTime.value,
//                         ),
//                       ),
//                       fontSize: SizeConfig.screenWidth * 0.04,
//                       fontWeight: FontWeight.w600,
//                       color: AppColors.whiteText.withOpacity(0.7),
//                     ),
//                   ),
//                   SizedBox(height: SizeConfig.screenHeight * 0.025),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           setState(() {
//                             selectedDate = "";
//                             selectedindex = 0;
//                             currentDate = DateTime(
//                                 currentDate.year, currentDate.month - 1);
//                           });
//                         },
//                         splashRadius: 25,
//                         icon: Icon(
//                           Icons.arrow_back_ios,
//                           color: AppColors.whiteText,
//                           size: SizeConfig.screenWidth * 0.05,
//                         ),
//                       ),
//                       AppText(
//                         text:
//                             '${DateFormat.MMMM().format(currentDate)} ${currentDate.year}',
//                         fontSize: SizeConfig.screenWidth * 0.045,
//                         fontWeight: FontWeight.w500,
//                         color: AppColors.iconColor,
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           setState(() {
//                             selectedDate = "";
//                             selectedindex = 0;
//                             currentDate = DateTime(
//                                 currentDate.year, currentDate.month + 1);
//                           });
//                         },
//                         splashRadius: 25,
//                         icon: Icon(
//                           Icons.arrow_forward_ios,
//                           color: AppColors.whiteText,
//                           size: SizeConfig.screenWidth * 0.05,
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: SizeConfig.screenHeight * 0.01),
//                   SizedBox(
//                     height: 30,
//                     width: double.infinity,
//                     child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         padding: EdgeInsets.zero,
//                         itemCount: weekDayList.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return Container(
//                             color: AppColors.transparent,
//                             alignment: Alignment.center,
//                             width: (SizeConfig.screenWidth -
//                                     (SizeConfig.screenWidth * 0.05 * 2)) /
//                                 7,
//                             child: AppText(
//                               text: weekDayList[index],
//                               fontSize: SizeConfig.screenWidth * 0.034,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           );
//                         }),
//                   ),
//                   SizedBox(
//                     height: 300,
//                     width: double.infinity,
//                     child: GridView.count(
//                       physics: NeverScrollableScrollPhysics(),
//                       padding: EdgeInsets.zero,
//                       crossAxisCount: 7,
//                       children: daysInMonth,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: AppText(
//                           text: "Select End Time",
//                           fontSize: SizeConfig.screenWidth * 0.04,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       timeTile(
//                         title: 'Hours',
//                         subtitle: selectedEndHour <= 9
//                             ? '0$selectedEndHour'
//                             : '$selectedEndHour',
//                         onTap: () {
//                           setState(() {
//                             if (selectedEndHour == 12) {
//                               selectedEndHour = 0;
//                             }
//                             selectedEndHour = selectedEndHour + 1;
//                           });
//                         },
//                       ),
//                       timeTile(
//                         title: 'Minutes',
//                         subtitle: selectedEndMin <= 9
//                             ? '0$selectedEndMin'
//                             : '$selectedEndMin',
//                         onTap: () {
//                           setState(() {
//                             int val = selectedEndMin + 5;
//                             if (val == 60) {
//                               selectedEndMin = 0;
//                             } else {
//                               selectedEndMin = val;
//                             }
//                           });
//                         },
//                       ),
//                       timeTile(
//                         title: '',
//                         subtitle: selectedEndSlot,
//                         onTap: () {
//                           setState(() {
//                             if (selectedEndSlot == 'AM') {
//                               selectedEndSlot = 'PM';
//                             } else {
//                               selectedEndSlot = 'AM';
//                             }
//                           });
//                         },
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: SizeConfig.screenHeight * 0.02),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: AppText(
//                       text: "Note",
//                       fontSize: SizeConfig.screenWidth * 0.045,
//                       
//                       color: AppColors.whiteText,
//                     ),
//                   ),
//                   SizedBox(height: SizeConfig.screenHeight * 0.01),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: AppText(
//                       text:
//                           "Just a quick reminder that it's important to set a deadline of at least one month before your event date to finalize all the necessary details. This will ensure that everything runs smoothly and you have enough time to prepare and promote it.",
//                       fontSize: SizeConfig.screenWidth * 0.035,
//                       fontWeight: FontWeight.w500,
//                       textAlign: TextAlign.justify,
//                       color: AppColors.iconColor,
//                       overflow: TextOverflow.visible,
//                     ),
//                   ),
//                   SizedBox(height: SizeConfig.screenHeight * 0.02),
//                   AppButton.mainButton(
//                     context,
//                     text: "Next",
//                     onPressed: () async {
//                       if (selectedDate.isNotEmpty) {
//                         _createEventVM.eventEndDateTime.value =
//                             await formateMethod(
//                           hours: selectedEndHour.toString(),
//                           minutes: selectedEndMin.toString(),
//                           amPm: selectedEndSlot,
//                           date: selectedDate,
//                         );
//                         _createEventVM.selectEndPartyDateTime();
//                       } else {
//                         Toast().error(massage: "Please select party End Date");
//                       }
//                     },
//                   ),
//                   const SizedBox(height: 30)
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget timeTile({
//     required String title,
//     required String subtitle,
//     required Function onTap,
//   }) {
//     return GestureDetector(
//       onTap: () {
//         onTap();
//       },
//       child: Padding(
//         padding: EdgeInsets.only(left: 10),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             title.isNotEmpty
//                 ? AppText(
//                     text: title,
//                     fontSize: SizeConfig.screenWidth * 0.025,
//                     fontWeight: FontWeight.w300,
//                   )
//                 : SizedBox(
//                     height: SizeConfig.screenWidth * 0.035,
//                   ),
//             Container(
//               height: SizeConfig.screenWidth * 0.14,
//               width: SizeConfig.screenWidth * 0.14,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 color: AppColors.whiteText.withOpacity(0.3),
//               ),
//               child: Center(
//                 child: AppText(
//                   text: subtitle,
//                   fontSize: SizeConfig.screenWidth * 0.045,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<String> formateMethod({
//     required String hours,
//     required String minutes,
//     required String amPm,
//     required String date,
//   }) async {
//     String iso8601String = "";
//     // Convert hours to a 24-hour format
//     if (amPm == 'PM') {
//       int hourInt = int.parse(hours);
//       hours = (hourInt + 12).toString();
//     }
//     // Create a DateTime object
//     DateTime dateTime = DateTime.parse(
//         '$selectedDate ${hours.padLeft(2, '0')}:${minutes.padLeft(2, '0')}:00.000');
//     iso8601String = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(dateTime);

//     return iso8601String; // Output: 2023-05-02T10:30:00.000Z
//   }
// }
