import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Modules/BecomePartner/VIew/Components/upload_bussines_tile.dart';
import 'package:partylux/Modules/BecomePartner/View%20Model/becompartner_vm.dart';
import 'package:partylux/Utils/AppBar/primary_app_bar.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

import '../../../Utils/Theme/app_text.dart';
import 'Components/select_image_tile.dart';

class AddBussinesDetailView extends StatelessWidget {
  AddBussinesDetailView({Key? key}) : super(key: key);

  final _becomePartnerVM = Get.isRegistered<BecomePartnerViewModel>()
      ? Get.find<BecomePartnerViewModel>()
      : Get.put(BecomePartnerViewModel());

  final String isShowArrow = Get.arguments ?? "";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return CustomScaffold(
      isBodyPadding: true,
      body: SizedBox.expand(
        child: Column(
          children: [
            SizedBox(height: SizeConfig.screenHeight * 0.06),
            primaryAppBar(
              context: context,
              title: "Add Business Details",
              subTitle:
                  "Please enter your business details\nImages, Location and type of business.",
              callback: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.03),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  uploadBusinessImages(callback: () {
                    _becomePartnerVM.getEventImage();
                  }),
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                  Align(
                    alignment: Alignment.topLeft,
                    child: AppText(
                      text: "Selected Images",
                      fontSize: 14,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      itemCount: _becomePartnerVM.imagesPathList.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: selectImageTile(
                            context: context,
                            imagePath: _becomePartnerVM.imagesPathList[index],
                            callBack: () {
                              _becomePartnerVM.imagesPathList.removeAt(index);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomBar: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth * 0.05,
          vertical: 10,
        ),
        child: AppButton.mainButton(
          context,
          text: "Next",
          onPressed: () {
            _becomePartnerVM.addBusinessGraphicMethod();
            // _becomePartnerVM.uploadbecomePartner(isShowArrow);
          },
        ),
      ),
    );
  }
}
