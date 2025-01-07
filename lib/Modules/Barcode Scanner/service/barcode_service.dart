import 'package:partylux/Utils/Network/api_client.dart';
import 'package:partylux/Utils/Network/api_urls.dart';

abstract class ClubService {

  Future onCheckIn({
    required Map data,
  }) async {


    int isLogout = 0;
    try {
      var response = await API().barCodePost(ApiManager.CHECK_IN, data,);

      if (response.data["status"] == 200) {
        isLogout = 1;
      }  else if(response.data["status"] == 202){
        isLogout = 2;
      }else if (response.data["status"] == 403) {
        isLogout = 0;
      }else {
        isLogout = 0;
      }
    } catch (e) {
      print("error-->> $e");
    }
    return isLogout;
  }

}
