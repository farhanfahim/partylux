import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/Create%20Module/View%20Model/create_viewmodel.dart';
import 'package:partylux/Modules/Create%20Module/View/Components/essential_section_dynamic.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

class SelectPartyAttendance extends StatelessWidget {
  SelectPartyAttendance({super.key});

  final _createEventVM = Get.find<CreateViewModel>();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showBackBtn:true,
      appBarTitle: "Attendance",
      body: SizedBox.expand(
        child: Column(
          children: [

            Align(
              alignment: Alignment.centerLeft,
              child: AppText(
                text: "Maximum Attendance",
                fontSize: SizeConfig.screenWidth * 0.038,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.005),
            Align(
              alignment: Alignment.centerLeft,
              child: AppText(
                text:
                    "Lorem ipsum dolor sit amet consectetur. Risus varius elementum consequat in quam.",
                fontSize: SizeConfig.screenWidth * 0.03,
                fontWeight: FontWeight.w400,
                color: AppColors.iconColor,
                height: 1.6,
                overflow: TextOverflow.visible,
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.03),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                children: [
                  Obx(
                    () => PartyAgeLimitSections(
                      title: "Party Attendance",
                      selectName: _createEventVM.maximumAttendance.value,
                      checkboxList: [
                        "0-25 People",
                        "25-50 People",
                        "50-100 People",
                        "Unlimited"
                      ],
                      callbak: (val) {
                        print(val);
                        _createEventVM.maximumAttendance.value = val;
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.005),
            AppButton.mainButton(
              context,
              text: "Next",
              onPressed: () {
                _createEventVM.selectPartyMaximumAttendance(context);
              },
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
