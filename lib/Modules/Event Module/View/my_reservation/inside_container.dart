import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/constants.dart';
import 'package:partylux/Modules/Event%20Module/View%20Model/event_viewmodel.dart';
import 'package:partylux/Modules/Event%20Module/View/Components/event_tile.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Modules/Home%20Module/View/Components/shimmer_view.dart';
import 'package:partylux/Modules/people_joined/model/order_model.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/navigation.dart';
import 'package:partylux/Utils/pagenation/paged_listview.dart';
import 'package:partylux/Utils/pagenation/paged_view.dart';
import 'package:partylux/models/page_model.dart';

import '../../../../Constants/color.dart';
import '../Components/reservation_tile.dart';

class InsideReservationContainer extends StatelessWidget {

  final String type;
  InsideReservationContainer({Key? key,required this.type,}) : super(key: key);

  final GlobalKey<PagedViewState> pageKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    final _eventVM = Get.find<EventViewModel>();
    return RefreshIndicator(
      color: AppColors.primary,
      onRefresh: () async {
        pageKey.currentState!.reloadPage();
      },child: PaginatedListView<OrderModel>(
      padding: EdgeInsets.symmetric(vertical: AppSizer.getVerticalSize(25)),
      key: pageKey,
      initialItems: _eventVM.orders[type],
      onFetchPage: (page){
        return _eventVM.getReservations(page: page,status: type);
      },
      onDispose: (list){
        _eventVM.orders[type]=list as PageModel<OrderModel>;
      },
      separatorBuilder: (con,ind){
        return const SizedBox.shrink();
      },
      itemBuilder: (ind,item){
        return ReservationTile(
          data: item,
          currentUserGender: _eventVM.userData.value.profile!.gender!,
          eventType: Constants.EVENT_MY_EVENT,
          callback: (OrderModel data, String eventType) {

            AppNavigator.navigateToNamed(AppRoutes.myEvent,
                arguments: [
                  data.event!.sId,
                  item.orderStatus == OrderModel.STATUS_APPROVED && item.paymentStatus == OrderModel.PAID
                      ?Constants.EVENT_RESERVED
                      :item.orderStatus == OrderModel.STATUS_PENDING && item.paymentStatus == OrderModel.UNPAID
                      ?Constants.EVENT_PENDING
                      :Constants.EVENT_PAYMENT,
                  item.sId,
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
