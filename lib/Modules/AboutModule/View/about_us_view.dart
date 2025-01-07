import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Modules/AboutModule/View/Components/about_us_tile.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';

import '../../../Constants/app_images.dart';
import '../../../Constants/app_routes.dart';
import '../../../Constants/color.dart';
import '../../../Constants/dimens.dart';
import '../../../Utils/Theme/app_text.dart';

class AboutView extends StatelessWidget {
  AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return CustomScaffold(
        isBodyPadding: true,
        showBackBtn: true,
        isLeftAlign: true,
        appBarTitle: "About Us",
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: "Here You can get the information about \nthe company and its polices ",
              fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
              fontWeight: FontWeight.w400,
              color: AppColors.iconColor,
              overflow: TextOverflow.visible,
              height: 1,
            ),

            SizedBox(height: SizeConfig.screenHeight * 0.03),

            Column(
              children: [
                aboutUsTile(
                  context: context,
                  title: "Party LUX",
                  image: AppImages.imgInfo,
                  callback: () {
                    Get.toNamed(
                      AppRoutes.customPrivacyView,
                      arguments: ["About Party Lux"],
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                aboutUsTile(
                  context: context,
                  title: "Privacy Policy",
                  image: AppImages.imgPrivacy,
                  callback: () {
                    Get.toNamed(
                      AppRoutes.customPrivacyView,
                      arguments: ["Privacy Policy"],
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                aboutUsTile(
                  context: context,
                  title: "Terms & Conditions",
                  image: AppImages.imgTerms,
                  callback: () {
                    Get.toNamed(
                      AppRoutes.customPrivacyView,
                      arguments: ["Terms & Conditions"],
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                aboutUsTile(
                  context: context,
                  title: "FAQs",
                  image: AppImages.imgFaq,
                  callback: () {
                    Get.toNamed(
                      AppRoutes.faqsView,
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                aboutUsTile(
                  context: context,
                  title: "Support",
                  image: AppImages.imgContact,
                  callback: () {
                    Get.toNamed(
                      AppRoutes.supportView,
                    );
                  },
                ),
              ],
            )
          ],
        ));
  }
}
