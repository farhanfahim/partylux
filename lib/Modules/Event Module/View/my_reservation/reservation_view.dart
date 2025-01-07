import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Modules/Event%20Module/View%20Model/event_viewmodel.dart';
import 'package:partylux/Utils/Common/custom_tab_bar.dart';
import 'package:partylux/Utils/Common/sizer.dart';

class ReservationView extends StatelessWidget {

  ReservationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final EventViewModel _eventVM=Get.find<EventViewModel>();
    return Column(children: [
      CustomTabBar(
          fontsize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
          controller: _eventVM.tabController,
          selectColor: AppColors.primary,
          indicatorColor: AppColors.midGrey,
          items: List.generate(_eventVM.tabController.length, (index) {
            return CustomTabBarItem(
              title: _eventVM.titles2[index],
            );
          }),
          height: AppSizer.getVerticalSize(AppDimen.tabbarHeight)),
      Expanded(
          child: TabBarView(
            controller: _eventVM.tabController,
            children: _eventVM.screens2,
          ))

    ],);
  }
}
