import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Modules/create_party/create_my_party/view_model/create_party_view_model.dart';
import 'package:partylux/Utils/Util.dart';
import 'package:partylux/Utils/helper_functions.dart';
import 'package:partylux/models/dropdown.dart';

class PrivacyViewModel extends GetxController {

  final viewModel=Get.find<CreatePartyViewModel>();

  final RxBool ownCode=false.obs,private=false.obs;

  final TextEditingController code=TextEditingController();

  final Rxn<DropDownItem?> value = Rxn(),value2=Rxn();
/*
  final List<ValueType<int>> items = [ValueType(text: "1",value: 1),ValueType(text: "2",value: 2),
    ValueType(text: "3",value: 3),
    ValueType(text: "4",value: 4),];*/

  final List<ValueType<int>> stopItems=[
    ValueType(text: "1 week before",value: 1),ValueType(text: "3 days before",value: 3),
    ValueType(text: "1 day before",value: 1),
    ValueType(text: "1 hour before",value: 1), ValueType(text: "never",value: 0),
  ];

/*  final List<ValueType<int>> cancelItems = [ValueType(text: "1",value: 1),ValueType(text: "2",value: 2),
    ValueType(text: "3",value: 3),
    ValueType(text: "4",value: 4),];*/



  @override
  void onInit() {
    setFields(viewModel.event);
    super.onInit();
  }

  void setFields(EventModel event){
    private.value=event.eventType==EventModel.TYPE_PRIVATE;
    ownCode.value=event.ownCode!;
    code.text=event.partyCode??"";
    value.value=event.stopBooking;
    value2.value=event.cancelPolicy;
    print("value 1: ${event.stopBooking?.value} ${event.stopBooking?.id}");
    print("value 2: ${event.cancelPolicy?.value} ${event.stopBooking?.id}");
  }

  void generateCode(EventModel event){
    code.text=RandomGenerator.generateRandomString2();
    event.partyCode=code.text;
    Util.showToast("Saved!");
  }

}