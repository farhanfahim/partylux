// ignore_for_file: invalid_use_of_protected_member

import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../../Utils/Network/cache_handler.dart';
import '../../../models/page_model.dart';
import '../../Auth Module/Models/usermodel.dart';
import '../../BecomePartner/Model/become_partner_model.dart';
import '../service/club_service.dart';

class ClubViewModel extends GetxController with ClubService {
  PageModel<BecomePartnerModel>? myClubList;

  final Rx<UserModel> userData = UserModel.fromEmpty().obs;

  @override
  void onInit() {
    super.onInit();
  }


//===========================================================================//
//==========      Get Events against eventCategory      =========//
//===========================================================================//
  Future<PageModel<BecomePartnerModel>?> getBusinessList({required String type, required int page}) async {

    userData.value = await DatabaseHandler().getUserData();
    if(userData.value.sId!.isNotEmpty) {
      return  await getBusiness(
        page:page,
        body: {
          "user_id":userData.value.sId!,
          "businessCategory":type,
        },
      );
    }


  }


}
