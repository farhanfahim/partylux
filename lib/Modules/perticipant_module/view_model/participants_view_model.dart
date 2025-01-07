
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:partylux/Modules/people_joined/service/people_joined_service.dart';
import '../../../Constants/color.dart';
import '../../../Utils/Theme/app_config.dart';
import '../../Auth Module/Models/usermodel.dart';
import '../../people_joined/model/evrnt_participants_model.dart';
import '../../people_joined/model/order_model.dart';
import '../../people_joined/model/participants_model.dart';
import '../Model/other_user_model.dart';
class ParticipantsViewModel extends GetxController with GetTickerProviderStateMixin, PeopleJoinedService{

  RxInt maxCount = 0.obs;
  RxInt joinedCount = 0.obs;
  RxInt requestCount = 0.obs;
  RxBool isLoading = true.obs;
  RxBool isUserDataLoading = true.obs;

  RxList<OrderModel> pendingOrderModel = List<OrderModel>.empty().obs;
  RxList<ParticipantsModel> orderModel = List<ParticipantsModel>.empty().obs;
  @override
  void onInit() {
    super.onInit();
    maxCount.value = Get.arguments[0];
    joinedCount.value = Get.arguments[1];
    getOrders(Get.arguments[2]);
    getPendingOrders(Get.arguments[2]);


  }


  void getOrders(String id) async {
    await getOrdersApi(eventId: id).then((value) {
      isLoading.value = false;
      orderModel.value = value;
      joinedCount.value = orderModel.length;
    });

  }

  void onUpdateRequest(id,isApprove) async {

    EasyLoading.show(
      status: 'Please Wait . . .',
      indicator: CupertinoActivityIndicator(
        color: AppColors.whiteText,
        radius: SizeConfig.screenWidth * 0.05,
      ),
    );
    Map<String, dynamic> data = {

      "status": isApprove?"approved":"cancelled",
      "orderId": id,
    };
    await onUpdateOrder(data).then((value) {
      EasyLoading.dismiss();
      if(isApprove){
        joinedCount.value++;
        requestCount.value--;
      }

    });
  }

  void getPendingOrders(String id) async {
    await getPendingOrdersApi(eventId: id).then((value) {
      isLoading.value = false;
      pendingOrderModel.value = value;
      requestCount.value = pendingOrderModel.length;
    });

  }




}