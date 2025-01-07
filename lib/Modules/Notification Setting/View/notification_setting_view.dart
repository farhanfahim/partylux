import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Modules/Notification%20Setting/View%20Model/notification_setting_vm.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import '../../../Constants/color.dart';
import '../../../Constants/dimens.dart';
import '../../../Utils/Common/custom_switch_tile.dart';
import '../../../Utils/Common/sizer.dart';
import '../../../Utils/Theme/app_text.dart';
class NotificationSettingView extends StatefulWidget {
  NotificationSettingView({Key? key}) : super(key: key);

  @override
  State<NotificationSettingView> createState() => _NotificationSettingViewState();
}

class _NotificationSettingViewState extends State<NotificationSettingView> {

  final _viewModel = Get.find<NotificationSettingViewModel>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return CustomScaffold(
        isBodyPadding: true,
        isLeftAlign: true,
        showBackBtn: true,
        appBarTitle: "Notifications Settings",
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SizeConfig.screenHeight * 0.01),


            Obx(() => customSwitchTile(title: "Push Notifications",
              content: "Enable reminders to your guests \nabout your upcoming events" ,
              isActive: _viewModel.isPushNotification.value,
              callBack: (v){
                _viewModel.isPushNotification.value = v;
                _viewModel.updateNotificationSetting();
              },),
            ),

            SizedBox(height: SizeConfig.screenHeight * 0.02),

            Obx(() => customSwitchTile(title: "Notify me when",
              content: "Enter/Leaving Notifications" ,
              isActive: _viewModel.isNotifyMe.value,
              callBack: (v){
                _viewModel.isNotifyMe.value = v;
                _viewModel.updateNotificationSetting();
              },),
            ),


          ],
        ));
  }
}
