import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/BecomePartner/View%20Model/becompartner_vm.dart';
import 'package:partylux/Utils/AppBar/primary_app_bar.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

import '../../../Constants/app_routes.dart';
import '../../../Utils/Text Fields/textfield.dart';
import '../../../Utils/Theme/app_text.dart';

class AddBussinesView extends StatelessWidget {
  AddBussinesView({Key? key}) : super(key: key);

  final _becomePartnerVM = Get.isRegistered<BecomePartnerViewModel>()
      ? Get.find<BecomePartnerViewModel>()
      : Get.put(BecomePartnerViewModel());

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return CustomScaffold(
      isBodyPadding: true,
      showBackBtn: true,
      appBarTitle: "Business Details",
      body: SizedBox.expand(
        child: Column(
          children: [
            SizedBox(height: SizeConfig.screenHeight * 0.01),

            Align(
              alignment: Alignment.centerLeft,
              child: AppText(
                text:
                "Unlock all the party secrets",
                fontSize: SizeConfig.screenWidth * 0.033,
                overflow: TextOverflow.visible,
                color: AppColors.whiteText.withOpacity(0.6),
              ),
            ),
            Expanded(
              child: Form(
                key: _becomePartnerVM.formKey,
                child: Obx(
                  () => ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: [
                      SizedBox(height: SizeConfig.screenHeight * 0.02),
                      AppTextField().commonField(
                        context,
                        hintText: "Business Name",
                        controller: _becomePartnerVM.businessName.value,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.02),
                      AppText(
                        text: "Business Type",
                        fontSize: SizeConfig.screenWidth * 0.034,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: SizeConfig.screenWidth * 0.015),
                      Row(
                        children: [
                          Expanded(
                            child: typeBusinessTile(
                              title: 'Club',
                              isActive:
                                  _becomePartnerVM.businessType.value == "club",
                              onTap: () {
                                _becomePartnerVM.businessType.value = "club";
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: typeBusinessTile(
                              title: 'Bar',
                              isActive:
                                  _becomePartnerVM.businessType.value == "bar",
                              onTap: () {
                                _becomePartnerVM.businessType.value = "bar";
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.02),
                      AppText(
                        text: "Business Description",
                        fontSize: SizeConfig.screenWidth * 0.034,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: SizeConfig.screenWidth * 0.015),
                      AppTextField().commonField(
                        context,
                        isShowLable: false,
                        isCustomHintText: true,
                        hintText: "Describe your business",
                        maxLines: 5,
                        controller: _becomePartnerVM.businessDescription.value,
                        keyboardType: TextInputType.text,
                      ),
                      AppTextField().commonField(
                        context,
                        hintText: "Location",
                        controller: _becomePartnerVM.businessAddress.value,
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.03),

                      // Stack(
                      //   children: [
                      //     GestureDetector(
                      //       onTap: () {
                      //         Get.toNamed(
                      //           AppRoutes.becomePartnerMapView,
                      //           arguments: [
                      //             _becomePartnerVM.currentlat.value,
                      //             _becomePartnerVM.currentlng.value,
                      //           ],
                      //         );
                      //       },
                      //       child: MapTileView(
                      //         Lat: _becomePartnerVM.currentlat.value,
                      //         Lng: _becomePartnerVM.currentlng.value,
                      //       ),
                      //     ),
                      //     Positioned(
                      //       bottom: 15,
                      //       right: 13,
                      //       child: GestureDetector(
                      //         onTap: () {
                      //           Get.toNamed(
                      //             AppRoutes.becomePartnerMapView,
                      //             arguments: [
                      //               _becomePartnerVM.currentlat.value,
                      //               _becomePartnerVM.currentlng.value,
                      //             ],
                      //           );
                      //         },
                      //         child: Container(
                      //           padding: EdgeInsets.all(
                      //               SizeConfig.screenWidth * 0.02),
                      //           decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(6),
                      //             color: AppColors.backgroundColor
                      //                 .withOpacity(0.6),
                      //           ),
                      //           child: Row(
                      //             children: [
                      //               Icon(
                      //                 Icons.menu,
                      //                 size: SizeConfig.screenWidth * 0.06,
                      //                 color: AppColors.whiteText,
                      //               ),
                      //               SizedBox(width: 5),
                      //               AppText(
                      //                 text: "See Map",
                      //                 fontSize: SizeConfig.screenWidth * 0.03,
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      AppText(
                        text: "Select Party Location",
                        fontSize: SizeConfig.screenWidth * 0.034,
                        fontWeight: FontWeight.w400,
                      ),
                      SizedBox(height: SizeConfig.screenWidth * 0.015),
                      GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.becomePartnerMapView,
                              arguments: [
                                _becomePartnerVM.currentlat.value,
                                _becomePartnerVM.currentlng.value,
                              ],
                            );
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
                      Row(
                        children: [
                          Expanded(
                            child: AppTextField().commonField(
                              context,
                              hintText: "Latitude",
                              controller: _becomePartnerVM.businessLat.value,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: AppTextField().commonField(
                              context,
                              hintText: "Longitude",
                              controller: _becomePartnerVM.businessLong.value,
                              keyboardType: TextInputType.text,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
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
            _becomePartnerVM.addbusinessDetailMethod();
          },
        ),
      ),
    );
  }

  Widget typeBusinessTile({
    required String title,
    required bool isActive,
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.whiteText.withOpacity(0.2),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  width: 1.4,
                  color: isActive
                      ? AppColors.primary
                      : AppColors.grey1.withOpacity(0.3),
                ),
              ),
              child: Container(
                height: 25,
                width: 25,
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: isActive
                      ? AppColors.primary
                      : AppColors.grey1.withOpacity(0.3),
                ),
              ),
            ),
            SizedBox(width: 10),
            AppText(
              text: title,
              fontSize: SizeConfig.screenWidth * 0.035,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}
