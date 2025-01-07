import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/gender_ratios/view_model/gender_ratios_view_model.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/griddelegate.dart';
import '../../Utils/Theme/app_text.dart';
import '../Home Module/View/Components/shimmer_view.dart';
import 'component/participant_tile.dart';


class GenderRatiosView extends  GetView<GenderRatiosViewModel> {
  GenderRatiosView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Obx(() => !controller.isLoading.value? Column(
        children: [

          controller.selectedIndex == 0?Expanded(
            child:  controller.maleList.isNotEmpty?GridView.builder(
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                crossAxisCount: 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                height: SizeConfig.screenWidth * 0.35,
              ),
              padding: EdgeInsets.only(top: 10, bottom: 20),
              itemCount:  controller.maleList.length,
              itemBuilder: (BuildContext context, int index) {
                return ParticipantsTile(
                  isMaleGender: true,
                  data: controller.maleList[index],
                );
              },
            ):Center(
              child: AppText(
                  text: AppStrings.noMaleFound),
            ),
          ):
          Expanded(
            child:  controller.femaleList.isNotEmpty?GridView.builder(
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                crossAxisCount: 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                height: SizeConfig.screenWidth * 0.35,
              ),
              padding: EdgeInsets.only(top: 10, bottom: 20),
              itemCount: controller.femaleList.length,
              itemBuilder: (BuildContext context, int index) {
                return ParticipantsTile(
                  isMaleGender: false,
                  data: controller.femaleList[index],
                );
              },
            ):Center(
              child: AppText(
                  text: AppStrings.noFemaleFound),
            ),
          ),
        ],
      ):viewGenderShimmer(),)
    );
  }
}
