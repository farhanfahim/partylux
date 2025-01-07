import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_fonts.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/AboutModule/View%20Model/support_viewmodel.dart';
import 'package:partylux/Utils/Common/custom_button.dart';
import 'package:partylux/Utils/Common/glassmorphic_container.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

import '../../../Constants/dimens.dart';
import '../../../Utils/Common/custom_textfield.dart';
import '../../../Utils/Common/sizer.dart';
import '../../../Utils/helper_functions.dart';

class SupportView extends StatelessWidget {
  SupportView({Key? key}) : super(key: key);

  final _supportVM = Get.find<SupportViewModel>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return CustomScaffold(
        isBodyPadding: true,
        showBackBtn: true,
        isLeftAlign: true,
        appBarTitle: "Support",
        body: Column(
          children: [
            AppText(
              text:
              AppStrings.hereYouCanAsk,
              fontSize:  AppSizer.getFontSize(16),
              fontWeight: FontWeight.w400,
              color: AppColors.whiteText.withOpacity(0.6),
            ),
            SizedBox(height: AppSizer.getVerticalSize(30),),
            Form(
              key: _supportVM.formKey,
              child: Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: [
                    CustomTextField(
                      controller: _supportVM.name.value,
                      label: "First Name",
                      maxLength: 100,
                      maxLines: 1,
                      textInputType: TextInputType.name,
                      onChanged: (v){
                        if(v.startsWith(' ')){
                          _supportVM.name.value.text = '';
                        }
                      },
                      validator: (value){
                        return HelperFunction.fieldValidator(value!,"Full Name");
                      },
                    ),
                    SizedBox(height: AppSizer.getVerticalSize(15)),
                    CustomTextField(
                      controller: _supportVM.email.value,
                      onChanged: (v){
                        if(v.startsWith(' ')){
                          _supportVM.email.value.text = '';
                        }
                      },
                      maxLength: 100,
                      maxLines: 1,
                      textInputType: TextInputType.emailAddress,
                      label: "Email",
                      validator: (value){
                        return HelperFunction.emailValidate(value!);
                      },
                    ),
                    SizedBox(height: AppSizer.getVerticalSize(15)),
                    CustomTextField(
                      controller: _supportVM.message.value,
                      textInputType: TextInputType.text,
                      maxLength: 250,
                      maxLines: 5,
                      onChanged: (v){
                        if(v.startsWith(' ')){
                          _supportVM.message.value.text = '';
                        }
                      },
                      label: "Your Message",
                      validator: (value){
                        return HelperFunction.fieldValidator(value!,"Message");
                      },
                    ),
                    SizedBox(height: AppSizer.getVerticalSize(30)),
                    CustomButton(
                        label: AppStrings.submit,
                        fontFamily: AppFonts.copperPlate2,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        gradientColors: [
                          AppColors.primaryText,
                          AppColors.female,
                        ],
                        onPressed: (){
                          _supportVM.getDataFAQs();
                        }),
                    // Obx(
                    //   () => AppButton.mainButton(
                    //     context,
                    //     text: "Submit",
                    //     loading: _supportVM.isLoading.value,
                    //     onPressed: () {
                    //       _supportVM.getDataFAQs();
                    //     },
                    //   ),
                    // ),
                    SizedBox(height: AppSizer.getVerticalSize(30)),
                    GlassContainer(
                      color: AppColors.primary,
                        borderRadius: 20,
                        padding: EdgeInsets.zero,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                                top:0,
                                left: 0,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
                                    child: Image.asset(AppImages.imgSupportCircle1))),
                            Positioned(
                                bottom:0,
                                right: 0,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
                                    child: Image.asset(AppImages.imgSupportCircle2))),
                            Padding(
                              padding: AppSizer.getPadding(top: 40,bottom: 20),
                              child: Column(
                                children: [
                                  AppText(text: AppStrings.contactInformation,fontSize: AppSizer.getFontSize(18),),
                                  SizedBox(height: AppSizer.getVerticalSize(5),),
                                  AppText(text: AppStrings.saySomethingForChat,fontSize: AppSizer.getFontSize(10),fontWeight: FontWeight.w500,fontFamily: AppFonts.copperPlate2,),
                                  SizedBox(height: AppSizer.getVerticalSize(30),),
                                  SvgPicture.asset(AppImages.icPhone),
                                  SizedBox(height: AppSizer.getVerticalSize(10),),
                                  AppText(text: "+1234 5674 91011",fontSize: AppSizer.getFontSize(12),),
                                  SizedBox(height: AppSizer.getVerticalSize(30),),
                                  SvgPicture.asset(AppImages.icSharpEmail),
                                  SizedBox(height: AppSizer.getVerticalSize(10),),
                                  AppText(text: "demo@gmail.com",fontSize: AppSizer.getFontSize(12),),
                                  SizedBox(height: AppSizer.getVerticalSize(30),),
                                  SvgPicture.asset(AppImages.icSharpLocation),
                                  SizedBox(height: AppSizer.getVerticalSize(10),),
                                  AppText(
                                    text: "132 Dartmouth Street Boston, Massachusetts 02156 United States",
                                    fontSize: AppSizer.getFontSize(12),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),),
                    // Container(
                    //   height: 200,
                    //   width: double.infinity,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //     gradient: LinearGradient(
                    //       begin: Alignment.topRight,
                    //       end: Alignment.bottomLeft,
                    //       stops: [0, 1],
                    //       colors: [
                    //         AppColors.secondary,
                    //         AppColors.primary,
                    //       ],
                    //     ),
                    //   ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       AppText(
                    //         text: "Contact Information",
                    //         fontSize: SizeConfig.screenWidth * 0.06,
                    //         fontWeight: FontWeight.w600,
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.only(top: 30.0),
                    //         child: Image.asset(
                    //           "assets/icon_assets/mailicon.png",
                    //           width: 35,
                    //           height: 35,
                    //           color: AppColors.whiteText,
                    //         ),
                    //       ),
                    //       SizedBox(height: 10),
                    //       AppText(
                    //         text: "support@partylux.app",
                    //         fontSize: SizeConfig.screenWidth * 0.038,
                    //         fontWeight: FontWeight.w400,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
