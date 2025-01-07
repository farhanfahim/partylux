import 'dart:convert';
import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/constants.dart';
import 'package:partylux/Constants/integer.dart';
import 'package:partylux/Modules/BecomePartner/Model/become_partner_model.dart';
import 'package:partylux/Modules/Club%20Module/service/club_service.dart';
import 'package:partylux/Modules/Event%20Module/service/event_service.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Modules/create_flyer/service/create_flyer_service.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Util.dart';
import 'package:partylux/Utils/date_time_util.dart';
import 'package:partylux/Utils/navigation.dart';
import 'package:partylux/models/dropdown.dart';
import 'package:partylux/models/media.dart';
import 'package:partylux/models/page_model.dart';
import 'package:video_player/video_player.dart';
import '../model/checkbox_item.dart';

class VideoModel extends GetxController{

  Rx<String> coverMedia = "".obs;
  late ChewieController chewieController;

  @override
  void onInit() {

    var arguments = Get.arguments;
    print(arguments[0]);

    super.onInit();
    chewieController = ChewieController(
      videoPlayerController: Get.arguments[0] == "url"?VideoPlayerController.networkUrl (Get.arguments[1],):VideoPlayerController.file(File(Get.arguments[1]),),
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void dispose() {
    chewieController.dispose();
    super.dispose();
  }


}
