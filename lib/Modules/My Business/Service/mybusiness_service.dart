import 'package:get/get.dart';
import 'package:partylux/Modules/BecomePartner/Model/become_partner_model.dart';
import 'package:partylux/Modules/BecomePartner/Model/participants_model.dart';
import 'package:partylux/Utils/Network/api_client.dart';
import 'package:partylux/Utils/Network/api_urls.dart';
import 'package:partylux/Utils/Network/tost.dart';

import '../../people_joined/model/order_model.dart';
import '../Model/business_detail_model.dart';

mixin BecomePartnerService {


  Future<BusinessDetailModel> getBusinessDetailApi(
      String businessId,
      ) async {
    BusinessDetailModel businessDetailModel = BusinessDetailModel();
    try {
      var data = {
        "businessId": businessId
      };
      var response = await API().post(ApiManager.GET_SPECIFIC_BUSINESS,data);
      if (response == null) {
      } else if (response.data["error"] == false) {
        businessDetailModel = BusinessDetailModel.fromJson(response.data["data"]);
      }
    } catch (e) {
      print("error-<<[[]][[]]->> $e");
    }
    return businessDetailModel;
  }

  Future<bool> onDeleteBusiness({
    required String businessID,
  }) async {
    bool result = false;
    try {
      Map data = {"businessId": businessID.trim()};
      var response = await API().delete(ApiManager.BUSINESS_DELETE, data: data);

      print("response-->> $response");
      if (response == null) {
      } else if (response.data["error"] == false &&
          response.data["status"] == 200) {
        Get.close(2);
       // Toast().success(massage: response.data["msg"].toString());
        result = true;
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return result;
  }

  Future<bool> onHideFlyer({
    required String flyerId,
  }) async {
    bool result = false;
    try {

      var response = await API().patch(ApiManager.HIDE_FLYER+"/"+flyerId,null);

      print("response-->> $response");
      if (response == null) {
      } else if (response.data["error"] == false &&
          response.data["status"] == 200) {
        //Toast().success(massage: response.data["msg"].toString());
        result = true;
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return result;
  }


  Future<String> onUpdateBusinessStat({
    required bool businessState,
    required String businessId,
  }) async {
    String result = "";
    try {
      Map data = {
        "businessState": businessState ? "open" : 'close',
        "businessId": businessId,
      };
      var response = await API().patch(
        ApiManager.UPDATE_BUSINESS_STATE,
        data,
      );

      print("response-->> $response");
      if (response == null) {
      } else if (response.data["error"] == false &&
          response.data["status"] == 200) {
        result = response.data["data"]["businessState"];
        //Toast().success(massage: response.data["msg"].toString());
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return result;
  }

  Future<OrderModel?> onReserveEvent({
    required String gender,
    required String enteranceCode,
    required String eventID,
    bool isBusiness = false,
  }) async {
    OrderModel? orderModel;
    try {
      Map data = {

        "gender": gender,
        if(isBusiness == true)"partnerId": eventID,
        if(isBusiness == false)"eventId": eventID,
        if(enteranceCode.isNotEmpty)"entranceCode": enteranceCode
      };
      var response = await API().post(ApiManager.ORDER_PLACE, data);
      if (response == null) {
      } else if (response.data["error"] == false) {
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


  Future onFavoriteBusiness({
    required Map data,
  }) async {
    bool isFav = false;
    try {
      var response =
      await API().patch(ApiManager.FAVORITE_BUSINESS, data,);

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
