import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show ByteData, NetworkAssetBundle, Uint8List, rootBundle;
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Modules/add_location_picker/model/local_location.dart';
import 'dart:math';
import '../../../../Utils/Common/sizer.dart';
import '../../../../Utils/Theme/app_text.dart';
import '../../../../Constants/dimens.dart';
import '../../../Auth Module/Models/usermodel.dart';
import '../../../Home Module/Model/event_model.dart';

class CustomWindowView extends StatelessWidget {
  EventModel? model;
  bool? showAgeLimit;
  UserModel? userModel;
  LocalLocation? location;
  CustomWindowView({this.model,this.showAgeLimit,this.userModel,this.location, super.key,});

  @override
  Widget build(BuildContext context) {
    return  Stack(
      alignment: Alignment.center,
      children: [
        Container(
            margin: AppSizer.getMargin( top:10,bottom: 0,),
            child: Image.asset(AppImages.imgMarkerBg,)),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  text:"Distance",
                  fontWeight: FontWeight.w400,
                  fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                ),
                AppText(
                  text:"${calculateDistance(
                      model!.location!.coordinates![0],
                      model!.location!.coordinates![1],
                      location!.coordinates![0],
                      location!.coordinates![1])} km",
                  fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel18),
                ),
              ],
            ),
            SizedBox(
              width: AppSizer.getHorizontalSize(20),
            ),
            showAgeLimit! ?Column(

              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text:"Age limit",
                  fontWeight: FontWeight.w400,
                  fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                ),
                AppText(
                  text:"${model!.business!.ageLimit!}",
                  fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel18),
                ),
              ],
            ):Container(),
            SizedBox(
              width: showAgeLimit! ?AppSizer.getHorizontalSize(20):0,
            ),
            Column(

              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text:"Fees",
                  fontWeight: FontWeight.w400,
                  fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                ),
                AppText(
                  text:userModel!.profile!.gender!.toLowerCase() == "male"
                      ? model!.maleFee!?"Free":"\$ ${model!.maleAmount!.toInt()}"
                      : model!.femaleFee!?"Free":"\$ ${model!.femaleAmount!.toInt()}",
                  fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel18),

                )
              ],
            )
          ],
        ),
      ],
    );
  }

  String calculateDistance(double startLat, double startLng, double endLat, double endLng) {
    const double earthRadius = 6371; // in kilometers

    // Convert degrees to radians
    double startLatRadians = degreesToRadians(startLat);
    double startLngRadians = degreesToRadians(startLng);
    double endLatRadians = degreesToRadians(endLat);
    double endLngRadians = degreesToRadians(endLng);

    print(startLat);
    print(startLng);
    print(endLat);
    print(endLng);

    // Calculate the change in coordinates
    double latDiff = endLatRadians - startLatRadians;
    double lngDiff = endLngRadians - startLngRadians;

    // Calculate Haversine formula
    double a = pow(sin(latDiff / 2), 2) +
        cos(startLatRadians) * cos(endLatRadians) * pow(sin(lngDiff / 2), 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    return distance.toStringAsFixed(1);
  }

  double degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

}

