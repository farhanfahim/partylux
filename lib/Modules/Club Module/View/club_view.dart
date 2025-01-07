import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/BecomePartner/Model/become_partner_model.dart';
import 'package:partylux/Modules/Create%20Module/Model/create_model.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import '../../../Constants/app_routes.dart';
import '../../../Utils/pagenation/paged_listview.dart';
import '../../../Utils/pagenation/paged_view.dart';
import '../../../models/page_model.dart';
import '../../Home Module/View/Components/shimmer_view.dart';
import '../View Model/club_viewmodel.dart';
import 'Components/business_club_tile.dart';


class ClubView extends StatelessWidget {
  ClubView({super.key});

  final String viewType = Get.arguments[0];
  final _eventVM = Get.find<ClubViewModel>();

  final GlobalKey<PagedViewState> pageKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isBodyPadding: true,
      showBackBtn: true,
      appBarTitle: viewType,
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Expanded(child: RefreshIndicator(

              color: AppColors.primary,
              onRefresh: () async {
                pageKey.currentState!.reloadPage();
              },
              child: PaginatedListView<BecomePartnerModel>(
                key: pageKey,
                initialItems: _eventVM.myClubList,
                onFetchPage: (page){
                  return _eventVM.getBusinessList(type:viewType,page: page);
                },
                onDispose: (list){
                  _eventVM.myClubList =list as PageModel<BecomePartnerModel>;
                },
                separatorBuilder: (con,ind){
                  return const SizedBox.shrink();
                },
                itemBuilder: (ind,item){
                  return BusinessClubTile(
                    data: item,
                    callback: (CreateEventModel data,
                        String eventType) {

                    },
                  );
                },
                initialLoader: notificationShimmer(),
              ),),)

          ],
        ),
      ),
        floatingActionButton:GestureDetector(
          onTap: (){
            Get.toNamed(AppRoutes.createBusiness,arguments: [viewType,null] );
          },
          child: Container(
            width: AppSizer.getHorizontalSize(55),
            height: AppSizer.getHorizontalSize(55),
            margin: EdgeInsets.only(left: 20,bottom: 50),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0, 1],
                colors: [
                  AppColors.primary,
                  AppColors.secondary,
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.topLeft,
            child: Center(
              child: SvgPicture.asset(AppImages.icAdd,width: AppSizer.getHorizontalSize(32),)
            ),
          ),
        ),
    );
  }

}
