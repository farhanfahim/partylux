import 'package:flutter/material.dart';
import 'package:partylux/Constants/app_fonts.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

import '../../Constants/dimens.dart';

 class customTicketButton extends StatelessWidget {
   final double width;
   final String text;
   final Color bgColor;
   final VoidCallback? callback;
   const customTicketButton({
     super.key,
     this.width=double.infinity,
     this.text= "Direction",
     this.bgColor = AppColors.transparent,
     this.callback,});

   @override
   Widget build(BuildContext context) {
     return GestureDetector(
       onTap: callback,
       child: Container(
         height: AppSizer.getVerticalSize(32),
         width: width,
         alignment: Alignment.center,
         decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(5),
             color: bgColor,
             border: Border.all(color: AppColors.whiteText.withOpacity(0.1))),
         child: text == "Expired"
             ? Row(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             AppText(
               text: text,
               fontWeight: FontWeight.w400,
               fontFamily: AppFonts.lexendDica,
               fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
             ),
           ],
         )
             : AppText(
           text: text,
           fontWeight: FontWeight.w400,
           fontFamily: AppFonts.lexendDica,
           fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
         ),
       ),
     );
   }
 }


class scanButton extends StatelessWidget {
  final VoidCallback? callback;
  const scanButton({
    super.key,
    this.callback,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Container(
        height:  AppSizer.getVerticalSize(32),
        decoration: BoxDecoration(
            color: AppColors.greenColor,
            borderRadius: BorderRadius.circular(05),
            border: Border.all(color: AppColors.whiteText.withOpacity(0.1))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/icon_assets/scanner.png'),
              height: 15,
            ),
            SizedBox(
              width: 10,
            ),
            AppText(
              text: "Show Ticket ",
              fontWeight: FontWeight.w400,
              fontFamily: AppFonts.lexendDica,
              fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
            )
          ],
        ),
      ),
    );
  }
}

