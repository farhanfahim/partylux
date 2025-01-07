import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Constants/constants.dart';
import 'package:partylux/Constants/integer.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/Auth%20Module/Models/usermodel.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Modules/create_party/create_my_party/service/create_party_service.dart';
import 'package:partylux/Modules/create_party/create_my_party/view/overview.dart';
import 'package:partylux/Modules/create_party/create_my_party/view/settings.dart';
import 'package:partylux/Utils/Network/api_client.dart';
import 'package:partylux/Utils/Network/api_urls.dart';
import 'package:partylux/Utils/Network/cache_handler.dart';
import 'package:partylux/Utils/Theme/app_config.dart';
import 'package:partylux/Utils/Util.dart';
import 'package:partylux/Utils/date_time_util.dart';
import 'package:partylux/Utils/navigation.dart';
import 'package:partylux/models/media.dart';

import '../../../../models/dropdown.dart';
import '../../../../models/page_model.dart';
import '../../../BecomePartner/Model/become_partner_model.dart';
import '../../../My Business/Model/business_detail_model.dart';

class CreatePartyViewModel extends GetxController with GetTickerProviderStateMixin, CreatePartyService {
  final ImagePicker _picker = ImagePicker();

  final Rx<Media> coverImage = Media().obs;

  late TabController tabController;

  final List<Widget> screens = [OverviewView(), SettingsView()];
  final List<String> titles = [AppStrings.txtOverview, AppStrings.txtSettings];

  final TextEditingController title = TextEditingController(),
      description = TextEditingController(),
      location = TextEditingController(),
      start_time = TextEditingController(),
      end_time = TextEditingController(),
      startDate = TextEditingController(),
      endDate = TextEditingController(),
      businessController= TextEditingController(),
      maleAmount = TextEditingController(),
      femaleAmount = TextEditingController();

  late EventModel event;// model used for event state
  EventModel? event2;

  final RxBool maleFree = true.obs, femaleFree = true.obs;

  FocusNode businessNode = FocusNode();
  late bool edit;

  PageModel<DropDownItem>? myClubList;
  BecomePartnerModel? selectedBusiness;
  Rx<BusinessDetailModel> businessDetailModel = BusinessDetailModel().obs;
  var arguments;
  @override
  void onInit() {
    arguments=Get.arguments;
    tabController = TabController(
      length: screens.length,
      vsync: this,
    );
    edit=arguments?[Constants.paramFrom2]??false;
    if(!edit) {
      event = EventModel(
        eventType: EventModel.TYPE_PUBLIC,
        maxCapacity: false,
        maxParticipants: 10000,
        restrict1: false,
        ownCode: true,
        push: false,
        allowPayments: false,
        eventCategory: arguments?[Constants.paramFrom] ?? EventModel.CATEGORY_HOUSEPARTY,
      );
    }
    else{
      event2=arguments[Constants.paramFrom3];
      setFields(event2!);
    }
    super.onInit();
  }

  @override
  void onReady(){
    super.onReady();
  }

  Future<PageModel<BecomePartnerModel>?> getBusinessList({int page=1,}) async {
    final Rx<UserModel> userData = UserModel.fromEmpty().obs;

    userData.value = await DatabaseHandler().getUserData();
    if(userData.value.sId!.isNotEmpty) {
      return  await getBusiness(
        page:page,
        body: {
          "user_id":userData.value.sId!,
          if(arguments[Constants.paramFrom] != Constants.CATEGORY_HOUSE_PARTY)"businessCategory":arguments[Constants.paramFrom],
        },
      );
    }
  }

  void getBusinessDetail(String id) async {
    await getBusinessDetailApi(id).then((value) {
      businessDetailModel.value = value;
      businessController.text = value.bussinessName!;
    });

  }

