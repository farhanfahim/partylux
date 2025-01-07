import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/Event%20Module/View/event_view.dart';
import 'package:partylux/Modules/Home%20Module/View/home_view.dart';
import 'package:partylux/Modules/NavRoot%20Module/View%20Model/nevroot_vm.dart';
import 'package:partylux/Modules/Profile%20Module/Profile%20Section/View/profile_view.dart';
import 'package:partylux/Modules/create_party/create_party_prompt/view/create_party_prompt.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import '../../../Constants/app_images.dart';
import '../../../Utils/keepAliveWraper.dart';
import '../../Map Module/View/map_event_view.dart';
import 'nav_tile.dart';

class NavRootView extends StatelessWidget {
  NavRootView({super.key});

  final _rootVM = Get.find<NavRootViewModel>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Obx(() => Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView(
          controller: _rootVM.pageController,
          scrollDirection: Axis.horizontal,
          physics: NeverScrollableScrollPhysics(),
          children: [
            HomeView(),
            EventView(),
            CreatePartyPrompt(),
            KeepAliveWrapper(child:MapView()),
            ProfileView(),
          ],
        ),
        Container(
          color: AppColors.transparent,
          height: 110,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                color: AppColors.navBarColor,
                height: 80,
                child: Row(
                  children: [
                    NavBarTile(
                      callback: () async {
                        _rootVM.selectedIndex.value = 0;
                        _rootVM.changePage(0);
                      },
                      icon: ImageIcon(
                        _rootVM.selectedIndex.value != 0
                            ? const AssetImage(AppImages.imgHome)
                            : const AssetImage(AppImages.imgHomeFill),
                        size: AppSizer.getSize(24),
                        color: _rootVM.selectedIndex.value == 0
                            ? AppColors.primaryText
                            : AppColors.iconColor,
                      ),
                      title: "Home",
                      isSelected: _rootVM.selectedIndex.value == 0 ? true : false,
                    ),
                    NavBarTile(
                      callback: () {
                        _rootVM.selectedIndex.value = 1;
                        _rootVM.changePage(1);
                      },
                      icon: ImageIcon(
                        _rootVM.selectedIndex.value != 1
                            ? const AssetImage(AppImages.imgCalender)
                            : const AssetImage(AppImages.imgCalenderFill),
                        size: AppSizer.getSize(24),
                        color: _rootVM.selectedIndex.value == 1
                            ? AppColors.primaryText
                            : AppColors.iconColor,
                      ),
                      title: "Events",
                      isSelected:
                      _rootVM.selectedIndex.value == 1 ? true : false,
                    ),
                    NavBarTile(
                      callback: () {

                      },
                      icon: Container(),
                      title: "",
                      isSelected: false,
                    ),
                    NavBarTile(
                      callback: () async {
                        _rootVM.selectedIndex.value = 3;
                        _rootVM.changePage(3);
                      },
                      icon: ImageIcon(
                        _rootVM.selectedIndex.value != 3
                            ? const AssetImage(AppImages.imgLocation)
                            : const AssetImage(AppImages.imgLocationFill),
                        size: AppSizer.getSize(24),
                        color: _rootVM.selectedIndex.value == 3
                            ? AppColors.primaryText
                            : AppColors.iconColor,
                      ),
                      title: "Map",
                      isSelected:
                      _rootVM.selectedIndex.value == 3 ? true : false,
                    ),
                    NavBarTile(
                      callback: () async {
                        _rootVM.selectedIndex.value = 4;
                        _rootVM.changePage(4);
                      },
                      isSelected:
                      _rootVM.selectedIndex.value == 4 ? true : false,
                      icon: ImageIcon(
                        _rootVM.selectedIndex.value != 4
                            ? const AssetImage(AppImages.imgProfile)
                            : const AssetImage(AppImages.imgProfileFill),
                        size: AppSizer.getSize(24),
                        color: _rootVM.selectedIndex.value == 4
                            ? AppColors.primaryText
                            : AppColors.iconColor,
                      ),
                      title: "Profile",
                    ),

                  ],
                ),
              ),
              NavBarTile(
                callback: () async {
                  Get.toNamed(AppRoutes.createPartyPrompt);
                },
                isSelected:
                _rootVM.selectedIndex.value == 2 ? true : false,
                icon: Container(
                  width: AppSizer.getSize(60),
                  height: AppSizer.getSize(60),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      stops: [0, 1],
                      colors: [
                        AppColors.secondary,
                        AppColors.primary,
                      ],
                    ),
                    border: Border.all(color: AppColors.primary,width: 4),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Padding(
                    padding: AppSizer.getPadding(all: 15),
                    child: ImageIcon( const AssetImage(
                        AppImages.imgPLus) ,
                        size: AppSizer.getSize(24),
                        color:  AppColors.whiteText
                    ),
                  ),
                ),
                title: "   ",
              ),
            ],
          ),
        )
      ],
    ),);
  }
}
