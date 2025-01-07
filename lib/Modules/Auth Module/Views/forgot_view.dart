import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/Auth%20Module/View%20Models/forgot_vm.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

import '../../../Constants/dimens.dart';
import '../../../Utils/Common/custom_textfield.dart';
import '../../../Constants/app_images.dart';
import '../../../Utils/Common/sizer.dart';
import '../../../Utils/helper_functions.dart';

class ForgotView extends StatelessWidget {
  ForgotView({super.key});

  final _forgotVM = Get.find<ForgotViewModel>();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showBackBtn: true,
      isLeftAlign: true,
      appBarTitle: "Forget Password?",
      body: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          AppText(
            text:
                "Type your email, we will send you \nverification code via email",
            overflow: TextOverflow.visible,
            fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
            height: 1,
            fontWeight: FontWeight.w400,
            color:AppColors.iconColor,
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.05),
          Form(
            key: _forgotVM.formKey,
            child: CustomTextField(
              controller: _forgotVM.email.value,
              textInputType: TextInputType.emailAddress,
              label: "Email",

              maxLength: 50,
              maxLines: 1,
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
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.03),
          Obx(
            () => AppButton.mainButton(
              context,
              text: "Submit",
              loading: _forgotVM.isLoading.value,
              onPressed: () {
                _forgotVM.onForgotSubmit();
              },
            ),
          ),
        ],
      ),
    );
  }
}
