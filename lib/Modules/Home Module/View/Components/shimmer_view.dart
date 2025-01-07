import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/extensions.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../Constants/app_fonts.dart';
import '../../../../Constants/app_images.dart';
import '../../../../Constants/strings.dart';
import '../../../../Utils/Common/icons.dart';
import '../../../../Utils/Common/sizer.dart';
import '../../../../Utils/Common/switch_button.dart';
import '../../../../Utils/Theme/app_text.dart';

Widget categiriesShimmer() {
  return ListView.builder(
    shrinkWrap: true,
    scrollDirection: Axis.horizontal,
    itemCount: 5,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        width: SizeConfig.screenWidth * 0.40,
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45),
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.2),
          highlightColor: Colors.white.withOpacity(0.3),
          direction: ShimmerDirection.ltr,
          period: const Duration(milliseconds: 2000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: SizeConfig.screenWidth * 0.40,
                width: SizeConfig.screenWidth * 0.40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.transparent.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 15),
              Container(
                height: 20,
                width: SizeConfig.screenWidth / 2,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColors.grey1),
              ),
              const SizedBox(height: 15),
              Container(
                height: 15,
                width: SizeConfig.screenWidth / 1.9,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColors.grey1),
              ),
              const SizedBox(height: 15),
              Container(
                height: 15,
                width: 120,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColors.grey1),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget topFiveShimmer() {
  return ListView.builder(
    shrinkWrap: true,
    padding: EdgeInsets.only(left: SizeConfig.screenWidth * 0.05),
    scrollDirection: Axis.horizontal,
    itemCount: 5,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        width: SizeConfig.screenWidth / 1.2,
        margin: EdgeInsets.only(right: SizeConfig.screenWidth * 0.05),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.whiteText.withOpacity(0.1),
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.2),
          highlightColor: Colors.white.withOpacity(0.3),
          direction: ShimmerDirection.ltr,
          period: const Duration(milliseconds: 2000),
          child: Row(
            children: [
              Container(
                height: SizeConfig.screenWidth * 0.25,
                width: SizeConfig.screenWidth * 0.25 - 12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: AppColors.whiteText.withOpacity(0.7),
                ),
              ),
              const SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 15,
                    width: SizeConfig.screenWidth / 3,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColors.grey1),
                  ),
                  Container(
                    height: 10,
                    width: SizeConfig.screenWidth / 2,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColors.grey1),
                  ),
                  SizedBox(),
                  SizedBox(),
                  Container(
                    height: 15,
                    width: SizeConfig.screenWidth / 3,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColors.grey1),
                  ),
                ],
              ),
              // const SizedBox(height: 15),
              // Container(
              //   height: 10,
              //   width: SizeConfig.screenWidth / 1.9,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(100),
              //       color: AppColors.grey1),
              // ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     Container(
              //       height: 15,
              //       width: 100,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(100),
              //           color: AppColors.grey1),
              //     ),
              //     Container(
              //       height: 25,
              //       width: 80,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(100),
              //           color: AppColors.grey1),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      );
    },
  );
}

Widget viewAllEventsShimmer() {
  return Column(
    children: List.generate(6, (index) {
      return Container(
        height: SizeConfig.screenWidth * 0.25,
        width: double.infinity,
        margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.03),
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(45),
          color: AppColors.whiteText.withOpacity(0.1),
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.2),
          highlightColor: Colors.white.withOpacity(0.3),
          direction: ShimmerDirection.ltr,
          period: const Duration(milliseconds: 2000),
          child: Row(
            children: [
              Container(
                height: SizeConfig.screenWidth * 0.25,
                width: SizeConfig.screenWidth * 0.25 - 12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: AppColors.whiteText.withOpacity(0.7),
                ),
              ),
              const SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 15,
                    width: SizeConfig.screenWidth / 3,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColors.grey1),
                  ),
                  Container(
                    height: 10,
                    width: SizeConfig.screenWidth / 2,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColors.grey1),
                  ),
                  SizedBox(),
                  SizedBox(),
                  Container(
                    height: 15,
                    width: SizeConfig.screenWidth / 3,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColors.grey1),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }),
  );
}

