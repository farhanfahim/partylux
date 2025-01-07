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
import '../../../Utils/Network/cache_handler.dart';
import '../../Auth Module/Models/usermodel.dart';
import '../model/checkbox_item.dart';

class CreateFlyerViewModel extends GetxController with ClubService,EventService,CreateFlyerService{

  Rx<String> coverMedia = "".obs;

  PageModel<DropDownItem>? myClubList;
  PageModel<DropDownItem>? myEvents;

  final TextEditingController dateController= TextEditingController(),startTimeController= TextEditingController(),
      endTimeController= TextEditingController(),descController= TextEditingController(),
      admissionFeeController= TextEditingController(),businessController= TextEditingController(),
      eventController= TextEditingController();

  EventModel? selectedEvent;
  BecomePartnerModel? selectedBusiness;


  FocusNode dateNode = FocusNode();
  FocusNode startTImeNode = FocusNode();
  FocusNode endTimeNode = FocusNode();
  FocusNode descNode = FocusNode();
  FocusNode admissionFeeNode = FocusNode();
  FocusNode businessNode = FocusNode();
  FocusNode eventNode = FocusNode();
  late ChewieController chewieController;

/*  DateTime selectedDate = DateTime.now();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now().add(Duration(minutes: 1));*/

/*  List<CheckboxItem> listOfBusinessType = [];
  List<CheckboxItem> listOfEventType = [];*/

  final ImagePicker _picker = ImagePicker();

  RxBool isLoading = false.obs;
  RxBool isFormCompleted = false.obs;
  RxBool isVideo = false.obs;
  late VideoPlayerController videoPlayerController;
  @override
  void onInit() {
    super.onInit();
  }

  void camera(String val) async {
    if (val == "video") {
      final XFile? video = await _picker.pickVideo(
          source:  ImageSource.gallery );
      if (video != null) {
        print("farhan");
        print(video.path);
        videoPlayerController = VideoPlayerController.file(File(video.path),);
        chewieController = ChewieController(
          aspectRatio: 2.3,
          videoPlayerController: videoPlayerController,
          autoPlay: true,
          looping: false,
            showControls: false,
          allowFullScreen: false
        );
        isVideo.value = true;
        coverMedia.value = video.path;
        print(coverMedia.value);
        checkForm();
      } else {
        print('No video selected.');
      }
    } else {
      final XFile? photo = await _picker.pickImage(
          source: val == "take" ? ImageSource.camera
              : ImageSource.gallery, imageQuality: AppInteger.IMAGE_QUALITY);
      if (photo != null) {
        isVideo.value = false;
        Util.compressFile(photo).then((value) {
          coverMedia.value = value!.path;
          print(coverMedia.value);
        });

        checkForm();
      } else {
        print('No image selected.');
      }
    }
  }


  Future<PageModel<EventModel>?> getMyEvents({String search = "", int page = 1, required int index}) {
    Map<String, dynamic> map = {
      "myEvents":1,
    };
    return getEvents(body: map, page: page, search: search);
  }

  Future<PageModel<BecomePartnerModel>?> getBusinessList({int page=1,}) async {
    final Rx<UserModel> userData = UserModel.fromEmpty().obs;

    userData.value = await DatabaseHandler().getUserData();
    if(userData.value.sId!.isNotEmpty) {
      return  await getBusiness(
        page:page,
        body: {
          "user_id":userData.value.sId!,
        },
      );
    }
  }

  checkForm() {
    if (coverMedia.value.isNotEmpty) {
      if (dateController.value.text.isNotEmpty &&
          startTimeController.value.text.isNotEmpty &&
          endTimeController.value.text.isNotEmpty &&
          descController.value.text.isNotEmpty &&
          admissionFeeController.value.text.isNotEmpty &&
          businessController.value.text.isNotEmpty &&
          eventController.value.text.isNotEmpty) {
        isFormCompleted.value = true;
      } else {
        isFormCompleted.value = false;
      }
    } else {
      isFormCompleted.value = false;
    }
  }

  bool validateFields(){
    bool val = true;
    if(DateTimeUtil.timeDifference12(startTimeController.text,endTimeController.text)<1){
      val=false;
      Util.showToast("End duration must be greater than start duration", error: true);
    }
    return val;
  }

  Future<void> switchAction() async{

    if (validateFields()) {

      EasyLoading.show(
        status: 'Please Wait . . .',
        indicator: CupertinoActivityIndicator(
          color: AppColors.whiteText,
          radius: SizeConfig.screenWidth * 0.05,
        ),
      );

      List<String> temoImagesURL = [];
      if(isVideo.value){
        await onUploadVideo(url: coverMedia.value).then((value) {
          temoImagesURL.add(value);
        });
        print("image path: $temoImagesURL");
      }else{
        temoImagesURL = await onUploadPicture(imageFileList: [coverMedia.value]);
        print("image path: $temoImagesURL");
      }

      if (temoImagesURL.isNotEmpty) {
        Map<String, dynamic> body = {

        "media": temoImagesURL[0],
        "eventDate": DateTimeUtil.formatDate(dateController.text,
        inputDateTimeFormat: DateTimeUtil.dateTimeFormat7, outputDateTimeFormat: DateTimeUtil.dateTimeFormat3),
        "fromTime": DateTimeUtil.formatDate(startTimeController.text,
        inputDateTimeFormat: DateTimeUtil.dateTimeFormat4, outputDateTimeFormat: DateTimeUtil.dateTimeFormat8),
        "toTime": DateTimeUtil.formatDate(endTimeController.text,
            inputDateTimeFormat: DateTimeUtil.dateTimeFormat4, outputDateTimeFormat: DateTimeUtil.dateTimeFormat8),
        "description": descController.text,
        "admissionFee": int.parse(admissionFeeController.value.text.replaceAll(RegExp(r"[^\w\s]"), "")),
        "partnerId": selectedBusiness!.id,
        "eventId": selectedEvent!.id,
          "mediaType": isVideo.value?"video":"image"
        };
        print("create flyer body: ${jsonEncode(body)}");

        bool val=await onCreateFlyer(body);
        if(val){
          AppNavigator.navigateToNamedReplace(AppRoutes.successView,
              arguments: {Constants.paramType: Constants.PUSH_FLYER});
        }
      }
      EasyLoading.dismiss();
    }

  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }


}
