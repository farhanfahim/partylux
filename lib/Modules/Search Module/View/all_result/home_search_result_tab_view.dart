import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/Search%20Module/View%20Model/home_search_vm.dart';
import 'package:partylux/Utils/Common/custom_tab_bar.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Custom%20Views/home_search_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/pagenation/paged_view.dart';

class HomeSearchResultTabView extends StatelessWidget {
  HomeSearchResultTabView({super.key});

  final _searchVM = Get.find<HomeSearchViewModel>();



  @override
  Widget build(BuildContext context) {
    return HomeSearchScaffold(
      searchController: _searchVM.searchController,
      onnChanged: (v){
        print("index changed: ${_searchVM.tabController.index}");
        ((_searchVM.screens[_searchVM.tabController.index] as dynamic).pageKey
          as GlobalKey<PagedViewState>).currentState?.reloadPage();
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
              padding: EdgeInsets.only(
                  right:
                  SizeConfig.screenWidth * 0.05),
              child:
              AppText(
                text: AppStrings.cancel,
                overflow: TextOverflow.visible,
                fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                height: 1,
                fontWeight: FontWeight.w700,
                color:AppColors.iconColor,
              ),
            ),
          ),
        ),
      ),
      body: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SizeConfig.screenWidth * 0.01),
            // SizedBox(height: AppSizer.getVerticalSize(15),),
            CustomTabBar(
                controller: _searchVM.tabController,
                scrollable: true,
                items: List.generate(_searchVM.screens.length, (index) {
                  return CustomTabBarItem(
                    sidePadding: 10,
                    title: _searchVM.titles[index],
                  );
                }),
                height: AppSizer.getVerticalSize(AppDimen.tabbarHeight)),
            Expanded(
                child: TabBarView(
                  controller: _searchVM.tabController,
                  children: _searchVM.screens,
                ))

          ],
        ),
      ),
    );
  }
}
