import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/create_party/payment/view_model/payment_view_model.dart';
import 'package:partylux/Utils/Common/common.dart';
import 'package:partylux/Utils/Common/create_party_items.dart';
import 'package:partylux/Utils/Common/custom_switch_tile.dart';
import 'package:partylux/Utils/Common/icons.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';

class PaymentView extends GetView<PaymentViewModel> {
  const PaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var event=controller.viewModel.event;
    final double spacing=AppSizer.getVerticalSize(18);
    return CustomScaffold(
        isBodyPadding: true,
        isVertPadding: true,
        isLeftAlign: true,
        appBarTitle: AppStrings.txtPayment,
        showBackBtn: true,
        appbarColor: AppColors.midGrey,
        showLeading: true,
        showDivider: true,
        onBackPressed: (){
          Get.back(result:  event.allowPayments);
        },
        leadingWidth: AppSizer.getHorizontalSize(AppDimen.appBarLeadingWidth),
        leadingWidget: Container(
          //color: Colors.red,
          child: CustomMonoIcon(
            icon: AppImages.icCard,
            size: AppSizer.getVerticalSize(AppDimen.appBarIconSize2),
            color: AppColors.whiteText,
            isSvg: true,
          ),
        ),
        body: SingleChildScrollView(child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          customSwitchTile(title: AppStrings.txtAllowPayments, content: AppStrings.txtAllowPaymentsForGuests,
              isActive: event.allowPayments!,
            fontColor: AppColors.red1,
            callBack: (val){
              event.allowPayments=val;
            },),
          SizedBox(
            height: AppSizer.getVerticalSize(13),
          ),
          NoteText(
            text: AppStrings.txtNotUsedTicketPayments,showIcon: true,
          ),
          SizedBox(height: AppSizer.getVerticalSize(26),),
          PaymentItem(image: AppImages.imgCashapp, text: "\$ ${AppStrings.txtCashTag}",
            controller: controller.cashApp,onChanged: (val){
              event.cashApp=val;
            },),
          SizedBox(height: spacing,),
          PaymentItem(image: AppImages.imgVenmo, text: "@ ${AppStrings.txtUserName}",
            controller: controller.venmo,onChanged: (val){
              event.venmo=val;
            },),
          SizedBox(height: spacing,),
          PaymentItem(image: AppImages.imgBenefitPay, text: AppStrings.txtBenefitPayNumber,
            controller: controller.benifitPay,onChanged: (val){
              event.benifitPay=val;
            },),

        ])));
  }
}
