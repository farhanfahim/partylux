import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/Auth%20Module/Models/usermodel.dart';
import 'package:partylux/Modules/Auth%20Module/View%20Models/login_vm.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import '../../../Constants/constants.dart';
import '../../../Constants/dimens.dart';
import '../../../Utils/Common/login_signup_tile.dart';
import '../../../Utils/Common/sizer.dart';
import 'login_view.dart';

class LoginSignUpView extends StatelessWidget {
  LoginSignUpView({super.key});

  final _loginVM = Get.find<LoginViewModel>();
  RxBool selectedType = true.obs;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      hideAppBar: true,
      body: SafeArea(
        top: true,
        bottom: true,
        child: Padding(
          padding: EdgeInsets.only(
            top: SizeConfig.screenHeight * 0.045,
            bottom: SizeConfig.screenHeight * 0.03,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Visibility(
                  visible:true,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: "Login to your account",
                          fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel20),
                        ),
                        SizedBox(height: 5),
                        AppText(
                          text: "Hi, Welcome back ",
                          fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                          color: AppColors.whiteText.withOpacity(0.7),
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.03),
                        AppText(
                          text: "Login as",
                          fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
                          color: AppColors.whiteText,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                LoginSigupButtonTile(
                  callback: (val) {
                    if(val == UserModel.ROLE_USER){
                      selectedType.value = true;
                      _loginVM.role.value = UserModel.ROLE_USER;

                    }else{
                      selectedType.value = false;
                      _loginVM.role.value = UserModel.ROLE_BUSINESS;
                    }

                  },
                ),
                LoginView(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
