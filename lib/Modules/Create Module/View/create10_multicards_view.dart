import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/Create%20Module/View%20Model/create_viewmodel.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';
import '../../../Constants/app_images.dart';
import 'Components/card_tile.dart';

class SelectPartyMultiCard extends StatelessWidget {
  SelectPartyMultiCard({super.key});

  final _createEventVM = Get.find<CreateViewModel>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isTopPadding: SizeConfig.screenHeight * 0.08,
      body: SizedBox.expand(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: SizeConfig.screenWidth * 0.1,
                    height: SizeConfig.screenWidth * 0.1,
                    color: AppColors.transparent,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.whiteText,
                        size: SizeConfig.screenWidth * 0.06,
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  AppImages.imgSimpleLogo,
                  width: SizeConfig.screenWidth / 2.2,
                ),
                Container(
                  width: SizeConfig.screenWidth * 0.1,
                  height: SizeConfig.screenWidth * 0.1,
                )
              ],
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.03),
            Align(
              alignment: Alignment.centerLeft,
              child: AppText(
                text: "ADD Multiple Premium Cards For VIPs",
                fontSize: SizeConfig.screenWidth * 0.038,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.visible,
              ),
            ),
            SizedBox(height: SizeConfig.screenWidth * 0.04),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  padding:
                      EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.1),
                  shrinkWrap: true,
                  itemCount:
                      _createEventVM.createdEventCards.value.cards.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Obx(
                      () => index !=
                              _createEventVM
                                  .createdEventCards.value.cards.length
                          ? CardTile(
                              cardTitle: _createEventVM.createdEventCards.value
                                  .cards[index].vipcardName,
                              cardPrice: _createEventVM
                                  .createdEventCards.value.cards[index].price
                                  .toString(),
                              cardFeatures: _createEventVM.createdEventCards
                                  .value.cards[index].services,
                            )
                          : GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.partyCreatedCard);
                              },
                              child: Container(
                                height: SizeConfig.screenWidth * 0.15,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColors.black54.withOpacity(0.6),
                                ),
                                child: Center(
                                  child: AppText(text: "Add VIP Cards"),
                                ),
                              ),
                            ),
                    );
                  },
                ),
              ),
              //  ListView(
              //   padding: EdgeInsets.zero,
              //   shrinkWrap: true,
              //   children: [
              //     const CardTile(
              //       cardTitle: 'Premium',
              //       cardPrice: '349',
              //       cardFeatures: [
              //         "All in Basic, plus",
              //         "Dance-floor access",
              //         "Free bottle service",
              //         "Unlimited free snacks",
              //         "Dance-floor access",
              //         "Free bottle service",
              //         "Unlimited free snacks",
              //       ],
              //     ),
              //     const CardTile(
              //       cardTitle: 'VIP',
              //       cardPrice: '249',
              //       cardFeatures: [
              //         "All in Basic, plus",
              //         "Dance-floor access",
              //         "Free bottle service",
              //         "Unlimited free snacks",
              //       ],
              //     ),
              //     const CardTile(
              //       cardTitle: 'Basic',
              //       cardPrice: '149',
              //       cardFeatures: [
              //         "All in Basic, plus",
              //         "Dance-floor access",
              //         "Unlimited free snacks",
              //       ],
              //     ),
              //     GestureDetector(
              //       onTap: () {
              //         Get.toNamed(AppRoutes.PARTY_CREATECARD);
              //       },
              //       child: Container(
              //         height: SizeConfig.screenWidth * 0.15,
              //         width: double.infinity,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(15),
              //           color: AppColors.black54.withOpacity(0.6),
              //         ),
              //         child: Center(
              //           child: AppText(text: "Add VIP Cards"),
              //         ),
              //       ),
              //     ),
              //     SizedBox(height: SizeConfig.screenWidth * 0.1),
              //   ],
              // ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.005),
            Obx(
              () => AppButton.mainButton(
                context,
                text: "Done",
                loading: _createEventVM.loadingCardUpload.value,
                onPressed: () {
                  _createEventVM.uploadEventCards();
                },
              ),
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
