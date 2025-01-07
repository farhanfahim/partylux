import 'package:partylux/Modules/BecomePartner/Model/become_partner_model.dart';
import 'package:partylux/Utils/Network/api_client.dart';
import 'package:partylux/Utils/Network/api_urls.dart';
import 'package:partylux/Utils/Network/tost.dart';

import '../../../Constants/integer.dart';
import '../../../models/page_model.dart';

abstract class ClubService {


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

}
