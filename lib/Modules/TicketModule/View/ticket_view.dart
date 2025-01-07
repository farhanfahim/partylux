import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/TicketModule/View%20Model/ticker_viewmodel.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

import '../../../Constants/dimens.dart';
import '../../../Utils/Common/sizer.dart';
import '../../../Utils/pagenation/paged_listview.dart';
import '../../../Utils/pagenation/paged_view.dart';
import '../../../models/page_model.dart';
import '../../Home Module/View/Components/shimmer_view.dart';
import '../../people_joined/model/order_model.dart';
import 'Components/ticket_list_tile.dart';

class TicketView extends StatelessWidget {
  TicketView({Key? key}) : super(key: key);

  final tickerController = Get.find<TicketViewModel>();
  final GlobalKey<PagedViewState> pageKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return CustomScaffold(
        isBodyPadding: true,
        showBackBtn: true,
        isLeftAlign: true,
        appBarTitle: "My Tickets",
        body: SizedBox.expand(
          child: Column(
            children: [
              Expanded(child: RefreshIndicator(
                color: AppColors.primary,
                onRefresh: () async {
                  pageKey.currentState!.reloadPage();
                },
                child: PaginatedListView<OrderModel>(
                  key: pageKey,
                  initialItems: tickerController.paginatedEventsList,
                  onFetchPage: (page) {
                    return tickerController.getTickets(page: page,);
                  },
                  onDispose: (list) {
                    tickerController.paginatedEventsList=list as PageModel<OrderModel>;
                  },
                  separatorBuilder: (con, ind) {
                    return const SizedBox.shrink();
                  },
                  itemBuilder: (ind, item) {
                    item as OrderModel;

                    RxBool isExpired = false.obs;
                    DateTime dateTime = DateTime.parse(item.event!.endDateTime!);
                    DateTime now = DateTime.now();
                    if (dateTime.isBefore(now)) {
                      isExpired.value = true;
                    } else {
                      isExpired.value = false;
                    }

                    return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ticketListTile(
                          isExpired: isExpired.value,
                          context: context,
                          ticketModel: item,
                        ));
                  },
                  initialLoader: viewAllEventsShimmer(),
                ),
              ),)
            ],
          ),
        ));
  }
}
