import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import '../../../../Constants/color.dart';
import '../../../../Constants/constants.dart';
import '../../../../Utils/pagenation/paged_listview.dart';
import '../../../../Utils/pagenation/paged_view.dart';
import '../../../../models/page_model.dart';
import '../../../Home Module/Model/event_model.dart';
import '../../../Home Module/View/Components/shimmer_view.dart';
import '../../../Home Module/View/Components/viewall_tile.dart';
import '../view_model/map_listing_view_model.dart';

class MapListingView extends StatelessWidget {
  MapListingView({super.key});
  String data = Get.arguments;
  final _mapListingVM = Get.find<MapListingViewModel>();


  final GlobalKey<PagedViewState> pageKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isBodyPadding: true,
      isLeftAlign: true,
      showBackBtn: true,
      appBarTitle: data == Constants.CATEGORY_HOUSE_PARTY ?"Parties"+" list":data,
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: SizeConfig.screenWidth * 0.01),
            Expanded(child: RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () async {
                pageKey.currentState!.reloadPage();
              },child: PaginatedListView<EventModel>(
              key: pageKey,
              initialItems: _mapListingVM.paginatedEventsList,
              onFetchPage: (page){
                return _mapListingVM.getPaginatedEvents(length:20,categoryType:data,page: page);
              },
              onDispose: (list){
                _mapListingVM.paginatedEventsList=list as PageModel<EventModel>;
              },
              separatorBuilder: (con,ind){
                return const SizedBox.shrink();
              },
              itemBuilder: (ind,item){
                return ViewAllTile(
                  data: item,
                  currentUser: _mapListingVM.userData.value,
                );
              },
              initialLoader: viewAllEventsShimmer(),
            ),),)

          ],
        ),
      ),
    );
  }
}
