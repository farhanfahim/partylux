import 'package:flutter/material.dart';
import 'package:partylux/Constants/color.dart';

import '../../../../Utils/Theme/app_config.dart';
import '../../../../Utils/Theme/app_text.dart';

Widget uploadBusinessImages({VoidCallback? callback}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      AppText(
        text: "Upload Business Images",
        fontSize: 14,
        textAlign: TextAlign.center,
        overflow: TextOverflow.clip,
        fontWeight: FontWeight.w600,
      ),
      SizedBox(
        height: 8,
      ),
      InkWell(
        onTap: callback,
        child: Container(
          height: SizeConfig.screenHeight / 5,
          width: SizeConfig.screenWidth,
          decoration: BoxDecoration(
            color: AppColors.whiteText.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage("assets/icon_assets/share.png"),
                height: 30,
              ),
              SizedBox(
                height: 5,
              ),
              AppText(
                text: "Attachment ",
                fontSize: 14,
                height: 1.4,
                textAlign: TextAlign.center,
                overflow: TextOverflow.clip,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ),
      )
    ],
  );
}
