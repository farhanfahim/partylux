import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Utils/Common/create_party_items.dart';
import 'package:partylux/Utils/Common/sizer.dart';

import '../view_model/create_party_view_model.dart';
class SettingsView extends StatelessWidget {
  SettingsView({Key? key}) : super(key: key);
  RxBool rsvp = false.obs;
  RxBool reminder = false.obs;
  RxBool privacy = false.obs;
  RxBool payment = false.obs;
  RxBool essentials = false.obs;
  @override
  Widget build(BuildContext context) {
    final double spacing=AppSizer.getVerticalSize(17);
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: spacing,crossAxisSpacing: spacing,
      padding: EdgeInsets.symmetric(vertical: AppSizer.getVerticalSize(AppDimen.vertPadd)),
      childAspectRatio: 2,
      //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      // itemCount: 5,
      children: [
       Obx(() =>  SettingTile(
         text: AppStrings.txtRsvps,
         icon: AppImages.icAudience,
         isChecked:rsvp.value?true.obs:false.obs,
         onTap: (){
           Get.toNamed(AppRoutes.createPartyRsvps)!.then((value) {
             rsvp.value = value;
             rsvp.refresh();

           });
         },),),
        Obx(() => SettingTile(
          text: AppStrings.txtReminders,
          icon: AppImages.icReminder,
          isChecked: reminder.value?true.obs:false.obs,
          onTap: (){
            Get.toNamed(AppRoutes.createPartyReminder)!.then((value) {
              reminder.value = value;
              reminder.refresh();
            });
          },),),
       Obx(() => SettingTile(text: AppStrings.txtPrivacy,
         icon: AppImages.icSecurity,
         isChecked:  privacy.value?true.obs:false.obs,
         onTap: (){
           Get.toNamed(AppRoutes.createPartyPrivacy)!.then((value) {
             privacy.value = value;
             privacy.refresh();
           });
         },),),
       Obx(() =>  SettingTile(text: AppStrings.txtPayment,
         icon: AppImages.icCard,
         isChecked: payment.value?true.obs:false.obs,
         onTap: (){
           Get.toNamed(AppRoutes.createPartyPayment)!.then((value) {
             payment.value = value;
             payment.refresh();
           });
         },),),
        Obx(() => SettingTile(text: AppStrings.txtEssetials,
          icon: AppImages.icMagicStar,
          isChecked: essentials.value?true.obs:false.obs,
          onTap: (){
            Get.toNamed(AppRoutes.createPartyEssentials)!.then((value) {
              essentials.value = value;
              essentials.refresh();
            });
          },),)
      ],
    );
  }
}
