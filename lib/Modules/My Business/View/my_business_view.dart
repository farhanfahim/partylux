import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import '../../../Constants/app_images.dart';
import '../../../Constants/constants.dart';
import '../../../Constants/strings.dart';
import '../../../Utils/Common/profile_section_tile.dart';
class MyBusinessView extends StatelessWidget {
  MyBusinessView({super.key});


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isBodyPadding: true,
      showBackBtn: true,
      isLeftAlign: false,
      appBarTitle: AppStrings.myBusiness,
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Expanded(
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                children: [

                  ProfileSectionTile(
                    title: AppStrings.clubs,
                    iconPath:AppImages.icProfile,
                    onTap: () {
                      Get.toNamed(AppRoutes.clubView,arguments: [Constants.CATEGORY_CLUB]);
                    },
                  ),

                  ProfileSectionTile(
                    title: AppStrings.bars,
                    iconPath: AppImages.icBusiness,
                    onTap: () {
                      Get.toNamed(AppRoutes.clubView,arguments: [Constants.CATEGORY_BAR]);
                    },
                  ),
                  ProfileSectionTile(
                    title: AppStrings.beach,
                    iconPath: AppImages.icBusiness,
                    onTap: () {
                      Get.toNamed(AppRoutes.clubView,arguments: [Constants.CATEGORY_BEACH]);
                    },
                  ),


                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
