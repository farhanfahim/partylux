import 'package:flutter/cupertino.dart';
import 'package:partylux/Constants/integer.dart';
import 'package:partylux/Modules/Create%20Module/Model/create_model.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Modules/people_joined/model/order_model.dart';
import 'package:partylux/Utils/Network/api_client.dart';
import 'package:partylux/Utils/Network/api_urls.dart';
import 'package:partylux/Utils/Network/tost.dart';

import '../../../Utils/Network/cache_handler.dart';
import '../../../models/page_model.dart';
import '../../Auth Module/Models/usermodel.dart';

abstract class EventService {


  Future<PageModel<EventModel>?> getEvents({int page = 1,int limit = AppInteger.PAGE_LIMIT,
    Map<String, dynamic> body = const {},String search=""}) async{

    PageModel<EventModel>? events;

    final Map<String, dynamic> map = {
      'page': page,
      'limit': limit,
      "isPaginated": 1,
    }..addAll(body);

    print("get event body: ${map}");

    try {

      var response = await API().get(
        ApiManager.GET_EVENTS,
        queryParameters: map,
      );

      //var response = await API().get(ApiManager.GET_MY_EVENT + "page=$pageNo");

      print("response GET_MY_EVENT -->> $response");
      if (response == null) {
      } else if (response.data["error"] == false) {
        var data=response.data["data"];
        events=PageModel.fromJson(data["data"], data, (d) {
          return EventModel.fromJson(d);
        });
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return events;
  }



  Future<PageModel<OrderModel>?> getOrdersApi({int page = 1,int limit = AppInteger.PAGE_LIMIT,
    Map<String, dynamic> body = const {},String search=""}) async {
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
}
