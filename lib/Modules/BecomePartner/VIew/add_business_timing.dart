import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Modules/BecomePartner/View%20Model/becompartner_vm.dart';
import 'package:partylux/Utils/AppBar/primary_app_bar.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

import 'Components/timing_tile.dart';

class AddBusinessTiming extends StatelessWidget {
  AddBusinessTiming({super.key});

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
                title: "Add Business Timing",
                subTitle:
                    "Here you can filter the events and\nget your desired event.",
                callback: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(
                child: Form(
                  // key: _becomePartnerVM.formKey,
                  child: Obx(
                    () => ListView(
                      padding: EdgeInsets.only(bottom: 20),
                      shrinkWrap: true,
                      children: [
                        SizedBox(height: 20),
                        AppText(
                          text: "Business Hours",
                          fontSize: SizeConfig.screenWidth * 0.04,
                          fontWeight: FontWeight.w600,
                        ),
                        TimingTile(
                          titile: Weekdays.Saturday,
                          isClose: _becomePartnerVM.isClose1.value,
                          initialStart: _becomePartnerVM.startTime1.value,
                          initialEnd: _becomePartnerVM.endTime1.value,
                          isOpenCallback: (bool val) {
                            _becomePartnerVM.isClose1.value = val;
                          },
                          startCallback: (DateTime val) {
                            _becomePartnerVM.startTime1.value = val.toString();
                            print("Start time $val");
                          },
                          endCallback: (DateTime val) {
                            _becomePartnerVM.endTime1.value = val.toString();
                            print("End time $val");
                          },
                        ),
                        TimingTile(
                          titile: Weekdays.Sunday,
                          isClose: _becomePartnerVM.isClose2.value,
                          initialStart: _becomePartnerVM.startTime2.value,
                          initialEnd: _becomePartnerVM.endTime2.value,
                          isOpenCallback: (bool val) {
                            _becomePartnerVM.isClose2.value = val;
                          },
                          startCallback: (DateTime val) {
                            _becomePartnerVM.startTime2.value = val.toString();
                            print("Start time $val");
                          },
                          endCallback: (DateTime val) {
                            _becomePartnerVM.endTime2.value = val.toString();
                            print("End time $val");
                          },
                        ),
                        TimingTile(
                          titile: Weekdays.Monday,
                          isClose: _becomePartnerVM.isClose3.value,
                          initialStart: _becomePartnerVM.startTime3.value,
                          initialEnd: _becomePartnerVM.endTime3.value,
                          isOpenCallback: (bool val) {
                            _becomePartnerVM.isClose3.value = val;
                          },
                          startCallback: (DateTime val) {
                            _becomePartnerVM.startTime3.value = val.toString();
                            print("Start time $val");
                          },
                          endCallback: (DateTime val) {
                            _becomePartnerVM.endTime3.value = val.toString();
                            print("End time $val");
                          },
                        ),
                        TimingTile(
                          titile: Weekdays.Thursday,
                          isClose: _becomePartnerVM.isClose4.value,
                          initialStart: _becomePartnerVM.startTime4.value,
                          initialEnd: _becomePartnerVM.endTime4.value,
                          isOpenCallback: (bool val) {
                            _becomePartnerVM.isClose4.value = val;
                          },
                          startCallback: (DateTime val) {
                            _becomePartnerVM.startTime4.value = val.toString();
                            print("Start time $val");
                          },
                          endCallback: (DateTime val) {
                            _becomePartnerVM.endTime4.value = val.toString();
                            print("End time $val");
                          },
                        ),
                        TimingTile(
                          titile: Weekdays.Wednesday,
                          isClose: _becomePartnerVM.isClose5.value,
                          initialStart: _becomePartnerVM.startTime5.value,
                          initialEnd: _becomePartnerVM.endTime5.value,
                          isOpenCallback: (bool val) {
                            _becomePartnerVM.isClose5.value = val;
                          },
                          startCallback: (DateTime val) {
                            _becomePartnerVM.startTime5.value = val.toString();
                            print("Start time $val");
                          },
                          endCallback: (DateTime val) {
                            _becomePartnerVM.endTime5.value = val.toString();
                            print("End time $val");
                          },
                        ),
                        TimingTile(
                          titile: Weekdays.Thursday,
                          isClose: _becomePartnerVM.isClose6.value,
                          initialStart: _becomePartnerVM.startTime6.value,
                          initialEnd: _becomePartnerVM.endTime6.value,
                          isOpenCallback: (bool val) {
                            _becomePartnerVM.isClose6.value = val;
                          },
                          startCallback: (DateTime val) {
                            _becomePartnerVM.startTime6.value = val.toString();
                            print("Start time $val");
                          },
                          endCallback: (DateTime val) {
                            _becomePartnerVM.endTime6.value = val.toString();
                            print("End time $val");
                          },
                        ),
                        TimingTile(
                          titile: Weekdays.Friday,
                          isClose: _becomePartnerVM.isClose7.value,
                          initialStart: _becomePartnerVM.startTime7.value,
                          initialEnd: _becomePartnerVM.endTime7.value,
                          isOpenCallback: (bool val) {
                            _becomePartnerVM.isClose7.value = val;
                          },
                          startCallback: (DateTime val) {
                            _becomePartnerVM.startTime7.value = val.toString();
                            print("Start time $val");
                          },
                          endCallback: (DateTime val) {
                            _becomePartnerVM.endTime7.value = val.toString();
                            print("End time $val");
                          },
                        ),
                      ],
                    ),
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
              _becomePartnerVM.addbusinessTimingMethod();
            },
          ),
        ));
  }
}

enum Weekdays {
  Sunday,
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
}
