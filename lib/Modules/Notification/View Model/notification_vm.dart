import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../Model/notification_model.dart';
import '../Service/notification_service.dart';

class NotificationViewModel extends GetxController with NotificationService {


  RxList<NotificationModel> listOfNotification = List<NotificationModel>.empty().obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getNotification();

  }

  void getNotification(){
    onNotificationService().then((value) => {
      listOfNotification.value = value,
      isLoading.value = false,
    });
  }
  Future<bool> deleteNotification(
    String notificationID,
  ) async {
    bool isResult = await onDeleteNotificationService(notificationID);
    return isResult;
  }
}
