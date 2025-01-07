import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/dimens.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Utils/Common/common_image_view.dart';
import 'package:partylux/Utils/Common/create_party_items.dart';
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
import '../view_model/create_party_success_view_model.dart';

class CreatePartySuccessView extends GetView<CreatePartySuccessViewModel> {
  const CreatePartySuccessView({Key? key}) : super(key: key);

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
                    AppText(
                      text: "${AppStrings.txtCongrats}, ",
                      fontSize: AppSizer.getFontSize(30),
                    ),
                    SizedBox(
                      height: AppSizer.getVerticalSize(7),
                    ),
                    AppText(
                      text: AppStrings.txtYouHostingParty,
                      textAlign: TextAlign.center,
                      fontSize: AppSizer.getFontSize(20),
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
                      height: AppSizer.getVerticalSize(50),
                    ),
                    AppText(
                      text: AppStrings.txtWeHopeMemories,
                      fontSize: AppSizer.getFontSize(18),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: AppSizer.getVerticalSize(35),
                    ),
                    CustomRichText(fontWeight: FontWeight.w400, fontSize: AppSizer.getFontSize(16),textAlign: TextAlign.center, spans: [
                      CustomSpan(text: "Here's the link", fontColor: AppColors.primary),
                      CustomSpan(text: " to send to your friends, \nif you have any", fontColor: AppColors.whiteText)
                    ]),
                    SizedBox(
                      height: AppSizer.getVerticalSize(21),
                    ),
                    CopyContainer(
                      text: "${controller.event.shareUrl}",
                      bgColor: AppColors.feildBGColor.withOpacity(0.10),
                      onCopy: () {
                        CommonMethods.copyText(controller.event.shareUrl).then((value) {
                          Util.showToast("Text copied!");
                        });
                      },
                    ),
                    controller.event.eventType == EventModel.TYPE_PRIVATE
                        ? Column(
                            children: [
                              SizedBox(
                                height: AppSizer.getVerticalSize(33),
                              ),
                              AppText(
                                text: AppStrings.txtYourEventCode,
                                fontWeight: FontWeight.w400,
                                fontSize: AppSizer.getFontSize(16),
                              ),
                              SizedBox(
                                height: AppSizer.getVerticalSize(21),
                              ),
                              CopyContainer(
                                text: "${controller.event.partyCode}",
                                iconColor: AppColors.whiteText,
                                onCopy: () {
                                  CommonMethods.copyText("${controller.event.partyCode}").then((value) {
                                    Util.showToast("Text copied!");
                                  });
                                },
                              ),
                            ],
                          )
                        : Container(),
                  ])),
            ),
            AppButton.mainButton(
              context,
              text: AppStrings.txtReturnToHome,
              onPressed: () {
                AppNavigator.navigateToNamedUntil(AppRoutes.NAV_ROOT);
              },
            ),
          ],
        ));
  }
}
