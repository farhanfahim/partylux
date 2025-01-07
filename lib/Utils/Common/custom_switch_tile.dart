import 'package:flutter/material.dart';
import 'package:partylux/Constants/app_fonts.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Common/switch_button.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

import '../../Constants/dimens.dart';

 class customSwitchTile extends StatelessWidget {
   final String title;
   final String content;
   final bool isActive;
   final Widget? widget,downWidget;
   final CrossAxisAlignment crossAxisAlignment;
   final void Function(bool val)? callBack;
   final Color fontColor;
   const customSwitchTile({
     super.key,
     this.title="",
     this.content= "", this.crossAxisAlignment=CrossAxisAlignment.center,
     this.isActive = false,this.widget,this.downWidget,this.fontColor=AppColors.whiteText,
     //required this.callback,
     this.callBack,});

   @override
   Widget build(BuildContext context) {
     return Container(
       width: double.maxFinite,
       alignment: Alignment.center,
       padding: AppSizer.getPadding(all: 15),
       decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(10),
           color: AppColors.white2.withOpacity(0.10),),
       child:  Column(
         children: [
           Row(crossAxisAlignment: crossAxisAlignment,
             children: [
               Expanded(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     AppText(
                       text: title,
                       overflow: TextOverflow.visible,
                       fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
                     ),
                     SizedBox(height: 5,),
                     AppText(
                       text: content,
                       overflow: TextOverflow.visible,
                       fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                       fontWeight: FontWeight.w400,
                       color: fontColor,
                     ),
                   ],
                 ),
               ),
              // SizedBox(width: AppSizer.getHorizontalSize(20),),
               widget??SwitchButton(
                 isActive: isActive,
                  callback: (val){
                    callBack?.call(val);
                  },
              /*   callback: (val) {
                   isActive != isActive;
                 },*/
               ),
             ],
           ),
           downWidget??const SizedBox.shrink(),
         ],
       )
     );
   }
 }

