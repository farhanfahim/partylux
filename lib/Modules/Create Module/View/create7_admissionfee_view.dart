import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/Create%20Module/View%20Model/create_viewmodel.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Text%20Fields/textfield.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';
import 'package:partylux/Utils/extensions.dart';

import '../../../Constants/app_images.dart';
import 'Components/private_party_tile.dart';

class SelectAdmissionFee extends StatelessWidget {
  SelectAdmissionFee({super.key});
  final _createEventVM = Get.find<CreateViewModel>();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showBackBtn:true,
      appBarTitle: "Admission Fee",
      body: SizedBox.expand(
        child: Column(
          children: [

            Align(
              alignment: Alignment.centerLeft,
              child: AppText(
                text:
                    "Here you can set the Admission fee for your party for both Male and female",
                fontSize: SizeConfig.screenWidth * 0.033,
                overflow: TextOverflow.visible,
                color: AppColors.whiteText.withOpacity(0.6),
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.03),
            (_createEventVM.eventType.value == "public")
                ? Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        AdmissionFeeTile(
                          lable: "Male",
                          lableColor: AppColors.male,
                          controller: _createEventVM.maleAmount.value,
                          callback: (v) {
                            print(v);

                            _createEventVM.isMaleFree.value = v;
                            if(v){
                              _createEventVM.maleAmount.value.text = "";
                            }
                          },
                        ),
                        AdmissionFeeTile(
                          lable: "Female",
                          lableColor: AppColors.female,
                          controller: _createEventVM.femaleAmount.value,
                          callback: (v) {
                            print(v);
                            _createEventVM.isFemaleFree.value = v;
                            if(v){
                              _createEventVM.femaleAmount.value.text = "";
                            }
                          },
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: Obx(
                      () => ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: 20),
                        // physics: const NeverScrollableScrollPhysics(),
                        children: [
                          PrivateAdmissionFeeTile(
                            isFreeParty: _createEventVM.isFreeParty.value,
                            controller: _createEventVM.privatePartyPrice.value,
                            callback: (bool val) {
                              print("object $val");
                              _createEventVM.isFreeParty.value = val;
                            },
                          ),

                          30.ph,
                          PrivateDiscountAdmissionFeeTile(
                            isFreeDiscount: _createEventVM.isFreeDiscount.value,
                            controller: _createEventVM.partyDiscountPrice.value,
                            callback: (bool val) {
                              _createEventVM.isFreeDiscount.value = val;
                            }, // _createEventVM.discountAmount.value,
                          ),
                        ],
                      ),
                    ),
                  ),
            // AppButton.mainButton(
            //   context,
            //   text: "Next",
            //   onPressed: () {
            //     _createEventVM.selectPartyAdmissionFee();
            //   },
            // ),
            // const SizedBox(height: 30)
          ],
        ),
      ),
      bottomBar: Container(
        height: 70,
        margin: EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.05),
        width: double.infinity,
        child: Column(children: [
          AppButton.mainButton(
            context,
            text: "Next",
            onPressed: () {
              print("next");
              _createEventVM.selectPartyAdmissionFee();
            },
          ),
        ]),
      ),
    );
  }
}

class AdmissionFeeTile extends StatelessWidget {
  final Function callback;
  final TextEditingController? controller;
  final String lable;
  final Color lableColor;
  AdmissionFeeTile({
    super.key,
    required this.callback,
    this.controller,
    required this.lable,
    required this.lableColor,
  });

 final RxBool isFreeActive = true.obs;
  @override
  Widget build(BuildContext context) {
    isFreeActive.value = controller!.text.isNotEmpty?false:true;
    return Obx(
      () => Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: AppText(
              text: lable,
              fontSize: SizeConfig.screenWidth * 0.04,
              fontWeight: FontWeight.w600,
              color: lableColor,
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.002),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  isFreeActive.value = true;
                  callback(isFreeActive.value);
                },
                child: Container(
                  color: AppColors.transparent,
                  child: Row(
                    children: [
                      Container(
                        height: SizeConfig.screenWidth * 0.06,
                        width: SizeConfig.screenWidth * 0.06,
                        margin: EdgeInsets.only(
                            right: 10, top: SizeConfig.screenWidth * 0.06),
                        color: AppColors.transparent,
                        child: Center(
                          child: isFreeActive.value
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
                      SizedBox(width: SizeConfig.screenWidth * 0.05),
                      Padding(
                        padding:
                            EdgeInsets.only(top: SizeConfig.screenWidth * 0.06),
                        child: AppText(
                          text: "Free",
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.screenWidth * 0.035,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: SizeConfig.screenWidth * 0.12),
              GestureDetector(
                onTap: () {
                  isFreeActive.value = false;
                  callback(isFreeActive.value);
                },
                child: Container(
                  color: AppColors.transparent,
                  child: Row(
                    children: [
                      Container(
                        height: SizeConfig.screenWidth * 0.06,
                        width: SizeConfig.screenWidth * 0.06,
                        margin: EdgeInsets.only(
                            right: 10, top: SizeConfig.screenWidth * 0.06),
                        color: AppColors.transparent,
                        child: Center(
                          child: !isFreeActive.value
                              ? Image.asset(
                                  "assets/icon_assets/checkbox_select.png",
                                  height: SizeConfig.screenWidth * 0.06,
                                  width: SizeConfig.screenWidth * 0.06,
                                )
                              : Image.asset(
                                  "assets/icon_assets/checkbox_unselect.png",
                                  width: (SizeConfig.screenWidth * 0.06) - 2,
                                  height: (SizeConfig.screenWidth * 0.06) - 2,
                                ),
                        ),
                      ),
                      SizedBox(width: SizeConfig.screenWidth * 0.02),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: AppTextField().commonField(
                  context,
                  hintText: "Amount",
                  fieldHeight: SizeConfig.screenWidth * 0.02,
                  lableFontSize: SizeConfig.screenWidth * 0.028,
                  lableFontWeight: FontWeight.w400,
                  isRemoveTopHight: false,
                  readOnly: isFreeActive.value,
                  keyboardType: TextInputType.number,
                  controller: controller ?? TextEditingController(),
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.screenWidth * 0.08),
        ],
      ),
    );
  }
}
