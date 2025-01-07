import 'package:flutter/material.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Common/checkbox.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/griddelegate.dart';

import '../../../../Constants/app_images.dart';

class PartyEssentialSections extends StatelessWidget {
  final String title;
  final bool isSingleSelection;
  final List checkboxList;
  final List? selectedList;
  final Function? callbak;

  const PartyEssentialSections({
    super.key,
    required this.title,
    required this.isSingleSelection,
    required this.checkboxList,
    this.selectedList,
    this.callbak,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: AppText(
            text: title,
            fontSize: SizeConfig.screenWidth * 0.038,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.01),
        MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: GridView.builder(
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
              crossAxisCount: 2,
              height: 50,
            ),
            itemCount: checkboxList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return CheckBoxField(
                simpleTitle: checkboxList[index],
                initialValue: selectedList!.contains(checkboxList[index]),
                simpleTextFontWeight: FontWeight.w500,
                simpleTextSize: SizeConfig.screenWidth * 0.033,
                centerSpace: SizeConfig.screenWidth * 0.033,
                callback: (val) {
                  if (isSingleSelection) {
                    callbak!(
                      val,
                      checkboxList[index],
                    );
                  } else {
                    callbak!(
                      val,
                      checkboxList[index],
                    );
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget simpleCheckBox({
    required String title,
    required bool isActive,
    required Function(String) callback,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            callback(title);
          },
          child: Container(
            height: SizeConfig.screenWidth * 0.06,
            width: SizeConfig.screenWidth * 0.06,
            margin: const EdgeInsets.only(right: 10),
            color: AppColors.transparent,
            child: Center(
              child: isActive
                  ? Image.asset(
                      AppImages.imgCheckSelect,
                      height: SizeConfig.screenWidth * 0.06,
                      width: SizeConfig.screenWidth * 0.06,
                    )
                  : Image.asset(
                      AppImages.imgUnCheckSelect,
                      width: (SizeConfig.screenWidth * 0.06) - 2,
                      height: (SizeConfig.screenWidth * 0.06) - 2,
                    ),
            ),
          ),
        ),
        AppText(
          text: title,
          fontWeight: FontWeight.w500,
          fontSize: SizeConfig.screenWidth * 0.035,
        ),
      ],
    );
  }
}

class PartyAgeLimitSections extends StatelessWidget {
  final String title;

  final List<String> checkboxList;
  final Function(String) callbak;

  final String selectName;
  const PartyAgeLimitSections({
    super.key,
    required this.title,
    required this.checkboxList,
    required this.callbak,
    this.selectName = "",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: AppText(
            text: title,
            fontSize: SizeConfig.screenWidth * 0.038,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.005),
        MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: GridView.builder(
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
              crossAxisCount: 2,
              height: 50,
            ),
            itemCount: checkboxList.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  callbak(checkboxList[index].toLowerCase());
                },
                child: Container(
                  color: Colors.transparent,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: SizeConfig.screenWidth * 0.06,
                        width: SizeConfig.screenWidth * 0.06,
                        margin: const EdgeInsets.only(right: 10),
                        color: AppColors.transparent,
                        child: Center(
                          child: selectName.toLowerCase() ==
                                  checkboxList[index].toLowerCase()
                              ? Image.asset(
                                  AppImages.imgCheckSelect,
                                  height: SizeConfig.screenWidth * 0.06,
                                  width: SizeConfig.screenWidth * 0.06,
                                )
                              : Image.asset(
                                  AppImages.imgUnCheckSelect,
                                  width: (SizeConfig.screenWidth * 0.06) - 2,
                                  height: (SizeConfig.screenWidth * 0.06) - 2,
                                ),
                        ),
                      ),
                      AppText(
                        text: checkboxList[index],
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.screenWidth * 0.035,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
