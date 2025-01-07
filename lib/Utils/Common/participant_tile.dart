import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Utils/Common/cechednetworlimage.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

import '../../Constants/app_routes.dart';
import '../../Modules/people_joined/model/evrnt_participants_model.dart';
import '../../Modules/people_joined/model/participants_model.dart';


class ParticipantsTile extends StatelessWidget {
  final bool isMaleGender;
  final ParticipantsModel data;
  ParticipantsTile({
    super.key,
    required this.isMaleGender,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          AppRoutes.participantsDetailView,
          arguments: [data.sId,data.name],
        );
      },
      child: Container(
        color: AppColors.transparent,
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Get.toNamed(
                    AppRoutes.imageView,
                    arguments: [  data.image,]
                );
              },
              child: Container(
                width:AppSizer.getSize(88),
                height:AppSizer.getSize(88),
                      decoration: BoxDecoration(
                        color: isMaleGender?AppColors.male.withOpacity(0.1):AppColors.female.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: cachedNetworkImage(
                            data.image!,
                            context: context),
                      ),
                    ),
            ),
            SizedBox(height: 10),
            Row(
                    children: [
                      Expanded(
                        child: AppText(
                          text: data.name!,
                          fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
            SizedBox(height: 3),
          ],
        ),
      ),
    );
  }
}
