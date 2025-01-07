import 'package:partylux/Constants/integer.dart';
import 'package:partylux/Modules/payment_module/add_card/model/card_model.dart';
import 'package:partylux/Utils/Network/api_client.dart';
import 'package:partylux/Utils/Network/api_urls.dart';
import 'package:partylux/Utils/Network/tost.dart';
import 'package:partylux/models/page_model.dart';

mixin CardService{

  Future<bool> onCreateCard(
      Map<String, dynamic> data,
      ) async {
  //  EventModel? val;
    bool stat=false;
    try {
      var response = await API().post(ApiManager.ADD_CARD, data);

      print("create card response-->> $response");
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


  Future<PageModel<CardModel>?> getUserCards({int page = 1,int limit = AppInteger.PAGE_LIMIT,
    Map<String, dynamic> body = const {},String search="",bool paginate=true}) async{

    PageModel<CardModel>? events;

    final Map<String, dynamic> map = {
      'page': page,
      'limit': limit,
      "isPaginated": paginate?1:0,
    }..addAll(body);

    try {

      var response = await API().get(
        ApiManager.ADD_CARD,
        queryParameters: map,
      );

      //var response = await API().get(ApiManager.GET_MY_EVENT + "page=$pageNo");

      print("response cards -->> $response");
      if (response == null) {
      } else if (response.data["success"] == true) {
        var data=response.data["data"];
        events=PageModel.fromJson(data, null, (d) {
          return CardModel.fromJson(d);
        });
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return events;
  }

  Future<bool> onDeleteCard(
      String id
      ) async {
    //  EventModel? val;
    bool stat=false;
    try {
      var response = await API().delete("${ApiManager.ADD_CARD}/$id",);

      print("delete card response-->> $response");
      if (response == null) {
      } else if (response.data["success"] == true) {
        stat=true;
        var data=response.data["data"];
          // Toast().success(massage: response.data["message"].toString());

      } else {
        Toast().error(massage: response.data["message"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }

    return stat;
  }

}