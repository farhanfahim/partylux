import 'dart:io';

import 'package:flutter/material.dart';
import 'package:partylux/Utils/Common/cechednetworlimage.dart';

import '../../../../Constants/color.dart';
import '../../../../Utils/Theme/app_config.dart';
import '../../../../Utils/Theme/app_text.dart';

Widget selectImageTile({
  required BuildContext context,
  required String imagePath,
  required Function callBack,
}) {
  return Container(
    height: SizeConfig.screenHeight / 8.5,
    width: SizeConfig.screenWidth,
    padding: EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: AppColors.whiteText.withOpacity(0.1),
      borderRadius: BorderRadius.circular(7),
    ),
    child: Row(
      children: [
        imagePath.contains("https://")
            ? Container(
                width: SizeConfig.screenWidth / 4,
                height: SizeConfig.screenHeight / 8.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                ),
                child: cachedNetworkImage(
                  imagePath,
                  context: context,
                  borderRadius: 5,
                ),
              )
            : Container(
                width: SizeConfig.screenWidth / 4,
                height: SizeConfig.screenHeight / 8.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: FileImage(File(imagePath)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
        SizedBox(width: 10),
        Expanded(
          child: AppText(
            text: imagePath.split('/').last,
            // imagePath.path.toString(),
            fontSize: SizeConfig.screenWidth * 0.03,
            textAlign: TextAlign.start,
            overflow: TextOverflow.visible,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            callBack();
          },
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: AppColors.whiteText.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.close,
              color: AppColors.whiteText,
            ),
          ),
        ),
      ],
    ),
  );
}
