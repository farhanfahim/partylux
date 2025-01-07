import 'package:get/get.dart';
import 'package:partylux/Modules/TicketModule/Model/ticket_model.dart';
import 'package:partylux/Modules/TicketModule/Service/ticker_service.dart';

import '../../../Utils/Network/api_client.dart';
import '../../../Utils/Network/api_urls.dart';
import '../../../Utils/Network/cache_handler.dart';
import '../../../models/page_model.dart';
import '../../Auth Module/Models/usermodel.dart';
import '../../people_joined/model/order_model.dart';

class TicketDetailViewModel extends GetxController with TicketService {

  RxBool isDataLoading = true.obs;
  Rx<TicketModel>? orderModel = TicketModel().obs;

  @override
  void onInit() async {
    super.onInit();
    getSingleOrderDetail(Get.arguments[0]);
  }

   void getSingleOrderDetail(
      String userID,
      ) async {
     try {
       var response = await API().get(ApiManager.GET_SINGLE_ORDERS + "$userID");
       if (response == null) {} else if (response.data["error"] == false) {
         orderModel!.value = TicketModel.fromJson(response.data["data"]);
         print(response.data["data"]);
         isDataLoading.value = false;
       }
     } catch (e) {
       print("error-<<[[]][[]]->> $e");
     }
   }
}
