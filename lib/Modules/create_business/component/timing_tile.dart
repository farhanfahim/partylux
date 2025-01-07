import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/date_time_util.dart';

import '../../../Constants/app_fonts.dart';
import '../../../Constants/app_images.dart';
import '../../../Utils/Common/custom_rectangle_checkbox.dart';
import '../../../Utils/Common/time_picker_view.dart';
import '../../../Utils/Util.dart';
import '../view_model/create_buisness_vm.dart';

class TimingTile extends StatelessWidget {

  final Weekdays title;
  final RxBool isClose;
  final Function isOpenCallback;
  final Function startCallback;
  final Function endCallback;
  RxString initialStart;
  RxString initialEnd;
  RxBool isSameTimeEnable;
  TimingTile({
    super.key,
    required this.title,
    required this.isClose,
    required this.isOpenCallback,
    required this.startCallback,
    required this.endCallback,
    required this.initialStart,
    required this.initialEnd,
    required this.isSameTimeEnable,
  });


  final _createBusinessVM = Get.put(CreateBusinessViewModel());
  RxBool isSelected = false.obs;
  RxBool close = true.obs;
  RxBool open = false.obs;
  Rx<DateTime> startTime = DateTime.now().obs;
  Rx<DateTime> endTime = DateTime.now().obs;

  @override
  Widget build(BuildContext context) {
    if(initialStart.isNotEmpty){
      startTime.value = DateTime.parse(initialStart.value);
    }
    if(initialEnd.isNotEmpty){
      endTime.value = DateTime.parse(initialEnd.value);
    }
    return Obx(() => AnimatedContainer(
      height: !isSelected.value
          ? 52.0
          : 280.0,
      alignment: Alignment.topCenter,
      duration: const Duration(milliseconds: 300),
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
            padding: EdgeInsets.only(top: 15, bottom: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppText(
                    text: title.name,
                    fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12)
                ),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    if(isSelected.value){
                      isSelected.value = false;
                    }else{
                      isSelected.value = true;
                    }
                  },
                  child: Row(
                    children: [
                      AppText(
                        text: !isClose.value ? "Open" : "Closed",
                        fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                        color:
                        !isClose.value ? AppColors.success : AppColors.error,
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.iconColor,
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
          Divider(
            thickness: 2,
            color: AppColors.whiteText.withOpacity(0.1),
            height: 0,
          ),
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => CustomRectangleCheckbox(
                  selected: isSameTimeEnable.value,
                  onChanged:(v){
                    isSameTimeEnable.value = v;
                    if(isSameTimeEnable.value){
                      for(var item in _createBusinessVM.listOfTiming){
                        open.value = true;
                        item.isClose.value = isClose.value;
                        item.startTime!.value = initialStart.value;
                        item.endTime!.value = initialEnd.value;
                        item.isSameTimeEnable!.value = true;
                        item.startTimeUTC!.value =DateFormat(DateTimeUtil.serverDateTimeFormat3).parse(initialStart.value).toUtc();;
                        item.endTimeUTC!.value = DateFormat(DateTimeUtil.serverDateTimeFormat3).parse(initialEnd.value).toUtc();
                        print( item.startTime!.value);
                        print( item.startTimeUTC!.value);
                      }
                    }


                  })),
              SizedBox(width: 10,),
              RichText(
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: "Select for the same time, ",

                  style: TextStyle(
                    fontFamily: AppFonts.copperPlate,
                    overflow: TextOverflow.visible,
                    color: AppColors.whiteText,
                    fontSize: 14,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: "everyday",
                      style: TextStyle(
                        fontFamily: AppFonts.copperPlate,
                        overflow: TextOverflow.visible,
                        color: AppColors.primaryText,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Obx(() => CustomRectangleCheckbox(
                  selected: !isClose.value,
                  onChanged:(v){
                    if(isClose.value){
                      isClose.value = false;
                    }else{
                      isClose.value = true;
                      initialStart.value = "";
                      initialEnd.value = "";
                    }
                  })),
              SizedBox(width: 10),
              AppText(
                text: "OPEN",
                fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),

              ),
              Spacer(),
              Obx(() => CustomRectangleCheckbox(
                  selected: isClose.value,
                  onChanged:(v){
                    if(isClose.value){
                      isClose.value = false;
                    }else{
                      isClose.value = true;
                      initialStart.value = "";
                      initialEnd.value = "";
                    }

                  })),
              SizedBox(width: 10),
              AppText(
                text: "CLOSE",
                fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),

              ),
              Spacer(),
            ],
          ),
          SizedBox(height: 30),
          Row(
            children: [
              Obx(() => Expanded(
                child: timeSelectorTile(
                  hintText: "Start Time",
                  title: initialStart.toString(),
                  callback: () async {

                    Util.showBottomSheet(
                        context,
                        showHeader:false,
                        widget:TimePickerView(
                          selectedTime: startTime.value ,
                          onTimeSelect: (selectedTime) {

                            print(initialEnd.value);
                            if(selectedTime.isBefore(endTime.value) && initialEnd.value.isNotEmpty){
                              startTime.value = selectedTime;
                              startCallback(startTime);
                              print("if start time ${startTime.value}");
                              print("if end time ${endTime.value}");

                            }else{
                              startTime.value = selectedTime;
                              startCallback(startTime);
                              print("else start time ${startTime.value}");
                              print("else end time ${endTime.value}");
                            }
                          },
                        ));

                  },
                ),
              ),),
              SizedBox(width: 10),
             Obx(() =>  Expanded(
               child: timeSelectorTile(
                 hintText: "End Time",
                 title: initialEnd.toString(),
                 callback: () async {
                   Util.showBottomSheet(
                       context,
                       showHeader:false,
                       widget:TimePickerView(
                         selectedTime: endTime.value ,
                         onTimeSelect: (selectedTime) {

                           if(selectedTime.isAfter(startTime.value)){
                             endTime.value = selectedTime;
                             endCallback(endTime);
                             print("if start time ${startTime.value}");
                             print("if end time ${endTime.value}");

                           }else{
                             endTime.value = selectedTime.add(Duration(days: 1));
                             print("else start time ${startTime.value}");
                             print("else end time ${endTime.value}");
                             endCallback(endTime);
                             endTime.value = selectedTime.add(Duration(days: 0));
                           }
                         },
                       ));
                 },
               ),
             ),)
            ],
          ),
        ],
      ),
    ),);
  }



  Widget timeSelectorTile({
    required String hintText,
    required String title,
    required Function callback,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          text: hintText,
          fontWeight: FontWeight.w400,
          fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
        ),
        SizedBox(height: AppSizer.getVerticalSize(10)),
        GestureDetector(
          onTap: () {
            callback();
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.midGrey
            ),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [

                Image.asset(
                  AppImages.imgTimer,
                  width: AppSizer.getSize(24),
                  height: AppSizer.getSize(24),
                ),


                Spacer(),
                AppText(
                    text: title.isEmpty
                        ? "_ _ : _ _"
                        : DateFormat('h:mm a').format(DateTime.parse(title)),
                    color: AppColors.iconColor,
                    fontWeight: FontWeight.w400,
                    fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14)
                ),
                Spacer(),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.iconColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

