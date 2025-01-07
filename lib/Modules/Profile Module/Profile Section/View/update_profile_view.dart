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
import '../../../../Utils/Theme/app_text.dart';
import '../../../../Utils/common_methods.dart';
import '../../../../Utils/helper_functions.dart';
import '../View Model/update_profile_vm.dart';
import 'Components/image_button.dart';

class UpdateProfileView extends StatelessWidget {
  UpdateProfileView({
    super.key,
  });

  final _updateVM = Get.find<UpdateProfileViewModel>();
  final bool? isProfile = Get.arguments[0];

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      hideAppBar: isProfile!,
      showBackBtn: isProfile!?false:true,
      appBarTitle: isProfile!?"":AppStrings.personalDetail,
      body: Obx(
        () => Column(
          children: [
            isProfile!?Container():Padding(
              padding: AppSizer.getMargin(bottom: 10,left: 5,right: 5),
              child: Divider(thickness: 0.5,),
            ),
            SizedBox(height: isProfile!?AppSizer.getVerticalSize(40):0),
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
                      isProfile!?Container(
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
                      ):Container(),
                      Expanded(
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: SizedBox(
                                  height: SizeConfig.screenWidth * 0.28,
                                  width: SizeConfig.screenWidth * 0.28,
                                  child: _updateVM.userImage.value.path.isNotEmpty
                                      ? Image.file(
                                          _updateVM.userImage.value,
                                          fit: BoxFit.cover,
                                        )
                                      : _updateVM.networkUserImage.value.isNotEmpty
                                          ? AnimatedContainer(
                                              duration: const Duration(milliseconds: 250),
                                              height: SizeConfig.screenWidth * 0.28,
                                              width: SizeConfig.screenWidth * 0.28,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white.withOpacity(0.2),
                                                border: Border.all(color: AppColors.whiteText,width: 1),
                                              ),
                                            child: cachedNetworkImage(
                                                _updateVM.networkUserImage.value,
                                                context: context),
                                          )
                                          : DottedBorder(
                                    borderType: BorderType.RRect,
                                    dashPattern: const [8, 7],
                                    color: AppColors.whiteText,
                                    strokeWidth: 2,
                                    radius:Radius.circular(100),
                                            child: Center(
                                              child: Container(
                                                child: SvgPicture.asset(
                                                    height: AppSizer.getSize(26),
                                                    width:AppSizer.getSize(26),
                                                    AppImages.icAdd,
                                                    color:AppColors.iconColor
                                                ),
                                              ),
                                            ),
                                          ),
                                ),
                              ),
                            ),
                            imageButton(
                              callback: () {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: (BuildContext bc) {
                                    return PhotoPopUpSheet(
                                      callback: (val) {
                                        if (val == "take") {
                                          _updateVM.camera();
                                        } else if (val == "photo") {
                                          _updateVM.photo();
                                        }
                                        Get.back();
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      isProfile!?SizedBox(
                        width: SizeConfig.screenWidth * 0.08,
                      ):Container(),
                    ],
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: _updateVM.fullname.value,
                    textInputType: TextInputType.name,
                    maxLength: 50,
                    maxLines: 1,
                    label: "Name",
                    hintText: "Enter your name",
                    validator: (value){
                      return HelperFunction.fieldValidator(value!,"Name");
                    },

                  ),
                  SizedBox(height: 20),

                  CustomTextField(
                    controller: _updateVM.email.value,
                    label: "Email",
                    readOnly: true,
                    maxLength: 50,
                    maxLines: 1,
                    textInputType: TextInputType.emailAddress,
                    hintText: "Enter your email",
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: _updateVM.age.value,
                    textInputType: TextInputType.numberWithOptions(decimal: false),
                    maxLength: 3,
                    label: "Age",
                    hintText: "Enter your age",
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: _updateVM.aboutus.value,
                    textInputType: TextInputType.text,
                    maxLength: 250,
                    maxLines: 5,
                    label: "About Me",
                    hintText: "Description",
                  ),



                  GenderSelectionTile(
                    isProfile:isProfile!,
                    hintText: "Gender",
                    isMale: _updateVM.gender.value.isNotEmpty
                        ?_updateVM.gender.value == "male"
                        ?true.obs
                        :false.obs:true.obs,
                    callback: (val) {
                      if(!isProfile!)_updateVM.gender.value = val;
                    },
                  ),
                  SizedBox(height: 20),
                  AppText(
                      text: "Phone No",
                    fontWeight: FontWeight.w400,
                    fontSize: AppSizer.getFontSize(18),

                  ),
                  SizedBox(height: 12),
                  Obx(() => InternationalPhoneNumberInput(
                    keyboardType: TextInputType.number,
                    cursorColor: AppColors.whiteText,
                    countrySelectorScrollControlled: true,
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
                      hintText: "Enter phone no",
                      filled: true,
                      hintStyle:
                          TextStyle(
                              fontFamily: AppFonts.copperPlate2,
                              fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                              color: AppColors.iconColor),

                    ),
                    onInputChanged: (phone) {
                      _updateVM.phoneNumber!.value = phone.phoneNumber!;
                      _updateVM.countryCode.value = phone.dialCode!;
                    },
                    onFieldSubmitted: (phone) {
                      _updateVM.phone.value.text = phone;
                    },

                  )),

                  SizedBox(height: 20),
                  CustomTextField(
                    controller: _updateVM.location.value,
                    textInputType: TextInputType.streetAddress,
                    maxLength: 200,
                    maxLines: 1,
                    readOnly: true,
                    label: "Location",
                    hintText: "Enter your location",
                    validator: (value){
                      return HelperFunction.fieldValidator(value!,"Location");
                    },
                    onTap: (){
                      CommonMethods.showLocationPicker((loc){
                        _updateVM.location.value.text=loc.address!;
                      });
                    },

                  ),

                  HobbiesAndIntrestsField(
                    title: "Hobbies",
                    itemsList: _updateVM.hobbies.value,
                    addTap: () {
                      Get.toNamed(AppRoutes.HOBBIES_INTREST, arguments: ["Hobbies"]);
                    },
                  ),
                  HobbiesAndIntrestsField(
                    title: "Interest",
                    itemsList: _updateVM.intrests.value,
                    addTap: () {
                      Get.toNamed(AppRoutes.HOBBIES_INTREST, arguments: ["Interest"]);
                    },
                  ),
                  SizedBox(height: 40),
                  AppButton.mainButton(
                    context,
                    text: "save",
                    loading: _updateVM.isLoading.value,
                    onPressed: () {
                      if (isProfile!) {
                        print("update Profile");
                        _updateVM.updateProfile(isProfile!);
                      } else {
                        print("create Profile");
                        _updateVM.createProfile();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
