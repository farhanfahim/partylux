import 'package:partylux/Utils/Network/api_client.dart';
import 'package:partylux/Utils/Network/api_urls.dart';

import '../../../Utils/Network/tost.dart';
import '../../Auth Module/Models/usermodel.dart';
import '../../perticipant_module/Model/other_user_model.dart';
import '../model/evrnt_participants_model.dart';
import '../model/order_model.dart';
import '../model/participants_model.dart';

mixin PeopleJoinedService {

  Future<List<ParticipantsModel>> getOrdersApi({
    required String eventId,
  }) async {
    List<ParticipantsModel> orderModel = [];

    try {
      var response = await API().get(
          ApiManager.GET_EVENt_PARTICIPANTS +
              "eventId=$eventId"
      );

      if (response == null) {
      } else if (response.statusCode == 200) {
        for(var item in response.data["data"]){
          orderModel.add(ParticipantsModel(
              sId: item['user']['_id'],
              name: item['user']['username'],
              image:item['user']['profile']['profileImage'],
              gender:item['user']['profile']['gender'] ));
        }
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return orderModel;
  }



  Future<List<ParticipantsModel>> getBusinessOrdersApi({
    required String eventId,
  }) async {
    List<ParticipantsModel> orderModel = [];

    try {
      var response = await API().get(
          ApiManager.GET_BUSINESS_PARTICIPANTS +
              "partnerId=$eventId"
      );

      if (response == null) {
      } else if (response.statusCode == 200) {
        for(var item in response.data["data"]){
          orderModel.add(ParticipantsModel(
              sId: item['_id'],
              name: item['username'],
              image:item['profileImage'],
              gender:item['gender'] ));
        }
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return orderModel;
  }

  Future<bool> onUpdateOrder(
      Map<String, dynamic> data) async {
    bool isSuccess = false;
    try {
      var response =
      await API().put(ApiManager.UPDATE_ORDER, data);

      print("response-->> $response");
      if (response == null) {
      } else if (response.data["error"] == false) {
        isSuccess = true;
       // Toast().success(massage: response.data["msg"].toString());
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }

    return isSuccess;
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

  Future<OtherUserModel> getUserProfile(
      String userID,
      ) async {
    OtherUserModel userData = OtherUserModel.fromEmpty();
    String userId = userID;
    try {
      var response = await API().get(ApiManager.GET_USER_PROFILE + "/$userId");
      if (response == null) {
      } else if (response.data["error"] == false) {
        userData = OtherUserModel.fromJson(response.data["data"]);
      }
    } catch (e) {
      print("error-<<[[]][[]]->> $e");
    }
    return userData;
  }


}
