import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/AccountModule/View%20Model/accountviewmodel.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';

import '../../../../Constants/dimens.dart';
import '../../../../Utils/Common/sizer.dart';
import '../../../../Utils/Theme/app_config.dart';

class accountDeleteBottomSheet extends StatelessWidget {
  accountDeleteBottomSheet({super.key});

  final _accountVM = Get.put(AccountViewModel());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight / 3,
      width: SizeConfig.screenWidth,
      padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
      decoration: BoxDecoration(
          color: AppColors.whiteText.withOpacity(0.1),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          )),
      child: Column(
        children: [
          Container(
            height: 5,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.whiteText,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          AppText(
            text: "Are Your Sure Want to\nDelete Your Account",
            fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
            textAlign: TextAlign.center,
            
            color: AppColors.whiteText,
          ),
          Spacer(),
          Obx(
            () => AppButton.mainButton(
              context,
              text: "Yes",
              loading: _accountVM.loading.value,
              onPressed: () {
                _accountVM.onDeleteAccount();
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          AppButton.cancelButton(
            context,
            text: "Cancel",
            onPressed: () {
              Get.back();
            },
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
// Widget accountDeleteBottomSheet({required BuildContext context}) {
//   return Container(
//     height: SizeConfig.screenHeight / 3,
//     width: SizeConfig.screenWidth,
//     padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
//     decoration: BoxDecoration(
//         color: AppColors.whiteText.withOpacity(0.1),
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(24),
//           topRight: Radius.circular(24),
//         )),
//     child: Column(
//       children: [
//         Container(
//           height: 5,
//           width: 40,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: AppColors.whiteText,
//           ),
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         AppText(
//           text: "Are Your Sure Want to\nDelete Your Account",
//           fontSize: 16,
//           textAlign: TextAlign.center,
//           
//           color: AppColors.whiteText,
//         ),
//         Spacer(),
//         AppButton.mainButton(
//           context,
//           text: "Yes",
//           onPressed: () {},
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         AppButton.cancelButton(
//           context,
//           text: "Cancel",
//           onPressed: () {
//             Get.back();
//           },
//         ),
//         SizedBox(
//           height: 20,
//         ),
//       ],
//     ),
//   );
// }