  void setFields(EventModel event){
    title.text=event.name!;
    description.text =event.note!;

    if(event.eventProfile!=null && event.eventProfile!.isNotEmpty) {
      coverImage.value = Media(value:event.eventProfile,imageType: ImageType.TYPE_NETWORK);
    }

    start_time.text=DateTimeUtil.formatDateToLocal(event.startDateTime!+"Z",
        inputDateTimeFormat: DateTimeUtil.serverDateTimeFormat3,
        outputDateTimeFormat: DateTimeUtil.dateTimeFormat4
      );
    end_time.text=DateTimeUtil.formatDateToLocal(event.endDateTime!+"Z",
        inputDateTimeFormat: DateTimeUtil.serverDateTimeFormat3,
        outputDateTimeFormat: DateTimeUtil.dateTimeFormat4
    );

    startDate.text=DateTimeUtil.formatDateToLocal(event.startDateTime!+"Z",
        inputDateTimeFormat: DateTimeUtil.serverDateTimeFormat3,
        outputDateTimeFormat: DateTimeUtil.dateTimeFormat6
    );

    endDate.text=DateTimeUtil.formatDateToLocal(event.endDateTime!+"Z",
        inputDateTimeFormat: DateTimeUtil.serverDateTimeFormat3,
        outputDateTimeFormat: DateTimeUtil.dateTimeFormat6
    );
    maleFree.value=event.maleFee!;
    if(!event.maleFee!){
      maleAmount.text=event.maleAmount.toString();
    }

    femaleFree.value=event.femaleFee!;
    if(!event.femaleFee!){
      femaleAmount.text=event.femaleAmount.toString();
    }

    if(event.eventCategory != Constants.CATEGORY_HOUSE_PARTY){
      getBusinessDetail(event.partnerId!);
    }
    location.text = event.location?.address??"";

    this.event=EventModel(
      eventType: event.eventType,
      maxCapacity: event.maxParticipants!>=10000?false:true,
      maxParticipants: event.maxParticipants,
      restrict1: event.restrict1,
      maxGuest: event.maxGuest,
      push: event.push,
      eventCategory: event.eventCategory,
      ownCode: event.ownCode,
      partyCode: event.partyCode,
      stopBooking: event.stopBooking,
      cancelPolicy: event.cancelPolicy,
      allowPayments: event.allowPayments,
      cashApp: event.cashApp,
      venmo: event.venmo,
      benifitPay: event.benifitPay,
      entertainment: event.entertainment,
      location: event.location,
    );

  }

  void setModel(EventModel event){
    var event2=this.event2!;

    event2.name=event.name;
    event2.eventProfile=event.eventProfile;
    event2.note=event.note;
    event2.startDateTime=DateTime.parse(event.startDateTime!+"Z").toLocal().toString();
    event2.endDateTime=DateTime.parse(event.endDateTime!+"Z").toLocal().toString();
    event2.maleFee=event.maleFee;
    event2.maleAmount=event.maleAmount;
    event2.femaleFee=event.femaleFee;
    event2.femaleAmount=event.femaleAmount;
    event2.location=event.location;
    event2.maxCapacity=event.maxCapacity;
    event2.maxParticipants=event.maxParticipants;
    event2.restrict1=event.restrict1;
    event2.maxGuest=event.maxGuest;
    event2.push=event.push;
    event2.eventType=event.eventType;
    event2.ownCode=event.ownCode;
    event2.partyCode=event.partyCode;
    event2.stopBooking=event.stopBooking;
    event2.cancelPolicy=event.cancelPolicy;
    event2.allowPayments=event.allowPayments;
    event2.cashApp=event.cashApp;
    event2.venmo= event.venmo;
    event2.benifitPay=event.benifitPay;
    event2.entertainment=event.entertainment;

  }

  void camera(String val) async {
    final XFile? photo = await _picker.pickImage(source: val == "take" ? ImageSource.camera
        : ImageSource.gallery,imageQuality: AppInteger.IMAGE_QUALITY);
    if (photo != null) {

      Util.compressFile(photo).then((value) {
        coverImage.value = Media(value: value!.path,imageType: ImageType.TYPE_FILE);
      });
      // event.image=photo.path;
    } else {
      print('No image selected.');
    }
  }

  bool validateFields(){
    bool val = true;
    if (coverImage.value.value.isEmpty) {
      val=false;
      Util.showToast("${AppStrings.txtUploadCoverImage} ${AppStrings.txtCannotBeEmpty}", error: true);
    }
    else if(startDate.value == endDate.value){
      if(DateTimeUtil.timeDifference12(start_time.text,end_time.text)<3600){
        val=false;
        Util.showToast("Duration should be atleast 1 hour", error: true);
      }
    }
    else if(event.allowPayments! &&
        ((event.venmo??"").isEmpty && (event.cashApp??"").isEmpty && (event.benifitPay??"").isEmpty)){
      val=false;
      Util.showToast("Please add at least one payment method.", error: true);
    }
    else if(event.eventType==EventModel.TYPE_PRIVATE && (event.partyCode==null || event.partyCode!.isEmpty)){
      val=false;
      Util.showToast("Party code cannot empty on private party", error: true);
    }
    else if(event.maxParticipants==null || event.maxParticipants!<=0){
      val=false;
      Util.showToast("Max participants must be greater than 0", error: true);
    }
    return val;

  }

