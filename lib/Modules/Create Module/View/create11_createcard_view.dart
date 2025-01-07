import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/Create%20Module/View%20Model/create_viewmodel.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Text%20Fields/textfield.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

import '../../../Constants/app_images.dart';

class SelectPartyCreateCard extends StatelessWidget {
  SelectPartyCreateCard({super.key});

  final _createEventVM = Get.find<CreateViewModel>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isTopPadding: SizeConfig.screenHeight * 0.08,
      body: SizedBox.expand(
        child: Obx(
          () => Column(
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
                  text: "Create Premium Card For VIPs",
                  fontSize: SizeConfig.screenWidth * 0.038,
                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.visible,
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.005),
              Expanded(
                child: Form(
                  key: _createEventVM.createCardformKey,
                  child: ListView(
                    padding: EdgeInsets.only(bottom: 20),
                    shrinkWrap: true,
                    children: [
                      AppTextField().commonField(
                        context,
                        hintText: "VIP Card Name",
                        controller: _createEventVM.vipCardName.value,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: SizeConfig.screenWidth * 0.04),
                          Row(
                            children: [
                              AppText(
                                text: "Services",
                                fontSize: SizeConfig.screenWidth * 0.034,
                                fontWeight: FontWeight.w600,
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                  _createEventVM.addServiceInList();
                                },
                                child: AppText(
                                  text: "+ Add",
                                  fontSize: SizeConfig.screenWidth * 0.034,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          AppTextField().commonField(
                            context,
                            hintText: "Services",
                            isShowLable: false,
                            topHight: SizeConfig.screenWidth * 0.02,
                            controller: _createEventVM.vipCardServices.value,
                            isValidation: false,
                          ),
                          SizedBox(height: SizeConfig.screenWidth * 0.04),
                          ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount:
                                  _createEventVM.vipCardServicesList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      bottom: SizeConfig.screenWidth * 0.02),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: SizeConfig.screenWidth * 0.02,
                                      vertical: SizeConfig.screenWidth * 0.02),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        AppColors.whiteText.withOpacity(0.05),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 5),
                                      Expanded(
                                        child: AppText(
                                          text: _createEventVM
                                              .vipCardServicesList[index],
                                          fontSize:
                                              SizeConfig.screenWidth * 0.034,
                                          fontWeight: FontWeight.w600,
                                          overflow: TextOverflow.visible,
                                          height: 1.5,
                                        ),
                                      ),
                                      InkWell(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        onTap: () {
                                          _createEventVM.removeCardService(
                                              _createEventVM
                                                  .vipCardServicesList[index]);
                                        },
                                        child: Container(
                                          child: Icon(
                                            Icons.close,
                                            color: AppColors.whiteText,
                                            size: SizeConfig.screenWidth * 0.07,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ],
                      ),

                      // SizedBox(height: SizeConfig.screenHeight * 0.01),
                      AppTextField().commonField(
                        context,
                        hintText: "Pricing",
                        controller: _createEventVM.vipCardPrice.value,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.005),
              AppButton.mainButton(
                context,
                text: "Add",
                onPressed: () {
                  _createEventVM.addCardInCardList();
                },
              ),
              const SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }
}
