import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../view_model/create_buisness_vm.dart';

class TimingModel {
  RxBool isClose;
  Weekdays title;
  RxString? startTime = "".obs;
  RxString? endTime = "".obs;
  Rx<DateTime>? startTimeUTC = DateTime.now().toUtc().obs;
  Rx<DateTime>? endTimeUTC = DateTime.now().toUtc().obs;
  RxBool? isSameTimeEnable = false.obs;

  TimingModel({
    required this.isClose,
    required this.title,
    this.startTime,
    this.endTime,
    this.isSameTimeEnable,
    this.startTimeUTC,
    this.endTimeUTC,
  });

}
