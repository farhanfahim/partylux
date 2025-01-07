import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/constants.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Modules/create_party/create_my_party/view_model/create_party_view_model.dart';
import 'package:partylux/Modules/create_party/event_category_selection/view_model/category_selection_view_model.dart';
import 'package:partylux/Utils/Common/create_party_items.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';
import 'package:partylux/Utils/navigation.dart';

class EventCategorySelection extends GetView<CategorySelectionViewModel> {
  const EventCategorySelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double spacing=AppSizer.getVerticalSize(11);
    return CustomScaffold(
        isBodyPadding: true,
        isLeftAlign: true,
        showBackBtn: true,
        appBarTitle: AppStrings.txtWhereYouWannaParty,
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: SingleChildScrollView(
            padding: EdgeInsets.only(top: AppSizer.getVerticalSize(37)),
            child: Obx(
            () {
              var selected=controller.selected.value;
              return Column(children: [
                TypeSelectContainer(type: AppStrings.lblClub,
                  selected: selected==EventModel.CATEGORY_CLUB,onTap: (){
                  controller.selected.value=EventModel.CATEGORY_CLUB;
                },),
                SizedBox(height: spacing,),
                TypeSelectContainer(type: AppStrings.lblHouseParty,
                  selected: selected==EventModel.CATEGORY_HOUSEPARTY,onTap: (){
                  controller.selected.value=EventModel.CATEGORY_HOUSEPARTY;
                },),
                SizedBox(height: spacing,),
                TypeSelectContainer(type: AppStrings.bars,
                  selected: selected==EventModel.CATEGORY_BAR,
                  onTap: (){
                  controller.selected.value=EventModel.CATEGORY_BAR;
                },),
                SizedBox(height: spacing,),
                TypeSelectContainer(type: AppStrings.beach,
                  selected: selected==EventModel.CATEGORY_BEACH,onTap: (){
                  controller.selected.value=EventModel.CATEGORY_BEACH;
                },),
              ],);
            }
          ),)),
          AppButton.mainButton(
            context,
            text: AppStrings.proceed,
            onPressed: () {
              AppNavigator.navigateToNamed(AppRoutes.createParty,arguments: {
                Constants.paramFrom: controller.selected.value,
              });
            },
          ),
          SizedBox(height: 20,)

        ]));
  }
}
