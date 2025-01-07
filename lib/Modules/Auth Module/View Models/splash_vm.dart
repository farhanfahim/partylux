import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/constants.dart';
import 'package:partylux/Utils/Network/cache_handler.dart';
import 'package:partylux/Utils/common_methods.dart';
import 'package:partylux/service/applinker.dart';

class SplashViewModel extends GetxController {
  LocationPermission? permission;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () {
      onSplashMethod();
    });
  }

  void onSplashMethod() async {

    DatabaseHandler handler = DatabaseHandler();
    await handler.removeTempToken();
    bool isOnBoarding = await handler.getOnBoarding();
   // Get.toNamed(AppRoutes.createParty);
    if (!isOnBoarding) {
      Get.offNamed(AppRoutes.ON_BOARDING);
    } else {

      if (await handler.getToken() != "") {
        String? initialLink=await Applinker().getLink();
        Get.offNamed(AppRoutes.NAV_ROOT,arguments: {Constants.paramFrom:initialLink,});
      } else {
        Get.offNamed(AppRoutes.LoginSignUpView);
      }
    }
  }
}
