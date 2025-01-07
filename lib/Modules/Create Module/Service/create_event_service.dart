import 'package:get/get.dart';
import 'package:partylux/Modules/Create%20Module/Model/card_model.dart';
import 'package:partylux/Utils/Network/api_client.dart';
import 'package:partylux/Utils/Network/api_urls.dart';
import 'package:partylux/Utils/Network/multipart_client.dart';
import 'package:partylux/Utils/Network/tost.dart';
import '../Model/create_model.dart';

abstract class CreateEventService {
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

  Future<CreateEventModel> onCreateEvent(
    Map<String, dynamic> data,
  ) async {
    CreateEventModel createEventModel = CreateEventModel.fromEmpty();
    try {
      var response = await API().post(ApiManager.CREATE_EVENT, data);

      print("response-->> $response");
      if (response == null) {
      } else if (response.data["error"] == false) {
        Get.back();
        //Toast().success(massage: response.data["msg"].toString());
        createEventModel = CreateEventModel.fromJson(response.data["data"]);
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }

    return createEventModel;
  }

  Future<CreateEventModel> onUpdateEvent(Map<String, dynamic> data,
      {required String eventID}) async {

    print(data);
    CreateEventModel createEventModel = CreateEventModel.fromEmpty();
    try {
      var response = await API().patch(ApiManager.UPDATE_EVENT + eventID, data);

      print("response-->> $response");
      if (response == null) {
      } else if (response.data["error"] == false) {
        Get.back();
        //Toast().success(massage: response.data["msg"].toString());
        createEventModel = CreateEventModel.fromJson(response.data["data"]);
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }

    return createEventModel;
  }

  Future<CreateEventCard> onCreatedEventVIPCard(
    Map<String, dynamic> data,
  ) async {
    CreateEventCard createdEventCards = CreateEventCard.fromEmpty();
    try {
      var response = await API().post(ApiManager.ADD_EVENT_VIP_CARD, data);

      print("response-->> $response");
      if (response == null) {
      } else if (response.statusCode == 200) {
        Get.back();
        //Toast().success(massage: response.data["msg"].toString());
        createdEventCards = CreateEventCard.fromJson(response.data["data"]);
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }

    return createdEventCards;
  }
  //
}
