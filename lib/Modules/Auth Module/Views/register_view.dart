import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:partylux/Modules/Auth%20Module/View%20Models/register_vm.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';
import '../../../Constants/app_fonts.dart';
import '../../../Constants/app_routes.dart';
import '../../../Constants/color.dart';
import '../../../Constants/dimens.dart';
import '../../../Utils/Common/checkbox.dart';
import '../../../Utils/Common/custom_textfield.dart';
import '../../../Utils/Common/photo_popup.dart';
import '../../../Utils/Common/sizer.dart';
import '../../../Utils/Theme/app_text.dart';
import '../../../Utils/helper_functions.dart';
class RegisterView extends StatelessWidget {
  RegisterView({super.key});

  final _registerVM = Get.find<RegisterViewModel>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: SizeConfig.screenHeight * 0.03,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _registerVM.formKey,
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              GestureDetector(
                onTap: (){
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext bc) {
                      return PhotoPopUpSheet(
                        callback: (val) {
                          if (val == "take") {
                            _registerVM.camera(true);
                          } else if (val == "photo") {
                            _registerVM.photo(true);
                          }
                          Get.back();
                        },
                      );
                    },
                  );
                },
                child: Center(
                  child: Column(
                    children: [
                      Obx(() => DottedBorder(
                        borderType: BorderType.Circle,
                        dashPattern: const [8, 7],
                        color: _registerVM.userImage.value.path.isNotEmpty?Colors.transparent:AppColors.darkgrey,
                        strokeWidth: 2,
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.whiteText.withOpacity(0.10),
                              borderRadius: const BorderRadius.all(Radius.circular(100))),
                          height: SizeConfig.screenWidth * 0.24,
                          width: SizeConfig.screenWidth * 0.24,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Obx(() => _registerVM.userImage.value.path.isNotEmpty
                                  ? ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                                child: Image.file(
                                  height: SizeConfig.screenWidth * 0.24,
                                  width: SizeConfig.screenWidth * 0.24,
                                  _registerVM.userImage.value,
                                  fit: BoxFit.cover,),) : Container(),
                              ),
                              Image.asset(
                                AppImages.imgCamera,
                                width: SizeConfig.screenWidth * 0.06,
                                height: SizeConfig.screenWidth * 0.06,
                              ),

                            ],
                          ),
                        ),
                      ),),
                      SizedBox(height: 15,),
                      AppText(
                        text: "Upload image",
                        fontSize:   AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              Row(
                children: [
                  AppText(
                    text: "Upload ID",
                    fontSize:   AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),

                  ),
                  Spacer(),
                 Obx(() =>  _registerVM.IDImage.value.path.isNotEmpty?AppText(
                   text: "X not verified",
                   color: AppColors.redText,
                   fontSize:   AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                 ):Container(),)
                ],
              ),
              SizedBox(height: 12),
              Obx(() => GestureDetector(
                onTap: (){
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (BuildContext bc) {
                      return PhotoPopUpSheet(
                        callback: (val) {
                          if (val == "take") {
                            _registerVM.camera(false);
                          } else if (val == "photo") {
                            _registerVM.photo(false);
                          }
                          Get.back();
                        },
                      );
                    },
                  );
                },
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  dashPattern: const [5, 5],
                  color: _registerVM.IDImage.value.path.isNotEmpty?Colors.transparent:AppColors.darkgrey,
                  strokeWidth: 2,

                  radius:Radius.circular(10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.whiteText.withOpacity(0.10),
                        borderRadius: const BorderRadius.all(Radius.circular(10))),
                    height: SizeConfig.screenWidth * 0.4,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Obx(() => _registerVM.IDImage.value.path.isNotEmpty
                            ? ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Image.file(
                            height: SizeConfig.screenWidth * 0.4,
                            width: SizeConfig.screenWidth * 0.9,
                            _registerVM.IDImage.value,
                            fit: BoxFit.cover,),) : Container(),
                        ),
                        _registerVM.IDImage.value.path.isNotEmpty?Container():Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppImages.imgIdCard,
                              width: SizeConfig.screenWidth * 0.06,
                              height: SizeConfig.screenWidth * 0.06,
                            ),
                            SizedBox(height: 10,),
                            AppText(
                              text: "Upload your id",
                              color: AppColors.iconColor,
                              fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),),
              SizedBox(height: 20),
              CustomTextField(
                controller: _registerVM.fullname.value,
                label: "Full Name",
                maxLength: 50,
                maxLines: 1,
                textInputType: TextInputType.name,
                hintText: "Enter your full name",
                validator: (value){
                  return HelperFunction.fieldValidator(value!,"Full Name");
                },
                onChanged: (v){
                  if(v.startsWith(' ')){
                    _registerVM.fullname.value.text = '';
                  }
                },
                prefix: Container(
                  width: 10,
                  height: 10,
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                  child: Image.asset(
                    AppImages.imgUser,
                    color: AppColors.iconColor,
                  ),
                ),
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: _registerVM.email.value,
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
                controller: _registerVM.password.value,

                maxLength: 50,
                maxLines: 1,
                textInputType: TextInputType.visiblePassword,
                label: "Password",
                hintText: "Enter your password",
                obscureText:  _registerVM.obscureText.value,
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
                    _registerVM.obscureText.value = !_registerVM.obscureText.value;
                  },
                  child: Container(
                      width: 10,
                      height: 10,
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: SvgPicture.asset(
                        _registerVM.obscureText.value
                            ?  AppImages.icEyeOpen:AppImages.icEyeClosed,
                      )),
                ),
              ),),

              SizedBox(height: 20),
              Obx(() => CustomTextField(
                controller: _registerVM.confirmPassword.value,
                label: "Confirm Password",

                maxLength: 50,
                maxLines: 1,
                textInputType: TextInputType.visiblePassword,
                hintText: "Enter your Confirm password",
                obscureText:  _registerVM.obscureText2.value,
                validator: (value){
                  return HelperFunction.confirmPasswordValidate(value!,_registerVM.password.value.text);
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
                    _registerVM.obscureText2.value = !_registerVM.obscureText2.value;
                  },
                  child: Container(
                      width: 10,
                      height: 10,
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: SvgPicture.asset(
                        _registerVM.obscureText2.value
                            ?  AppImages.icEyeOpen:AppImages.icEyeClosed,
                      )),
                ),
              ),),
              SizedBox(height: 20),
              CheckBoxField(
                isRichText: true,
                richText1: "By checking this box, you agree to our\n",
                richText2: "Terms & Conditions",
                richText3: "Privacy Policy.",
                richTextCallBack: (String val) {
                  if (val == "Terms & Conditions") {
                    Get.toNamed(
                      AppRoutes.customPrivacyView,
                      arguments: ["Terms & Conditions"],
                    );
                  } else {
                    Get.toNamed(
                      AppRoutes.customPrivacyView,
                      arguments: ["Privacy Policy"],
                    );
                  }
                },
                callback: (val) {
                  _registerVM.isCheckTerms.value = val;
                },
              ),

              SizedBox(height: 30),
              Obx(
                () => AppButton.mainButton(
                  context,
                  text: "Register",
                  loading: _registerVM.isLoading.value,
                  onPressed: () {
                    _registerVM.onRegister();
                  },
                ),
              ),
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
    );
  }
}
