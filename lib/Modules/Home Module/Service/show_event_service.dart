import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Modules/Auth%20Module/Models/usermodel.dart';
import 'package:partylux/Modules/Home%20Module/Model/eticket_model.dart';
import 'package:partylux/Utils/Network/api_client.dart';
import 'package:partylux/Utils/Network/api_urls.dart';
import 'package:partylux/Utils/Network/tost.dart';

abstract class ShoeEventService {
  Future<bool> onReserveEventPaymentChcekOutService({
    required String eventName,
    required int eventPrice,
    required String eventID,
  }) async {
    bool isReserveEvent = false;
    try {
      Map data = {
        "eventName": eventName,
        "eventPrice": eventPrice,
        "eventId": eventID
      };
      var response = await API().post(ApiManager.PAYMENT_CHECKOUT, data);
      print("response<<>><<PAYMENT_CHECKOUT>>-->> ${response.data}");
      if (response == null) {
      } else if (response.data["error"] == false) {
        isReserveEvent = true;
        // Toast().success(massage: response.data["msg"].toString());
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return isReserveEvent;
  }

  Future<bool> onSubscribeEventService({
    required String expirationDate,
    required int eventPrice,
    required String genderType,
    required String eventType,
    required String entranceCode,
    required String eventId,
  }) async {
    bool isReserveEvent = false;
    try {
      Map data = {
        "expirationDate": expirationDate, //"2023-08-28T02:27:23.000",
        "genderType": genderType,
        "eventPrice": eventPrice,
        "eventType": eventType,
        "entranceCode": entranceCode,
      };
      print("Subscribe Event Data ❌ ${data.toString()}");
      var response = await API().post(
        ApiManager.SUBSCRIBE_EVENT + eventId + "/subscribe",
        data,
      );
      print("response<<>><<PAYMENT_CHECKOUT>>-->> ${response.data}");
      if (response == null) {
      } else if (response.data["error"] == false) {
        isReserveEvent = true;
        print("Done Reservation 🧨🧨🧨🧨🧨🧨");
        Get.offAllNamed(AppRoutes.NAV_ROOT);
        // Toast().success(massage: response.data["msg"].toString());
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return isReserveEvent;
  }

  Future<ETickerModel> onReserveEventService({required Map dt}) async {
    ETickerModel reserveEventTicket = ETickerModel();
    try {
      Map data = dt;
      print(dt);
      // {
      //   "genderType": gender,
      //   "price": eventPrice,
      // };
      var response = await API().post(ApiManager.PAYMENT_CHECKOUT, data);
      print("response-->> $response");
      if (response == null) {
      } else if (response.data["error"] == false) {
        reserveEventTicket = ETickerModel.fromJson(response.data);
        // Toast().success(massage: response.data["msg"].toString());
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return reserveEventTicket;
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
      } else if (response.statusCode == 200) {
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
}
