// ignore_for_file: unused_local_variable, invalid_use_of_protected_member

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Modules/Search%20Module/Model/search_model.dart';
import 'package:partylux/Modules/Search%20Module/service/search_service.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/pagenation/paged_view.dart';
import 'package:partylux/models/page_model.dart';

import '../../../Utils/Network/cache_handler.dart';
import '../../Auth Module/Models/usermodel.dart';

class SearchViewModel extends GetxController with GetTickerProviderStateMixin,SearchService {
  Rx<UserModel> userData = UserModel.fromEmpty().obs;

  @override
  void onInit() {
    loadRecentSearches();
    super.onInit();
    getUserDetail();
  }

  void getUserDetail() async {
    print("object");
    userData.value = await DatabaseHandler().getUserData();
    userData.refresh();

  }
  Rx<PageModel<SearchModel>> recentSearches= PageModel<SearchModel>().obs;
  Rx<PageModel<EventModel>> eventList= PageModel<EventModel>().obs;


  //Rx<TextEditingController> searchController = TextEditingController().obs;

  final TextEditingController searchController = TextEditingController();



  Future<PageModel<SearchModel>?> getRecentSearches({int page=1,}){
    return getSearches(page: page,);
  }

  Future<void> loadRecentSearches() async{
    getSearches(limit: 10).then((value) {
      if(value!=null){
        recentSearches.value=value;
      }
    });
  }

  void targetSearch(String text){
    searchController.text=text;
    loadResults();
  }

  Future<void> loadResults() async{
    if(searchController.text.isNotEmpty) {
      eventList.value=PageModel();
      getEvents(limit: 3, search: searchController.text,).then((value) {
        if (value != null) {
          eventList.value = value;
        }
      });
    }
  }



  Future<void> deleteRecentSearch(SearchModel model,{GlobalKey<PagedViewState>? key,}) async{
    EasyLoading.show(
      status: 'Please Wait . . .',
      indicator: CupertinoActivityIndicator(
        color: AppColors.whiteText,
        radius: SizeConfig.screenWidth * 0.05,
      ),
    );
    bool val=await deleteSearch(model.id!);
    if(val){
      if(key!=null){
        key.currentState?.removeItem(model);
      }
      else{
        recentSearches.value.data?.remove(model);
        recentSearches.refresh();
      }
    }
    EasyLoading.dismiss();
  }

  Future<void> clearRecentSearch(GlobalKey<PagedViewState> key,) async{
    var list=key.currentState?.pagingController.itemList??[];
    if(list.isNotEmpty) {
      EasyLoading.show(
        status: 'Please Wait . . .',
        indicator: CupertinoActivityIndicator(
          color: AppColors.whiteText,
          radius: SizeConfig.screenWidth * 0.05,
        ),
      );
      bool val = await clearSearch();
      if (val) {
        key.currentState?.clearList();
        recentSearches.value.data?.clear();
        recentSearches.refresh();
      }
      EasyLoading.dismiss();
    }
  }

}
