// ignore_for_file: unused_local_variable, invalid_use_of_protected_member

import 'package:get/get.dart';
import '../../../../Constants/app_images.dart';
import '../../../../Utils/Network/cache_handler.dart';
import '../../../../models/page_model.dart';
import '../../../Auth Module/Models/usermodel.dart';
import '../../../Club Module/Model/club_model.dart';
import '../../../Home Module/Model/event_model.dart';
import '../../Services/map_module_service.dart';

class MapListingViewModel extends GetxController with MapModuleService {

  Rx<UserModel> userData = UserModel.fromEmpty().obs;
  PageModel<EventModel>? paginatedEventsList;
  @override
  Future<void> onInit() async {
    super.onInit();
    userData.value = await DatabaseHandler().getUserData();
    userData.refresh();
  }

  //===========================================================================//
//==========      Get Events against eventCategory      =========//
//===========================================================================//
  Future<PageModel<EventModel>?> getPaginatedEvents({
    int length = 6,
    required String? categoryType,
    required int page}) async {

    return  await paginatedEvents(
      page:page,
      length: length,
      categoryType: categoryType!,
    );
  }

}
