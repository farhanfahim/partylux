import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Modules/BecomePartner/View%20Model/becompartner_vm.dart';
import 'package:partylux/Modules/Create%20Module/View/Components/essential_section_dynamic.dart';
import 'package:partylux/Utils/AppBar/primary_app_bar.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

class AddBusinessAttendence extends StatelessWidget {
  AddBusinessAttendence({super.key});

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
                title: "Business Attendance",
                subTitle:
                    "Lorem ipsum dolor sit amet consectetur.\nRisus varius elementum consequat in quam.",
                callback: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.03),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: [
                    Obx(
                      () => PartyAgeLimitSections(
                        title: "Maximum Attendance",
                        selectName: _becomePartnerVM.maximumAttendance.value,
                        checkboxList: [
                          "0-25 People",
                          "25-50 People",
                          "50-100 People",
                          "Unlimited"
                        ],
                        callbak: (val) {
                          print(val);
                          _becomePartnerVM.maximumAttendance.value = val;
                        },
                      ),
                    ),
                  ],
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
              _becomePartnerVM.addBusinessAttendanceMethod(context);
            },
          ),
        ));
  }
}
