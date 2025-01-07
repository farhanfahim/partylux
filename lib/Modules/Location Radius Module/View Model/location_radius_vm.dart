// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:partylux/Modules/Auth%20Module/Models/usermodel.dart';
import 'package:partylux/Utils/Network/cache_handler.dart';
import '../../Profile Module/Profile Section/Service/profile_service.dart';

class LocationRadiusViewModel extends GetxController {
  RxDouble min = 0.0.obs;
  RxDouble max = 0.0.obs;

  RxBool isLoading = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    min.value = await DatabaseHandler().getRadius();
    print(min.value);
  }

}
