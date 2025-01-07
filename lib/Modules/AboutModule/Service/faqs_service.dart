import 'package:get/get.dart';
import 'package:partylux/Modules/AboutModule/Model/faqs_model.dart';
import 'package:partylux/Utils/Network/api_client.dart';
import 'package:partylux/Utils/Network/api_urls.dart';
import 'package:partylux/Utils/Network/tost.dart';

mixin FAQsService {
  // Future   {
  //   //  var  response = await API().get(ApiManager.ABOUT_PARTYLUX);
  //   //   htmlData.value = response.data["data"]["partyLux"];
  //     return

  // }

  Future<List<Faqsmodel>> onGetFAQs() async {
    List<Faqsmodel> data = [];
    try {
      var response = await API().get(ApiManager.FAQS);
      print("response-->> $response");
      if (response == null) {
      } else if (response.data["error"] == false) {
        data = Faqsmodel.fromJsonToList(response.data["data"]["faqs"]);
        // Toast().success(massage: response.data["msg"].toString());
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return data;
  }

  Future<bool> onPostSupport({
    required String name,
    required String email,
    required String message,
  }) async {
    bool result = false;
    try {
      Map data = {
        "firstName": name,
        "email": email,
        "message": message,
        "isActive": true
      };
      print(data);
      var response = await API().post(ApiManager.SUPPORT, data);

      if (response == null) {
      } else if (response.data["error"] == false) {
        result = true;
        Get.back();
        //Toast().success(massage: response.data["msg"].toString());
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return result;
  }
}
