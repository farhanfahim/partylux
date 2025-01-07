import 'package:partylux/Utils/Network/api_client.dart';
import 'package:partylux/Utils/Network/api_urls.dart';
import 'package:partylux/Utils/Network/tost.dart';

mixin PaymentService{

  Future<bool> onOrderCheckout(
      Map<String, dynamic> data,
      ) async {
    //  EventModel? val;
    bool stat=false;
    try {
      var response = await API().post(ApiManager.PROCESS_PAYMENT, data);

      print("order checkout response-->> $response");
      if (response == null) {
      } else if (response.data["success"] == true) {
        //Get.back();
        stat=true;
        var data=response.data["data"];
        // val=EventModel.fromJson(data);
        //   Toast().success(massage: response.data["msg"].toString());

      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }

    return stat;
  }


  Future<String?> onConnectAccount(
      Map<String, dynamic> data,
      ) async {
    //  EventModel? val;
    String? stat;
    try {
      var response = await API().post(ApiManager.ADD_CONNECT_ACCOUNT, data);

      print("onConnectAccount response-->> $response");
      if (response == null) {
      } else if (response.data["success"] == true) {
        //Get.back();
        var data=response.data["data"];
        stat=data["account_link"]["url"];

      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }

    return stat;
  }


  Future<bool> onUpdateConnectAccount(
      Map<String, dynamic> data,
      ) async {
    bool stat=false;
    try {
      var response = await API().post(ApiManager.UPDATE_CONNECT_ACCOUNT, data);

      print("onUpdateConnectAccount response-->> $response");
      if (response == null) {
      } else if (response.data["success"] == true) {
        //Get.back();
        stat=true;
        var data=response.data["data"];

      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }

    return stat;
  }


}