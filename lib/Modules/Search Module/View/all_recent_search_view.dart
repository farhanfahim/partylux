import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Modules/Home%20Module/View%20Model/home_vm.dart';
import 'package:partylux/Modules/Home%20Module/View/Components/shimmer_view.dart';
import 'package:partylux/Modules/Home%20Module/View/Components/viewall_tile.dart';
import 'package:partylux/Modules/Search%20Module/Model/search_model.dart';
import 'package:partylux/Modules/Search%20Module/View%20Model/search_vm.dart';
import 'package:partylux/Modules/Search%20Module/component/search_item.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Custom%20Views/home_search_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/navigation.dart';
import 'package:partylux/Utils/pagenation/paged_listview.dart';
import 'package:partylux/Utils/pagenation/paged_view.dart';

class AllRecentSearchView extends StatelessWidget {
  AllRecentSearchView({super.key});

  final _searchVM = Get.find<SearchViewModel>();

  final GlobalKey<PagedViewState> pageKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isBodyPadding: true,
      isVertPadding: true,
      isLeftAlign: true,
      appBarTitle: "Recent Searches",
      appBarFont: AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
      showBackBtn: true,
      appbarColor: AppColors.midGrey,
        basicAppTrailingIcon: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          child: GestureDetector(
            onTap: () {
              _searchVM.clearRecentSearch(pageKey);
            },
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(
                    SizeConfig.screenWidth * 0.025),
                child:
                AppText(
                  text: "Clear All",
                  overflow: TextOverflow.visible,
                  fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                  height: 1,
                  color:AppColors.iconColor,
                ),
              ),
            ),
          ),
        ),
/*      basicAppTrailingIcon: ValueListenableBuilder(
        valueListenable: pageKey.currentState!.pagingController,
        builder: (context,cont,wid) {
          return cont.itemList!=null && cont.itemList!.isNotEmpty?Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: GestureDetector(
              onTap: () {
                _searchVM.clearRecentSearch(pageKey);
              },
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(
                      SizeConfig.screenWidth * 0.025),
                  child:
                  AppText(
                    text: "Clear All",
                    overflow: TextOverflow.visible,
                    fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                    height: 1,
                    color:AppColors.iconColor,
                  ),
                ),
              ),
            ),
          ):Container();
        }
      ),*/
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: SizeConfig.screenWidth * 0.01),
            Expanded(
              child: RefreshIndicator(
                color: AppColors.primary,
                onRefresh: () async {
                  pageKey.currentState!.reloadPage();
                },child: PaginatedListView<SearchModel>(
                padding: EdgeInsets.only(
                  top: SizeConfig.screenWidth * 0.02,
                  bottom: SizeConfig.screenWidth * 0.05,
                ),
                key: pageKey,
                //initialItems: _eventVM.events[index],
                onFetchPage: (page){
                  return _searchVM.getRecentSearches(page: page);
                },
                onDispose: (list){
                  // _eventVM.events[index]=list as PageModel<EventModel>;
                },
                separatorBuilder: (con,ind){
                  return const SizedBox.shrink();
                },
                itemBuilder: (ind,item){
                  return RecentSearchItem(item: item,
                    onTap: (){
                      AppNavigator.pop(result: item.query);
                    },
                    onRemove: (){
                    _searchVM.deleteRecentSearch(item,key: pageKey);
                  },);
                },
                notFoundWidget: SearchNotFound(),
              ),),
            )

          ],
        ),
      ),
    );
  }
}
