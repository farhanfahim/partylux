import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/Auth%20Module/Models/usermodel.dart';
import 'package:partylux/Modules/Auth%20Module/View%20Models/login_vm.dart';
import 'package:partylux/Modules/Auth%20Module/Views/register_view.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import '../../../Constants/constants.dart';
import '../../../Constants/dimens.dart';
import '../../../Utils/Common/login_signup_tile.dart';
import '../../../Utils/Common/sizer.dart';
import '../../create_business/view/create_business_view.dart';

class UserBusinessSignUpView extends StatelessWidget {
  UserBusinessSignUpView({super.key});

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
          child: Column(
            children: [
              Visibility(
                visible:true,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: AppText(
                          text: "Register new account",
                          fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel20),
                        ),
                      ),

                      SizedBox(height: SizeConfig.screenHeight * 0.03),
                      AppText(
                        text: "Sign up as",
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
                  }else{
                    selectedType.value = false;
                  }
                },
              ),
             Expanded(child: Obx(() =>  selectedType.value?RegisterView()
                 : CreateBusinessView(Constants.BUSINESS),))
            ],
          ),
        ),
      ),
    );
  }
}
