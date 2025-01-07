import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Theme/app_config.dart';

class PhotoPopUpSheet extends StatelessWidget {
  final Function callback;
  bool isShowVideo = false;
  PhotoPopUpSheet({super.key, required this.callback,this.isShowVideo = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      padding: EdgeInsets.all(SizeConfig.screenWidth * 0.05),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select action',
            style: TextStyle(
              color: AppColors.whiteText,
              fontSize: SizeConfig.screenWidth * 0.033,
              fontWeight: FontWeight.w500,
            ),
          ),

          SizedBox(height: 10),
          Divider(color: AppColors.whiteText,),
          GestureDetector(
            onTap: () {
              callback("take");
            },
            child: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Text(
                    'Take a Picture',
                    style: TextStyle(
                      color: AppColors.whiteText,
                      fontSize: SizeConfig.screenWidth * 0.033,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              callback("photo");
            },
            child: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Text(
                    'Upload a picture',
                    style: TextStyle(
                      color: AppColors.whiteText,
                      fontSize: SizeConfig.screenWidth * 0.033,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(visible:isShowVideo,child: GestureDetector(
            onTap: () {
              callback("video");
            },
            child: Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Text(
                    'Upload a Video',
                    style: TextStyle(
                      color: AppColors.whiteText,
                      fontSize: SizeConfig.screenWidth * 0.033,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),),
          SizedBox(height: 10,)
        ],
      ),
    );
  }
}
