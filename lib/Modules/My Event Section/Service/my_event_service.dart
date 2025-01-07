import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:partylux/Utils/Network/api_client.dart';
import 'package:partylux/Utils/Network/api_urls.dart';
import 'package:partylux/Utils/Network/tost.dart';
import '../../../Constants/color.dart';
import '../../../Utils/Theme/app_config.dart';
import '../../people_joined/model/order_model.dart';
import '../Model/event_detail_model.dart';

mixin MyEventService {

  Future<EventDetailModel?> getEventDetailApi(
      String eventId,
      ) async {
    EventDetailModel? eventDetailModel;
    try {
      var data = {
        "eventId": eventId
      };
      var response = await API().post(ApiManager.GET_EVENT_DETAIL,data);
      print("event response is: $response");
      if (response.data["error"] == false) {
        eventDetailModel = EventDetailModel.fromJson(response.data["data"]);
      }
    } catch (e) {
      print("event error: $e");
    }
    return eventDetailModel;
  }

  Future<bool> onDeleteEvent({
    required String eventID,
  }) async {
    bool result = false;
    try {

      var data = {"eventId": eventID};

      var response = await API().delete(ApiManager.EVENT_DELETE, data: data);
      print("response-->> $response");
      if (response == null) {
      } else if (response.data['error'] == false) {
        //Toast().success(massage: response.data["msg"].toString());
        result = true;
      } else {
        result = false;
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return result;
  }

  Future<List<OrderModel>> getPendingOrdersApi({
    required String eventId,
  }) async {
    List<OrderModel> orderModel = [];

    try {
      var response = await API().get(
          ApiManager.GET_ORDERS +
              "eventId=$eventId" +
              "&orderStatus=pending"
      );

      if (response == null) {
      } else if (response.statusCode == 200) {
        orderModel = OrderModel.fromJsonToList(response.data["data"]);
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return orderModel;
  }

  Future<OrderModel?> onReserveEvent({
    required String gender,
    required String enteranceCode,
    required String eventID,
  }) async {
  //  bool isReserveEvent = false;
    OrderModel? orderModel;
    try {
      Map data = {

        "gender": gender,
        "eventId": eventID,
        if(enteranceCode.isNotEmpty)"entranceCode": enteranceCode
      };
      print("reserve body: ${jsonEncode(data)}");
      var response = await API().post(ApiManager.ORDER_PLACE, data);
      print("order response: ${response?.data}");
      if (response == null) {
      } else if (response.data["error"] == false) {
       // isReserveEvent = true;
        var data=response.data["data"];
        orderModel=OrderModel.fromJson(data,);


      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return orderModel;
  }

  onCancelEvent({
    required String eventID,
  }) async {
    EasyLoading.show(
      status: 'Please Wait . . .',
      indicator: CupertinoActivityIndicator(
        color: AppColors.whiteText,
        radius: SizeConfig.screenWidth * 0.05,
      ),
    );
    try {
      Map data = {
        "eventId": eventID,
      };
      var response = await API().post(ApiManager.CANCEL_EVENT, data);
      if (response == null) {
      } else if (response.data["error"] == false) {
        EasyLoading.dismiss();
      } else {
        Toast().error(massage: response.data["msg"].toString());
        EasyLoading.dismiss();
      }
    } catch (e) {
      print("error-->> $e");
    }

  }

  Future onFavoriteEvent({
    required Map data,
  }) async {
    bool isFav = false;
    try {
      var response =
      await API().patch(ApiManager.FAVORITE_EVENT, data,);

      if (response == null) {
      } else if (response.data["status"] == 200) {
        isFav = true;
      } else {
        isFav = false;
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return isFav;
  }
}
