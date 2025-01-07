import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/Create%20Module/View%20Model/create_viewmodel.dart';
import 'package:partylux/Utils/Common/cechednetworlimage.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Text%20Fields/textfield.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';
import 'package:partylux/Utils/extensions.dart';
import 'package:partylux/Utils/griddelegate.dart';

class SelectEventGallery extends StatelessWidget {
  SelectEventGallery({super.key});

  final _createEventVM = Get.find<CreateViewModel>();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showBackBtn:true,
      appBarTitle: "Create Party",
      body: Obx(
        () => SizedBox.expand(
          child: Column(
            children: [

              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: [
                    Form(
                      key: _createEventVM.formKeyEventName,
                      child: AppTextField().commonField(
                        context,
                        hintText: "Event Name",
                        controller: _createEventVM.eventName.value,
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.04),
                    AppText(
                      text: "Event Description",
                      fontSize: SizeConfig.screenWidth * 0.034,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.01),
                    Form(
                      key: _createEventVM.formKeyEventDiscription,
                      child: AppTextField().commonField(
                        context,
                        isShowLable: false,
                        hintText: "Describe your party",
                        isCustomHintText: true,
                        maxLines: 5,
                        controller: _createEventVM.eventdiscription.value,
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.04),
                    AppText(
                      text: "Event Type",
                      fontSize: SizeConfig.screenWidth * 0.034,
                      fontWeight: FontWeight.w400,
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.01),
                    Row(
                      children: [
                        Expanded(
                          child: button(
                            title: 'Public',
                            isActive:
                                _createEventVM.eventType.value == "public",
                            callback: () {
                              _createEventVM.eventType.value = "public";
                            },
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: button(
                            title: 'Private',
                            isActive:
                                _createEventVM.eventType.value == "private",
                            callback: () {
                              _createEventVM.eventType.value = "private";
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.045),
                    GestureDetector(
                      onTap: () {
                        _createEventVM.eventImage();
                      },
                      child: Container(
                        height: SizeConfig.screenWidth * 0.5,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.whiteText.withOpacity(0.2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: SizeConfig.screenWidth * 0.2,
                              width: SizeConfig.screenWidth * 0.2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppColors.whiteText.withOpacity(0.1),
                              ),
                              padding:
                                  EdgeInsets.all(SizeConfig.screenWidth * 0.05),
                              child: Image.asset(
                                  "assets/icon_assets/image_pin.png"),
                            ),
                            const SizedBox(height: 10),
                            AppText(
                              text: "Select or take image",
                              fontSize: SizeConfig.screenWidth * 0.035,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.03),
                    Visibility(
                      visible:_createEventVM.imagesList.length>0,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: AppText(
                          text: "Selected Image",
                          fontSize: SizeConfig.screenWidth * 0.038,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.005),
                    GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                        crossAxisCount: 2,
                        mainAxisSpacing: SizeConfig.screenHeight * 0.02,
                        crossAxisSpacing: SizeConfig.screenHeight * 0.02,
                        height: SizeConfig.screenWidth * 0.35,
                      ),
                      itemCount: _createEventVM.imagesList.length,
                      padding: EdgeInsets.only(
                          top: 4, bottom: SizeConfig.screenWidth * 0.05),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        //             imagePath.contains("https://")
                        // ? Container(
                        //     width: SizeConfig.screenWidth / 4,
                        //     height: SizeConfig.screenHeight / 8.5,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(5),
                        //     ),
                        //     child: cachedNetworkImage(
                        //       imagePath,
                        //       context: context,
                        //       borderRadius: 5,
                        //     ),
                        //   )
                        // : Container(
                        //     width: SizeConfig.screenWidth / 4,
                        //     height: SizeConfig.screenHeight / 8.5,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(5),
                        //       image: DecorationImage(
                        //         image: FileImage(File(imagePath)),
                        //         fit: BoxFit.cover,
                        //       ),
                        //     ),
                        //   ),
                        return Obx(
                          () => Container(
                            decoration: BoxDecoration(
                              // image: DecorationImage(
                              //   image: FileImage(
                              //     File(_createEventVM.imagesList[index]),
                              //   ),
                              //   fit: BoxFit.cover,
                              // ),
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.whiteText.withOpacity(0.1),
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: SizeConfig.screenWidth * 0.35,
                                      width: double.infinity,
                                      child: _createEventVM.imagesList[index]
                                              .contains("https://")
                                          ? cachedNetworkImage(
                                              _createEventVM.imagesList[index],
                                              context: context,
                                              borderRadius: 5,
                                            )
                                          : Image.file(
                                              File(_createEventVM
                                                  .imagesList[index]),
                                              fit: BoxFit.cover,
                                            ),
                                    )),
                                // Image.file(
                                //   File(_createEventVM.imagesList[index]),
                                //   fit: BoxFit.cover,
                                // ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: SizeConfig.screenWidth * 0.025,
                                          right:
                                              SizeConfig.screenWidth * 0.025),
                                      child: GestureDetector(
                                        onTap: () {
                                          print("object");
                                          _createEventVM.imagesList.removeWhere(
                                              (file) =>
                                                  file ==
                                                  _createEventVM
                                                      .imagesList[index]);
                                        },
                                        child: Container(
                                          height: SizeConfig.screenWidth * 0.08,
                                          width: SizeConfig.screenWidth * 0.08,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: AppColors.darkgrey
                                                .withOpacity(0.5),
                                          ),
                                          child: Icon(
                                            Icons.close,
                                            color: AppColors.whiteText
                                                .withOpacity(0.8),
                                            size: SizeConfig.screenWidth * 0.05,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              AppButton.mainButton(
                context,
                text: "Next",
                onPressed: () {
                  _createEventVM.selectPartyImages();
                  // _createEventVM.uploadEventImages();
                },
              ),
              const SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector selectTileUI({
    required String title,
    required bool isActive,
    required Function callback,
  }) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Container(
        height: SizeConfig.screenWidth * 0.14,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.whiteText.withOpacity(0.1),
        ),
        padding:
            EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.04),
        margin: EdgeInsets.symmetric(vertical: SizeConfig.screenWidth * 0.015),
        child: Row(
          children: [
            Container(
              height: SizeConfig.screenWidth * 0.05,
              width: SizeConfig.screenWidth * 0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: isActive ? AppColors.primary : AppColors.iconColor,
                  width: 1.5,
                ),
              ),
              padding: const EdgeInsets.all(2),
              child: Container(
                height: SizeConfig.screenWidth * 0.05,
                width: SizeConfig.screenWidth * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: isActive ? AppColors.primary : AppColors.iconColor,
                ),
              ),
            ),
            SizedBox(width: SizeConfig.screenWidth * 0.05),
            Expanded(
              child: AppText(
                text: title,
                fontSize: SizeConfig.screenWidth * 0.04,
                
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget button({
    required bool isActive,
    required String title,
    required VoidCallback callback,
  }) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: AppColors.whiteText.withOpacity(0.2),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () => callback(),
        child: Container(
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              15.pw,
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: isActive
                        ? AppColors.primary
                        : AppColors.whiteText.withOpacity(0.25),
                    width: 1.5,
                  ),
                ),
                padding: EdgeInsets.all(2),
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: isActive
                        ? AppColors.primary
                        : AppColors.whiteText.withOpacity(0.25),
                  ),
                ),
              ),
              15.pw,
              AppText(
                text: title,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


//  Material(
//       borderRadius: BorderRadius.circular(10),
//       color:
//           isActive ? AppColors.primary : AppColors.whiteText.withOpacity(0.25),
//       child: InkWell(
//         borderRadius: BorderRadius.circular(10),
//         onTap: () => callback(),
//         child: Container(
//           height: 50,
//           child: Center(
//             child: AppText(
//               text: title,
//             ),
//           ),
//         ),
//       ),
//     );