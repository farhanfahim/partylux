import 'package:get/get.dart';
import 'package:partylux/Constants/constants.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';

class CreatePartySuccessViewModel extends GetxController {

  late EventModel event;

  @override
  void onInit() {
    var arguments=Get.arguments;
    event=arguments[Constants.paramFrom];
    super.onInit();
  }


}