import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Modules/AboutModule/View%20Model/faqs_viewmodel.dart';
import 'package:partylux/Utils/AppBar/primary_app_bar.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';

import '../../../Constants/color.dart';
import '../../../Constants/dimens.dart';
import '../../../Utils/Common/sizer.dart';
import '../../../Utils/Theme/app_text.dart';
import 'Components/faqs_tile.dart';

class FaqsView extends StatelessWidget {
  FaqsView({Key? key}) : super(key: key);

  final _faqsVM = Get.find<FAQsViewModel>();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return CustomScaffold(
        isBodyPadding: true,
        showBackBtn: true,
        isLeftAlign: true,
        appBarTitle: "FAQs",
        body: Column(
          children: [

            Align(
              alignment: Alignment.centerLeft,
              child: AppText(
                text:
                "Here you can see all related queries & answer \nthat you have",
                fontSize:  AppSizer.getFontSize(AppDimen.fontTextfieldLabel14),
                overflow: TextOverflow.visible,
                fontWeight: FontWeight.w400,
                color: AppColors.whiteText.withOpacity(0.6),
              ),
            ),

            SizedBox(height: SizeConfig.screenHeight * 0.03),
            Obx(
              () => Expanded(
                child: ListView.builder(
                  itemCount: _faqsVM.faqsList.length,
                  padding: EdgeInsets.only(left: 0, right: 0),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return
                    FaqsTile(
                      faqsModel: _faqsVM.faqsList[index],
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
