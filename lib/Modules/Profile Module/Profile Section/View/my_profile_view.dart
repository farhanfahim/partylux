// ignore_for_file: invalid_use_of_protected_member

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/Profile%20Module/Profile%20Section/View/Components/gender_selection_tile.dart';
import 'package:partylux/Modules/Profile%20Module/Profile%20Section/View/Components/hobbies_intrests_field.dart';
import 'package:partylux/Utils/Common/cechednetworlimage.dart';
import 'package:partylux/Utils/Common/country_picker.dart';
import 'package:partylux/Utils/Common/photo_popup.dart';
import 'package:partylux/Utils/Common/sizer.dart';

import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Text%20Fields/textfield.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

import '../../../../Constants/app_fonts.dart';
import '../../../../Constants/app_images.dart';
import '../../../../Utils/Common/custom_textfield.dart';
import '../../../../Utils/Common/radio_button.dart';
import '../../../../Utils/Theme/app_text.dart';
import '../../../../Utils/helper_functions.dart';
import '../View Model/update_profile_vm.dart';
import 'Components/image_button.dart';

class MyProfileView extends StatelessWidget {
  MyProfileView({
    super.key,
  });

  final _updateVM = Get.find<UpdateProfileViewModel>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      hideAppBar: true,
      body: Obx(
        () => Column(
          children: [

            SizedBox(height: AppSizer.getVerticalSize(40)),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(
                  top: 20,
                  bottom: 40,
                ),
                shrinkWrap: true,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Container(
                        width: SizeConfig.screenWidth * 0.08,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {

                            Navigator.pop(context);
                          },
                          child: Container(
                            width: SizeConfig.screenWidth * 0.09,
                            height: SizeConfig.screenWidth * 0.09,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.centerLeft,
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(
                                    SizeConfig.screenWidth * 0.01),
                                child:
                                Image.asset(AppImages.imgArrowLeft),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Get.toNamed(
                                    AppRoutes.imageView,
                                    arguments: [
                                      _updateVM.networkUserImage.value,]
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 250),
                                    height: SizeConfig.screenWidth * 0.35,
                                    width: SizeConfig.screenWidth * 0.35,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withOpacity(0.2),
                                      border: Border.all(color: AppColors.whiteText,width: 1),
                                    ),
                                    child: cachedNetworkImage(
                                      _updateVM.networkUserImage.value,
                                      context: context,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {

                          Get.toNamed(
                            AppRoutes.UPDATE_PROFILE,
                            arguments: [true],
                          );
                        },
                        child: Container(
                          width: AppSizer.getSize(24),
                          height: AppSizer.getSize(24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.centerLeft,
                          child: Center(
                            child: Image.asset(AppImages.imgEdit),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Center(child: AppText(text: _updateVM.fullname.value.text,fontSize: AppSizer.getFontSize(24),)),


                  SizedBox(height: 20),
                  CustomTextField(
                    controller: _updateVM.aboutus.value,
                    textInputType: TextInputType.text,
                    maxLength: 250,
                    readOnly: true,
                    maxLines: 5,
                    label: "About Me",
                    hintText: "Description",
                  ),

                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [ 
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            AppText(
                                text: "Gender",
                              fontWeight: FontWeight.w400,
                              fontSize: AppSizer.getFontSize(18),

                            ),
                            SizedBox(height: 12),
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.whiteText.withOpacity(0.10),
                              ),
                              padding:
                              EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.03),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: AppText(
                                      text: _updateVM.gender.value,
                                      color: AppColors.iconColor,
                                      fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),

                                    ),
                                  ),
                                  RadioButton().single(true),
                                  SizedBox(width: 10,),



                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(width: AppSizer.getHorizontalSize(10),),
                      Expanded(
                        child: Column(

                          children: [
                            CustomTextField(
                              controller: _updateVM.age.value,
                              textInputType: TextInputType.numberWithOptions(decimal: false),
                              maxLength: 3,
                              readOnly: true,
                              label: "Age",
                              hintText: "age",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  AppText(
                      text: "Phone No",
                    fontWeight: FontWeight.w400,
                    fontSize: AppSizer.getFontSize(18),

                  ),
                  SizedBox(height: 12),
                  Obx(() => InternationalPhoneNumberInput(
                    validator: (val) {
                      return HelperFunction.contactNumberFieldValidator(
                          val!);
                    },
                    focusNode: _updateVM.focusPass,
                    keyboardType: TextInputType.number,
                    cursorColor: AppColors.whiteText,
                    isEnabled: false,
                    countrySelectorScrollControlled: true,
                    ignoreBlank: true,
                    selectorTextStyle: TextStyle(
                        fontFamily: AppFonts.copperPlate2,
                        fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                        color: AppColors.whiteText),
                    selectorConfig: SelectorConfig(

                      leadingPadding: 10,
                      showFlags: false,
                      trailingSpace: false,
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      setSelectorButtonAsPrefixIcon: true,
                    ),
                    textFieldController: _updateVM.phone.value,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    initialValue: _updateVM .initialPhone.value,
                    searchBoxDecoration: InputDecoration(
                      filled: true,
                      hintText: "Search",
                      fillColor: AppColors.feildBGColor.withOpacity(0.10),
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(AppSizer.getRadius(AppDimen.textFieldRadius)),
                        borderSide: BorderSide.none,),
                      enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizer.getRadius(AppDimen.textFieldRadius)),
                        borderSide: BorderSide.none,),
                      disabledBorder:   OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizer.getRadius(AppDimen.textFieldRadius)),
                        borderSide: BorderSide.none,),
                      focusedBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizer.getRadius(AppDimen.textFieldRadius)),
                        borderSide: BorderSide.none,),
                      errorBorder:   OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizer.getRadius(AppDimen.textFieldRadius)),
                        borderSide: BorderSide.none,),
                    ),
                    textStyle: TextStyle(
                        fontFamily:  AppFonts.copperPlate2,
                        color:  AppColors.whiteText,
                        fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),),
                    inputDecoration: InputDecoration(
                      fillColor: AppColors.feildBGColor.withOpacity(0.10),
                      floatingLabelBehavior:FloatingLabelBehavior.never,
                      border: OutlineInputBorder(

                        borderRadius: BorderRadius.circular(AppSizer.getRadius(AppDimen.textFieldRadius)),
                        borderSide: BorderSide.none,),
                      enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizer.getRadius(AppDimen.textFieldRadius)),
                        borderSide: BorderSide.none,),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizer.getRadius(AppDimen.textFieldRadius)),
                        borderSide: BorderSide.none,),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizer.getRadius(AppDimen.textFieldRadius)),
                        borderSide: BorderSide.none,),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppSizer.getRadius(AppDimen.textFieldRadius)),
                        borderSide: BorderSide.none,),
                      errorMaxLines: 2,
                      errorStyle: TextStyle(
                        color: Theme.of(context).colorScheme.error, // or any other color
                      ),
                      contentPadding: EdgeInsets.all(10),
                      hintText: "phone no",
                      filled: true,
                      hintStyle:
                          TextStyle(
                              fontFamily: AppFonts.copperPlate2,
                              fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                              color: AppColors.iconColor),

                    ),
                    onInputChanged: (phone) {
                      _updateVM.phoneNumber!.value = phone.phoneNumber!;
                    },
                    onFieldSubmitted: (phone) {
                      FocusScope.of(context).requestFocus(_updateVM.focusPass);
                      _updateVM.phone.value.text = phone;
                    },

                  )),

                  SizedBox(height: 20),
                  CustomTextField(
                    controller: _updateVM.location.value,
                    textInputType: TextInputType.streetAddress,
                    maxLength: 100,
                    readOnly: true,
                    maxLines: 1,
                    label: "Location",
                    hintText: "location",
                    validator: (value){
                      return HelperFunction.fieldValidator(value!,"Location");
                    },

                  ),

                  HobbiesAndIntrestsField(
                    showAddBtn:false,
                    title: "Hobbies",
                    itemsList: _updateVM.hobbies.value,
                    addTap: () {
                      Get.toNamed(AppRoutes.HOBBIES_INTREST, arguments: ["Hobbies"]);
                    },
                  ),
                  HobbiesAndIntrestsField(
                    showAddBtn:false,
                    title: "Interest",
                    itemsList: _updateVM.intrests.value,
                    addTap: () {
                      Get.toNamed(AppRoutes.HOBBIES_INTREST, arguments: ["Interest"]);
                    },
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
