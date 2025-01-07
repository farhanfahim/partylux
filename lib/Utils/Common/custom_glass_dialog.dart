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

class CustomGlassDialog extends StatelessWidget {
  CustomGlassDialog({super.key,required this.title,required this.firstButtonContent, this.secondButtonContent,required this.firstCallback, this.secondCallback,this.image,this.content,this.showContent});
  final String firstButtonContent;
  final String? secondButtonContent;
  final VoidCallback firstCallback;
  final VoidCallback? secondCallback;
  final String title;
  final String? content;
  final String? image;
  final bool? showContent;

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
          AppColors.female.withOpacity(0.4),
          AppColors.primary.withOpacity(0.4)
        ],
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(image ?? AppImages.imgDelete,height: AppSizer.getVerticalSize(80),),
                SizedBox(height: AppSizer.getVerticalSize(15),),
                secondCallback != null ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: showContent!,
                      child: AppText(
                        text: content??AppStrings.areYouSureYouWantToCancel,
                        fontSize: AppSizer.getFontSize(14),
                        fontFamily: AppFonts.lexendDica,
                        textAlign: TextAlign.center, ),
                    ),
                    AppText(
                      text: title,
                      fontSize: AppSizer.getFontSize(24),
                      textAlign: TextAlign.center,
                      fontWeight: FontWeight.w400,),
                  ],
                ) : Column(
                  children: [
                    AppText(text: title,
                        fontSize: AppSizer.getFontSize(24),
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w400),
                    AppText(text: content!,
                      fontSize: AppSizer.getFontSize(14),
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,),
                  ],
                ),
                SizedBox(height: AppSizer.getVerticalSize(30),),
                secondCallback != null ?
                Row(
                  children: [
                    Expanded(child: CustomButton(label: firstButtonContent, onPressed: firstCallback)),
                    SizedBox(width: AppSizer.getHorizontalSize(15),),
                    Expanded(
                        child: CustomButton(
                            label: secondButtonContent!,
                            color: Colors.white,
                            textColor: Colors.black,
                            onPressed: secondCallback!,
                        )),
                  ],
                ) : CustomButton(label: firstButtonContent, onPressed: firstCallback,fontFamily: AppFonts.copperPlate2,fontSize: 16,)
              ],
            ),
            InkWell(
                onTap: (){
                  Get.back();
                },
                child: Image.asset(AppImages.imgClose,height: AppSizer.getVerticalSize(30),))
          ],
        ),

      ),
    );
  }
}
