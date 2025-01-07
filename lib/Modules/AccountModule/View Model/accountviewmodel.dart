import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:partylux/Constants/app_routes.dart';

import '../Service/account_service.dart';

class AccountViewModel extends GetxController with AccountService {
  RxBool loading = false.obs;

  void onDeleteAccount() async {
    loading.value = true;
    bool status = await deleteAccount();
    if (status) {
      loading.value = false;
      Get.toNamed(AppRoutes.LoginSignUpView);
    }
  }
}
