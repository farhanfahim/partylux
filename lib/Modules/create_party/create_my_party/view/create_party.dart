import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/create_party/create_my_party/view_model/create_party_view_model.dart';
import 'package:partylux/Utils/Common/common_image_view.dart';
import 'package:partylux/Utils/Common/custom_tab_bar.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/Util.dart';

import '../../../../Utils/Common/custom_alert_dialog.dart';

class CreatePartyView extends GetView<CreatePartyViewModel> {
  const CreatePartyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        isBodyPadding: true,
        isVertPadding: true,
        isLeftAlign: false,
        appBarTitle: AppStrings.txtCreateParty,
        showBackBtn: true,
        onBackPressed: (){
          showDialog(
              context: context,
              builder: (ct) {
                return CustomAlertDialog(
                  title: "Alert",
                  content: AppStrings.areYouSureYouWantToBackout,
                  firstButtonContent: "No",
                  secondButtonContent:"Yes",
                  first: () {
                    Get.back();
                  },
                  second: () async {
                    Get.back();
                    Get.back();
                  },
                );
              });

        },
        appbarColor: AppColors.midGrey,
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: AppSizer.getVerticalSize(13),
            ),
            CommonImageView(
              imagePath: AppImages.imgSimpleLogo,

              height: AppSizer.getVerticalSize(24),
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: AppSizer.getVerticalSize(13),
            ),
            AppText(
              text: AppStrings.throwOwnParty,
              textAlign: TextAlign.center,
              fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel20),
            ),
            SizedBox(height: AppSizer.getVerticalSize(15),),
            CustomTabBar(
                controller: controller.tabController,
                items: List.generate(controller.screens.length, (index) {
                  return CustomTabBarItem(
                    title: controller.titles[index],
                  );
                }),
                height: AppSizer.getVerticalSize(AppDimen.tabbarHeight)),
            Expanded(
                child: TabBarView(
              controller: controller.tabController,
              children: controller.screens,
            ))
          ],
        ));
  }
}
