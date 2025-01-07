import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Utils/Common/sizer.dart';

import '../../Constants/color.dart';
import '../Theme/app_config.dart';
import '../Theme/app_text.dart';
class CustomSuccessDialog extends StatelessWidget {
  final String image;
  final String title;
  final String? btn;
  final Color? btnColor;
  final VoidCallback? btnCallback;

  CustomSuccessDialog({super.key,
    required this.image,
    required this.title,
    this.btn,
    this.btnColor,
    required this.btnCallback});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(margin: EdgeInsets.only(left: 30,right: 30),

        decoration: BoxDecoration(
            color: AppColors.midGrey,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color:AppColors.midGrey, width: 0.5)),
        height: 320,
        child: Column(
          children: [

            SizedBox(height: 40,),
            Image.asset(
              width:SizeConfig.screenWidth*0.25,
              height:SizeConfig.screenWidth*0.25,
              AppImages.imgSuccess,
            ),
            SizedBox(height: 20,),
            Container(
              child: title.isNotEmpty?Container(
                child: Center(
                  child: AppText(textAlign:TextAlign.center,text: title,fontSize: 24,color: AppColors.whiteText),
                ),
              ):Container(),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: btnCallback,
              child: Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                width: double.maxFinite,
                padding: AppSizer.getPadding(all: 15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0, 1],
                    colors: [
                      AppColors.primary,
                      AppColors.secondary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.topLeft,
                child: Center(
                  child: AppText(
                    text: btn!,
                    height: 1,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
