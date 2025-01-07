import 'package:flutter/material.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

import '../../Constants/color.dart';
import 'common_image_view.dart';

class ChipInTile extends StatelessWidget {
  final Function() onTap;
  final String image,text;
  const ChipInTile({Key? key,required this.image,required this.text,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height=AppSizer.getVerticalSize(41);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(child: Row(children: [
        CommonImageView(
          width: height,height: height,
          imagePath: image,),
        SizedBox(width: AppSizer.getHorizontalSize(10),),
        Expanded(child: AppText(textAlign:TextAlign.center,text: text,fontWeight: FontWeight.w400,fontSize: AppSizer.getFontSize(13),)),
        SizedBox(width: AppSizer.getHorizontalSize(10),),
        GestureDetector(
          onTap: onTap,
          child: CommonImageView(
            width: AppSizer.getSize(30),height:  AppSizer.getSize(30),
            imagePath: AppImages.imgCopy,),
        ),
      ],),),
    );
  }
}
