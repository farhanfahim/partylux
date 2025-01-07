// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/integer.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/Create%20Module/Model/create_model.dart';
import 'package:partylux/Modules/Event%20Module/View/inside_event_container.dart';
import 'package:partylux/Modules/Event%20Module/View/my_reservation/inside_container.dart';
import 'package:partylux/Modules/Event%20Module/View/my_reservation/reservation_view.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Modules/people_joined/model/order_model.dart';
import 'package:partylux/Utils/Network/api_client.dart';
import 'package:partylux/Utils/Network/api_urls.dart';
import 'package:partylux/Utils/Network/tost.dart';
import 'package:partylux/models/page_model.dart';

import '../../../Utils/Network/cache_handler.dart';
import '../../Auth Module/Models/usermodel.dart';
import '../service/event_service.dart';

class EventViewModel extends GetxController with EventService, GetTickerProviderStateMixin {
  RxInt tapIndex = 0.obs;
  final Rx<UserModel> userData = UserModel.fromEmpty().obs;

  late TabController tabController;
  //RxInt selectedIndex = 0.obs;

  final List<Widget> screens = [InsideEventContainer(index: 0), ReservationView(), InsideEventContainer(index: 2)];

  final List<Widget> screens2 = [
    InsideReservationContainer(type: OrderModel.STATUS_APPROVED),
    InsideReservationContainer(type: OrderModel.STATUS_PENDING),
  ];

  final Map<int, PageModel<EventModel>> events = {};

  final Map<String, PageModel<OrderModel>> orders = {};

  final List<String> titles2 = [AppStrings.txtReserved, AppStrings.txtPending];

  @override
  void onInit() {
    getUserDetail();
    super.onInit();
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    //data.addAll(Get.arguments[0]);
  }

  Future<void> getUserDetail() async {
    userData.value = await DatabaseHandler().getUserData();
/*    print("email ${userData.value.userEmail}");
    print("username ${userData.value.userName}");
    print("userID ${userData.value.userId}");
    userData.refresh();
    UserModel result = await getUserProfile(userData.value.userId!);
    userData.value = result;
    userData.refresh();
    print("membershipType😍😍😍 ${userData.value.membershipType}");*/
  }

  Future<PageModel<EventModel>?> getMyEvents({String search = "", int page = 1, required int index}) {
    Map<String, dynamic> map = {
      "myEvents":1,
    };
    print("sel ind: ${tapIndex.value}");
    if (index == 2) {
      map["history"] = 1;
    }
    return getEvents(body: map, page: page, search: search);
  }

  Future<PageModel<OrderModel>?> getReservations({
    String search = "",
    int page = 1,
    required String status,
  }) {
    Map<String, dynamic> map = {
      "filterUserId": userData.value.sId,
      "orderStatus": status,
    };
    map["orderStatus"] = status;
    return getOrdersApi(body: map, page: page, search: search);
  }
}
