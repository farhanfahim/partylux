import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/Profile%20Module/Profile%20Section/View/Components/hobbies_intrests_field.dart';
import 'package:partylux/Modules/create_party/essentials/view_model/essentials_view_model.dart';
import 'package:partylux/Utils/Common/common_image_view.dart';
import 'package:partylux/Utils/Common/custom_textfield.dart';
import 'package:partylux/Utils/Common/icons.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';
import 'package:partylux/Utils/common_methods.dart';

import '../../../Utils/Network/cache_handler.dart';
import '../view_model/enable_location_services_view_model.dart';

class EnableLocatonServicesView extends GetView<EnableLocationServicesViewModel> {
  const EnableLocatonServicesView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final double spacing=AppSizer.getVerticalSize(14);
    return CustomScaffold(
        isBodyPadding: true,
        isVertPadding: true,
        isLeftAlign: true,
        showBackBtn: true,
        appbarColor: AppColors.transparent,
        showLeading: true,
        body: Column(
          children: [
            SizedBox(height: AppSizer.getVerticalSize(25),),
            AppText(text: AppStrings.txtEnableLocationServices,fontSize: AppSizer.getFontSize(28),
              textAlign: TextAlign.center,),
             SizedBox(height: AppSizer.getVerticalSize(25),),
            CommonImageView(imagePath: AppImages.imgEnableLocation,
              height: AppSizer.getVerticalSize(154),
              fit: BoxFit.contain,),
            const Spacer(),
            AppButton.mainButton(
              context,
              fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
              text: AppStrings.txtEnableDeviceLocation,
              onPressed: () {

                controller.onTapEnableLocation();
              },
              textColor: AppColors.black3,
              icon:AppImages.icGps,
            ),
            SizedBox(height: spacing,),
            AppButton.mainButton(
              context,
              fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
              text: AppStrings.txtEnterLocationManually,
              onPressed: () {
                CommonMethods.showLocationPicker((loc) async {
                  await DatabaseHandler().setLocation(loc.toJson());
                });
              },
              textColor: AppColors.navBarActiveColor,
              border: BorderSide(width: 1,color: AppColors.navBarActiveColor),
              buttonColor: AppColors.transparent,
            ),
            SizedBox(height: spacing,),
            AppButton.mainButton(
                context,
              fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                text: AppStrings.txtSetRadius,
                onPressed: () {
                  Get.toNamed(AppRoutes.locationRadius);
                },
              buttonColor: AppColors.transparent,
            ),
            SizedBox(height: AppSizer.getVerticalSize(AppDimen.locBottomPadd),)
          ],
        ));
  }
}
