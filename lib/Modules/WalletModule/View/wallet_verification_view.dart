import 'package:flutter/material.dart';
import 'package:partylux/Utils/AppBar/primary_app_bar.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../Constants/color.dart';
import '../../../Utils/buttons/dg_main_button.dart';

class WalletVerficationView extends StatelessWidget {
  WalletVerficationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return CustomScaffold(
        isBodyPadding: false,
        body: SizedBox.expand(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.06),
              primaryAppBar(
                context: context,
                title: "Verification",
                subTitle:
                    "The confimation code was sent via email\nesmeralda@gmail.com",
                callback: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.08),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Column(
                  children: [
                    PinCodeTextField(
                      length: 4,
                      obscureText: false,
                      textStyle: const TextStyle(color: AppColors.whiteText),
                      animationType: AnimationType.fade,
                      keyboardType: TextInputType.number,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(18),
                        fieldHeight: 75,
                        fieldWidth: SizeConfig.screenWidth / 5,
                        activeFillColor:
                            AppColors.feildBGColor.withOpacity(0.1),
                        selectedColor: AppColors.backgroundColor,
                        activeColor: AppColors.backgroundColor,
                        inactiveColor: AppColors.backgroundColor,
                        selectedFillColor:
                            AppColors.feildBGColor.withOpacity(0.1),
                        borderWidth: 0.5,
                        inactiveFillColor:
                            AppColors.feildBGColor.withOpacity(0.1),
                        disabledColor: AppColors.error,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      backgroundColor: AppColors.transparent,
                      cursorColor: AppColors.iconColor,
                      enableActiveFill: true,
                      controller: TextEditingController(),
                      onCompleted: (v) {
                        debugPrint("Completed");
                      },
                      onChanged: (value) {},
                      beforeTextPaste: (text) {
                        return true;
                      },
                      appContext: context,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 30),
                      child: AppButton.mainButton(
                        context,
                        text: "Verify Now",
                        textColor: AppColors.whiteText,
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
