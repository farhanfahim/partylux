import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/Create%20Module/View%20Model/create_viewmodel.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Text%20Fields/textfield.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

class SelectLocation extends StatelessWidget {
  SelectLocation({super.key});

  final _createEventVM = Get.find<CreateViewModel>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return CustomScaffold(
      showBackBtn:true,
      appBarTitle: "Party Location",
      body: Column(
        children: [

          Obx(
            () => Expanded(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: [
                  // AppText(
                  //   text: "Party Location",
                  //   fontSize: SizeConfig.screenWidth * 0.05,
                  //   fontWeight: FontWeight.w600,
                  // ),
                  // SizedBox(height: 10),
                  AppText(
                    text:
                        "Please enter your event Location for user to find party easily.",
                    fontSize: SizeConfig.screenWidth * 0.033,
                    overflow: TextOverflow.visible,
                    color: AppColors.whiteText.withOpacity(0.6),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.015),
                  AppTextField().commonField(
                    context,
                    hintText: "Location",
                    readOnly: true,
                    controller: _createEventVM.placeName.value,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.035),
                  AppText(
                    text: "Select Party Location",
                    fontSize: SizeConfig.screenWidth * 0.034,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: SizeConfig.screenWidth * 0.015),
                  GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.SELECT_LOCATION_ON_MAP);
                      },
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.transparent,
                          image: DecorationImage(
                            image: AssetImage(
                              "assets/icon_assets/mapviewimage.jpeg",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                      //MapViewCard(),
                      ),
                  SizedBox(height: SizeConfig.screenHeight * 0.015),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextField().commonField(
                          context,
                          hintText: "Latitude",
                          readOnly: true,
                          controller: _createEventVM.placeLat.value,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: AppTextField().commonField(
                          context,
                          hintText: "Longitude",
                          readOnly: true,
                          controller: _createEventVM.placeLong.value,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: !_createEventVM.isKeyboard.value,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: AppButton.mainButton(
                  context,
                  text: "Next",
                  onPressed: () {
                    _createEventVM.selectedPartyLocation();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
