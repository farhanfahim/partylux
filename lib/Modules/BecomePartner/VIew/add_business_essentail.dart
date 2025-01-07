import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Modules/BecomePartner/View%20Model/becompartner_vm.dart';
import 'package:partylux/Modules/Create%20Module/View/Components/essential_section_dynamic.dart';
import 'package:partylux/Utils/AppBar/primary_app_bar.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

class AddBusinessEssentails extends StatelessWidget {
  AddBusinessEssentails({super.key});

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
                title: "Business Essential",
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
                    PartyEssentialSections(
                      isSingleSelection: true,
                      title: "Music",
                      checkboxList: [
                        "EDM",
                        "POP",
                        "Hip Hop",
                        "Rap",
                        "Rock",
                        "Country",
                      ],
                      callbak: (val, title) {
                        if (val) {
                          print("object $val $title");
                          _becomePartnerVM.musicList.add(title);
                        } else {
                          _becomePartnerVM.musicList.remove(title);
                        }
                      },
                      selectedList: _becomePartnerVM.musicList,
                    ),
                    PartyEssentialSections(
                      isSingleSelection: true,
                      title: "Entertainment",
                      checkboxList: [
                        "Billiards",
                        "Ping Pong",
                        "BEER",
                        "Cards",
                        "DARTS",
                        "Swimming Pool",
                        "Movie",
                        "Live DJ",
                      ],
                      selectedList: _becomePartnerVM.entertainmentList,
                      callbak: (val, title) {
                        if (val) {
                          _becomePartnerVM.entertainmentList.add(title);
                        } else {
                          _becomePartnerVM.entertainmentList.remove(title);
                        }
                      },
                    ),
                    PartyEssentialSections(
                      isSingleSelection: true,
                      title: "Disclaimer",
                      checkboxList: ["BYOB", "FREE", "FOOD"],
                      selectedList: _becomePartnerVM.disclaimerList,
                      callbak: (val, title) {
                        if (val) {
                          _becomePartnerVM.disclaimerList.add(title);
                        } else {
                          _becomePartnerVM.disclaimerList.remove(title);
                        }
                      },
                    ),
                    Obx(
                      () => PartyAgeLimitSections(
                        title: "Age Limit",
                        selectName: _becomePartnerVM.ageLimit.value,
                        checkboxList: [
                          "15+ Year",
                          "18+ Year",
                          "21+ Year",
                        ],
                        callbak: (val) {
                          print(val);
                          _becomePartnerVM.ageLimit.value = val;
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
              _becomePartnerVM.addBusinessEssentailMethod();
            },
          ),
        ));
  }
}
