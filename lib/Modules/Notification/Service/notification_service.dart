import 'package:partylux/Modules/Notification/Model/notification_model.dart';
import 'package:partylux/Utils/Network/api_client.dart';
import 'package:partylux/Utils/Network/tost.dart';

import '../../../Utils/Network/api_urls.dart';

mixin NotificationService {
  Future<List<NotificationModel>> onNotificationService() async {
    List<NotificationModel> dataList = [];
    try {
      var response = await API().get(ApiManager.NOTIFICATION);
      print("response-->> $response");
      if (response == null) {
      } else if (response.data["success"]) {
        dataList = NotificationModel.fromJsonToList(response.data["data"]);
       /* dataList.add(NotificationModel(role: "user", isReadAll: false, fcmToken: "", id: "", user: "65b90090be23fc4d93495a9e", types: [
          NotificationTypes(title:"You Received an invitation",isRead: false,content: "You have created an event! ",actionId: "",eventName: "invitation",id: "",createdAt: DateTime.now().subtract(Duration( minutes: 1,seconds: 1))),
          NotificationTypes(title:"Your Event is Cancelled",isRead: false,content: "You have successfully sent money to Maria of...",actionId: "cancelled",eventName: "",id: "",createdAt: DateTime.now().subtract(Duration( minutes: 10)))
        ], createdAt: DateTime.now().subtract(Duration( minutes: 1,seconds: 1)), updatedAt: DateTime.now()));

        dataList.add(NotificationModel(role: "user", isReadAll: false, fcmToken: "", id: "", user: "65b90090be23fc4d93495a9e", types: [
          NotificationTypes(title:"Payment Notification",isRead: false,content: "Successfully paid!🤑",actionId: "",eventName: "payment",id: "",createdAt: DateTime.parse("2024-01-30")),
          NotificationTypes(title:"Event Reserve Successfully",isRead: false,content: "You have successfully sent money to Maria of...",actionId: "",eventName: "reserve",id: "",createdAt: DateTime.parse("2024-01-25")),
          NotificationTypes(title:"Purchased LUX Membership",isRead: false,content: "Successfully Purchased",actionId: "",eventName: "membership",id: "",createdAt: DateTime.parse("2024-01-19"))
        ], createdAt: DateTime.parse("2024-01-30"), updatedAt: DateTime.now()));

*/
      } else {
        Toast().error(massage: response.data["message"].toString());
      }
    } catch (e) {
      print("error-->> $e");
     }
    return dataList;
  }

  Future<bool> onDeleteNotificationService(
    String notificationID,
  ) async {
    bool isResult = false;
    try {
      Map data = {"notiObjectId": notificationID};
      var response =
          await API().delete(ApiManager.NOTIFICATION_DELETE, data: data);
      print("response-->> $response");
      if (response == null) {
      } else if (response.data["error"] == false) {
        isResult = false;
      } else {
        Toast().error(massage: response.data["msg"].toString());
      }
    } catch (e) {
      print("error-->> $e");
    }
    return isResult;
  }
}
