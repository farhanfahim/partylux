import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Modules/Onboarding%20Module/View%20Model/onboarding_vm.dart';
import 'package:partylux/Modules/Onboarding%20Module/View/Components/stepdots.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

import '../../../Constants/dimens.dart';
import '../../../Utils/Common/sizer.dart';

class OnboardingView extends StatelessWidget {
  OnboardingView({super.key});

  final _serviceVM = Get.find<OnboardingViewModel>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isBodyPadding: false,
      hideAppBar: true,
      bottom: false,
      body: Obx(
        () => Stack(
          alignment: Alignment.bottomCenter,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Image.asset(
                _serviceVM.onBoardingList[_serviceVM.currentIndex.value]
                    ["image"],
                fit: BoxFit.cover,
                key: UniqueKey(),
                height: double.infinity,
                width: double.infinity,
              ),
            ),
            SizedBox(
              height: SizeConfig.screenHeight / 2.3,
              child: Container(
                width: SizeConfig.screenWidth,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(1),
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: SizeConfig.screenWidth,
                        child: CarouselSlider(
                          carouselController:
                              _serviceVM.buttonCarouselController,
                          options: CarouselOptions(
                            initialPage: _serviceVM.currentIndex.value,
                            enableInfiniteScroll: false,
                            pageSnapping: true,
                            reverse: false,
                            autoPlay: false,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            // enlargeCenterPage: true,
                            // onPageChanged: callbackFunction,
                            onPageChanged: (index, reason) {
                              _serviceVM.onChangeSelectedPageIndex(index);
                            },
                            disableCenter: true,
                            viewportFraction: 1,
                            enlargeCenterPage: false,
                            scrollDirection: Axis.horizontal,
                          ),
                          items: _serviceVM.onBoardingList.map((index) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    /*AppText(
                                      text: _serviceVM.onBoardingList[_serviceVM
                                          .currentIndex.value]["title"],
                                      fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel24),
                                      textAlign: TextAlign.center,
                                      height: 1.1,
                                    ),*/
                                    const SizedBox(height: 20),
                                    AppText(
                                      text: _serviceVM.onBoardingList[_serviceVM
                                          .currentIndex.value]["description"],
                                      fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
                                      textAlign: TextAlign.center,
                                      height: 1.4,
                                    ),
                                  ],
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth * 0.05),
                      child: Row(
                        children: [
                          TextButton(
                            onPressed: () {
                              _serviceVM.onFinishedOnboarding();
                            },
                            child: AppText(
                              text: "SKIP",
                              fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel18),
                              
                              textAlign: TextAlign.center,
                              height: 1.4,
                            ),
                          ),
                          const Spacer(),
                          StepDots(
                            totalSteps: 3,
                            currentStep: int.parse(
                              _serviceVM
                                  .onBoardingList[_serviceVM.currentIndex.value]
                                      ["currentStep"]
                                  .toString(),
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              if (_serviceVM.currentIndex.value == 2) {
                                _serviceVM.onFinishedOnboarding();
                              } else {
                                _serviceVM.buttonCarouselController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease,
                                );
                              }
                            },
                            child: AppText(
                              text: "NEXT",
                              fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel18),
                              
                              textAlign: TextAlign.center,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