Widget viewEventDetailShimmer() {
  return Column(
    children: [
      Container(
        child: Shimmer.fromColors(
            baseColor: Colors.grey.withOpacity(0.2),
            highlightColor: Colors.white.withOpacity(0.3),
            direction: ShimmerDirection.ltr,
            period: const Duration(milliseconds: 2000),
            child: Column(
              children: [
                Container(
                  height: AppSizer.getVerticalSize(350),
                  child: Stack(
                    children: [
                      Container(height: AppSizer.getVerticalSize(320), color: AppColors.grey1),
                      AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        automaticallyImplyLeading: false,
                        leading: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Center(
                              child: CustomMonoIcon(icon: AppImages.imgArrowLeft, color: AppColors.whiteText, isSvg: false, size: 30),
                            )),
                        title: AppText(
                          text: AppStrings.event,
                          fontSize: AppSizer.getFontSize(18),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.grey1,
                            ),
                            margin: AppSizer.getMargin(left: 14, right: 14),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                        child: AppText(
                                      text: "",
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: AppFonts.lexendDica,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                    Row(
                                      children: [
                                        AppText(
                                          text: "Live",
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: AppFonts.lexendDica,
                                        ),
                                        SizedBox(
                                          width: AppSizer.getHorizontalSize(10),
                                        ),
                                        SwitchButton(
                                          isActive: true,
                                          callback: (val) {},
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                5.ph,
                                Row(
                                  children: [
                                    Expanded(
                                      child: AppText(
                                        text: "",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontFamily: AppFonts.lexendDica,
                                      ),
                                    ),
                                    Expanded(
                                      child: AppText(
                                        textAlign: TextAlign.right,
                                        text: "",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white,
                                        fontFamily: AppFonts.lexendDica,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        width: 100,
                        color: AppColors.grey1,
                      ),
                      SizedBox(
                        height: AppSizer.getVerticalSize(15),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 15,
                            width: 200,
                            color: AppColors.grey1,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AppSizer.getVerticalSize(15),
                      ),
                      Container(
                        height: 20,
                        width: 150,
                        color: AppColors.grey1,
                      ),
                      SizedBox(
                        height: AppSizer.getVerticalSize(15),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 40,
                            width: 60,
                            color: AppColors.grey1,
                          ),
                          SizedBox(
                            height: AppSizer.getHorizontalSize(10),
                          ),
                          Container(
                            height: 40,
                            width: 60,
                            color: AppColors.grey1,
                          ),
                          SizedBox(
                            height: AppSizer.getHorizontalSize(10),
                          ),
                          Container(
                            height: 40,
                            width: 60,
                            color: AppColors.grey1,
                          ),
                          SizedBox(
                            height: AppSizer.getHorizontalSize(10),
                          ),
                          Container(
                            height: 40,
                            width: 60,
                            color: AppColors.grey1,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AppSizer.getVerticalSize(15),
                      ),
                      Container(
                        height: 100,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.grey1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    ],
  );
}

Widget viewGenderShimmer() {
  return Container(
    child: Shimmer.fromColors(
        baseColor: Colors.grey.withOpacity(0.2),
        highlightColor: Colors.white.withOpacity(0.3),
        direction: ShimmerDirection.ltr,
        period: const Duration(milliseconds: 2000),
        child: Row(
          children: [
            Container(
              color: AppColors.transparent,
              padding: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Container(
                    width: AppSizer.getSize(88),
                    height: AppSizer.getSize(88),
                    decoration: BoxDecoration(
                      color: AppColors.grey1,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 10,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.grey1,
                    ),
                  ),
                  SizedBox(height: 3),
                ],
              ),
            ),
          ],
        )),
  );
}

Widget notificationShimmer() {
  return Column(
    children: List.generate(6, (index) {
      return Container(
        padding: AppSizer.getPadding(left: 16,top: 10,right: 16,bottom: 10),
        width: double.infinity,
        margin: EdgeInsets.only(bottom: SizeConfig.screenWidth * 0.03),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.whiteText.withOpacity(0.1),
        ),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.withOpacity(0.2),
          highlightColor: Colors.white.withOpacity(0.3),
          direction: ShimmerDirection.ltr,
          period: const Duration(milliseconds: 2000),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.whiteText.withOpacity(0.7),
                ),
              ),
              const SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 15,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.grey1),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 15,
                        width: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColors.grey1),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 15,
                    width: SizeConfig.screenWidth / 3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.grey1),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }),
  );
}
