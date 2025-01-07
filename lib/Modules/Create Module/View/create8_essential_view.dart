import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/Create%20Module/View%20Model/create_viewmodel.dart';
import 'package:partylux/Modules/Create%20Module/View/Components/essential_section_dynamic.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

class SelectPartyEssential extends StatelessWidget {
  SelectPartyEssential({super.key});

  final _createEventVM = Get.find<CreateViewModel>();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showBackBtn:true,
      appBarTitle: "Party Essential",
      body: SizedBox.expand(
        child: Column(
          children: [

            Align(
              alignment: Alignment.centerLeft,
              child: AppText(
                text:
                    "Lorem ipsum dolor sit amet consectetur. Risus varius elementum consequat in quam.",
                fontSize: SizeConfig.screenWidth * 0.033,
                overflow: TextOverflow.visible,
                color: AppColors.whiteText.withOpacity(0.6),
              ),
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
                      "Country"
                    ],
                    selectedList: _createEventVM.musicList,
                    callbak: (val, title) {
                      if (val) {
                        print("object $val $title");
                        _createEventVM.musicList.add(title);
                      } else {
                        _createEventVM.musicList.remove(title);
                      }
                    },
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.025),
                  PartyEssentialSections(
                    isSingleSelection: true,
                    title: "Entertainment",
                    selectedList: _createEventVM.entertainmentList,
                    checkboxList: [
                      "Billiards",
                      "Ping Pong",
                      "BEER",
                      "Cards",
                      "DARTS",
                      "Swimming Pool",
                      "Movie",
                      "Live DJ"
                    ],
                    callbak: (val, title) {
                      if (val) {
                        _createEventVM.entertainmentList.add(title);
                      } else {
                        _createEventVM.entertainmentList.remove(title);
                      }
                    },
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.025),
                  PartyEssentialSections(
                    isSingleSelection: true,
                    title: "Disclaimer",
                    checkboxList: ["BYOB", "FREE", "FOOD"],
                    selectedList: _createEventVM.disclaimerList,
                    callbak: (val, title) {
                      if (val) {
                        _createEventVM.disclaimerList.add(title);
                      } else {
                        _createEventVM.disclaimerList.remove(title);
                      }
                    },
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.025),
                  Obx(
                    () => PartyAgeLimitSections(
                      title: "Age Limit",
                      selectName: _createEventVM.ageLimit.value,
                      checkboxList: [
                        "15+ Year",
                        "18+ Year",
                        "21+ Year",
                      ],
                      callbak: (val) {
                        print(val);
                        _createEventVM.ageLimit.value = val;
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
                _createEventVM.selectPartyEssential();
              },
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }

  // Widget sd(
  //   BuildContext context, {
  //   required String title,
  //   required List<String> checkboxList,
  //   required Function(String) callbak,
  // }) {
  //   return Column(
  //     children: [
  //       Align(
  //         alignment: Alignment.centerLeft,
  //         child: AppText(
  //           text: title,
  //           fontSize: SizeConfig.screenWidth * 0.038,
  //           fontWeight: FontWeight.w600,
  //         ),
  //       ),
  //       SizedBox(height: SizeConfig.screenHeight * 0.005),
  //       MediaQuery.removePadding(
  //         context: context,
  //         removeTop: true,
  //         child: GridView.builder(
  //           gridDelegate:
  //               const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
  //             crossAxisCount: 2,
  //             height: 50,
  //           ),
  //           itemCount: checkboxList.length,
  //           shrinkWrap: true,
  //           physics: const NeverScrollableScrollPhysics(),
  //           itemBuilder: (BuildContext context, int index) {
  //             return Row(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               mainAxisAlignment: MainAxisAlignment.start,
  //               children: [
  //                 GestureDetector(
  //                   onTap: () {
  //                     callbak(checkboxList[index]);
  //                   },
  //                   child: Container(
  //                     height: SizeConfig.screenWidth * 0.06,
  //                     width: SizeConfig.screenWidth * 0.06,
  //                     margin: const EdgeInsets.only(right: 10),
  //                     color: AppColors.transparent,
  //                     child: Center(
  //                       child: selectName == checkboxList[index]
  //                           ? Image.asset(
  //                               "assets/icon_assets/checkbox_select.png",
  //                               height: SizeConfig.screenWidth * 0.06,
  //                               width: SizeConfig.screenWidth * 0.06,
  //                             )
  //                           : Image.asset(
  //                               "assets/icon_assets/checkbox_unselect.png",
  //                               width: (SizeConfig.screenWidth * 0.06) - 2,
  //                               height: (SizeConfig.screenWidth * 0.06) - 2,
  //                             ),
  //                     ),
  //                   ),
  //                 ),
  //                 AppText(
  //                   text: checkboxList[index],
  //                   fontWeight: FontWeight.w500,
  //                   fontSize: SizeConfig.screenWidth * 0.035,
  //                 ),
  //               ],
  //             );
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
