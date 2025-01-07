import 'package:get/get.dart';
import 'package:partylux/Modules/Create%20Module/Model/create_model.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Utils/Network/api_client.dart';
import 'package:partylux/Utils/Network/api_urls.dart';
import 'package:partylux/Utils/Network/multipart_client.dart';
import 'package:partylux/Utils/Network/tost.dart';
import 'package:partylux/Utils/Util.dart';

import '../../../../Constants/integer.dart';
import '../../../../models/page_model.dart';
import '../../../BecomePartner/Model/become_partner_model.dart';
import '../../../My Business/Model/business_detail_model.dart';

mixin CreatePartyService {


  Future<EventModel?> onCreateEvent(
      Map<String, dynamic> data,
      ) async {
    EventModel? val;
    try {
      var response = await API().post(ApiManager.CREATE_EVENT, data);

      print("create event response-->> $response");
      if (response == null) {
      } else if (response.data["error"] == false) {
        //Get.back();
        var data=response.data["data"];
        val=EventModel.fromJson(data);
       // Toast().success(massage: response.data["msg"].toString());

      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }

    return val;
  }

  Future<EventModel?> onUpdateEvent(String id, Map<String, dynamic> data,) async {
    EventModel? val;
    try {
      var response = await API().patch("${ApiManager.UPDATE_EVENT}/$id", data);

      print("edit event response-->> $response");
      if (response == null) {
      } else if (response.data["error"] == false) {
        //Get.back();
        var data=response.data["data"];
        val=EventModel.fromJson(data);
       // Toast().success(massage: response.data["msg"].toString());

      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }

    return val;
  }

  Future<List<String>> onUploadPicture({
    required List<String> imageFileList,
  }) async {
    List<String> urlImagesList = [];
    try {

      List<String> urlList = await MultiPartAPI().multiImageUpload(
        imageFileList,
      );

      print("urlList ${urlList.length}");
      if (urlList.length > 0) {
        urlImagesList = urlList;
      } else {
        print("urlList is empty");
      }
    } catch (e) {
      print("error-->> $e");
    }
    print(urlImagesList.length);
    return urlImagesList;
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


  Future<PageModel<BecomePartnerModel>?> getBusiness({int page = 1,int limit = AppInteger.PAGE_LIMIT,
    Map<String, dynamic> body = const {},String search=""}) async{

    PageModel<BecomePartnerModel>? events;

    final Map<String, dynamic> map = {
      'page': page,
      'limit': limit,
      "isPaginated": 1,
    }..addAll(body);

    print("get body: ${map}");

    try {

      var response = await API().get(
        ApiManager.GET_BUSINESS_LIMITED,
        queryParameters: map,
      );

      print("response -->> $response");
      if (response == null) {
      } else if (response.data["error"] == false) {
        var data=response.data["data"];
        events=PageModel.fromJson(data["businesses"], data, (d) {
          return BecomePartnerModel.fromJson(d);
        });
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return events;
  }

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

}