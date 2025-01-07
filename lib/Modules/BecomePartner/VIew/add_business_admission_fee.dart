import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/BecomePartner/View%20Model/becompartner_vm.dart';
import 'package:partylux/Modules/Create%20Module/View/create7_admissionfee_view.dart';
import 'package:partylux/Utils/AppBar/primary_app_bar.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

class AddBusinessAdmissionFee extends StatelessWidget {
  AddBusinessAdmissionFee({super.key});

  final _becomePartnerVM = Get.isRegistered<BecomePartnerViewModel>()
      ? Get.find<BecomePartnerViewModel>()
      : Get.put(BecomePartnerViewModel());

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        isBodyPadding: true,
        body: SizedBox.expand(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight * 0.06),
              primaryAppBar(
                context: context,
                title: "Admission Fee",
                subTitle:
                    "Here you can set the Admission fee for your\nparty for both Male and fee male",
                callback: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: Form(
                  // key: _becomePartnerVM.formKey,
                  child: ListView(
                    padding: EdgeInsets.only(bottom: 20),
                    shrinkWrap: true,
                    children: [
                      SizedBox(height: 30),
                      AdmissionFeeTile(
                        lable: "Male",
                        lableColor: AppColors.male,
                        controller: _becomePartnerVM.maleAmount.value,
                        callback: (value) {
                          print(value);
                          _becomePartnerVM.isMaleFree.value = value;
                        },
                      ),
                      AdmissionFeeTile(
                        lable: "Female",
                        lableColor: AppColors.female,
                        controller: _becomePartnerVM.femaleAmount.value,
                        callback: (value) {
                          print(value);
                          _becomePartnerVM.isFemaleFree.value = value;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomBar: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth * 0.05,
            vertical: 10,
          ),
          child: AppButton.mainButton(
            context,
            text: "Next",
            onPressed: () {
              _becomePartnerVM.addBusinessAdmissionFeeMethod();
            },
          ),
        ));
  }
}
