import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Modules/Home%20Module/View/Components/shimmer_view.dart';
import 'package:partylux/Modules/Search%20Module/View%20Model/home_search_vm.dart';
import 'package:partylux/Modules/Search%20Module/component/event_tile.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/pagenation/paged_listview.dart';
import 'package:partylux/Utils/pagenation/paged_view.dart';
import 'package:partylux/models/page_model.dart';

import '../../../../Constants/app_routes.dart';
import '../../../../Constants/color.dart';
import '../../../../Constants/constants.dart';
import '../../../../Utils/Common/not_found_text.dart';

class InsideContainer extends StatelessWidget {
  final String type;
  InsideContainer({Key? key,required this.type,}) : super(key: key);

  final GlobalKey<PagedViewState> pageKey=GlobalKey();


  @override
  Widget build(BuildContext context) {
    final _searchVM = Get.find<HomeSearchViewModel>();
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        pageKey.currentState!.reloadPage();
      },child: PaginatedListView<EventModel>(
      key: pageKey,
      padding: EdgeInsets.symmetric(vertical: AppSizer.getVerticalSize(AppDimen.vertPadd)),
      initialItems: _searchVM.events[type],
      onFetchPage: (page){
        return _searchVM.getResults(page: page,category: type);
      },
      onDispose: (list){
        _searchVM.events[type]=list as PageModel<EventModel>;
      },
      separatorBuilder: (con,ind){
        return const SizedBox.shrink();
      },
      notFoundWidget: NotFoundText(text: "No Results Match Your Query.",),
      itemBuilder: (ind,item){
        return EventTile(onTap:(){
          if(_searchVM.userData.value.sId == item.userId) {
            Get.toNamed(
                AppRoutes.myEvent, arguments: [item.sId, Constants.EVENT_MY_EVENT])!;
          } else{
            if( item.eventType == Constants.EVENT_PRIVATE) {
              Get.toNamed(
                  AppRoutes.myEvent, arguments: [item.sId, Constants.EVENT_PRIVATE])!;
            } else{
              Get.toNamed(
                  AppRoutes.myEvent, arguments: [item.sId, Constants.EVENT_OTHER])!;
            }
          }
        },item: item,
          currentUserGender: _searchVM.userData.value.profile!.gender!,);
      },
      initialLoader: notificationShimmer(),
    ),);
  }
}
