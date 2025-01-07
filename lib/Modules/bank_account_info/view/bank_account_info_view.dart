import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import '../../../Utils/Common/custom_textfield.dart';
import '../../../Utils/buttons/dg_main_button.dart';
import '../../../Utils/helper_functions.dart';
import '../view_model/bank_account_info_vm.dart';

class BankAccountInfoView extends StatelessWidget {
  BankAccountInfoView({super.key});
  final _bankInfoVM = Get.find<BankAccountInfoViewModel>();


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        isBodyPadding: true,
        isLeftAlign: false,
        showBackBtn: true,
        appBarTitle:AppStrings.bankAccountInfo,
        isTopPadding: 30,
        body: Form(
          key: _bankInfoVM.formKey,
          child: Column(
            children: [
              SizedBox(height: 12),
              CustomTextField(
                controller: _bankInfoVM.accountNumberController.value,
                label: AppStrings.bankAccountNumber,
                maxLength: 16,
                validator: (value){
                  return HelperFunction.fieldValidator(value!,AppStrings.bankAccountNumber);
                },
                textInputType:TextInputType.numberWithOptions(decimal: false),
                hintText: AppStrings.enterBankAcc,
              ),
              SizedBox(height: 20),
              CustomTextField(
                controller: _bankInfoVM.routeNumberController.value,
                textInputType: TextInputType.numberWithOptions(decimal: false),
                maxLength: 20,
                validator: (value){
                  return HelperFunction.fieldValidator(value!,AppStrings.routingNumber);
                },
                label: AppStrings.routingNumber,
                hintText: AppStrings.enterBankRoute,
              ),
              Spacer(),
              AppButton.mainButton(
                context,
                text: AppStrings.save,
                loading: false,
                onPressed: () {
                  if (_bankInfoVM.formKey.currentState!.validate()) {
                    Get.back();
                  }
                },
              ),

              SizedBox(height: 40,)
            ],
          ),
        ));
  }
}

