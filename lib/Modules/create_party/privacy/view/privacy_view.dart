import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Modules/create_party/privacy/view_model/privacy_view_model.dart';
import 'package:partylux/Utils/Common/custom_dropdown.dart';
import 'package:partylux/Utils/Common/custom_switch_tile.dart';
import 'package:partylux/Utils/Common/custom_textfield.dart';
import 'package:partylux/Utils/Common/icons.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Util.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';
import 'package:partylux/Utils/common_methods.dart';
import 'package:partylux/models/dropdown.dart';

class PrivacyView extends GetView<PrivacyViewModel> {
  const PrivacyView({Key? key}) : super(key: key);

  static const duration=300;

  @override
  Widget build(BuildContext context) {
    var event=controller.viewModel.event;
    final double spacing=AppSizer.getVerticalSize(14);
    return CustomScaffold(
        isBodyPadding: true,
        isVertPadding: true,
        isLeftAlign: true,
        appBarTitle: AppStrings.txtPrivacy,
        showBackBtn: true,
        appbarColor: AppColors.midGrey,
        showLeading: true,
        showDivider: true,
        onBackPressed: (){
          Get.back(result: event.eventType==EventModel.TYPE_PRIVATE?true:false);
        },
        leadingWidth: AppSizer.getHorizontalSize(AppDimen.appBarLeadingWidth),
        leadingWidget: CustomMonoIcon(
          icon: AppImages.icSecurity,
          size: AppSizer.getVerticalSize(AppDimen.appBarIconSize2),
          color: AppColors.whiteText,
          isSvg: true,
        ),
        body: SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          customSwitchTile(title: AppStrings.txtMakeEventPrivate, content: AppStrings.txtWithThisEnabled,
            fontColor: AppColors.red1,
            isActive: event.eventType==EventModel.TYPE_PRIVATE, callBack: (val){
              event.eventType=val?EventModel.TYPE_PRIVATE:EventModel.TYPE_PUBLIC;
              controller.private.value=val;
            },),
          Obx(
            () {
              return AnimatedSize(duration: const Duration(milliseconds: duration),
                child: controller.private.value?Column(
               // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: spacing,),
                  Obx(
                          () {
                        return customSwitchTile(title: AppStrings.txtGenerateOwnCode,
                          content: AppStrings.txtCaseSensitive,
                          fontColor: AppColors.red1,
                          isActive: controller.ownCode.value,
                          callBack: (val){
                            controller.ownCode.value=val;
                            event.ownCode=val;
                            controller.code.clear();
                          },
                          downWidget: AnimatedSize(
                            duration: const Duration(milliseconds: duration),
                            child: controller.ownCode.value?Padding(
                              padding: EdgeInsets.symmetric(vertical: AppSizer.getVerticalSize(22)),
                              child: Column(children: [
                                CustomTextField(
                                  controller: controller.code,
                                  hintText: AppStrings.txtEnterCode,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: spacing,),
                                AppButton.mainButton(
                                  context,
                                  text: AppStrings.save,
                                  buttonColor: AppColors.greenColor,
                                  onPressed: () {
                                    event.partyCode=controller.code.text;
                                    Util.showToast("Saved!");
                                  },
                                ),
                              ],),
                            ):Container(),
                          ),);
                      }
                  ),
                  SizedBox(height: spacing,),
                  Obx(
                          () {
                        return customSwitchTile(title: AppStrings.txtHaveGenerateCode,
                          content: AppStrings.txtCaseSensitive,
                          fontColor: AppColors.red1,
                          isActive: !controller.ownCode.value,   callBack: (val){
                            controller.ownCode.value=!val;
                            event.ownCode=!val;
                            controller.code.clear();
                          },
                          downWidget: AnimatedSize(
                            duration: const Duration(milliseconds: duration),
                            child: !controller.ownCode.value?Padding(
                              padding: EdgeInsets.symmetric(vertical: AppSizer.getVerticalSize(22)),
                              child: Column(children: [
                                CustomTextField(
                                  controller: controller.code,
                                  hintText: AppStrings.txtNoCodeGenerated,
                                  textAlign: TextAlign.center,
                                  suffix: IconButton(icon: CustomMonoIcon(
                                    icon: AppImages.icCopy,
                                    size: null,
                                    isSvg: true,
                                    color: AppColors.whiteText,
                                  ), onPressed: () {
                                    CommonMethods.copyText(controller.code.text).then((value) {
                                      Util.showToast("Text copied!");
                                    });
                                  },),

                                  /*             Container(
                              width: 10,
                              height: 10,
                              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                              child: CustomMonoIcon(
                                icon: AppImages.icCopy,
                                size: null,
                                isSvg: true,
                                color: AppColors.whiteText,
                              ),
                            ),*/
                                ),
                                SizedBox(height: spacing,),
                                AppButton.mainButton(
                                  context,
                                  text: AppStrings.txtGenerate,
                                  buttonColor: AppColors.greenColor,
                                  onPressed: () {
                                    controller.generateCode(event);
                                  },
                                ),
                              ],),
                            ):Container(),
                          ),
                        );
                      }
                  ),
              ],):Container(),);
            }
          ),

          SizedBox(height: spacing,),
          customSwitchTile(title: AppStrings.txtChooseWhenStop, content: AppStrings.txtChooseOneWeek,
            crossAxisAlignment: CrossAxisAlignment.start,
            fontColor: AppColors.red1,
              isActive: false, widget: Container(
                width: AppSizer.getPerWidth(0.25),
                  child: Obx(
                          (){
                        return DropDownField(
                          selected_value: controller.value.value,
                          items: controller.stopItems,hintText: AppStrings.txtHours,onValueChanged: (val){
                          controller.value.value=val!;
                          event.stopBooking=val as ValueType<int>;
                        },);
                      }
                  )),),
          SizedBox(height: spacing,),
          customSwitchTile(title: AppStrings.txtCancellationPolicy, content: AppStrings.txtAlways,
            fontColor: AppColors.red1,
              crossAxisAlignment: CrossAxisAlignment.start,
              isActive: false,widget: Container(
                width: AppSizer.getPerWidth(0.33),
                child: Obx(
                        (){
                      return DropDownField(
                        selected_value: controller.value2.value,
                        items: controller.stopItems,
                        hintText: AppStrings.txtUptoHours,onValueChanged: (val){
                        controller.value2.value=val!;
                        event.cancelPolicy=val as ValueType<int>;
                      },);
                    }
                )),),
        ])));
  }
}
