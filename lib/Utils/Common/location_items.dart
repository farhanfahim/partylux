import 'package:flutter/material.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Utils/Common/icons.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

import '../../Constants/dimens.dart';
import '../../Modules/add_location_picker/model/local_location.dart';

class LocationSearchItem extends StatelessWidget {

  final Prediction location;
  final void Function()? onTap;
  const LocationSearchItem({Key? key,required this.location,this.onTap,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: AppSizer.getVerticalSize(18)),
          child: Row(
            children: [
              CustomMonoIcon(icon: AppImages.icLocation2, size: AppSizer.getVerticalSize(18),
                color: AppColors.primary,isSvg: true,),
              SizedBox(width: AppSizer.getHorizontalSize(7),),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  AppText(text: location.description!,fontSize: AppSizer.getFontSize(12),),
                  AppText(text: "${location.structuredFormatting!.secondaryText!=null?location.structuredFormatting!.secondaryText:"-"}",
                    fontSize: AppSizer.getFontSize(12),fontWeight: FontWeight.w400,
                    color: AppColors.grey4,),
                ],),
              ),
            ],
          ),
        ),
      ),
    ),);
  }
}


class SearchedLocationItem extends StatelessWidget {

  final String mainText;
  final String secondaryText;
  const SearchedLocationItem({Key? key,required this.mainText,required this.secondaryText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double radius=AppSizer.getRadius(8);
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppSizer.getVerticalSize(11),
          horizontal: AppSizer.getHorizontalSize(12)),
      decoration: BoxDecoration(color: AppColors.bottomsheetLogout,
          borderRadius: BorderRadius.circular(radius)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(text: AppStrings.txtYourLocation,color: AppColors.grey4,
            fontSize: AppSizer.getFontSize(14),fontWeight: FontWeight.w400,),
          SizedBox(height: AppSizer.getVerticalSize(12),),
          Row(children: [
            CustomMonoIcon(icon: AppImages.icPickMarker, size: AppSizer.getVerticalSize(17),
              color: AppColors.navBarActiveColor,),
            SizedBox(width: AppSizer.getHorizontalSize(6),),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(text: mainText,fontSize: AppSizer.getFontSize(12),),
                  AppText(text: secondaryText, fontSize: AppSizer.getFontSize(12),fontWeight: FontWeight.w400,
                    color: AppColors.grey4,),
                ],),
            ),
          ],),
        ],
      ),);
  }
}

