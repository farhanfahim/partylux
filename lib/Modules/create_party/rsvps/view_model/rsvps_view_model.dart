import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Modules/create_party/create_my_party/view_model/create_party_view_model.dart';
import 'package:partylux/models/dropdown.dart';
import 'package:partylux/models/dropdown.dart';

class RsvpsViewModel extends GetxController {

  final Rxn<DropDownItem?> value = Rxn();

  final viewModel=Get.find<CreatePartyViewModel>();
  RxBool isMaxCapacity = false.obs;
  final TextEditingController numParticipants=TextEditingController();

  final List<ValueType<int>> items = List.generate(10, (index) {
    return ValueType(text: "${index+1}",value: index+1);
  });

  @override
  void onInit() {
    setFields(viewModel.event);
    super.onInit();
  }

  void setFields(EventModel event){
    //value.value=event.maxGuest;
    numParticipants.text=event.maxParticipants?.toString()??"";
    value.value=event.maxGuest;
    isMaxCapacity.value = event.maxCapacity!;
  }

}
