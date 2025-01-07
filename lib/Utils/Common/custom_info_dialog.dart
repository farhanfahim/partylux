import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_fonts.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Utils/Common/custom_button.dart';
import 'package:partylux/Utils/Common/glassmorphic_container.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

class CustomInfoDialog extends StatelessWidget {
  const CustomInfoDialog({super.key,this.image,this.content});
  final String? content;
  final String? image;

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
            Container(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(image ?? AppImages.imageInfo,height: AppSizer.getVerticalSize(60),),
                  SizedBox(height: AppSizer.getVerticalSize(15),),
                  AppText(
                    text: content!,
                    fontSize: AppSizer.getFontSize(14),
                    textAlign: TextAlign.center,
                    fontFamily: AppFonts.lexendDica,
                    fontWeight: FontWeight.w400,),
                ],
              ),
            ),
            InkWell(
                onTap: (){
                  Get.back();
                },
                child: Image.asset(AppImages.imgClose,height: AppSizer.getVerticalSize(16),color: AppColors.iconColor,))
          ],
        ),

      ),
    );
  }
}
