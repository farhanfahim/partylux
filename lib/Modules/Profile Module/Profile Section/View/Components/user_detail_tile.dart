import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Modules/Profile%20Module/Profile%20Section/View%20Model/profile_vm.dart';
import 'package:partylux/Utils/Common/cechednetworlimage.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Common/switch_button.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

import '../../../../../Constants/app_images.dart';
import '../../../../../Constants/app_routes.dart';
import '../../../../../Constants/color.dart';

class UserDetailTile extends StatelessWidget {
  UserDetailTile({super.key});

  final _profileVM = Get.find<ProfileViewModel>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [


              GestureDetector(
                onTap: (){
                  Get.toNamed(
                    AppRoutes.My_PROFILE,
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: _profileVM.imageSize.value,
                    height: _profileVM.imageSize.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                      border: Border.all(color: AppColors.whiteText,width: 0.5),
                    ),
                    child: cachedNetworkImage(
                      _profileVM.userProfileData.value.profileImage,
                      context: context,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 20),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AppText(
                maxLines: 2,
                overflow:TextOverflow.ellipsis,
                text: _profileVM.userProfileData.value.username!,
                fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel20),

              ),
              Visibility(
                visible:  _profileVM.userProfileData.value.role == "business"?true:false,
                child:  AppText(
                  maxLines: 2,
                  overflow:TextOverflow.ellipsis,
                  text: "Party Lux Business Account",
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryText,
                  fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),

                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
