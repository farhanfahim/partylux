import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Modules/Create%20Module/Model/create_model.dart';
import 'package:partylux/Modules/Event%20Module/View%20Model/event_viewmodel.dart';
import 'package:partylux/Modules/Event%20Module/View/Components/event_tile.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Utils/navigation.dart';
import 'package:partylux/Utils/pagenation/paged_listview.dart';
import 'package:partylux/Utils/pagenation/paged_view.dart';
import 'package:partylux/models/page_model.dart';

import '../../../Constants/color.dart';
import '../../../Constants/constants.dart';
import '../../Home Module/View/Components/shimmer_view.dart';

class InsideEventContainer extends StatelessWidget {

  final int index;
  InsideEventContainer({Key? key,required this.index,}) : super(key: key);

  final GlobalKey<PagedViewState> pageKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    final _eventVM = Get.find<EventViewModel>();
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        pageKey.currentState?.reloadPage();
      },child: PaginatedListView<EventModel>(
        key: pageKey,
   //   padding: EdgeInsets.zero,
      initialItems: _eventVM.events[index],
      onFetchPage: (page){
          return _eventVM.getMyEvents(page: page,index: index);
      },
      onDispose: (list){
        _eventVM.events[index]=list as PageModel<EventModel>;
      },
      separatorBuilder: (con,ind){
        return const SizedBox.shrink();
      },
      itemBuilder: (ind,item){
        return MyEventTile(
          data: item,
          currentUserGender: _eventVM.userData.value.profile!.gender!,
          eventType: Constants.EVENT_MY_EVENT,
          callback: (EventModel data, String eventType) {
            AppNavigator.navigateToNamed(AppRoutes.myEvent,arguments: [data.sId,
              index==0?Constants.EVENT_MY_EVENT:index==1?Constants.EVENT_RESERVED:
                  index==2?Constants.EVENT_CLOSED:""
            ])?.then((value) {
              pageKey.currentState?.refreshPage();
            });

          },
        );
      },
      initialLoader: viewAllEventsShimmer(),
    ),);
  }
}
