import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

import '../../../../Constants/app_fonts.dart';
import '../../../../Constants/app_routes.dart';
import '../../../../Utils/Common/cechednetworlimage.dart';
import '../../../Profile Module/Profile Section/View Model/profile_vm.dart';

class HomeMainTile extends StatelessWidget {
  final String username;
  HomeMainTile({
    super.key,
    required this.username,
  });


  final _profileVM = Get.find<ProfileViewModel>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [

            GestureDetector(
              onTap: (){
                Get.toNamed(
                    AppRoutes.imageView,
                    arguments: [
                      _profileVM.userProfileData.value.profileImage,]
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: AppSizer.getSize(30),
                  height: AppSizer.getSize(30),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.2),
                    border: Border.all(color: AppColors.primaryText),
                  ),
                  child: cachedNetworkImage(
                    _profileVM.userProfileData.value.profileImage,
                    context: context,
                  ),
                ),
              ),
            ),
            SizedBox(width: 5,),
            Expanded(
              child: AppText(
                text: "Hey, $username!",
                fontFamily: AppFonts.lexendDica,
                fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        SizedBox(height: SizeConfig.screenWidth * 0.02),
        AppText(
          text: "What's the move?",
          fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel24),
          
        ),
        SizedBox(height: SizeConfig.screenWidth * 0.035),
      ],
    );
  }
}
