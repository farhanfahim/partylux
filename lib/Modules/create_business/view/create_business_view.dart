import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/create_business/model/become_partner_model.dart';
import 'package:partylux/Utils/Common/common_image_view.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import '../../../Constants/app_fonts.dart';
import '../../../Constants/app_images.dart';
import '../../../Constants/app_routes.dart';
import '../../../Constants/color.dart';
import '../../../Constants/constants.dart';
import '../../../Constants/dimens.dart';
import '../../../Utils/Common/custom_rectangle_checkbox.dart';
import '../../../Utils/Common/custom_textfield.dart';
import '../../../Utils/Common/icons.dart';
import '../../../Utils/Common/multi_image_view.dart';
import '../../../Utils/Common/sizer.dart';
import '../../../Utils/Theme/app_text.dart';
import '../../../Utils/Util.dart';
import '../../../Utils/buttons/dg_main_button.dart';
import '../../../Utils/common_methods.dart';
import '../../../Utils/helper_functions.dart';
import '../component/timing_tile.dart';
import '../view_model/create_buisness_vm.dart';
class CreateBusinessView extends StatelessWidget {
  String type = "";
  CreateBusinessView(this.type);
  final _createBusinessVM = Get.put(CreateBusinessViewModel());

  

  @override
  Widget build(BuildContext context) {

    if(type.isNotEmpty){
      _createBusinessVM.viewType.value = Constants.BUSINESS;
    }

    return CustomScaffold(
        isBodyPadding: _createBusinessVM.viewType.value == Constants.BUSINESS?false:true,
        isLeftAlign: false,
        showBackBtn: true,
        hideBackgroundImage: _createBusinessVM.viewType.value == Constants.BUSINESS?true:false,
        hideAppBar: _createBusinessVM.viewType.value == Constants.BUSINESS?true:false,
        appBarTitle:"Create "+_createBusinessVM.viewType.value,
        isTopPadding: _createBusinessVM.viewType.value == Constants.BUSINESS?30:10,
        body: SingleChildScrollView(
          child: Form(
            key: _createBusinessVM.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Visibility(child: SizedBox(height: _createBusinessVM.viewType.value==Constants.BUSINESS?20:0,)),
                CustomTextField(
                  controller: _createBusinessVM.clubNameController.value,
                  label: _createBusinessVM.viewType.value+" Name",
                  focusNode: _createBusinessVM.clubNameNode,
                  textInputType: TextInputType.text,
                  hintText: "Enter ${_createBusinessVM.viewType.value} Name",
                  maxLength: 100,
                  maxLines: 1,
                  onChanged: (v){
                    if(v.startsWith(' ')){
                      _createBusinessVM.clubNameController.value.text = '';
                    }
                  },
                  validator: (value){
                    return HelperFunction.fieldValidator(value!,_createBusinessVM.viewType.value+" Name");
                  },
                  prefix: Container(
                    width: 10,
                    height: 10,
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    child: Image.asset(
                      AppImages.imgClub,
                    ),
                  ),
                ),
                Visibility(
                  visible: _createBusinessVM.viewType.value==Constants.BUSINESS?true:false,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      CustomTextField(
                        controller: _createBusinessVM.email.value,
                        maxLength: 50,
                        maxLines: 1,
                        textInputType: TextInputType.emailAddress,
                        label: "Email",
                        hintText: "Enter your email",
                        validator: (value){
                          return HelperFunction.emailValidate(value!);
                        },
                        prefix: Container(
                          width: 10,
                          height: 10,
                          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                          child: Image.asset(
                            AppImages.imgEmail,
                            color: AppColors.iconColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Obx(() => CustomTextField(
                        controller: _createBusinessVM.password.value,

                        maxLength: 50,
                        maxLines: 1,
                        textInputType: TextInputType.visiblePassword,
                        label: "Password",
                        hintText: "Enter your password",
                        obscureText:  _createBusinessVM.obscureText.value,
                        validator: (value){
                          return HelperFunction.passwordValidate(value!);
                        },
                        prefix: Container(
                          width: 10,
                          height: 10,
                          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                          child: Image.asset(
                            AppImages.imgKey,
                            color: AppColors.iconColor,
                          ),
                        ),
                        suffix: GestureDetector(
                          onTap: (){
                            _createBusinessVM.obscureText.value = !_createBusinessVM.obscureText.value;
                          },
                          child: Container(
                              width: 10,
                              height: 10,
                              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                              child: SvgPicture.asset(
                                _createBusinessVM.obscureText.value
                                    ?  AppImages.icEyeOpen:AppImages.icEyeClosed,
                              )),
                        ),
                      ),),

                      SizedBox(height: 20),
                      Obx(() => CustomTextField(
                        controller: _createBusinessVM.confirmPassword.value,
                        label: "Confirm Password",

                        maxLength: 50,
                        maxLines: 1,
                        textInputType: TextInputType.visiblePassword,
                        hintText: "Enter your Confirm password",
                        obscureText:  _createBusinessVM.obscureText2.value,
                        validator: (value){
                          return HelperFunction.confirmPasswordValidate(value!,_createBusinessVM.password.value.text);
                        },
                        prefix: Container(
                          width: 10,
                          height: 10,
                          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                          child: Image.asset(
                            AppImages.imgKey,
                            color: AppColors.iconColor,
                          ),
                        ),
                        suffix: GestureDetector(
                          onTap: (){
                            _createBusinessVM.obscureText2.value = !_createBusinessVM.obscureText2.value;
                          },
                          child: Container(
                              width: 10,
                              height: 10,
                              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                              child: SvgPicture.asset(
                                _createBusinessVM.obscureText2.value
                                    ?  AppImages.icEyeOpen:AppImages.icEyeClosed,
                              )),
                        ),
                      ),),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: _createBusinessVM.clubTypeController.value,
                  label: AppStrings.type,
                  readOnly: true,
                  maxLength: 50,
                  maxLines: 1,
                  focusNode: _createBusinessVM.clubTypeNode,
                  textInputType: TextInputType.text,
                  hintText: AppStrings.selectType,
                  validator: (value){
                    return HelperFunction.fieldValidator(value!,AppStrings.type,);
                  },
                  onTap: (){
                    Util.showBottomSheet(
                      context,
                      screenTitle:AppStrings.selectType,
                      saveTap: (){
                        Get.back();
                      },
                      widget:ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: _createBusinessVM.listOfType.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                  padding:AppSizer.getPadding(left: 16,right: 16,top: 8,bottom: 8),
                                  child: Row(
                                    children: [
                                      Expanded(child: AppText(text: _createBusinessVM.listOfType[index].title,)),
                                      Obx(() => CustomRectangleCheckbox(

                                          selected: _createBusinessVM.listOfType[index].selected.value,onChanged:(v){


                                        for(var item in _createBusinessVM.listOfType){
                                          item.selected.value = false;
                                        }
                                        _createBusinessVM.listOfType[index].selected.value = v;
                                        _createBusinessVM.listOfType[index].selected.refresh();
                                        _createBusinessVM.clubTypeController.value.text = _createBusinessVM.listOfType[index].title;
                                      }),)
                                    ],
                                  )
                              ),
                              Divider(thickness: 0.2,)
                            ],
                          );
                        },
                      ),);
                  },
                  prefix: Container(
                    width: 10,
                    height: 10,
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    child: Image.asset(
                      AppImages.imgClub,
                    ),
                  ),
                  suffix: Container(
                    width: 10,
                    height: 10,
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    child: SvgPicture.asset(
                      AppImages.icDown,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: _createBusinessVM.locationController.value,
                  readOnly: true,
                  maxLines: 1,
                  focusNode: _createBusinessVM.locationNode,
                  textInputType: TextInputType.streetAddress,
                  maxLength: 200,
                  validator: (value){
                    return HelperFunction.fieldValidator(value!,_createBusinessVM.viewType.value+" "+AppStrings.location,);
                  },
                  prefix: Container(
                    width: 10,
                    height: 10,
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    child: CustomMonoIcon(
                      icon: AppImages.icLocation,
                      size: null,
                      isSvg: false,
                      color: AppColors.iconColor,
                    ),
                  ),
                  label: _createBusinessVM.viewType.value+" "+AppStrings.location,
                  hintText: "Enter ${_createBusinessVM.viewType.value} Location",
                  onTap: (){
                    CommonMethods.showLocationPicker((loc){
                      _createBusinessVM.createBecomePartner.value.location = Location(
                        type : "Point",
                        coordinates: [loc.coordinates![0],loc.coordinates![1]],
                        radius: "30",
                      );
                      _createBusinessVM.locationController.value.text=loc.address!;
                    });
                  },
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: _createBusinessVM.descController.value,
                  textInputType: TextInputType.text,
                  maxLength: 250,
                  maxLines: 5,
                  onChanged: (v) {
                    if(v.startsWith(' ')){
                      _createBusinessVM.descController.value.text = '';
                    }
                  },
                  label: AppStrings.desc,
                  hintText: AppStrings.desc,
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    AppText(text: _createBusinessVM.viewType.value+" "+AppStrings.hours,
                      fontWeight: FontWeight.w400,
                      fontSize: AppSizer.getFontSize(18), ),

                  ],
                ),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: _createBusinessVM.listOfTiming.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return TimingTile(
                      title: _createBusinessVM.listOfTiming[index].title,
                      isClose: _createBusinessVM.listOfTiming[index].isClose,
                      initialStart: _createBusinessVM.listOfTiming[index].startTime!,
                      initialEnd: _createBusinessVM.listOfTiming[index].endTime!,
                      isSameTimeEnable: _createBusinessVM.listOfTiming[index].isSameTimeEnable!,
                      isOpenCallback: (bool val) {
                        _createBusinessVM.listOfTiming[index].isClose.value != _createBusinessVM.listOfTiming[index].isClose;
                      },
                      startCallback: (Rx<DateTime> val) {
                        _createBusinessVM.listOfTiming[index].startTime!.value = val.toString();
                        _createBusinessVM.listOfTiming[index].startTimeUTC!.value = val.value.toUtc();
                      },
                      endCallback: (Rx<DateTime> val) {
                        _createBusinessVM.listOfTiming[index].endTime!.value = val.toString();
                        _createBusinessVM.listOfTiming[index].endTimeUTC!.value = val.value.toUtc();
                      },
                    );
                  },
                ),
                SizedBox(height: 20,),
                AppText(
                  text: "Upload Images",
                  fontWeight: FontWeight.w400,
                  fontSize: AppSizer.getFontSize(18),

                ),
                SizedBox(height: 12),
                MultiImageView(_createBusinessVM.arrOfImage),
                SizedBox(height: 20),
                CustomTextField(
                  controller: _createBusinessVM.admissionFeeController.value,
                  inputFormatters: [
                    CurrencyTextInputFormatter(symbol: '\$',decimalDigits: 0)
                  ],
                  textInputAction:TextInputAction.next,
                  textInputType: TextInputType.numberWithOptions(),
                  prefix: Container(
                    width: 10,
                    height: 10,
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    child: CustomMonoIcon(
                      icon: AppImages.imgDollar,
                      size: null,
                      isSvg: false,
                      color: AppColors.iconColor,
                    ),
                  ),
                  validator: (value){
                    return HelperFunction.fieldValidator(value!,AppStrings.admissionFee);
                  },
                  label: AppStrings.admissionFee,
                  hintText: "\$0",
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    AppText(text: AppStrings.music,
                      fontWeight: FontWeight.w400,
                      fontSize: AppSizer.getFontSize(18),),
                    Spacer(),
                    AppText(text: AppStrings.optional,
                      color: AppColors.secondary,
                      fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                      fontWeight: FontWeight.w400,),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                CustomTextField(
                  controller: _createBusinessVM.musicController.value,
                  readOnly: true,
                  focusNode: _createBusinessVM.musicNode,
                  maxLines: 1,
                  prefix: Container(
                    width: 10,
                    height: 10,
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    child: CustomMonoIcon(
                      icon: AppImages.imgMusic,
                      size: null,
                      isSvg: false,
                      color: AppColors.iconColor,
                    ),
                  ),
                  suffix: Container(
                    width: 10,
                    height: 10,
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    child: SvgPicture.asset(
                      AppImages.icDown,
                    ),
                  ),
                  hintText: AppStrings.selectMusic,
                  onTap: (){
                    Util.showBottomSheet(
                      context,
                      saveTap: (){
                        Get.back();
                      },
                      screenTitle:AppStrings.selectMusicGenre,
                      widget:ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: _createBusinessVM.listOfMusic.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                  padding:AppSizer.getPadding(left: 16,right: 16,top: 8,bottom: 8),
                                  child: Row(
                                    children: [
                                      Expanded(child: AppText(text: _createBusinessVM.listOfMusic[index].title,)),
                                      Obx(() => CustomRectangleCheckbox(

                                          selected: _createBusinessVM.listOfMusic[index].selected.value,onChanged:(v){

                                        _createBusinessVM.listOfMusic[index].selected.value = v;
                                        _createBusinessVM.listOfMusic[index].selected.refresh();

                                        if (_createBusinessVM.listOfMusic[index].title == "all") {
                                          bool isSelected = _createBusinessVM.listOfMusic[index].selected.value;
                                          print(isSelected);
                                          for (var item in _createBusinessVM.listOfMusic) {
                                            item.selected.value = isSelected;
                                          }
                                        } else {
                                          _createBusinessVM.listOfMusic[0].selected.value = false;
                                        }

                                        _createBusinessVM.musicController.value.text = "";
                                        for(var item in _createBusinessVM.listOfMusic){
                                          if(item.selected.value){
                                            if(item.title != "all"){
                                              _createBusinessVM.musicController.value.text += item.title +", ";
                                            }
                                          }
                                        }
                                      }),)
                                    ],
                                  )
                              ),
                              Divider(thickness: 0.2,)
                            ],
                          );
                        },
                      ),);
                  },
                ),

                SizedBox(height: 20),
                Row(
                  children: [
                    AppText(text: AppStrings.entertainment,
                      fontWeight: FontWeight.w400,
                      fontSize: AppSizer.getFontSize(18),),
                    Spacer(),
                    AppText(text: AppStrings.optional,
                      color: AppColors.secondary,
                      fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                      fontWeight: FontWeight.w400,),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                CustomTextField(
                  controller: _createBusinessVM.entertainmentController.value,
                  readOnly: false,
                  focusNode: _createBusinessVM.entertainmentNode,
                  maxLines: 1,
                  prefix: Container(
                    width: 10,
                    height: 10,
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    child: CustomMonoIcon(
                      icon: AppImages.imgEntertainment,
                      size: null,
                      isSvg: false,
                      color: AppColors.iconColor,
                    ),
                  ),
                 /* suffix: Container(
                    width: 10,
                    height: 10,
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    child: SvgPicture.asset(
                      AppImages.icDown,
                    ),
                  ),*/
                  hintText: AppStrings.selectEntertainment,
                  /*onTap: (){
                    Util.showBottomSheet(
                      context,
                      saveTap: (){
                        Get.back();
                      },
                      screenTitle:AppStrings.selectEntertainment,
                      widget:ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: _createBusinessVM.listOfEntertainment.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                  padding:AppSizer.getPadding(left: 16,right: 16,top: 8,bottom: 8),
                                  child: Row(
                                    children: [
                                      Expanded(child: AppText(text: _createBusinessVM.listOfEntertainment[index].title,)),
                                      Obx(() => CustomRectangleCheckbox(

                                          selected: _createBusinessVM.listOfEntertainment[index].selected.value,onChanged:(v){
                                        _createBusinessVM.listOfEntertainment[index].selected.value = v;
                                        _createBusinessVM.listOfEntertainment[index].selected.refresh();
                                        _createBusinessVM.entertainmentController.value.text = "";
                                        for(var item in _createBusinessVM.listOfEntertainment){
                                          if(item.selected.value){
                                            _createBusinessVM.entertainmentController.value.text += item.title +", ";
                                          }
                                        }
                                      }),)
                                    ],
                                  )
                              ),
                              Divider(thickness: 0.2,)
                            ],
                          );
                        },
                      ),);
                  },*/
                ),
               /* AppText(text: AppStrings.youCanSelect,
                  color: AppColors.iconColor,
                  fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                  fontWeight: FontWeight.w400,),*/
                SizedBox(height: 20),
                Row(
                  children: [
                    AppText(text: AppStrings.macCapacity,
                      fontWeight: FontWeight.w400,
                      fontSize: AppSizer.getFontSize(18),),
                    Spacer(),

                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                CustomTextField(
                  controller: _createBusinessVM.maxCapacityController.value,
                  focusNode: _createBusinessVM.maxCapacityNode,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                    LengthLimitingTextInputFormatter(10),
                  ],
                  textInputType: TextInputType.number,
                  prefix: Container(
                    width: 10,
                    height: 10,
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    child: CustomMonoIcon(
                      icon: AppImages.imgMaxCapacity,
                      size: null,
                      isSvg: false,
                      color: AppColors.iconColor,
                    ),
                  ),
                  hintText: AppStrings.enterMaxCapacity,

                ),
                SizedBox(height: 20),
    /*            CustomTextField(
                  controller: _createBusinessVM.ageLimitController.value,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                    LengthLimitingTextInputFormatter(3),
                  ],
                  textInputAction:TextInputAction.done,
                  textInputType: TextInputType.number,
                  prefix: Container(
                    width: 10,
                    height: 10,
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    child: CustomMonoIcon(
                      icon: AppImages.imgAgeLimit,
                      size: null,
                      isSvg: false,
                      color: AppColors.iconColor,
                    ),
                  ),
                  validator: (value){
                    return HelperFunction.fieldValidator(value!,AppStrings.ageLimit);
                  },
                  label: AppStrings.ageLimit,
                  hintText: AppStrings.enterAgeLimit,
                ),
                SizedBox(height: 20,),*/

                Visibility(
                  visible: _createBusinessVM.viewType.value==Constants.BUSINESS?true:false,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(text: AppStrings.addSocialUrl,
                        fontWeight: FontWeight.w400,
                        fontSize: AppSizer.getFontSize(18),),
                      SizedBox(
                        height: 12,
                      ),
                      CustomTextField(
                        controller: _createBusinessVM.facebookController.value,
                        maxLength: 200,
                        maxLines: 1,
                        textInputType: TextInputType.text,
                        prefix: Container(
                          width: 10,
                          height: 10,
                          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                          child: CommonImageView(
                            imagePath: AppImages.imgFacebook,
                          ),
                        ),
                        hintText: AppStrings.enterUrl,

                      ),
                      SizedBox(height: 10,),
                      CustomTextField(
                        controller: _createBusinessVM.instaController.value,
                        maxLength: 200,
                        maxLines: 1,
                        textInputType: TextInputType.text,
                        prefix: Container(
                          width: 10,
                          height: 10,
                          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                          child: CommonImageView(
                            imagePath: AppImages.imgInsta,
                          ),
                        ),
                        hintText: AppStrings.enterUrl,

                      ),
                      SizedBox(height: 10,),
                      CustomTextField(
                        controller: _createBusinessVM.snapchatController.value,
                        maxLength: 200,
                        maxLines: 1,
                        textInputType: TextInputType.text,
                        prefix: Container(
                          width: 10,
                          height: 10,
                          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                          child: CommonImageView(
                            imagePath: AppImages.imgSnapchat,
                          ),
                        ),
                        hintText: AppStrings.enterUrl,

                      ),

                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Obx(() => AppButton.mainButton(
                  context,
                  text:
                  _createBusinessVM.viewType.value==Constants.BUSINESS?
                  AppStrings.register:
                  _createBusinessVM.isEditFalse.value?
                  AppStrings.update:
                  AppStrings.txtCreate,

                  loading: _createBusinessVM.isLoading.value,
                  onPressed: () {

                     _createBusinessVM.viewType.value==Constants.BUSINESS
                        ?_createBusinessVM.onCreateBusinessAccount()
                        :_createBusinessVM.onCreateOrUpdateClubBar(_createBusinessVM.isEditFalse.value?true:false);
                  },
                ),),
                Center(
                  child: Visibility(
                    visible: _createBusinessVM.viewType.value==Constants.BUSINESS?true:false,
                    child: Column(
                      children: [
                        SizedBox(height: 50),
                        RichText(
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(
                              fontFamily: AppFonts.copperPlate,
                              overflow: TextOverflow.visible,
                              color: AppColors.iconColor,
                              fontSize: 14,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "Login",
                                recognizer: new TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.offNamed(AppRoutes.LoginSignUpView);
                                  },
                                style: TextStyle(
                                  fontFamily: AppFonts.copperPlate,
                                  overflow: TextOverflow.visible,
                                  color: AppColors.primaryText,
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40,)
              ],
            ),
          )
        ));
  }
}

