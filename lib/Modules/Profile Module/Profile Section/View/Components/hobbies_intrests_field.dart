import 'package:flutter/material.dart';
import 'package:partylux/Constants/app_fonts.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

import '../../../../../Utils/Common/sizer.dart';

class HobbiesAndIntrestsField extends StatelessWidget {
  final bool showAddBtn;
  final String title;
  final List<String> itemsList;
  final Function addTap;
  const HobbiesAndIntrestsField({
    super.key,
    this.showAddBtn = true,
    required this.title,
    required this.itemsList,
    required this.addTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenWidth * 0.04),
        Row(
          children: [
            AppText(
              text: title,
              fontFamily: AppFonts.lexendDica,
              fontWeight: FontWeight.w400,
              fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
            ),
            const Spacer(),
            showAddBtn?TextButton(
              onPressed: () {
                addTap();
              },
              child: AppText(
                text: "+Add",
                fontFamily: AppFonts.lexendDica,
                fontWeight: FontWeight.w400,
                fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14)
              ),
            ):Container(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: showAddBtn ?0.0:10.0),
              child: itemsList.isNotEmpty?Wrap(
                alignment: WrapAlignment.start,
                spacing: 15,
                runSpacing: 15,
                children: [
                  for (var item in itemsList)
                    HobbyContainer(text: item,),
                ],
              ):showAddBtn==false?AppText(text: "No ${title} found",fontSize: AppSizer.getFontSize(12),fontWeight: FontWeight.w400,):Container(),
            ),
          ],
        ),
      ],
    );
  }
}


class HobbyContainer extends StatelessWidget {

  final String text;
  final void Function()? onTap;
  const HobbyContainer({Key? key,required this.text,this.onTap,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth * 0.04,
          vertical: SizeConfig.screenWidth * 0.025,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: AppColors.primaryText),
            color: AppColors.whiteText.withOpacity(0.10)
        ),
        child: AppText(
            text: text,
            textAlign: TextAlign.center,
            fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12)
        ),
      ),
    );
  }
}
