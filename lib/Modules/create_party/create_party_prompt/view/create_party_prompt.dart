import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_images.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/Auth%20Module/Models/usermodel.dart';
import 'package:partylux/Modules/create_party/create_my_party/view_model/create_party_view_model.dart';
import 'package:partylux/Modules/create_party/create_party_prompt/view_model/party_prompt_view_model.dart';
import 'package:partylux/Utils/Common/common_image_view.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';
import 'package:partylux/Utils/navigation.dart';

import '../../../../Constants/dimens.dart';

class CreatePartyPrompt extends GetView<PartyPromptViewModel> {
  const CreatePartyPrompt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isBodyPadding: true,
      isLeftAlign: true,
      showBackBtn: true,
      appBarTitle: AppStrings.txtCreate,
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizer.getHorizontalSize(25)),
              child: Align(
                alignment: FractionalOffset(0.5,0.26),
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  AppText(
                    text: "Create Your Own Party!",
                    textAlign: TextAlign.center,
                    //fontSize: SizeConfig.screenWidth * 0.04,
                    fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel20),
                    fontWeight: FontWeight.w400,
                  ),
             /*     AppText(
                    text: "House Party?",
                    textAlign: TextAlign.center,
                    //fontSize: SizeConfig.screenWidth * 0.04,
                    fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel40),
                    fontWeight: FontWeight.w400,
                    height: 0.8,
                  ),*/
                  SizedBox(height: AppSizer.getVerticalSize(24),),
                  CommonImageView(imagePath: AppImages.imgParty,height: AppSizer.getVerticalSize(290),
                    fit: BoxFit.contain,),

                ],),
              ),
            ),
          ),
          AppButton.mainButton(
            context,
            text: AppStrings.txtCreateMyParty,
            onPressed: () {
              controller.advance();
            },
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}
