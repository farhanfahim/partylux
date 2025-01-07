import 'package:get/get.dart';
import 'package:partylux/Utils/Network/api_client.dart';
import 'package:partylux/Utils/Network/api_urls.dart';
import 'package:partylux/Utils/Network/multipart_client.dart';
import 'package:partylux/Utils/Network/tost.dart';

import '../../../Constants/constants.dart';
import '../../create_business/model/become_partner_model.dart';
import '../Model/business_card_model.dart';

abstract class BecomePartnerService {
  Future<List<String>> onUploadPicture({
    required List<String> imageFileList,
  }) async {
    List<String> imagesPathList = [];
    List<String> urlImagesList = [];
    for (int i = 0; i < imageFileList.length; i++) {
      if (imageFileList[i].contains("https://")) {
        urlImagesList.add(imageFileList[i]);
      } else {
        imagesPathList.add(imageFileList[i]);
      }
    }
    try {
      List<String> urlList =
          await MultiPartAPI().multiImageUpload(imagesPathList);

      print("urlList ${urlList.length}");
      if (urlList.length > 0) {
        urlImagesList.addAll(urlList);
      } else {
        print("urlList is empty");
      }
    } catch (e) {
      print("error-->> $e");
    }
    print(urlImagesList.length);
    return urlImagesList;
  }

  // Future<List<String>> onUploadPictures({
  //   required List<File> imageFileList,
  // }) async {
  //   List<String> urlImagesList = [];
  //   String token = await DatabaseHandler().getTempToken();
  //   try {
  //     List<String> urlList = await MultiPartAPI().multiImageUpload(
  //       ApiManager.UPLOAD_PHOTO,
  //       imageFileList,
  //       accessToken: token,
  //     );

  //     print("urlList ${urlList.length}");
  //     if (urlList.length > 0) {
  //       urlImagesList = urlList;
  //     } else {
  //       print("urlList is empty");
  //     }
  //   } catch (e) {
  //     print("error-->> $e");
  //   }
  //   print(urlImagesList.length);
  //   return urlImagesList;
  // }

  // Future<bool> onCreateEvent(Map<String, dynamic> data) async {
  //   bool resultSuccess = false;
  //   String token = await DatabaseHandler().getTempToken();
  //   try {
  //     var response =
  //         await API().post(ApiManager.BECOME_PARTNER, data, tempToken: token);
  //     print("response-->> $response");
  //     if (response == null) {
  //     } else if (response.data["error"] == false &&
  //         response.data["status"] == 200) {
  //       // if (isShowArrow != "signup") {
  //       //   Get.close(3);
  //       // }
  //       await DatabaseHandler().setToken(token);

  //       Toast().success(massage: response.data["msg"].toString());
  //       resultSuccess = true;
  //       //CreateEventModel.fromJson(response.data["data"]);
  //     } else {
  //       Toast().error(massage: response.data["msg"].toString());
  //     }
  //   } catch (e) {
  //     print("error-->> $e");
  //   }

  //   return resultSuccess;
  // }

  Future<CreateBusinessCard> onCreatedBusinessVIPCard(
    Map<String, dynamic> data,
  ) async {
    CreateBusinessCard createdEventCards = CreateBusinessCard.fromEmpty();
    try {
      var response = await API().post(ApiManager.ADD_EVENT_VIP_CARD, data);

      print("response-->> $response");
      if (response == null) {
      } else if (response.statusCode == 200) {
        Get.back();
        //Toast().success(massage: response.data["msg"].toString());
        createdEventCards = CreateBusinessCard.fromJson(response.data["data"]);
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return createdEventCards;
  }

  Future<bool> onCreateBusiness(
    Map<String, dynamic> data,
    String type,
  ) async {
    RxBool isSuccess = false.obs;
    try {
      var response = await API().post(type==Constants.REGISTER ?ApiManager.REGISTER_BUSINESS:ApiManager.BECOME_PARTNER, data);
      print("response-->> $response");
      if (response == null) {
      } else if (response.data["error"] == false) {
        Get.back();
        if(type==Constants.REGISTER) {
         // Toast().success(massage: response.data["msg"].toString());
        }
        isSuccess.value = true;
      } else {
        Toast().error(massage: response.data["msg"].toString());
        isSuccess.value = false;
      }
    } catch (e) {
      print("error-->> $e");
      isSuccess.value = false;
    }

    return isSuccess.value;
  }

  Future<bool> onUpdateBusiness(
    Map<String, dynamic> data, {
    required String eventId,
  }) async {
    bool isSuccess = false;
    try {
      var response =
          await API().put(ApiManager.UPDATE_BUSINESS_DETAIL + eventId, data);

      print("response-->> $response");
      if (response == null) {
      } else if (response.data["error"] == false) {
        isSuccess = true;
        Get.back();
        //Toast().success(massage: response.data["msg"].toString());
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }

    return isSuccess;
  }

  Future<BecomePartnerModel> onUpdateBusinessState(
    Map<String, dynamic> data, {
    required String eventId,
  }) async {
    BecomePartnerModel businessModel = BecomePartnerModel();
    try {
      var response =
          await API().patch(ApiManager.UPDATE_BUSINESS + eventId, data);

      print("response-->> $response");
      if (response == null) {
      } else if (response.data["error"] == false) {
       // Toast().success(massage: response.data["msg"].toString());
        businessModel = BecomePartnerModel.fromJson(response.data["data"]);
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }

    return businessModel;
  }
}
