import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/buttons/dg_main_button.dart';
import '../../../Constants/color.dart';
import '../View Model/ticker_detail_viewmodel.dart';
import 'Components/ticket_detait_tile.dart';

class TicketDetailView extends StatelessWidget {
  TicketDetailView({Key? key}) : super(key: key);

  final tickerController = Get.find<TicketDetailViewModel>();

  String? id = Get.arguments[0];
  final String ticketType = Get.arguments[1];

  @override
  Widget build(BuildContext context) {
    print(ticketType);
    return CustomScaffold(
        isBodyPadding: true,
        isLeftAlign: false,
        showBackBtn: true,
        appBarTitle: AppStrings.txtYourTicket,
        body: Column(
          children: [

            Obx(() => tickerController.isDataLoading.value == false?Expanded(
              child: Container(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TicketDetailTile(tickerController.orderModel!.value,ticketType)
                      ],
                    ),
                  ),
                ),
              ),
            ):Expanded(
              child: Center(
                child: CupertinoActivityIndicator(
                  color: AppColors.whiteText,
                  radius: 10,
                ),
              ),
            ),),
            ticketType=="business"?AppButton.mainButton(
              context,
              isTransparent: true,
              textColor: AppColors.primaryText,
              buttonColor: AppColors.transparent,
              text: "Go to home",
              onPressed: () {
               Get.offAllNamed(AppRoutes.NAV_ROOT);
              },
            ):Container(),
            SizedBox(height: AppSizer.getVerticalSize(40),)
          ],
        ) );
  }

}
