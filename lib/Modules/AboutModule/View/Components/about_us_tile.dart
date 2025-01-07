import 'package:flutter/material.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import '../../../../Constants/color.dart';
import '../../../../Constants/dimens.dart';
import '../../../../Utils/Common/sizer.dart';

Widget aboutUsTile(
    {required BuildContext context,
    String title = "test@gmail.com ",
    String image = AppImages.imgPrivacy,

    VoidCallback? callback}) {
  return GestureDetector(
    onTap: callback,
    child: Container(
      height: 55,
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteText.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image(
            image: AssetImage(image),
            color: Colors.white,
            height: 20,
            width: 20,

          ),
          const SizedBox(
            width: 15,
          ),
          AppText(
              text:title,
              fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),),

          const Spacer(),
           Image(
            image: AssetImage(AppImages.imgArrowRight),
            height: 20,
            width: 20,

          ),
        ],
      ),
    ),
  );
}
