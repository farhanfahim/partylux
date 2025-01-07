import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_fonts.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/constants.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Modules/Home%20Module/View%20Model/home_vm.dart';
import 'package:partylux/Modules/Home%20Module/View/Components/shimmer_view.dart';
import 'package:partylux/Modules/Home%20Module/View/Components/viewall_tile.dart';
import 'package:partylux/Modules/Search%20Module/Model/search_model.dart';
import 'package:partylux/Modules/Search%20Module/View%20Model/search_vm.dart';
import 'package:partylux/Modules/Search%20Module/component/club_tile.dart';
import 'package:partylux/Modules/Search%20Module/component/search_item.dart';
import 'package:partylux/Utils/Common/not_found_text.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Custom%20Views/home_search_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/navigation.dart';
import 'package:partylux/Utils/pagenation/paged_listview.dart';
import 'package:partylux/Utils/pagenation/paged_view.dart';

class HomeSearchView extends StatelessWidget {
  HomeSearchView({super.key});

  final _searchVM = Get.find<SearchViewModel>();

  final GlobalKey<PagedViewState> searchKey = GlobalKey(), recentPageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return HomeSearchScaffold(
      searchController: _searchVM.searchController,
      onnChanged: (v) {
        // _searchVM.recentSearchesList.refresh();
        //searchKey.currentState?.reloadPage();
        _searchVM.loadResults();
      },
      isBodyPadding: true,
      isLeftAlign: true,
      showBackBtn: false,
      appBarTitle: "",
      appbarColor: AppColors.midGrey,
      basicAppTrailingIcon: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(right: SizeConfig.screenWidth * 0.05),
              child: AppText(
                text: AppStrings.cancel,
                overflow: TextOverflow.visible,
                fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                height: 1,
                fontWeight: FontWeight.w700,
                color: AppColors.iconColor,
              ),
            ),
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: _searchVM.searchController,
        builder: (con, cont, wid) {
          List<EventModel>? list;
          return SizedBox.expand(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenWidth * 0.01),
                _searchVM.searchController.text.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Obx(() {
                            list = _searchVM.eventList.value.data;
                            return list != null
                                ? (list!.isNotEmpty
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: list!.length,
                                        padding: EdgeInsets.only(
                                          top: SizeConfig.screenWidth * 0.02,
                                          bottom: SizeConfig.screenWidth * 0.02,
                                        ),
                                        itemBuilder: (con, ind) {
                                          var item = list![ind];
                                          return Column(
                                            children: [
                                              ClubTile(
                                                currentUser: _searchVM.userData.value,
                                                item: item,
                                              ),

                                              list!.last.sId == list![ind].sId? GestureDetector(
                                                behavior: HitTestBehavior.translucent,
                                                onTap: () {
                                                  AppNavigator.navigateToNamed(AppRoutes.HOME_SEARCH_RESULT_TAB_VIEW,
                                                      arguments: {Constants.paramFrom:_searchVM.searchController.text,});
                                                },
                                                child: AppText(
                                                  text: 'See all results', //"Club Party",
                                                  fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                                                  fontFamily: AppFonts.lexendDica,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.iconColor,
                                                ),
                                              ):Container(),
                                            ],
                                          );
                                        })
                                    : Container(height:AppSizer.height*0.8,child: const NotFoundText(text: "No Results Match Your Query.",)))
                                : Center(
                                  child: CupertinoActivityIndicator(
                                      color: AppColors.whiteText,
                                    ),
                                );
                          }),

                        ],
                      )
                    : Expanded(
                        child: Column(
                        children: [
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                text: "Recent Searches",
                                overflow: TextOverflow.visible,
                                fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
                                height: 1,
                                fontWeight: FontWeight.w700,
                                color: AppColors.whiteText,
                              ),
                              InkWell(
                                onTap: () {
                                  AppNavigator.navigateToNamed(AppRoutes.ALL_RECENT_SEARCHES)?.then((value) {
                                    if (value != null) {
                                      _searchVM.targetSearch(value);
                                    }
                                  });
                                },
                                child: AppText(
                                  text: "See All",
                                  overflow: TextOverflow.visible,
                                  fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                                  height: 1,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.iconColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Expanded(
                            child: Obx(() {
                              List<SearchModel>? list = _searchVM.recentSearches.value.data;
                              return list != null
                                  ? (list.isNotEmpty
                                      ? ListView.builder(
                                          itemCount: list.length,
                                          padding: EdgeInsets.only(
                                            top: SizeConfig.screenWidth * 0.02,
                                            bottom: SizeConfig.screenWidth * 0.05,
                                          ),
                                          itemBuilder: (con, ind) {
                                            var item = list[ind];
                                            return RecentSearchItem(
                                              item: item,
                                              onTap: () {
                                                _searchVM.targetSearch(item.query!);
                                              },
                                              onRemove: () {
                                                _searchVM.deleteRecentSearch(
                                                  item,
                                                );
                                              },
                                            );
                                          })
                                      : const SearchNotFound())
                                  : CupertinoActivityIndicator(
                                      color: AppColors.whiteText,
                                    );
                            }),
                          ),
                        ],
                      )),
              ],
            ),
          );
        },
      ),
    );
  }
}
