import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Modules/create_party/create_my_party/view_model/create_party_view_model.dart';

class PaymentViewModel extends GetxController {

  final viewModel=Get.find<CreatePartyViewModel>();

  final TextEditingController cashApp=TextEditingController(),venmo=TextEditingController(),
      benifitPay=TextEditingController();

  @override
  void onInit() {
    setFields(viewModel.event);
    super.onInit();
  }


  void setFields(EventModel event){
    cashApp.text=event.cashApp??"";
    venmo.text=event.venmo??"";
    benifitPay.text=event.benifitPay??"";
  }

}