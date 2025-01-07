import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_fonts.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/WalletModule/View%20Model/wallets_viewmodel.dart';
import 'package:partylux/Utils/Common/custom_button.dart';
import 'package:partylux/Utils/Common/glassmorphic_container.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/Util.dart';

import '../../../Constants/app_routes.dart';
import '../../../Constants/color.dart';
import '../../../Utils/Common/custom_textfield.dart';
import '../../../Utils/buttons/dg_main_button.dart';

class WithdrawView extends StatelessWidget {
  WithdrawView({Key? key}) : super(key: key);
  final double _amount = Get.arguments;
  final _walletController = Get.find<WalletViewModel>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        isBodyPadding: true,
        showBackBtn: true,
        isLeftAlign: true,
        appBarTitle: AppStrings.withdraw,

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: AppStrings.hereYouCanWithdrawAmount,
              fontSize: AppSizer.getFontSize(16),
              fontWeight: FontWeight.w400,
              color: AppColors.iconColor,
              overflow: TextOverflow.visible,
            ),
            SizedBox(height: AppSizer.getVerticalSize(20)),
            CustomTextField(
              controller: _walletController.withDrawController,
              label: AppStrings.availableForWithdraw,
              subLabel: AppText(
                text: "${Util.formatNumberWithCommas(_amount)} \$",
                color: AppColors.male,
                fontWeight: FontWeight.w400,
                fontSize: AppSizer.getFontSize(18),
              ),
              textInputType: TextInputType.number,
            ),
            SizedBox(
              height: AppSizer.getVerticalSize(20),
            ),
            Obx(() => CustomTextField(
              controller: _walletController.walletController.value,
              label: AppStrings.selectWallet,
              textInputType: TextInputType.number,
              readOnly: true,
              prefix: Padding(
                padding: AppSizer.getPadding(left: 16,right: 10),
                child: Row(

                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(AppImages.icApple,fit: BoxFit.scaleDown,),
                    AppText(text: " Pay",fontFamily: AppFonts.lexendDica,fontWeight: FontWeight.w500,),
                  ],
                ),
              ),
              suffix: GestureDetector(
                onTap: (){
                  Util.showBottomSheet(
                    context,
                    screenTitle: AppStrings.selectMethod,
                    showDivider: false,
                    widget: Padding(
                      padding: AppSizer.getPadding(left: 16,right: 16,top: 10,bottom: 10),
                      child: Column(
                        children: [
                          GlassContainer(
                              onPressed:(){},
                              padding: AppSizer.getPadding(left: 16,right: 16,top: 20,bottom: 20),
                              child: Row(
                                children: [
                                  SvgPicture.asset(AppImages.icApple),
                                  SizedBox(width: AppSizer.getHorizontalSize(15),),
                                  AppText(text: AppStrings.applePay,fontSize: AppSizer.getFontSize(14),)
                                ],
                              )
                          ),
                          SizedBox(height: AppSizer.getVerticalSize(15),),
                          GlassContainer(
                              onPressed:(){},
                              padding: AppSizer.getPadding(left: 16,right: 16,top: 20,bottom: 20),
                              child: Row(
                                children: [
                                  SvgPicture.asset(AppImages.icGoogle),
                                  SizedBox(width: AppSizer.getHorizontalSize(15),),
                                  AppText(text: AppStrings.googlePay,fontSize: AppSizer.getFontSize(14),)
                                ],
                              )
                          ),
                          SizedBox(height: AppSizer.getVerticalSize(15),),
                          GlassContainer(
                              onPressed:(){},
                              padding: AppSizer.getPadding(left: 16,right: 16,top: 10,bottom: 10),
                              child: Row(
                                children: [
                                  SvgPicture.asset(AppImages.icVisa),
                                  SizedBox(width: AppSizer.getHorizontalSize(15),),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AppText(text: AppStrings.debitCard,fontSize: AppSizer.getFontSize(14),),
                                      SizedBox(height: AppSizer.getVerticalSize(5),),
                                      AppText(text: "****1234",fontSize: AppSizer.getFontSize(14),),
                                    ],
                                  )
                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: AppSizer.getPadding(top: 20,bottom: 20),
                  child: Image.asset(
                    AppImages.imgArrowRight,
                    height: AppSizer.getVerticalSize(20),
                  ),
                ),
              ),
            ),),
            SizedBox(
              height: AppSizer.getVerticalSize(40),
            ),
            CustomButton(
                label: AppStrings.withdraw,
                fontFamily: AppFonts.copperPlate2,
                fontSize: AppSizer.getFontSize(16),
                gradientColors: [
                  AppColors.primary,
                  AppColors.female
                ],
                onPressed: (){
              Get.toNamed(AppRoutes.OTP,arguments: [
                "withdraw",
                _walletController.currentUserEmail.value,
              ],);
            }),
          ],
        ));
  }
}
