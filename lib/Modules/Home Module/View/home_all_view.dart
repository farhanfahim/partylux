import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Modules/Home%20Module/View/Components/shimmer_view.dart';
import 'package:partylux/Modules/Home%20Module/View/Components/viewall_tile.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/models/page_model.dart';
import '../../../Constants/dimens.dart';
import '../../../Constants/strings.dart';
import '../../../Utils/Common/sizer.dart';
import '../../../Utils/pagenation/paged_listview.dart';
import '../../../Utils/pagenation/paged_view.dart';
import '../View Model/home_all_vm.dart';
import '../View Model/home_vm.dart';

class HomeViewAllView extends StatelessWidget {
  HomeViewAllView({super.key});

  final GlobalKey<PagedViewState> pageKey=GlobalKey();

  final _homeVM = Get.find<HomeAllViewModel>();
  final _mainHomeVM = Get.find<HomeViewModel>();
  String categoryType = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isBodyPadding: true,
      isLeftAlign: true,
      showBackBtn: true,
      appBarTitle: AppStrings.eventList,
      basicAppTrailingIcon: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: GestureDetector(
          onTap: () {
            Get.toNamed(AppRoutes.viewAllFilter)!.then((value) {
              pageKey.currentState!.reloadPage();
            });
          },
          child: Container(
            width: SizeConfig.screenWidth * 0.09,
            height: SizeConfig.screenWidth * 0.09,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.feildBGColor.withOpacity(0.1),
            ),
            alignment: Alignment.centerLeft,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(
                    SizeConfig.screenWidth * 0.025),
                child:
                Image.asset("assets/icon_assets/filter.png"),
              ),
            ),
          ),
        ),
      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
   /*         AppText(
              text: "Here you can filter the events and get your desired event",
              overflow: TextOverflow.visible,
              fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
              height: 1,
              fontWeight: FontWeight.w400,
              color:AppColors.iconColor,
            ),

            SizedBox(height: SizeConfig.screenWidth * 0.01),*/
            Expanded(child: RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () async {
                pageKey.currentState!.reloadPage();
              },child: PaginatedListView<EventModel>(
              key: pageKey,
              initialItems: _homeVM.paginatedEventsList,
              onFetchPage: (page){
                return _homeVM.getPaginatedEvents(
                    length:20,
                    categoryType:categoryType,
                    page: page,
                    isFilter:_mainHomeVM.isFilterApply.value,
                    isLocationSelected:_mainHomeVM.isLocationSelected.value,
                    isCapacitySelected:_mainHomeVM.isCapacitySelected.value,
                    distance: _mainHomeVM.locationFilter.value,
                    minPrice: _mainHomeVM.priceRangeMin.value,
                    maxPrice: _mainHomeVM.priceRangeMax.value,
                    minPeople: _mainHomeVM.peopleCapacityMin.value,
                    maxPeople: _mainHomeVM.peopleCapacityMax.value,
                    gender: _mainHomeVM.userData.value.profile!.gender!,
                );
              },
              onDispose: (list){
                _homeVM.paginatedEventsList=list as PageModel<EventModel>;
              },
              separatorBuilder: (con,ind){
                return const SizedBox.shrink();
              },
              itemBuilder: (ind,item){
                return ViewAllTile(
                  data: item,
                  currentUser: _homeVM.userData.value,
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
