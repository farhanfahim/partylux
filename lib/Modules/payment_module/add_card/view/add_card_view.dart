import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/payment_module/add_card/view_model/add_card_view_model.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

class AddCardView extends GetView<AddCardViewModel> {
  const AddCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        isBodyPadding: true,
        isVertPadding: true,
        isLeftAlign: false,
        appBarTitle: AppStrings.addCard,
        showBackBtn: true,
        appbarColor: AppColors.midGrey,
        body: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CardField(
              controller: controller.cardEditController,
              onCardChanged: (val){
                controller.isComplete.value=val!.complete;
              },
              decoration: InputDecoration(
                hintStyle: TextStyle(color: AppColors.grey4),
                fillColor: AppColors.whiteText,
                filled: true
              ),
              style: TextStyle(color: AppColors.black),
            ),
            const Spacer(),
       /*     CardFormField(
              controller: controller.cardController,
              onCardChanged: (val){
                controller.isComplete.value=val!.complete;
              },
              countryCode: 'US',
              enablePostalCode: false,
              style: CardFormStyle(
                  textColor: AppColors.black,
                //  cursorColor: AppColors.black,
                  placeholderColor: AppColors.grey4,
                  backgroundColor: AppColors.whiteText,
                 // placeholderColor: AppColors.whiteText,
           *//*     borderColor: Colors.blueGrey,
                textColor: Colors.black,
                placeholderColor: Colors.blue,*//*
              ),
            ),*/

            Obx(
                  () => AppButton.mainButton(
                context,
                text: AppStrings.addCard,
                loading: controller.isLoading.value,
                isDisable: !controller.isComplete.value,
                buttonColor: AppColors.primary,
                onPressed: () {
                  controller.addCard();
                },
              ),
            ),
          ],
        ));
  }
}
