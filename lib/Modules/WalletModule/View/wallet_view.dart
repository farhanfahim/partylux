import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_fonts.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/WalletModule/View%20Model/wallets_viewmodel.dart';
import 'package:partylux/Modules/WalletModule/View/Components/wallet_tile.dart';
import 'package:partylux/Utils/AppBar/primary_app_bar.dart';
import 'package:partylux/Utils/Common/custom_button.dart';
import 'package:partylux/Utils/Common/gradient_text.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

import '../../../Constants/app_images.dart';
import '../../../Constants/color.dart';
import '../../../Constants/dimens.dart';
import '../../../Utils/Common/glassmorphic_container.dart';
import '../../../Utils/Util.dart';
import '../Model/wallet_enum.dart';

class WalletView extends StatelessWidget {
  WalletView({Key? key}) : super(key: key);

  final walletController = Get.find<WalletViewModel>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Obx(() => CustomScaffold(
        isBodyPadding: true,
        showBackBtn: true,
        isLeftAlign: true,
        appBarTitle: "Wallet",
        body: Column(
          children: [

            SizedBox(height: SizeConfig.screenHeight * 0.01),

            Align(
              alignment: Alignment.centerLeft,
              child: AppText(
                text:"Your Party LUX wallet. Your all investment shows here",
                overflow: TextOverflow.visible,
                fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                height: 1,
                fontWeight: FontWeight.w400,
                color:AppColors.iconColor,

              ),
            ),

            SizedBox(height: SizeConfig.screenHeight * 0.05),
            AppText(
              text: AppStrings.totalBalance,
              fontSize: AppSizer.getFontSize(14),
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: AppSizer.getVerticalSize(30),
            ),
            GradientText(
                "USD",
                fontSize: 28,
                gradient: LinearGradient(
              colors: [
                AppColors.female,
                AppColors.primary
              ]
            )),
            SizedBox(
              height: AppSizer.getVerticalSize(15),
            ),
            AppText(
              text:
                  "${walletController.myWalletData.value.balance.toDouble()} \$",
              fontSize: AppSizer.getFontSize(28),
              fontWeight: FontWeight.w700,
              fontFamily: AppFonts.copperPlate2,
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
              label: AppStrings.withdraw,
              width: MediaQuery.sizeOf(context).width * 0.5,
              fontFamily: AppFonts.copperPlate2,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              gradientColors: [
                AppColors.female,
                AppColors.primary,
              ],
              onPressed: () {
                Util.showBottomSheet(
                  context,
                  screenTitle: AppStrings.selectMethod,
                  showDivider: false,
                  widget: Padding(
                    padding: AppSizer.getPadding(left: 16,right: 16,top: 10,bottom: 10),
                    child: Column(
                      children: [
                        GlassContainer(
                            onPressed:(){
                              Get.back();
                              Get.toNamed(AppRoutes.OTP,arguments: [
                                "withdraw",
                                walletController.currentUserEmail.value,
                              ],);
                            },
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
                            onPressed:(){
                              Get.back();
                              Get.toNamed(AppRoutes.OTP,arguments: [
                                "withdraw",
                                walletController.currentUserEmail.value,
                              ],);
                            },
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
                            onPressed:(){
                              Get.back();
                              Get.toNamed(AppRoutes.OTP,arguments: [
                                "withdraw",
                                walletController.currentUserEmail.value,
                              ],);
                            },
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
                //Get.toNamed(AppRoutes.withdrawView,arguments: walletController.myWalletData.value.balance.toDouble());
              },

            ),
            SizedBox(
              height: AppSizer.getVerticalSize(50),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: AppText(
                text: "Transaction details",
                color: AppColors.whiteText,
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
              child: walletController.isLoading.value
                  ? Center(
                      child: CupertinoActivityIndicator(
                        radius: 20.0,
                        animating: true,
                        color: AppColors.whiteText,
                      ),
                    )
                  : walletController.myWalletData.value.transacrion.isNotEmpty
                      ? ListView.builder(
                          padding:
                              EdgeInsets.only(top: 10),
                          itemCount: walletController
                              .myWalletData.value.transacrion.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: walletController.myWalletData.value
                                          .transacrion[index].transType ==
                                      "debit"
                                  ? walletTile(
                                      context: context,
                                      walletEnum: WalletEnum.debit,
                                      title: walletController.myWalletData
                                          .value.transacrion[index].action,
                                      amount: walletController.myWalletData
                                          .value.transacrion[index].amount
                                          .toDouble(),
                                    )
                                  : walletTile(
                                      context: context,
                                      walletEnum: WalletEnum.credit,
                                      title: walletController.myWalletData
                                          .value.transacrion[index].action,
                                      amount: walletController.myWalletData
                                          .value.transacrion[index].amount
                                          .toDouble(),
                                    ),
                            );
                          })
                      : Center(
                          child: AppText(text: "No any transaction"),
                        ),
            )
          ],
        )));
  }
}
