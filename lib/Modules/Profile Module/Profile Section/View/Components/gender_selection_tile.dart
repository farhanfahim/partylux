import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Utils/Common/radio_button.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

class GenderSelectionTile extends StatelessWidget {
  final String hintText;
  final Function callback;
  final RxBool isMale;
  final bool isProfile;
  GenderSelectionTile({
    super.key,
    required this.hintText,
    required this.isMale,
    required this.callback,
    required this.isProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: SizeConfig.screenWidth * 0.03),
          AppText(
            text: hintText,
            fontWeight: FontWeight.w400,
            fontSize: AppSizer.getFontSize(18),
            
          ),
          SizedBox(height: 12),
          Row(
            children: [
              tileView(
                isMale.value,
                title: "Male",
                callback: () {
                  callback("male");
                 if(!isProfile) isMale.value = !isMale.value;
                },
              ),
              SizedBox(width: SizeConfig.screenWidth * 0.05),
              tileView(
                !isMale.value,
                title: "Female",
                callback: () {
                  callback("female");
                  if(!isProfile)isMale.value = !isMale.value;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget tileView(
    bool isActive, {
    required String title,
    required Function callback,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          callback();
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.whiteText.withOpacity(0.10),
          ),
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * 0.03),
          child: Row(
            children: [
              Expanded(
                child: AppText(
                  text: title,
                  color: AppColors.iconColor,
                  fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),

                ),
              ),
              RadioButton().single(isActive),
              SizedBox(width: 10,),



            ],
          ),
        ),
      ),
    );
  }
}
