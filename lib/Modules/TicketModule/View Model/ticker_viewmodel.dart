import 'package:get/get.dart';
import 'package:partylux/Modules/TicketModule/Model/ticket_model.dart';
import 'package:partylux/Modules/TicketModule/Service/ticker_service.dart';

import '../../../Utils/Network/cache_handler.dart';
import '../../../models/page_model.dart';
import '../../Auth Module/Models/usermodel.dart';
import '../../people_joined/model/order_model.dart';

class TicketViewModel extends GetxController with TicketService {

  final Rx<UserModel> userData = UserModel.fromEmpty().obs;

  PageModel<OrderModel>? paginatedEventsList;

  RxBool isDataLoading = true.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
  }


  Future<PageModel<OrderModel>?> getTickets({
    int page = 1,
  }) async {
    userData.value = await DatabaseHandler().getUserData();
    if(userData.value.sId!.isNotEmpty) {
      Map<String, dynamic> map = {
        "filterUserId": userData.value.sId,
      };
      return getOrdersApi(body: map, page: page);
    }
  }

}
