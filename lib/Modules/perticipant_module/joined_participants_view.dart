import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/perticipant_module/view_model/participants_view_model.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/griddelegate.dart';

import '../../Constants/color.dart';
import '../../Utils/Common/sizer.dart';
import '../../Utils/Theme/app_text.dart';
import '../gender_ratios/component/participant_tile.dart';
class JoinedParticipantsView extends GetView<ParticipantsViewModel> {
  JoinedParticipantsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


        SizedBox(height: AppSizer.getVerticalSize(10)),

        Obx(() => !controller.isLoading.value?Expanded(
          child: controller.orderModel.isNotEmpty?GridView.builder(
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
              crossAxisCount: 3,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              height: SizeConfig.screenWidth * 0.35,
            ),
            padding: EdgeInsets.only(top: 10, bottom: 20),
            itemCount: controller.orderModel.length,
            itemBuilder: (BuildContext context, int index) {
              return ParticipantsTile(
                  isMaleGender:controller.orderModel[index].gender=="male"?true:false,
                  data: controller.orderModel[index]
              );
            },
          ):Center(
            child: AppText(
                text: AppStrings.noRecordFound),
          ),
        ):Center(
          child: CupertinoActivityIndicator(
              radius: 20,
              color: AppColors.primary
          ),
        ),)
      ],
    );
  }
}
