import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/constants.dart';
import 'package:partylux/Modules/Auth%20Module/Models/usermodel.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Modules/Search%20Module/View/all_result/inside_container.dart';
import 'package:partylux/Modules/Search%20Module/service/search_service.dart';
import 'package:partylux/Utils/Network/cache_handler.dart';
import 'package:partylux/models/page_model.dart';

class HomeSearchViewModel extends GetxController with GetTickerProviderStateMixin,SearchService{

  final Map<String,PageModel<EventModel>> events={};

  late TabController tabController;

  final List<Widget> screens=[InsideContainer(type: EventModel.CATEGORY_CLUB),
    InsideContainer(type: EventModel.CATEGORY_BAR),
    InsideContainer(type: EventModel.CATEGORY_HOUSEPARTY),];

  final Rx<UserModel> userData = UserModel.fromEmpty().obs;

  final List<String> titles=["Clubs","Bars","Parties"];

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    var arguments=Get.arguments;
    tabController=TabController(length: screens.length, vsync: this,);
    searchController.text=arguments?[Constants.paramFrom]??"";
    getUserDetail();
    super.onInit();
  }

  Future<void> getUserDetail() async {
    userData.value = await DatabaseHandler().getUserData();
  }

  Future<PageModel<EventModel>?> getResults({int page=1,String? category,}){
    Map<String,dynamic> map={

    };
    if(category!=null){
      map["eventCategory"]=category;
    }
    return getEvents(page: page,body: map,search: searchController.text);
  }

}