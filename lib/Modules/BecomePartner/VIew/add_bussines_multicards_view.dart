import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/BecomePartner/View%20Model/becompartner_vm.dart';
import 'package:partylux/Modules/Create%20Module/View/Components/card_tile.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

class AddBusinessMultiCard extends StatelessWidget {
  AddBusinessMultiCard({super.key});

  // final _createEventVM = Get.find<CreateViewModel>();
  final _becomePartnerVM = Get.isRegistered<BecomePartnerViewModel>()
      ? Get.find<BecomePartnerViewModel>()
      : Get.put(BecomePartnerViewModel());

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
                  "assets/app_assets/simplelogo.png",
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
                      _becomePartnerVM.createdEventCards.value.cards.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    return Obx(
                      () => index !=
                              _becomePartnerVM
                                  .createdEventCards.value.cards.length
                          ? CardTile(
                              cardTitle: _becomePartnerVM.createdEventCards
                                  .value.cards[index].vipcardName,
                              cardPrice: _becomePartnerVM
                                  .createdEventCards.value.cards[index].price
                                  .toString(),
                              cardFeatures: _becomePartnerVM.createdEventCards
                                  .value.cards[index].services,
                            )
                          : GestureDetector(
                              onTap: () {
                                Get.toNamed(AppRoutes.addBusinessCreateCard);
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
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.005),
            Obx(
              () => AppButton.mainButton(
                context,
                text: "Done",
                loading: _becomePartnerVM.loadingCardUpload.value,
                onPressed: () {
                  _becomePartnerVM.uploadBusinessCards();
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
