import 'package:chewie/chewie.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/BecomePartner/Model/become_partner_model.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Modules/common/bottom_sheets/item_sheet/item_sheet.dart';
import 'package:partylux/Modules/create_flyer/view_model/create_flyer_vm.dart';
import 'package:partylux/Utils/Common/image_upload.dart';
import 'package:partylux/Utils/Custom%20Views/custom_scaffold.dart';
import 'package:partylux/Utils/common_methods.dart';
import 'package:partylux/models/media.dart';
import '../../../Constants/app_images.dart';
import '../../../Constants/color.dart';
import '../../../Constants/dimens.dart';
import '../../../Utils/Common/custom_textfield.dart';
import '../../../Utils/Common/photo_popup.dart';
import '../../../Utils/Common/sizer.dart';
import '../../../Utils/Theme/app_text.dart';
import '../../../Utils/Util.dart';
import '../../../Utils/buttons/dg_main_button.dart';
import '../../../Utils/date_time_util.dart';
import '../../../Utils/helper_functions.dart';
import '../view_model/video_vm.dart';

class VideoView extends StatelessWidget {
  VideoView({super.key});
  final _videoVM = Get.find<VideoModel>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        isBodyPadding: true,
        isLeftAlign: false,
        showBackBtn: true,
        appbarColor: AppColors.midGrey,
        appBarTitle: "",
        isTopPadding: 30,
        body: Chewie(
          controller: _videoVM.chewieController,
        ),);
  }
}
