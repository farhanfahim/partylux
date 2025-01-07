import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/Create%20Module/Model/create_model.dart';
import 'package:partylux/Modules/Home%20Module/View/Components/shimmer_view.dart';
import 'package:partylux/Modules/people_joined/model/evrnt_participants_model.dart';
import 'package:partylux/Modules/people_joined/model/order_model.dart';
import 'package:partylux/Modules/perticipant_module/component/participant_request_tile.dart';
import 'package:partylux/Modules/perticipant_module/view_model/participants_view_model.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Theme/app_text.dart';
import 'package:partylux/Utils/griddelegate.dart';

import '../../Constants/app_fonts.dart';
import '../../Constants/dimens.dart';
import '../../Utils/Common/participant_tile.dart';
import '../../Utils/Common/sizer.dart';
class RequestParticipantsView extends GetView<ParticipantsViewModel> {
  RequestParticipantsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


        SizedBox(height: AppSizer.getVerticalSize(20)),
        Obx(() => !controller.isLoading.value?Expanded(
          child: controller.pendingOrderModel.isNotEmpty?ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: controller.pendingOrderModel.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ParticipantRequestTile(
                  context: context,
                  data: controller.pendingOrderModel[index].user!,
                  reject: (){
                    controller.onUpdateRequest(controller.pendingOrderModel[index].sId,false);
                    controller.pendingOrderModel.removeAt(index);
                  },
                  accept: (){
                    controller.onUpdateRequest(controller.pendingOrderModel[index].sId,true);
                    controller.pendingOrderModel[index].orderStatus = "approved";
                    controller.pendingOrderModel.removeAt(index);
                  }
              );
            },
          ):Center(
            child: AppText(
                text: AppStrings.noRequestFound),
          ),
        ):viewGenderShimmer(),)



      ],
    );
  }
}
