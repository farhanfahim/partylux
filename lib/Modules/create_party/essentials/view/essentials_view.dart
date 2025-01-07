import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/Profile%20Module/Profile%20Section/View/Components/hobbies_intrests_field.dart';
import 'package:partylux/Modules/create_party/essentials/view_model/essentials_view_model.dart';
import 'package:partylux/Utils/Common/custom_textfield.dart';
import 'package:partylux/Utils/Common/icons.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

class EssentialsView extends GetView<EssentialsViewModel> {
  const EssentialsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double fontsize = 14;
    final double listSpacing = AppSizer.getHorizontalSize(7);
    return CustomScaffold(
        isBodyPadding: true,
        isVertPadding: true,
        isLeftAlign: true,
        appBarTitle: AppStrings.txtEssetials,
        showBackBtn: true,
        appbarColor: AppColors.midGrey,
        showLeading: true,
        showDivider: true,
        onBackPressed: (){
          Get.back(result: controller.viewModel.event.entertainment!.length>0?true:false);
        },
        leadingWidth: AppSizer.getHorizontalSize(AppDimen.appBarLeadingWidth),
        leadingWidget: Container(
          //color: Colors.red,
          child: CustomMonoIcon(
            icon: AppImages.icMagicStar,
            size: AppSizer.getVerticalSize(AppDimen.appBarIconSize2),
            color: AppColors.whiteText,
            isSvg: true,
          ),
        ),
        body: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(
            children: [
              Expanded(
                  child: CustomTextField(
                controller: controller.essentials,
                hintText: "Add Essentials",
              )),
              SizedBox(
                width: AppSizer.getHorizontalSize(20),
              ),
              GestureDetector(
                onTap: () {
                  if(controller.essentials.value.text.isNotEmpty){
                    if(controller.isSuggested.value){
                      controller.tags.clear();
                    }
                    controller.tags.add(controller.essentials.text);
                    controller.essentials.text = "";
                    controller.isSuggested.value = false;

                  }
                },
                behavior: HitTestBehavior.opaque,
                child: Row(
                  children: [
                    CustomMonoIcon(icon: AppImages.icAddCircle, color: null, size: AppSizer.getFontSize(fontsize + 7)),
                    SizedBox(
                      width: AppSizer.getHorizontalSize(5),
                    ),
                    AppText(
                      text: AppStrings.txtAdd,
                      fontSize: AppSizer.getFontSize(fontsize),
                    ),
                  ],
                ),
              ),
            ],
          ),
         Obx(() =>  Visibility(
           visible: controller.isSuggested.value,
           child: SizedBox(
             height: AppSizer.getVerticalSize(9),
           ),
         ),),
          Obx(() => Visibility(
            visible: controller.isSuggested.value,
            child: AppText(
              text: "example: pool, byob, beer pong, etc.",
              color: AppColors.red1,
              fontSize: AppSizer.getFontSize(14),
              fontWeight: FontWeight.w400,
            ),
          ),),

          SizedBox(
            height: AppSizer.getVerticalSize(25),
          ),
          Obx(() => Visibility(
            visible: controller.isSuggested.value,
            child: AppText(
              text: AppStrings.txtSuggestedTags,
              fontSize: AppSizer.getFontSize(14),
            ),
          ),),
         Obx(() =>  Visibility(
           visible: controller.isSuggested.value,
           child: SizedBox(
             height: AppSizer.getVerticalSize(12),
           ),
         ),),
          Obx(() => Wrap(
            spacing: listSpacing,
            runSpacing: listSpacing,
            children: List.generate(
              controller.tags.length,
                  (index) {
                var item = controller.tags[index];
                return HobbyContainer(
                  text: item,
                  onTap: () {
                    controller.tags.removeAt(index);
                    if(controller.tags.isEmpty){
                      controller.tags.value =["Pool Party","Vine","Drinks","DJ"];
                      controller.isSuggested .value= true;
                    }
                  },
                );
              },
            ),
          ))
        ])));
  }
}
