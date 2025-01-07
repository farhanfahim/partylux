import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/Create%20Module/View%20Model/create_viewmodel.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

import '../../../Constants/app_images.dart';

class SelectCancelationPolicies extends StatelessWidget {
  SelectCancelationPolicies({super.key});

  final _createEventVM = Get.find<CreateViewModel>();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showBackBtn:true,
      appBarTitle: "Cancellation Policy",
      body: SizedBox.expand(
        child: Column(
          children: [

            Align(
              alignment: Alignment.centerLeft,
              child: AppText(
                text:
                    "Here you can set the cancellation duration for a user before the party get start.",
                fontSize: SizeConfig.screenWidth * 0.033,
                overflow: TextOverflow.visible,
                color: AppColors.whiteText.withOpacity(0.6),
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.03),
            Expanded(
              child: Obx(
                () => ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    simpleCheckBox(
                      title: "24 Hours",
                      isActive:
                          _createEventVM.selectCancelPlane.value == '24 hrs',
                      callback: (val) {
                        _createEventVM.selectCancelPlane.value = '24 hrs';
                      },
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.025),
                    simpleCheckBox(
                      title: "48 Hours",
                      isActive:
                          _createEventVM.selectCancelPlane.value == '48 hrs',
                      callback: (val) {
                        _createEventVM.selectCancelPlane.value = '48 hrs';
                      },
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.025),
                    simpleCheckBox(
                      title: "72 Hours",
                      isActive:
                          _createEventVM.selectCancelPlane.value == '72 hrs',
                      callback: (val) {
                        print(val);

                        _createEventVM.selectCancelPlane.value = '72 hrs';
                      },
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.025),
                    simpleCheckBox(
                      title: "Any Time",
                      isActive: _createEventVM.selectCancelPlane.value == 'any',
                      callback: (val) {
                        print(val);

                        _createEventVM.selectCancelPlane.value = 'any';
                      },
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.025),
                    simpleCheckBox(
                      title: "None",
                      isActive:
                          _createEventVM.selectCancelPlane.value == 'none',
                      callback: (val) {
                        _createEventVM.selectCancelPlane.value = 'none';
                      },
                    ),
                  ],
                ),
              ),
            ),
            AppButton.mainButton(
              context,
              text: "Next",
              onPressed: () {
                _createEventVM.selectPartyCancelPolicies();
              },
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }

  Widget simpleCheckBox({
    required String title,
    required bool isActive,
    required Function(String) callback,
  }) {
    return GestureDetector(
      onTap: () {
        callback(title);
      },
      child: Container(
        color: AppColors.transparent,
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: SizeConfig.screenWidth * 0.06,
              width: SizeConfig.screenWidth * 0.06,
              margin: const EdgeInsets.only(right: 10),
              color: AppColors.transparent,
              child: Center(
                child: isActive
                    ? Image.asset(
                        AppImages.imgCheckSelect,
                        height: SizeConfig.screenWidth * 0.06,
                        width: SizeConfig.screenWidth * 0.06,
                      )
                    : Image.asset(
                        AppImages.imgUnCheckSelect,
                        width: (SizeConfig.screenWidth * 0.06) - 2,
                        height: (SizeConfig.screenWidth * 0.06) - 2,
                      ),
              ),
            ),
            AppText(
              text: title,
              fontWeight: FontWeight.w500,
              fontSize: SizeConfig.screenWidth * 0.035,
            ),
          ],
        ),
      ),
    );
  }
}
