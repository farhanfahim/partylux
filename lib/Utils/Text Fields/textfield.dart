import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:partylux/Constants/app_fonts.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

class AppTextField extends TextFormField {
  AppTextField({super.key});

  commonField(
    BuildContext context, {
    required String hintText,
    bool isCustomHintText = false,
    bool isAuth = false,
    required TextEditingController controller,
    int maxLines = 1,
    int limit = 250,
    double? lableFontSize,
    FontWeight? lableFontWeight,
    bool readOnly = false,
    bool isShowLable = true,
    bool isRemoveTopHight = true,
    String icon = "",
    double? fieldHeight,
    double? topHight,
    TextInputType keyboardType = TextInputType.text,
    Function? callback,
    bool isValidation = true,
    bool isIntegerValue = false,
    TextCapitalization? textCapitalization,
  }) {
    final double fontsize = SizeConfig.screenWidth * 0.032;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: isShowLable,
            child: Column(
              children: [
                Visibility(
                  visible: isRemoveTopHight,
                  child: SizedBox(
                      height: topHight ?? SizeConfig.screenWidth * 0.04),
                ),
                AppText(
                  text: hintText,
                  color: AppColors.whiteText,
                  fontSize: lableFontSize ?? SizeConfig.screenWidth * 0.034,
                  fontWeight: lableFontWeight ?? FontWeight.w700,
                ),
                SizedBox(height: SizeConfig.screenWidth * 0.015),
              ],
            ),
          ),
          TextFormField(
            textCapitalization: textCapitalization ?? TextCapitalization.words,
            keyboardType: keyboardType,
            controller: controller,
            readOnly: readOnly,
            maxLines: maxLines,
            inputFormatters: [
              LengthLimitingTextInputFormatter(limit),
              if (isIntegerValue) FilteringTextInputFormatter.digitsOnly
            ],
            onTap: () {
              if (callback != null) {
                callback();
              }
            },
            onChanged: (v){
              if(v.startsWith(' ')){
                controller.text = '';
              }
            },
            validator: isValidation
                ? (value) {
                    if (value!.isEmpty) {
                      return isAuth?"Please enter your ${hintText}":"Please enter ${hintText}";
                    }
                    return null;
                  }
                : (value) {
                    return null;
                  },
            decoration: InputDecoration(
              hintText: isCustomHintText
                  ? "$hintText".toUpperCase()
                  : "Enter your $hintText",
              hintStyle: TextStyle(
                fontFamily: AppFonts.copperPlate,
                color: AppColors.iconColor,
                fontSize: fontsize,
                
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              errorStyle: TextStyle(
                fontFamily: AppFonts.copperPlate,
                color: AppColors.error,
                fontSize: SizeConfig.screenWidth * 0.022,
                
              ),
              fillColor: AppColors.feildBGColor.withOpacity(0.10),
              filled: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * 0.035,
                vertical: fieldHeight ?? SizeConfig.screenWidth * 0.04,
              ),
              prefixIcon: icon.isNotEmpty
                  ? Container(
                      width: 10,
                      height: 10,
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                      decoration: BoxDecoration(
                        color: AppColors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.asset(
                        icon,
                        color: AppColors.whiteText,
                      ),
                    )
                  : null,
            ),
            cursorColor: AppColors.whiteText,
            style: TextStyle(
              fontFamily:AppFonts.copperPlate,
              color: AppColors.whiteText, //whiteText,
              fontSize: fontsize,
              
            ),
          ),
        ],
      ),
    );
  }

  static passwordField(
    BuildContext context, {
    required String hintText,
    bool isCustomHintText = false,
    bool isShowLabel = false,
    required TextEditingController controller,
    bool readOnly = false,
    bool obscureText = false,
    required Function obscureCallback,
    bool isSimpleValidator = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: SizeConfig.screenWidth * 0.02),
        Visibility(
          visible: isShowLabel,
          child: AppText(
            text: hintText,
            fontSize: SizeConfig.screenWidth * 0.036,
            
          ),
        ),
        SizedBox(height: SizeConfig.screenWidth * 0.015),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: controller,
          readOnly: readOnly,
          obscureText: !obscureText,
          validator: (value) {
            if (isSimpleValidator) {
              if (value!.isEmpty) {
                return "Please enter your ${hintText}";
              }
            } else {
              if (value == null || value.isEmpty) {
                return "Please enter your ${hintText}";
              } else {
                String pattern = r'^.{8,}$';
                // r"^(?=.*?[A-Z])(?=(.*[a-z]){1,})(?=(.*[\d]){1,})(?=(.*[\W]){1,})(?!.*\s).{8,}$";
                RegExp regex = RegExp(pattern);
                if (!regex.hasMatch(value)) {
                  return 'Minimum of 8 Characters is Required';
                }
              }
            }
            return null;
          },
          onChanged: (v){
            if(v.startsWith(' ')){
              controller.text = '';
            }
          },
          decoration: InputDecoration(
            hintText: isCustomHintText
                ? hintText.toUpperCase()
                : "Enter Your $hintText",

            hintStyle: TextStyle(
              fontFamily: AppFonts.copperPlate,
              color: AppColors.iconColor,
              fontSize: SizeConfig.screenWidth * 0.032,
              
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            errorStyle: TextStyle(
              fontFamily: AppFonts.copperPlate,
              color: AppColors.error,
              fontSize: SizeConfig.screenWidth * 0.022,
              
            ),
            fillColor: AppColors.feildBGColor.withOpacity(0.10),
            filled: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenWidth * 0.035,
              vertical: SizeConfig.screenWidth * 0.04,
            ),
            prefixIcon: Container(
              width: 10,
              height: 10,
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              decoration: BoxDecoration(
                color: AppColors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                "assets/icon_assets/Feild_Icons/key.png",
                color: AppColors.iconColor,
              ),
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                obscureCallback();
              },
              child: Container(
                  width: 10,
                  height: 10,
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                  decoration: BoxDecoration(
                    color: AppColors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset(
                    obscureText
                        ? AppImages.icEyeClosed
                        : AppImages.icEyeOpen
                  )),
            ),
          ),
          cursorColor: AppColors.whiteText,
          style: TextStyle(
            fontFamily: AppFonts.copperPlate,
            color: AppColors.whiteText, //whiteText,
            fontSize: SizeConfig.screenWidth * 0.032,
            
          ),
        ),
      ],
    );
  }

  static emailField(
    BuildContext context, {
    required String hintText,
    bool isCustomHintText = false,
    bool isShowLabel = false,
    required TextEditingController controller,
    bool readOnly = false,
    double? topHight,

    // required Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: topHight ?? SizeConfig.screenWidth * 0.02),
        Visibility(
          visible: isShowLabel,
          child: AppText(
            text: hintText,
            fontSize: SizeConfig.screenWidth * 0.036,
            
          ),
        ),
        SizedBox(height: SizeConfig.screenWidth * 0.015),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: controller,
          readOnly: readOnly,
          validator: (value) {
            // validator(value);
            print(value);
            if (value == null || value.isEmpty) {
              return "Please enter your email address";
            } else {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regex = RegExp(pattern);
              if (!regex.hasMatch(value)) {
                return 'Enter a valid email address';
              }
            }
            return null;
          },
          onChanged: (v){
            if(v.startsWith(' ')){
              controller.text = '';
            }
          },
          decoration: InputDecoration(
            hintText: isCustomHintText
                ? hintText.toUpperCase()
                : "Enter Your Email Address",
            hintStyle: TextStyle(
              fontFamily: AppFonts.copperPlate,
              color: AppColors.iconColor,
              fontSize: SizeConfig.screenWidth * 0.032,
              
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            errorStyle: TextStyle(
              fontFamily: AppFonts.copperPlate,
              color: AppColors.error,
              fontSize: SizeConfig.screenWidth * 0.022,
              
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            fillColor: AppColors.feildBGColor.withOpacity(0.10),
            filled: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenWidth * 0.035,
              vertical: SizeConfig.screenWidth * 0.04,
            ),
            prefixIcon: Container(
              width: 10,
              height: 10,
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
              decoration: BoxDecoration(
                color: AppColors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                "assets/icon_assets/Feild_Icons/email.png",
                color: AppColors.iconColor,
              ),
            ),
          ),
          cursorColor: AppColors.whiteText,
          style: TextStyle(
            fontFamily: AppFonts.copperPlate,
            color: AppColors.whiteText, //whiteText,
            fontSize: SizeConfig.screenWidth * 0.032,
            
          ),
        ),
      ],
    );
  }

  static search(
    BuildContext context, {
    required String hintText,
    TextEditingController? controller,
    Function? onChanged,
    Function? onSubmit,
    bool readOnly = false,
  }) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      readOnly: readOnly,
      onChanged: (val) {
        if (onChanged != null) {
          onChanged(val);
        }
      },
      onFieldSubmitted: (value) {
        if (onSubmit != null) {
          onSubmit(value);
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "Please Enter $hintText";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          fontFamily: AppFonts.copperPlate,
          color:  AppColors.iconColor,
          fontSize: SizeConfig.screenWidth * 0.032,
          
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        errorStyle: TextStyle(
          fontFamily: AppFonts.copperPlate,
          color: AppColors.error,
          fontSize: SizeConfig.screenWidth * 0.022,
          
        ),
        fillColor: AppColors.feildBGColor.withOpacity(0.10),
        filled: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth * 0.035,
          vertical: SizeConfig.screenWidth * 0.03,
        ),
        prefixIcon: Container(
          width: 10,
          height: 10,
          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
          decoration: BoxDecoration(
            color: AppColors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Image.asset(
            AppImages.imgSearch,
            color: AppColors.whiteText,
          ),
        ),
      ),
      cursorColor: AppColors.whiteText,
      style: TextStyle(
        fontFamily: AppFonts.copperPlate,
        color: AppColors.whiteText, //whiteText,
        fontSize: SizeConfig.screenWidth * 0.032,
        
      ),
    );
  }

  static phoneField(
    BuildContext context, {
    required String hintText,
    required TextEditingController controller,
    bool readOnly = false,
    String countryCode = "+1",
    required Function prefixCallBack,
  }) {
    final double fontsize = SizeConfig.screenWidth * 0.032;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: SizeConfig.screenWidth * 0.04),
        AppText(
          text: hintText,
          fontSize: SizeConfig.screenWidth * 0.036,
          
        ),
        SizedBox(height: SizeConfig.screenWidth * 0.015),
        TextFormField(
          keyboardType: TextInputType.phone,
          controller: controller,
          readOnly: readOnly,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter phone number";
            }
            return null;
          },
          inputFormatters: [
            LengthLimitingTextInputFormatter(10),
          ],
          onChanged: (v){
            if(v.startsWith(' ')){
              controller.text = '';
            }
          },
          decoration: InputDecoration(
            hintText: "Enter Phone Number",
            hintStyle: TextStyle(
              fontFamily: AppFonts.copperPlate,
              color: AppColors.iconColor,
              fontSize: fontsize,
              
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            errorStyle: TextStyle(
              fontFamily: AppFonts.copperPlate,
              color: AppColors.error,
              fontSize: SizeConfig.screenWidth * 0.022,
              
            ),
            fillColor: AppColors.feildBGColor.withOpacity(0.2),
            filled: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenWidth * 0.035,
              vertical: SizeConfig.screenWidth * 0.04,
            ),
            prefixIcon: GestureDetector(
              onTap: () {
                prefixCallBack();
              },
              child: Container(
                width: 100,
                height: 10,
                padding: const EdgeInsets.fromLTRB(12, 12, 20, 12),
                decoration: BoxDecoration(
                  color: AppColors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Spacer(flex: 2),
                    AppText(
                      text: countryCode,
                      fontSize: SizeConfig.screenWidth * 0.032,
                      fontWeight: FontWeight.w400,
                    ),
                    Spacer(flex: 4),
                    Container(
                      width: 2.5,
                      height: 30,
                      color: AppColors.whiteText,
                    )
                  ],
                ),
              ),
            ),
          ),
          cursorColor: AppColors.whiteText,
            style: TextStyle(
              fontFamily: AppFonts.copperPlate,
              color: AppColors.whiteText,
              fontSize: fontsize,
              
            )),
      ],
    );
  }
}
