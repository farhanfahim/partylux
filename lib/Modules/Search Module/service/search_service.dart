import 'package:partylux/Constants/integer.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Modules/Search%20Module/Model/search_model.dart';
import 'package:partylux/Utils/Network/api_client.dart';
import 'package:partylux/Utils/Network/api_urls.dart';
import 'package:partylux/Utils/Network/tost.dart';
import 'package:partylux/models/page_model.dart';

mixin SearchService {

  Future<PageModel<SearchModel>?> getSearches({int page = 1,int limit = AppInteger.PAGE_LIMIT,
    Map<String, dynamic> body = const {},String search=""}) async{

    PageModel<SearchModel>? events;

    final Map<String, dynamic> map = {
      'page': page,
      'limit': limit,
      "isPaginated": 1,
    }..addAll(body);

    print("get search body: ${map}");

    try {

      var response = await API().get(
        ApiManager.GET_RECENT_SEARCHES,
        queryParameters: map,
      );

      //var response = await API().get(ApiManager.GET_MY_EVENT + "page=$pageNo");

      print("response GET_MY_EVENT -->> $response");
      if (response == null) {
      } else if (response.data["error"] == false) {
        var data=response.data["data"];
        events=PageModel.fromJson(data["data"], data, (d) {
          return SearchModel.fromJson(d);
        });
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return events;
  }

  Future<PageModel<EventModel>?> getEvents({int page = 1,int limit = AppInteger.PAGE_LIMIT,
    Map<String, dynamic> body = const {},String search=""}) async{

    PageModel<EventModel>? events;

    final Map<String, dynamic> map = {
      'page': page,
      'limit': limit,
      "isPaginated": 1,
    }..addAll(body);

    if(search.isNotEmpty){
      map["searchEvent"]=search;
    }

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

  Future<bool> deleteSearch(String id) async {
    bool val=false;
    try {
      var response = await API().delete("${ApiManager.DELETE_RECENT_SEARCHES}/$id",);

      print("response-->> $response");
      if (response == null) {
      } else if (response.data["message"] == "Search deleted successfully") {
        //Get.back();
       // Toast().success(massage: response.data["message"].toString());
        val=true;
      } else {
        Toast().error(massage: response.data["message"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }

    return val;
  }

  Future<bool> clearSearch() async {
    bool val=false;
    try {
      var response = await API().delete(ApiManager.CLEAR_RECENT_SEARCHES);

      print("response-->> $response");
      if (response == null) {
      } else if (response.data["message"] == "Search deleted successfully") {
        //Get.back();
        //Toast().success(massage: response.data["message"].toString());
        val=true;
      } else {
        Toast().error(massage: response.data["message"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }

    return val;
  }

}