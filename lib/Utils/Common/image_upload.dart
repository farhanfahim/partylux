import 'dart:io';

import 'package:flutter/material.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Utils/Common/common_image_view.dart';
import 'package:partylux/Utils/Common/custom_dotted_container.dart';
import 'package:partylux/Utils/Common/icons.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/models/media.dart';

class ImageUploadContainer extends StatelessWidget {

  final bool isCover;
  final String icon,text;
  final void Function()? onTap;
  final Media? image;
  const ImageUploadContainer({Key? key,required this.text,this.isCover = false,this.icon=AppImages.icGalleryUpload,
    this.onTap,this.image,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double iconsize=AppSizer.getVerticalSize(26);
    final double radius=AppSizer.getRadius(AppDimen.textFieldRadius);
    return GestureDetector(
      onTap: onTap,behavior: HitTestBehavior.opaque,
      child: CustomDottedContainer(
        color: AppColors.iconColor,
        radius: radius,
        child: Container(
          width: double.infinity,
          height: AppSizer.getVerticalSize(isCover?AppDimen.descriptionFieldCoverHeight:AppDimen.descriptionFieldHeight),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius),
            color: AppColors.feildBGColor.withOpacity(0.10),),
       //   padding: EdgeInsets.symmetric(vertical: AppSizer.getVerticalSize(41)),
          child: (image!=null && image!.value.isNotEmpty)?ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: CommonImageView(
              file: image!.imageType==ImageType.TYPE_FILE?File(image!.value):null,
              url: image!.imageType==ImageType.TYPE_NETWORK?image!.value:null,
              fit: BoxFit.cover,),)
              :Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
          CustomMonoIcon(icon: icon, size: iconsize,color: AppColors.iconColor,),
          SizedBox(height: AppSizer.getVerticalSize(6),),
          AppText(text: text,fontSize: AppSizer.getFontSize(12),color: AppColors.iconColor,textAlign: TextAlign.center,),
        ],),),
      ),
    );
  }
}
