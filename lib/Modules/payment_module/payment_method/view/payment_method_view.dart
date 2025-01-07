import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_fonts.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/Home%20Module/View/Components/shimmer_view.dart';
import 'package:partylux/Modules/payment_module/add_card/model/card_model.dart';
import 'package:partylux/Modules/payment_module/payment_method/components/payment_container.dart';
import 'package:partylux/Modules/payment_module/payment_method/components/shimmer_view.dart';
import 'package:partylux/Modules/payment_module/payment_method/view_model/payment_method_viewmodel.dart';
import 'package:partylux/Utils/Common/glassmorphic_container.dart';
import 'package:partylux/Utils/Common/gradient_text.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/Util.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';
import 'package:partylux/Utils/navigation.dart';
import 'package:partylux/Utils/pagenation/paged_listview.dart';
import 'package:partylux/Utils/pagenation/paged_view.dart';
import 'package:partylux/service/payment/stripe_service.dart';

import '../../../../Utils/Theme/app_config.dart';

class PaymentMethodView extends GetView<PaymentMethodViewModel> {
  PaymentMethodView({super.key});

  @override
  Widget build(BuildContext context) {
    final double spacing = AppSizer.getVerticalSize(25);

    return CustomScaffold(
        showBackBtn: true,
        appBarTitle: AppStrings.paymentMethod,
        isLeftAlign: true,
        body: Column(
          children: [
           Obx(() =>  Expanded(
             child: controller.isDataLoading.value?RefreshIndicator(
               color: AppColors.primary,
               onRefresh: () async {
                 controller.pageKey.currentState?.reloadPage();
               },
               child: SingleChildScrollView(
                 physics: const AlwaysScrollableScrollPhysics(),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [


                    Visibility(
                      visible: !controller.isPayment,
                      child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text:  AppStrings.stripeConnect,
                          fontSize: AppSizer.getFontSize(14),
                          fontWeight: FontWeight.w500,
                          fontFamily: AppFonts.copperPlate2,
                        ),
                        SizedBox(height: 15,),
                       Obx(() =>  GlassContainer(
                         gradientColors: controller.userData.value.connectedAccountId!=null?[AppColors.red1,AppColors.red1]:null,
                         onPressed: () {
                           if(controller.userData.value.connectedAccountId==null){
                             controller.advance();
                           }else{
                             controller.disconnectAccount(controller.userData.value.connectedAccountId!);
                           }

                         },
                         padding: AppSizer.getPadding(top: 16, bottom: 16),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Visibility(
                                 visible:controller.userData.value.connectedAccountId!=null?false:true,
                                 child: GradientText("+", fontSize: 14, gradient: LinearGradient(colors: [AppColors.female, AppColors.primary]))),
                             SizedBox(
                               width: AppSizer.getHorizontalSize(10),
                             ),
                             AppText(
                               text: controller.userData.value.connectedAccountId!=null?
                               AppStrings.removeMerchantAccount:AppStrings.addMerchantAccount,
                               fontSize: AppSizer.getFontSize(14),
                               fontWeight: FontWeight.w500,
                               fontFamily: AppFonts.copperPlate2,
                             )
                           ],
                         ),
                       ),),
                        SizedBox(
                          height: 15,
                        ),
                        Divider(),
                        SizedBox(
                          height: !controller.isPayment?15:spacing,
                        ),
                      ],
                    ),),
                     GlassContainer(
                       onPressed: () {
                         AppNavigator.navigateToNamed(AppRoutes.addCardView)?.then((value) {
                           if (value == true) {
                             controller.pageKey.currentState?.reloadPage();
                           }
                         });
                       },
                       padding: AppSizer.getPadding(top: 16, bottom: 16),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           GradientText("+", fontSize: 14, gradient: LinearGradient(colors: [AppColors.female, AppColors.primary])),
                           SizedBox(
                             width: AppSizer.getHorizontalSize(10),
                           ),
                           AppText(
                             text: AppStrings.addCard,
                             fontSize: AppSizer.getFontSize(14),
                             fontWeight: FontWeight.w500,
                             fontFamily: AppFonts.copperPlate2,
                           )
                         ],
                       ),
                     ),
                     SizedBox(
                       height: spacing,
                     ),
                     Visibility(
                         visible: controller.isPayment,
                         child: Column(
                           children: [
                             Visibility(
                               visible: Platform.isIOS,
                               child: Padding(
                                 padding: EdgeInsets.only(bottom: spacing),
                                 child: PaymentContainer(
                                   text: AppStrings.applePay,
                                   icon: AppImages.icApple,
                                   onTap: () {
                                     StripeService.openApplePay(controller.orderModel!.value.event?.name??"test name",
                                         controller.orderModel!.value.price!.toDouble()).then((value) {
                                       controller.orderCheckOut(value);
                                     });
                                   },
                                 ),
                               ),
                             ),
                             Visibility(
                               visible: Platform.isAndroid,
                               child: Padding(
                                 padding: EdgeInsets.only(bottom: spacing),
                                 child: PaymentContainer(
                                   text: AppStrings.googlePay,
                                   icon: AppImages.icGoogle,
                                   onTap: () {
                                     StripeService.openGooglePay(controller.orderModel!.value.event?.name??"test name",
                                         controller.orderModel!.value.price!.toDouble()).then((value) {
                                       controller.orderCheckOut(value);
                                     });
                                   },
                                 ),
                               ),
                             ),
                           ],
                         )),
                     Obx(() {
                       controller.selCard.value;
                       return PaginatedListView<CardModel>(
                         key: controller.pageKey,
                         //   padding: EdgeInsets.symmetric(vertical: spacing),
                         initialItems: controller.cards,
                         shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                         onFetchPage: (page) {
                           return controller.getCards(
                             page: page,
                           );
                         },
                         onDispose: (list) {
                           controller.cards = list;
                         },
                         notFoundWidget: Container(),
                         separatorBuilder: (con, ind) {
                           return SizedBox(
                             height: spacing,
                           );
                         },
                         itemBuilder: (ind, item) {
                           return PaymentCardContainer(
                             text: "Debit Card",
                             selected: controller.selCard.value.sId == item.sId,
                             card: item,
                             onTap: () {
                               if (controller.isPayment) {
                                 controller.selCard.value = item;
                               }
                             },
                             onAction: () {
                               controller.deleteCard(item);
                             },
                           );
                         },
                         initialLoader: viewAllCardsShimmer(),
                       );
                     }),
                   ],
                 ),
               ),
             ):
             Center(child: CupertinoActivityIndicator(
               color: AppColors.whiteText,
               radius: SizeConfig.screenWidth * 0.05,
             )),
           ),),
            Visibility(
              visible: controller.isPayment,
              child: Obx(() {
                return AppButton.mainButton(
                  context,
                  text: AppStrings.proceedPayment,
                  loading: controller.isLoading.value,
                  buttonColor: AppColors.primary,
                  isDisable: controller.selCard.value.sId == null,
                  onPressed: () {
                    controller.orderCheckOut(controller.selCard.value.pmId);
                  },
                );
              }),
            ),
            SizedBox(height: 20,)
          ],
        ));
  }
}