  Future<bool> switchAction() async{
    bool stat=true;
    if (validateFields()) {

      EasyLoading.show(
        status: 'Please Wait . . .',
        indicator: CupertinoActivityIndicator(
          color: AppColors.whiteText,
          radius: SizeConfig.screenWidth * 0.05,
        ),
      );
      List<String> temoImagesURL = await addDoc(coverImage.value);
      print("image path: $temoImagesURL");
      if (temoImagesURL.isNotEmpty) {
        Map<String, dynamic> body = {
          "name": title.text, // Event Title
          "eventProfile": temoImagesURL[0], // Cover Image
          "note": description.text, // Description
          "admissionFee": {
            "male": {"free": maleFree.value, "amount": !maleFree.value ? double.parse(maleAmount.text) : 0},
            "female": {"free": femaleFree.value, "amount": !femaleFree.value ? double.parse(femaleAmount.text) : 0}
          }, // Ticket Price
          "place": event.location!.address, // Location
          "location": {
            "type": "Point",
            "coordinates": [event.location!.coordinates![0], event.location!.coordinates![1]],
            "radius": "50"
          },
          if(arguments[Constants.paramFrom] != Constants.CATEGORY_HOUSE_PARTY) "partnerId": edit?businessDetailModel.value.sId:selectedBusiness!.id, // Bar/Club ID, Required if Event Category is Club or Bar
          "maxParticipants": event.maxParticipants.toString(),
          "maxGuest": (event.maxGuest?.value.toString()) ?? "0",
          "eventType": event.eventType,
          "entrenceCode": [],
          "stopBooking": (event.stopBooking?.value.toString()) ?? "0",
          "cancelationPolicy": (event.cancelPolicy?.value.toString()) ?? "0",
          "entertainment": event.entertainment??[],
          "reminder": "12",
          "cashApp": event.cashApp ?? "",
          "venmo": event.venmo ?? "",
          "benifitPay": event.benifitPay ?? "",

          "startDateTime": DateTimeUtil.formatDateInUTC("${startDate.text} ${start_time.text}",
              inputDateTimeFormat: "${DateTimeUtil.dateTimeFormat6} ${DateTimeUtil.dateTimeFormat4}",
              outputDateTimeFormat: DateTimeUtil.serverDateTimeFormat2),

          "endDateTime": DateTimeUtil.formatDateInUTC("${endDate.text} ${end_time.text}",
              inputDateTimeFormat: "${DateTimeUtil.dateTimeFormat6} ${DateTimeUtil.dateTimeFormat4}",
              outputDateTimeFormat: DateTimeUtil.serverDateTimeFormat2),

          "eventCategory": event.eventCategory,
        };
        if (event.eventType==EventModel.TYPE_PRIVATE) {
          (body["entrenceCode"] as List).add(event.partyCode);
        }
        log("create event body: ${jsonEncode(body)}");
        if(!edit) {
          var event = await onCreateEvent(body);
          if(event!=null){
            stat=false;
            AppNavigator.navigateToNamed(AppRoutes.createPartySuccess,arguments: {Constants.paramFrom:event});
          }
        }
        else{
          var event = await onUpdateEvent(event2!.sId!,body);
          if(event!=null){
            stat=false;
            setModel(event);
            Get.back();
          }
        }
      }
      stat=false;
      EasyLoading.dismiss();
    }else{
      stat=false;
    }
    return stat;
  }

  Future<List<String>> addDoc(Media media,) async{
    List<String> list=[];
    if(media.imageType==ImageType.TYPE_FILE) {
      list = await onUploadPicture(imageFileList: [coverImage.value.value]);
    }
    else if(media.imageType==ImageType.TYPE_NETWORK){
      list.add(media.value);
    }
    return list;
  }

}
