import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Network/tost.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

import '../../../../Constants/app_fonts.dart';
import '../../../../Constants/app_images.dart';
import '../../../../Constants/dimens.dart';
import '../../../../Utils/Common/custom_textfield.dart';
import '../../../../Utils/Common/sizer.dart';
import '../View Model/update_profile_vm.dart';

class HobbiesIntrestsView extends StatelessWidget {
  HobbiesIntrestsView({super.key});

  final _updateVM = Get.find<UpdateProfileViewModel>();
  final String viewType = Get.arguments[0];
  final Rx<TextEditingController> addfeildController =
      TextEditingController().obs;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showBackBtn: true,
      isLeftAlign: true,
      appBarTitle:"Your $viewType",
      body: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: "Here you can add your $viewType so the user will \nsee you",
              overflow: TextOverflow.visible,
              fontSize: 14,
              height: 1,
              fontWeight: FontWeight.w400,
              color:AppColors.iconColor,
            ),
            SizedBox(height: SizeConfig.screenWidth * 0.07),
            Row(
              children: [

                Expanded(child: CustomTextField(
                  controller: addfeildController.value,
                  maxLength: 30,
                  hintText: "Write Your ${viewType}",
                ),),
                GestureDetector(
                  onTap: () {
                    if (addfeildController.value.text.isNotEmpty) {
                      if (viewType == "Hobbies") {
                        if(addfeildController.value.text.trim().isNotEmpty){
                          _updateVM.hobbies.add(addfeildController.value.text);

                        }
                        addfeildController.value.text = "";
                        FocusManager.instance.primaryFocus?.unfocus();
                      } else if (viewType == "Interest") {
                        _updateVM.intrests.add(addfeildController.value.text);
                        addfeildController.value.text = "";
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                    } else {
                      Toast().error(massage: "Please enter some text");
                    }
                  },
                  child: Container(
                    width: 60,
                    height: 45,
                    margin: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        stops: [0, 1],
                        colors: [
                          AppColors.primary,
                          AppColors.secondary,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.topLeft,
                    child: Center(
                      child: AppText(
                        text: "Add",
                        height: 1,
                        fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeConfig.screenWidth * 0.035),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Expanded(
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        spacing: 15,
                        runSpacing: 15,
                        children: [

                          for (var item in viewType == "Hobbies"
                              ? _updateVM.hobbies
                              : _updateVM.intrests)
                            FittedBox(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.screenWidth * 0.02,
                                  vertical: SizeConfig.screenWidth * 0.02,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(color: AppColors.midGrey),
                                    color: AppColors.midGrey
                                ),
                                child: Row(
                                  children: [
                                    Container(

                                      child: AppText(
                                          text: item,
                                          textAlign: TextAlign.center,
                                          fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12)
                                      ),
                                    ),
                                    SizedBox(width: 15,),
                                    GestureDetector(
                                        onTap: () {
                                          if (viewType == "Hobbies") {
                                            _updateVM.hobbies.remove(item);
                                          } else if (viewType == "Interest") {
                                            _updateVM.intrests.remove(item);
                                          }
                                        },
                                        child:Image.asset(
                                            width:20,
                                            height:20,
                                            AppImages.imgClose,
                                            color: AppColors.primaryText,
                                            fit: BoxFit.scaleDown)),
                                  ],
                                ),
                              ),
                            ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppButton.mainButton(
              context,
              text: "save",
              onPressed: () {
                _updateVM.hobbies.refresh();
                _updateVM.intrests.refresh();
                Get.back();
              },
            ),
            SizedBox(height: SizeConfig.screenWidth * 0.1),
          ],
        ),
      ),
    );
  }
}
