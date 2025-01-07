import 'package:partylux/Modules/TicketModule/Model/ticket_model.dart';
import 'package:partylux/Utils/Network/api_client.dart';
import 'package:partylux/Utils/Network/api_urls.dart';
import 'package:partylux/Utils/Network/tost.dart';

import '../../../Constants/integer.dart';
import '../../../models/page_model.dart';
import '../../people_joined/model/order_model.dart';

mixin TicketService {

  Future<PageModel<OrderModel>?> getOrdersApi({int page = 1,int limit = AppInteger.PAGE_LIMIT,
    Map<String, dynamic> body = const {},}) async {
    PageModel<OrderModel>? orderModel;


    final Map<String, dynamic> map = {
      'page': page,
      'limit': limit,
      "isPaginated": 1,
    }..addAll(body);

    print("get order body: ${map}");

    try {
      var response = await API().get(
        ApiManager.GET_ORDERS,queryParameters: map,
      );

      print("order response: ${response.data}");
      if (response == null) {
      } else if (response.statusCode == 200) {
        var data=response.data["data"];
        orderModel=PageModel.fromJson(data["data"], data, (d) {
          return OrderModel.fromJson(d);
        });
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return orderModel;
  }

  Future<TicketModel> getSingleOrder(
      String userID,
      ) async {
    TicketModel? orderModel;
    try {
      var response = await API().get(ApiManager.GET_SINGLE_ORDERS + "$userID");
      if (response == null) {
      } else if (response.data["error"] == false) {
        print(response.data["data"]);
        orderModel = TicketModel.fromJson(response.data["data"]);
      }
    } catch (e) {
      print("error-<<[[]][[]]->> $e");
    }
    return orderModel!;
  }
}
