import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Utils/Common/common_image_view.dart';
import 'package:partylux/Utils/Common/create_party_items.dart';
import 'package:partylux/Utils/Common/glassmorphic_container.dart';
import 'package:partylux/Utils/Common/icons.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/Util.dart';
import 'package:partylux/Utils/buttons/circular_button.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';
import 'package:partylux/Utils/common_methods.dart';
import 'package:partylux/Utils/navigation.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../Utils/Common/chipInTile.dart';

class ReservationSuccessView extends StatelessWidget {
  const ReservationSuccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double imgHeight = AppSizer.getVerticalSize(200);

    return CustomScaffold(
        isBodyPadding: true,
        isVertPadding: true,
        hideAppBar: true,
        isLeftAlign: true,
        showBackBtn: false,
        safeTop: true,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: AppSizer.getVerticalSize(AppDimen.vertPadd)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [

                    SizedBox(
                      height: AppSizer.getVerticalSize(50),
                    ),

               GlassContainer(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     SizedBox(
                       height: AppSizer.getVerticalSize(7),
                     ),
                     AppText(
                       text: AppStrings.youHaveReserved,
                       fontSize: AppSizer.getFontSize(20),

                       textAlign: TextAlign.center,
                     ),
                     SizedBox(
                       height: AppSizer.getVerticalSize(45),
                     ),
                     Container(
                       //color: Colors.red,
                       height: imgHeight, width: imgHeight * 0.97,
                       child: Stack(
                         children: [
                           Positioned.fill(
                             child: CommonImageView(
                               imagePath: AppImages.imgPartyBalloon,
                               fit: BoxFit.contain,
                             ),
                           ),
                           Align(
                             alignment: Alignment.topLeft,
                             child: CircularButton(
                               diameter: imgHeight * 0.26,
                               icon: AppImages.icTick,
                               isSvg: true,
                               bgColor: AppColors.greenColor,
                               color: AppColors.whiteText,
                             ),
                           ),
                         ],
                       ),
                     ),
                     SizedBox(
                       height: AppSizer.getVerticalSize(60),
                     ),
                     AppText(
                       text: AppStrings.yourTickWill,
                       fontSize: AppSizer.getFontSize(18),
                       textAlign: TextAlign.center,
                     ),
                     SizedBox(
                       height: AppSizer.getVerticalSize(15),
                     ),
                   ],
                 ),
               ),
                    SizedBox(
                      height: AppSizer.getVerticalSize(20),
                    ),
                AppText(
                  text: AppStrings.youCanAlsoSave,
                  color: AppColors.iconColor,
                  fontSize: AppSizer.getFontSize(14),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: AppSizer.getVerticalSize(20),
                ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppImages.imgAppleWallet,width: AppSizer.getHorizontalSize(150),),
                        SizedBox(width: AppSizer.getHorizontalSize(10),),
                        Image.asset(AppImages.imgGoogleWallet,width: AppSizer.getHorizontalSize(150),),
                      ],
                    )

              ])),
            ),
            AppButton.mainButton(
              context,
              text: AppStrings.txtReturnToHome,
              onPressed: () {
                AppNavigator.navigateToNamedUntil(AppRoutes.NAV_ROOT);


                //Get.toNamed(AppRoutes.successView,arguments: {"type":"payment"});

              },
            ),
          ],
        ));
  }
}
