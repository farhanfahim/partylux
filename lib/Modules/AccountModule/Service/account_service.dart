import 'package:partylux/Utils/Network/api_client.dart';
import 'package:partylux/Utils/Network/tost.dart';

import '../../../Utils/Network/api_urls.dart';

mixin AccountService {
  Future<bool> deleteAccount() async {
    try {
      var response = await API().delete(ApiManager.DELETE_ACCOUNT);

      print("response topTENEvents -->> $response");
      if (response == null) {
      } else if (response.data["error"] == false &&
          response.data["status"] == 200) {
        //Toast().success(massage: response.data["msg"].toString());
        // createEventModel =
        //     CreateEventModel.fromJsonToList(response.data["data"]);
        return true;
      } else {
        Toast().error(massage: response.data["msg"].toString());
        return false;
      }
    } catch (e) {
      print("error-->> $e");
    }
    return false;
  }
}
