// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/AppBar/primary_app_bar.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Network/api_client.dart';
import 'package:partylux/Utils/Network/api_urls.dart';
import 'package:partylux/Utils/Theme/app_config.dart';

import '../../../Constants/dimens.dart';
import '../../../Utils/Common/sizer.dart';
import '../../../Utils/Theme/app_text.dart';

class CustomPrivacyView extends StatefulWidget {
  CustomPrivacyView({Key? key}) : super(key: key);

  @override
  State<CustomPrivacyView> createState() => _CustomPrivacyViewState();
}

class _CustomPrivacyViewState extends State<CustomPrivacyView> {
  String header = Get.arguments[0];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  RxString htmlData = "".obs;

  void getData() async {
    var response;
    if (header == "About Party Lux") {
      response = await API().get(ApiManager.ABOUT_PARTYLUX);
      htmlData.value = response.data["data"]["partyLux"];
    } else if (header == "Privacy Policy") {
      response = await API().get(ApiManager.PRIVACY_POLICY);
      htmlData.value = response.data["data"]["privacyPolicy"];
    } else if (header == "Terms & Conditions") {
      response = await API().get(ApiManager.TERMS_CONDITION);
      htmlData.value = response.data["data"]["termsAndCondition"];
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return CustomScaffold(
        isBodyPadding: true,
        showBackBtn: true,
        isLeftAlign: true,
        appBarTitle: header,
        body: SizedBox.expand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: AppText(
                    text:
                    "Here you can see the company $header",
                    fontSize: AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                    overflow: TextOverflow.visible,
                    fontWeight: FontWeight.w400,
                    color: AppColors.whiteText.withOpacity(0.6),
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.screenHeight * 0.02),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: AppText(
                    text: "Introduction",
                    fontSize: 20,
                    textAlign: TextAlign.left,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                  () => htmlData.value.isNotEmpty
                      ? ListView(
                          padding: const EdgeInsets.only(top: 10),
                          children: [
                            Html(
                              style: {
                                "body": Style(
                                    fontSize: FontSize( AppSizer.getFontSize(AppDimen.fontTextfieldLabel12),),
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.iconColor),
                              },
                              data: htmlData.value,
                            ),
                          ],
                        )
                      : CupertinoActivityIndicator(
                          radius: SizeConfig.screenWidth * 0.06,
                          color: AppColors.whiteText,
                        ),
                ),
              )
            ],
          ),
        ));
  }
}
