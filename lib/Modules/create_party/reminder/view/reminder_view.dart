import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/create_party/reminder/view_model/reminder_view_model.dart';
import 'package:partylux/Utils/Common/common.dart';
import 'package:partylux/Utils/Common/custom_switch_tile.dart';
import 'package:partylux/Utils/Common/icons.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

class ReminderView extends GetView<ReminderViewModel> {
  const ReminderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var event=controller.viewModel.event;
    return CustomScaffold(
        isBodyPadding: true,
        isVertPadding: true,
        isLeftAlign: true,
        appBarTitle: AppStrings.txtReminders,
        showBackBtn: true,
        appbarColor: AppColors.midGrey,
        showLeading: true,
        showDivider: true,
        onBackPressed: (){
          Get.back(result: event.push);
        },
        leadingWidth: AppSizer.getHorizontalSize(AppDimen.appBarLeadingWidth),
        leadingWidget: Container(
          //color: Colors.red,
          child: CustomMonoIcon(
            icon: AppImages.icReminder,
            size: AppSizer.getVerticalSize(AppDimen.appBarIconSize2),
            color: AppColors.whiteText,
            isSvg: true,
          ),
        ),
        body: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          customSwitchTile(title: AppStrings.txtPushNotifications, content: AppStrings.txtEnableReminders,
              isActive: event.push!, callBack: (val){
              event.push=val;
            },),
          SizedBox(
            height: AppSizer.getVerticalSize(13),
          ),
          NoteText(
            text: AppStrings.txtScheduledMonth,showIcon: true,
          ),
        ])));
  }
}
