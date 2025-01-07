import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/Auth%20Module/View%20Models/newpassword_vm.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

import '../../../Utils/Common/custom_textfield.dart';
import '../../../Utils/helper_functions.dart';

class NewPasswordView extends StatelessWidget {
  NewPasswordView({super.key});

  final _newPasswordVM = Get.find<NewPasswordViewModel>();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showBackBtn: false,
      isLeftAlign: true,
      appBarTitle: "New Password",
      body: Obx(
        () => Form(
          key: _newPasswordVM.formKey,
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [


              AppText(
                text: "Create your new password to Login",
                fontSize: SizeConfig.screenWidth * 0.035,
                fontWeight: FontWeight.w400,
                color: AppColors.iconColor,
                overflow: TextOverflow.visible,
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.05),

              Obx(() => CustomTextField(
                controller: _newPasswordVM.password.value,
                label: "New Password",

                maxLength: 50,
                maxLines: 1,
                textInputType: TextInputType.visiblePassword,
                hintText: "Enter your new password",
                obscureText:  _newPasswordVM.obscureText1.value,
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
                    _newPasswordVM.obscureText1.value = !_newPasswordVM.obscureText1.value;
                  },
                  child: Container(
                      width: 10,
                      height: 10,
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: SvgPicture.asset(
                        _newPasswordVM.obscureText1.value
                            ?  AppImages.icEyeOpen:AppImages.icEyeClosed,
                      )),
                ),
              ),),

              SizedBox(height: SizeConfig.screenHeight * 0.03),
              Obx(() => CustomTextField(
                controller: _newPasswordVM.confirmPassword.value,
                label: "Confirmation Password",
                hintText: "Enter your Confirm password",

                maxLength: 50,
                maxLines: 1,
                textInputType: TextInputType.visiblePassword,
                obscureText:  _newPasswordVM.obscureText1.value,
                validator: (value){
                  return HelperFunction.confirmPasswordValidate(value!,_newPasswordVM.password.value.text);
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
                    _newPasswordVM.obscureText1.value = !_newPasswordVM.obscureText1.value;
                  },
                  child: Container(
                      width: 10,
                      height: 10,
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: SvgPicture.asset(
                        _newPasswordVM.obscureText1.value
                            ?  AppImages.icEyeOpen:AppImages.icEyeClosed,
                      )),
                ),
              ),),
              SizedBox(height: SizeConfig.screenHeight * 0.04),
              AppButton.mainButton(
                context,
                text: "Reset Password",
                loading: _newPasswordVM.isLoading.value,
                onPressed: () {
                  _newPasswordVM.onResetPassword();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
