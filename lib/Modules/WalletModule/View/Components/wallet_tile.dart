import 'package:flutter/cupertino.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Theme/app_text.dart';

import '../../../../Constants/app_images.dart';
import '../../Model/wallet_enum.dart';

Widget walletTile(
    {required BuildContext context,
    String title = "Withdrawal",
    WalletEnum walletEnum = WalletEnum.credit,
    double amount = 0.0,
    VoidCallback? callback}) {
  return GestureDetector(
    onTap: callback,
    child: Container(
      // height: 55,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.whiteText.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),

      child: Row(
        children: [
          walletEnum == WalletEnum.credit
              ? Image(
                  image: AssetImage(AppImages.imgCredit),
                  height: 20,
                  width: 20,
                )
              : Image(
                  image: AssetImage(AppImages.imgDebit),
                  height: 20,
                  width: 20,
                ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: AppText(
              text: title,
              color: AppColors.whiteText,
              fontSize: AppSizer.getFontSize(12),
              overflow: TextOverflow.visible,
            ),
          ),
          AppText(
              text: "$amount\$",
            fontSize: AppSizer.getFontSize(12),
              color: walletEnum == WalletEnum.credit
                  ? Color(0xFF0AC94B)
                  : Color(0xFFEF497A), ),
        ],
      ),
    ),
  );
}
