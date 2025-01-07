import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/navigation.dart';
import '../../../Constants/app_fonts.dart';
import '../../../Constants/dimens.dart';
import '../../../Utils/Common/sizer.dart';
import '../../../Utils/Theme/app_text.dart';
import '../../../Utils/buttons/dg_main_button.dart';
import '../../TicketModule/Model/ticket_model.dart';
class SuccessView extends StatefulWidget {
  SuccessView({Key? key}) : super(key: key);


  @override
  State<SuccessView> createState() => _SuccessViewState();
}

class _SuccessViewState extends State<SuccessView> {
  Map<String,String> map  = Get.arguments;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return CustomScaffold(
        isBodyPadding: true,
        hideAppBar: true,
        body: Column(
          children: [


            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.imgSuccessPng,
                    width: SizeConfig.screenWidth * 0.6,
                  ),
                  SizedBox(height: 30,),
                  map['type'] == "flyer"?AppText(
                    text:AppStrings.yourBusinessFlyer,
                    overflow: TextOverflow.visible,
                    fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel18),
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500,
                  ):map['type'] == "business"?Column(
                    children: [
                      AppText(
                        text:AppStrings.yourBusinessCreated,
                        overflow: TextOverflow.visible,
                        fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel18),
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: AppSizer.getVerticalSize(10),),
                      RichText(
                        maxLines: 3,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: AppStrings.youHavetoWait,
                          style: TextStyle(
                            fontFamily: AppFonts.copperPlate,
                            overflow: TextOverflow.visible,
                            height: 0.8,
                            fontSize: AppSizer.getFontSize(15),
                          ),

                        ),
                      ),

                    ],
                  ):Column(
                    children: [
                      AppText(
                        text:AppStrings.yourPayment,
                        overflow: TextOverflow.visible,
                        fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel18),
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: AppSizer.getVerticalSize(10),),
                      AppText(
                        text:AppStrings.youCanNowView,
                        overflow: TextOverflow.visible,
                        color: AppColors.iconColor,
                        fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel16),
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                ],
              ),
            ),
           

            AppButton.mainButton(
              context,
              text: AppStrings.continueTxt,
              loading: false,
              onPressed: () {
                if(map['type'] == "business"){
                  Get.offAllNamed(AppRoutes.LoginSignUpView);
                }else if(map['type'] == "payment"){

                  Get.toNamed(
                    AppRoutes.ticketDetailView,
                    arguments: [map['orderId'],"business"],
                  );
                }else{
                 // Get.offAllNamed(AppRoutes.NAV_ROOT);
                  AppNavigator.navigateToNamedUntil(AppRoutes.NAV_ROOT);
                }

              },
            ),
            SizedBox(height: 40,)
          ],
        ));
  }
}
