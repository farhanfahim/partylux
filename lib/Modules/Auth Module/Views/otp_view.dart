import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:im_animations/im_animations.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/Auth%20Module/View%20Models/otp_vm.dart';
import 'package:partylux/Utils/Common/custom_button.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../Constants/app_fonts.dart';
import '../../../Constants/app_images.dart';
import '../../../Constants/dimens.dart';
import '../../../Utils/Common/sizer.dart';

class OTPView extends StatelessWidget {
  OTPView({super.key});

  final _otpVM = Get.find<OTPViewModel>();

  final String verificationFor = Get.arguments[0];
  final String verificationEmail = Get.arguments[1];
  final String userID = Get.arguments[2];

  @override
  Widget build(BuildContext context) {

    return CustomScaffold(
      showBackBtn: true,
      appBarTitle: "Verify code",
      isLeftAlign: true,
      body: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text:
                "The confirmation code was sent via email",
            overflow: TextOverflow.visible,
            fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
            height: 1,
            fontWeight: FontWeight.w400,
            color:AppColors.iconColor,
          ),
          AppText(
            text:
            "$verificationEmail",
            fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
            fontWeight: FontWeight.w400,
            color: AppColors.whiteText,
            height: 1.2,
            overflow: TextOverflow.visible,
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.05),
          Container(
            margin: AppSizer.getMargin(left: 60,right: 60),
            child: PinCodeTextField(
              controller: TextEditingController(),
              appContext: context,
              length: 4,
              autoFocus: true,
              animationType: AnimationType.fade,
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(12),
                fieldHeight: AppSizer.getVerticalSize(50),
                fieldWidth: AppSizer.getHorizontalSize(48),
                activeFillColor: AppColors.feildBGColor.withOpacity(0.1),
                selectedColor: AppColors.primaryText,
                activeColor: AppColors.primaryText,
                inactiveColor: AppColors.primaryText,
                selectedFillColor: AppColors.feildBGColor.withOpacity(0.1),
                borderWidth: 0.3,
                activeBorderWidth: 0.3,
                selectedBorderWidth: 0.3,
                inactiveBorderWidth: 0.3,
                disabledBorderWidth: 0.3,
                errorBorderWidth: 0.3,
                inactiveFillColor: AppColors.feildBGColor.withOpacity(0.1),
                disabledColor: AppColors.error,
              ),
              hintCharacter: '-',
              textStyle: TextStyle(
                fontFamily: AppFonts.lexendDica,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
              hintStyle: TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: AppColors.transparent,
              cursorColor: AppColors.iconColor,
              enableActiveFill: true,
              beforeTextPaste: (text) {
                return false;
              },
              onChanged: (value) {
                _otpVM.otpCode.value = value;
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
          ),
          SizedBox(height: AppSizer.getVerticalSize(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(text:"Expires in: ",fontSize:  AppSizer.getFontSize(14),),
              Obx(() => AppText(text:"0: ${_otpVM.sec2.toString().length == 1 ? '0${_otpVM.sec2}' : _otpVM.sec2} ",fontSize:  AppSizer.getFontSize(14),color: AppColors.primaryText,))
            ],
          ),
          SizedBox(height: AppSizer.getVerticalSize(60)),
          Obx(
                () => _otpVM.isLoading.value == false
                ? CustomButton(
                    label: AppStrings.continueTxt,
                    gradientColors: [
                      AppColors.primary,
                      AppColors.female
                    ],
                    fontFamily: AppFonts.copperPlate,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    onPressed: (){
                      if (verificationFor == "forgot") {
                        _otpVM.onVerifyForgot(userID);
                      } else if(verificationFor == "withdraw") {
                        _otpVM.onWithdraw();
                      }else {
                        _otpVM.onVerifyRegister(userID);
                      }
                    })
                : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Rotate(
                  repeat: true,
                  child: Image(
                    image: AssetImage(AppImages.imgLoader),
                    height: 48,
                    width: 48,

                  )
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: AppText(text:"Verifying Code",fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),)
                ),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.05),

          Align(
            alignment: Alignment.center,
            child: Obx(() => RichText(
              text: TextSpan(
                text: "Didn’t receive code? ",
                style: TextStyle(
                  fontFamily: AppFonts.copperPlate,
                  
                  overflow: TextOverflow.visible,
                  color: AppColors.whiteText,
                  fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: _otpVM.showTimer.value
                        ? " 0: ${_otpVM.sec.toString().length == 1 ? '0${_otpVM.sec}' : _otpVM.sec} "
                        : " Resend",
                    style: TextStyle(
                      fontFamily: AppFonts.copperPlate,
                      overflow: TextOverflow.visible,
                      
                      color: AppColors.primary,
                      fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {

                      print("trigger");
                      print(_otpVM.sec.value);
                      print(_otpVM.sec2.value);
                        if (_otpVM.sec.value == 15 || _otpVM.sec.value == 0) {
                          _otpVM.sec.value = 15;
                          _otpVM.sec2.value = 60;
                          _otpVM.countDown();
                          _otpVM.expiresCountDown();
                          _otpVM.onResendOtp();
                        }
                      },
                  )
                ],
              ),
            ),)
          ),

        ],
      ),
    );
  }
}
