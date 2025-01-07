import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Utils/Network/cache_handler.dart';

import '../../../Constants/app_images.dart';

class OnboardingViewModel extends GetxController {
  RxInt currentIndex = 0.obs;
  CarouselController buttonCarouselController = CarouselController();
  onChangeSelectedPageIndex(int num) {
    currentIndex.value = num;
  }

  onFinishedOnboarding() async {
    Get.offAllNamed(AppRoutes.LoginSignUpView);
  }

  RxList onBoardingList = [
    {
      "title": "Make your own \nprivate Club Night",
      "description":
          "The Best Networking Platform\nFor A Party Experience",
      "image": AppImages.imgOnBoarding1,
      "currentStep": 1
    },
    {
      "title": "Gender ratios",
      "description":
      "Live Gender Ratios So\n You Wont Get FOMO",
      "image": AppImages.imgOnBoarding2,
      "currentStep": 2
    },
    {
      "title": "Throw Your Own\nHouse Party",
      "description":
      "Throw Your Own \nEvent, Your Way",
      "image": AppImages.imgOnBoarding3,
      "currentStep": 3
    },
  ].obs;
}
