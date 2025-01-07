import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/create_party/create_my_party/view_model/create_party_view_model.dart';
import 'package:partylux/Modules/create_party/rsvps/view_model/rsvps_view_model.dart';
import 'package:partylux/Utils/Common/common.dart';
import 'package:partylux/Utils/Common/custom_dropdown.dart';
import 'package:partylux/Utils/Common/custom_switch_tile.dart';
import 'package:partylux/Utils/Common/custom_textfield.dart';
import 'package:partylux/Utils/Common/icons.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/models/dropdown.dart';

class RsvpsView extends GetView<RsvpsViewModel> {
  const RsvpsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double spacing = AppSizer.getVerticalSize(14);
    var event = controller.viewModel.event;

    return CustomScaffold(
        isBodyPadding: true,
        isVertPadding: true,
        isLeftAlign: true,
        showDivider: true,
        appBarTitle: AppStrings.txtRsvps,
        showBackBtn: true,
        appbarColor: AppColors.midGrey,
        leadingWidth: AppSizer.getHorizontalSize(AppDimen.appBarLeadingWidth),
        showLeading: true,
        onBackPressed: (){
          print(controller.viewModel.event.maxParticipants!);
          Get.back(result: controller.viewModel.event.maxParticipants!>0?true:false);
        },
        leadingWidget: CustomMonoIcon(
          icon: AppImages.icAudience,
          size: AppSizer.getVerticalSize(AppDimen.appBarIconSize2),
          color: AppColors.whiteText,
          isSvg: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Obx(() => customSwitchTile(
                title: AppStrings.txtMaxCapacity,
                content: AppStrings.txtRestrictTotal,
                isActive: event.maxCapacity!,
                fontColor: AppColors.whiteText,
                callBack: (val) {
                  event.maxCapacity = val;
                  controller.isMaxCapacity.value = val;
                  if(controller.isMaxCapacity.value){
                    event.maxParticipants = 0;
                    controller.numParticipants.text = "";
                  }else{
                    event.maxParticipants = 10000;
                  }
                },

                downWidget: controller.isMaxCapacity.value ?Container(
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1,
                    color: AppColors.iconColor,))),
                  child: CustomTextField(
                    showBorder: false,
                    filled: false,
                    controller: controller.numParticipants,
                    textInputType: TextInputType.number,
                    hintText: AppStrings.txtEnterCapacity,
                    onChanged: (val) {
                      event.maxParticipants = int.tryParse(val);
                    },
                  ),
                ):Container(),
              ),),
              SizedBox(
                height: spacing,
              ),
              customSwitchTile(
                title: AppStrings.txtRestrict1s,
                content: AppStrings.txtSetIndividuals,
                isActive: event.restrict1!,
                fontColor: AppColors.whiteText,
                callBack: (val) {
                  event.restrict1 = val;
                },
              ),
              SizedBox(
                height: AppSizer.getVerticalSize(18),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: NoteText(
                      text: AppStrings.txtForEvery1s,
                    ),
                  ),
                  SizedBox(
                    width: AppSizer.getHorizontalSize(20),
                  ),
                  Expanded(
                      flex: 1,
                      child: Obx(() {
                        return DropDownField(
                          selected_value: controller.value.value,
                          items: controller.items,
                          hintText: "Up to 1",
                          onValueChanged: (val) {
                            controller.value.value = val!;
                            event.maxGuest = val as ValueType<int>;
                          },
                        );
                      })),
                ],
              ),
            ],
          ),
        ));
  }
}
