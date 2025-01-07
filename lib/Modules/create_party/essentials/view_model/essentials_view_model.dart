import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Modules/create_party/create_my_party/view_model/create_party_view_model.dart';

class EssentialsViewModel extends GetxController {

  final viewModel=Get.find<CreatePartyViewModel>();

  final TextEditingController essentials=TextEditingController();

  final RxList<String> tags=List<String>.empty().obs;
  final RxBool isSuggested = true.obs;

 // final List<String> selected=[];

  @override
  void onInit() {
    setFields(viewModel.event);
    super.onInit();
  }

  void setFields(EventModel event){
    tags.value = event.entertainment??=[];
    if(event.entertainment!.isNotEmpty) {
      isSuggested.value=false;
    }
  }

}