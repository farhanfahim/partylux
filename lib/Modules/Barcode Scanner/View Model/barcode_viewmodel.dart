// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../../Constants/color.dart';
import '../../../Utils/Network/api_client.dart';
import '../../../Utils/Network/api_urls.dart';
import '../../../Utils/Theme/app_config.dart';
import '../../TicketModule/Model/ticket_model.dart';
import '../service/barcode_service.dart';

import '../../../Utils/Network/tost.dart';

class BarcodeViewModel extends GetxController with ClubService {
  Rx<TicketModel>? orderModel = TicketModel().obs;
  RxString qrCode  = "".obs;
  RxInt status  = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  void getSingleOrderDetail(
      String userID,
      ) async {
    try {
      var response = await API().get(ApiManager.GET_SINGLE_ORDERS + "$userID");
      EasyLoading.dismiss();
      if (response == null) {} else if (response.data["error"] == false) {

        orderModel!.value = TicketModel.fromJson(response.data["data"]);

        if(status.value == 1){

          Toast().success(massage: "welcome ${orderModel!.value.user!.username} party of ${orderModel!.value.event!.name!}");
          Timer(Duration(seconds: 3), () {
            Navigator.pop(Get.context!);
          });
        }else if(status.value == 2){

          Toast().success(massage: "Already Checked in");
          Timer(Duration(seconds: 3), () {
            Navigator.pop(Get.context!);
          });
        }else{
          Toast().error(massage: "Not Valid");

          Timer(Duration(seconds: 3), () {
            Navigator.pop(Get.context!);
          });

        }
        print(response.data["data"]);
      }
    } catch (e) {
      print("error-<<[[]][[]]->> $e");
    }
  }

  void onCheckEvent(id) async {
    getSingleOrderDetail(id);
    EasyLoading.show(
      status: 'Please Wait . . .',
      indicator: CupertinoActivityIndicator(
        color: AppColors.whiteText,
        radius: SizeConfig.screenWidth * 0.05,
      ),
    );

    await FlutterTimezone.getLocalTimezone().then((value) async {
      Map data = {
        "orderId": id,
      };
      await onCheckIn(data: data).then((value) async {
        status.value = value;

      });
    });

  }

  @override
  void dispose() {
    super.dispose();
  }


}
