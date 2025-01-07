import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_fonts.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Utils/Common/custom_button.dart';
import 'package:partylux/Utils/Common/glassmorphic_container.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

class CustomLocationDialog extends StatelessWidget {
  CustomLocationDialog({super.key,this.content,this.onAccept,this.onReject});
  final String? content;
  Function()? onAccept;
  Function()? onReject;


  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: GlassContainer(
        padding: AppSizer.getPadding(left: 16,right: 16,top: 20,bottom: 20),
        gradientColors: [
          AppColors.backgroundColor,
          AppColors.backgroundColor
        ],
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(
                  text: content!,
                  fontSize: AppSizer.getFontSize(14),
                  textAlign: TextAlign.center,
                  fontFamily: AppFonts.lexendDica,
                  fontWeight: FontWeight.w400,),
                SizedBox(height: AppSizer.getHorizontalSize(10),),
                Row(
                  children: [
                    Expanded(child: CustomButton(
                        label: AppStrings.accept,
                        color: Colors.green,
                        textColor: Colors.white,
                        onPressed: onAccept! )),
                    SizedBox(width: AppSizer.getHorizontalSize(15),),
                    Expanded(
                        child: CustomButton(
                          label: AppStrings.reject,
                          color: Colors.redAccent,
                          textColor: Colors.white,
                          onPressed: onReject!,
                        )),
                  ],
                )
              ],
            ),

          ],
        ),

      ),
    );
  }
}
