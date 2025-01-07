import 'dart:io' show Platform;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/Auth%20Module/View%20Models/login_vm.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';
import '../../../Constants/app_fonts.dart';
import '../../../Constants/dimens.dart';
import '../../../Utils/Common/checkbox.dart';
import '../../../Utils/Common/custom_textfield.dart';
import '../../../Constants/app_images.dart';
import '../../../Utils/Common/sizer.dart';
import '../../../Utils/helper_functions.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _loginVM = Get.find<LoginViewModel>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.screenHeight * 0.04,
        bottom: SizeConfig.screenHeight * 0.03,
      ),
      child: Form(
        key: _loginVM.formKey,
        child: Column(
          children: [

            CustomTextField(
              controller: _loginVM.email.value,
              label: "Email",

              maxLength: 50,
              maxLines: 1,
              textInputType: TextInputType.emailAddress,
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
            SizedBox(height: SizeConfig.screenHeight * 0.03),

            Obx(() => CustomTextField(
              controller: _loginVM.password.value,
              label: "Password",

              maxLength: 50,
              maxLines: 1,
              textInputType: TextInputType.visiblePassword,
              hintText: "Enter your password",
              obscureText:  _loginVM.obscureText.value,

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
                  _loginVM.obscureText.value = !_loginVM.obscureText.value;
                },
                child: Container(
                    width: 10,
                    height: 10,
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    child: SvgPicture.asset(
                      _loginVM.obscureText.value
                          ?  AppImages.icEyeOpen:AppImages.icEyeClosed,
                    )),
              ),
            ),),

            SizedBox(height: SizeConfig.screenHeight * 0.02),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {

                  Get.toNamed(AppRoutes.FORGOT);
                },
                child: AppText(
                  text: "Forgot Password?",
                  fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                  fontWeight: FontWeight.w400,
                  color: AppColors.primary,
                ),
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.015),
            Obx(
                  () => AppButton.mainButton(
                context,
                text: "Login",
                loading: _loginVM.isLoading.value,
                onPressed: () {
                  _loginVM.onLogin();
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: true,
                  child: Column(
                    children: [
                      SizedBox(height: SizeConfig.screenHeight * 0.06),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              _loginVM.SignInWithGoogleButton();
                            },
                            child: Container(
                              color: AppColors.transparent,
                              child: Image.asset(
                                AppImages.imgGoogle,
                                width: SizeConfig.screenWidth * 0.15,
                                height: SizeConfig.screenWidth * 0.15,
                              ),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: Platform.isIOS,
                  child: Padding(
                    padding: AppSizer.getPadding(left: 15),
                    child: Column(
                      children: [
                        SizedBox(height: SizeConfig.screenHeight * 0.06),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                _loginVM.SignInWithAppleButton();
                              },
                              child: Container(
                                color: AppColors.transparent,
                                child: Image.asset(
                                  AppImages.imgAppleLogin,
                                  width: SizeConfig.screenWidth * 0.15,
                                  height: SizeConfig.screenWidth * 0.15,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50,),
            RichText(
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                text: "Don't have an account? ",
                style: TextStyle(
                  fontFamily: AppFonts.copperPlate,
                  overflow: TextOverflow.visible,
                  color: AppColors.iconColor,
                  fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: "Sign Up",
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () {
                        Get.offNamed(AppRoutes.UserBusinessSignUpView);
                      },
                    style: TextStyle(
                      fontFamily: AppFonts.copperPlate,
                      overflow: TextOverflow.visible,
                      color: AppColors.primaryText,
                      fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                    ),
                  )
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
