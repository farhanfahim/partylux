import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Utils/Network/api_client.dart';
import 'package:partylux/Utils/Network/api_urls.dart';
import 'package:partylux/Utils/Network/multipart_client.dart';
import 'package:partylux/Utils/Network/tost.dart';

mixin CreateFlyerService{

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

  Future<String> onUploadVideo({
    required String url,
  }) async {
    String videUrl = '';
    try {
      var response = await MultiPartAPI().videoUpload(
        ApiManager.UPLOAD_VIDEO,
        url,
      );
      print(response.data.toString());
      if (response == null) {
      } else if (response.data["error"] == false) {
        videUrl = response.data["data"]["videoUrl"];
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }

    return videUrl;
  }

  Future<bool> onCreateFlyer(
      Map<String, dynamic> data,
      ) async {
    bool val=false;
    try {
      var response = await API().post(ApiManager.CREATE_FLYER, data);

      print("create flyer response-->> $response");
      if (response == null) {
      } else if (response.data["error"] == false) {
        //Get.back();
        val=true;
        var data=response.data["data"];
     //   val=EventModel.fromJson(data);
       // Toast().success(massage: "Event Created");

      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }

    return val;
  }

}