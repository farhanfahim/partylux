// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/constants.dart';
import 'package:partylux/Modules/create_business/model/become_partner_model.dart';
import 'package:partylux/Utils/navigation.dart';
import '../../../Constants/app_routes.dart';
import '../../../Utils/Network/tost.dart';
import '../../../Utils/Util.dart';
import '../../BecomePartner/Service/becomepartner_serivece.dart';
import '../../My Business/Model/business_detail_model.dart';
import '../../create_flyer/model/checkbox_item.dart';
import '../model/timing_model.dart';

class CreateBusinessViewModel extends GetxController with BecomePartnerService {


  Rx<TextEditingController> clubNameController = TextEditingController().obs;
  Rx<TextEditingController> clubTypeController = TextEditingController().obs;
  Rx<TextEditingController> locationController = TextEditingController().obs;
  Rx<TextEditingController> admissionFeeController = TextEditingController().obs;
  Rx<TextEditingController> musicController = TextEditingController().obs;
  Rx<TextEditingController> entertainmentController = TextEditingController().obs;
  Rx<TextEditingController> maxCapacityController = TextEditingController().obs;
  Rx<TextEditingController> ageLimitController = TextEditingController().obs;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  Rx<TextEditingController> confirmPassword = TextEditingController().obs;
  Rx<TextEditingController> facebookController = TextEditingController().obs;
  Rx<TextEditingController> instaController = TextEditingController().obs;
  Rx<TextEditingController> snapchatController = TextEditingController().obs;
  Rx<TextEditingController> descController = TextEditingController().obs;

  RxBool obscureText2 = true.obs;
  RxBool obscureText = true.obs;

  FocusNode clubNameNode = FocusNode();
  FocusNode clubTypeNode = FocusNode();
  FocusNode locationNode = FocusNode();
  FocusNode admissionFeeNode = FocusNode();
  FocusNode musicNode = FocusNode();
  FocusNode entertainmentNode = FocusNode();
  FocusNode maxCapacityNode = FocusNode();
  FocusNode ageLimitNode = FocusNode();
  FocusNode descNode = FocusNode();

  List<CheckboxItem> listOfType = [];
  List<CheckboxItem> listOfMusic = [];
  List<CheckboxItem> listOfEntertainment = [];
  List<TimingModel> listOfTiming = [];

  Rx<File> IDImage = File("").obs;
  RxBool isLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  RxList<String> arrOfImage = List<String>.empty().obs;

  Rx<BecomePartnerModel> createBecomePartner = BecomePartnerModel().obs;

  Rx<BusinessDetailModel>? model = BusinessDetailModel().obs;

  RxString viewType = "".obs;
  RxBool isEditFalse = false.obs;
  @override
  void onInit() {
    super.onInit();



    listOfType.add(CheckboxItem(title: Constants.CATEGORY_CLUB, selected: false.obs));
    listOfType.add(CheckboxItem(title: Constants.CATEGORY_BAR, selected: false.obs));
    listOfType.add(CheckboxItem(title: Constants.CATEGORY_BEACH, selected: false.obs));

    listOfTiming.add(TimingModel(isClose: true.obs, title: Weekdays.Monday,startTime: "".obs,endTime: "".obs,isSameTimeEnable:false.obs,startTimeUTC: DateTime.now().toUtc().obs,endTimeUTC: DateTime.now().toUtc().obs));
    listOfTiming.add(TimingModel(isClose: true.obs, title:Weekdays.Tuesday,startTime: "".obs,endTime: "".obs,isSameTimeEnable:false.obs,startTimeUTC: DateTime.now().toUtc().obs,endTimeUTC: DateTime.now().toUtc().obs));
    listOfTiming.add(TimingModel(isClose: true.obs, title:Weekdays.Wednesday,startTime: "".obs,endTime: "".obs,isSameTimeEnable:false.obs,startTimeUTC: DateTime.now().toUtc().obs,endTimeUTC: DateTime.now().toUtc().obs));
    listOfTiming.add(TimingModel(isClose: true.obs, title: Weekdays.Thursday,startTime: "".obs,endTime: "".obs,isSameTimeEnable:false.obs,startTimeUTC: DateTime.now().toUtc().obs,endTimeUTC: DateTime.now().toUtc().obs));
    listOfTiming.add(TimingModel(isClose: true.obs, title:Weekdays.Friday,startTime: "".obs,endTime: "".obs,isSameTimeEnable:false.obs,startTimeUTC: DateTime.now().toUtc().obs,endTimeUTC: DateTime.now().toUtc().obs));
    listOfTiming.add(TimingModel(isClose: true.obs, title: Weekdays.Saturday,startTime: "".obs,endTime: "".obs,isSameTimeEnable:false.obs,startTimeUTC: DateTime.now().toUtc().obs,endTimeUTC: DateTime.now().toUtc().obs));
    listOfTiming.add(TimingModel(isClose: true.obs, title: Weekdays.Sunday,startTime: "".obs,endTime: "".obs,isSameTimeEnable:false.obs,startTimeUTC: DateTime.now().toUtc().obs,endTimeUTC: DateTime.now().toUtc().obs));

    listOfMusic.add(CheckboxItem(title: "all", selected: false.obs));
    listOfMusic.add(CheckboxItem(title: "edm", selected: false.obs));
    listOfMusic.add(CheckboxItem(title: "hip hop", selected: false.obs));
    listOfMusic.add(CheckboxItem(title: "rap", selected: false.obs));
    listOfMusic.add(CheckboxItem(title: "pop", selected: false.obs));
    listOfMusic.add(CheckboxItem(title: "rock", selected: false.obs));

    listOfEntertainment.add(CheckboxItem(title: "all", selected: false.obs));
    listOfEntertainment.add(CheckboxItem(title: "Billiards", selected: false.obs));
    listOfEntertainment.add(CheckboxItem(title: "ping pong", selected: false.obs));
    listOfEntertainment.add(CheckboxItem(title: "bear", selected: false.obs));
    listOfEntertainment.add(CheckboxItem(title: "card", selected: false.obs));
    listOfEntertainment.add(CheckboxItem(title: "darts", selected: false.obs));
    listOfEntertainment.add(CheckboxItem(title: "live dj", selected: false.obs));

    var arguments = Get.arguments;

    if(arguments !=null) {
      viewType.value = Get.arguments[0];
      if(Get.arguments[1] !=null) {
        model!.value = Get.arguments[1];
        onSetData();
        isEditFalse.value = true;
      }
    }



  }

  onSetData(){
    clubNameController.value.text = model!.value.bussinessName!;
    locationController.value.text = model!.value.place!;
    clubTypeController.value.text = model!.value.bussinessCategory!;
    maxCapacityController.value.text = model!.value.maxParticipants!.toString();
   // ageLimitController.value.text = model!.value.ageLimit!;
    descController.value.text = model!.value.note!;

    createBecomePartner.value.location = Location(
      type : "Point",
      coordinates: [model!.value.location!.coordinates![0],model!.value.location!.coordinates![1]],
      radius: "50",
    );

    for(var item in listOfType){
      if(item.title == model!.value.bussinessCategory!){
        item.selected.value = true;
      }
    }

    Set<String> musicSet = Set<String>.from(model!.value.music!);
    for (var item in listOfMusic) {
      if (musicSet.contains(item.title)) {
        item.selected.value = true;
        musicController.value.text += item.title;
      }
    }

    if(model!.value.entertainment!.isNotEmpty) {
      entertainmentController.value.text = model!.value.entertainment![0];
    }

    listOfTiming.forEach((item) {
      model!.value.businessWeek!.where((subItem) =>
      subItem.bussinessDay == item.title.name.toLowerCase()).forEach((subItem) {

        item.isClose.value = subItem.isClose!;
        if( subItem.startTime!.isNotEmpty) {
         String formattedDateTimeString = subItem.startTime!.substring(0, 19);

         item.startTime!.value = DateTime.parse(formattedDateTimeString+"Z").toLocal().toString();
         item.startTimeUTC!.value = DateTime.parse(formattedDateTimeString+"Z");
         print("frhn");
         print(item.startTime!.value);
         print(item.startTimeUTC!.value);
        }
        if( subItem.endTime!.isNotEmpty) {
           String formattedDateTimeString = subItem.endTime!.substring(0, 19);
          item.endTime!.value = DateTime.parse(formattedDateTimeString+"Z").toLocal().toString();
           item.endTimeUTC!.value = DateTime.parse(formattedDateTimeString+"Z");
        }
      });
    });


    for(var item in model!.value.photos!){
      arrOfImage.add(item);
    }

    admissionFeeController.value.text = model!.value.admissionFee!.male!.amount.toString();

    for (var item in model!.value.social!) {
      switch (item.type) {
        case "facebook":
          facebookController.value.text = item.url!;
          break;
        case "instagram":
          instaController.value.text = item.url!;
          break;
        case "snapchat":
          snapchatController.value.text = item.url!;
          break;
        default:
        // Handle other social media types if needed
          break;
      }
    }

  }

  onCreateBusinessAccount() async {
    if (formKey.currentState!.validate()) {
      if(checkTiming()) {
        if(arrOfImage.isNotEmpty) {

          createBecomePartner.value.username = clubNameController.value.text;
          createBecomePartner.value.email = email.value.text;
          createBecomePartner.value.password = password.value.text;
          createBecomePartner.value.bussinessName = clubNameController.value.text;
          createBecomePartner.value.place = locationController.value.text;
          createBecomePartner.value.bussinessCategory = clubTypeController.value.text.toLowerCase();
          createBecomePartner.value.maxParticipants = int.parse(maxCapacityController.value.text);
         // createBecomePartner.value.ageLimit = ageLimitController.value.text;
          createBecomePartner.value.cancelationPolicy = "24 hrs";
          createBecomePartner.value.note = descController.value.text;
          createBecomePartner.value.disclaimer = [""];


          ///List of Music
          RxList<String> arrOfMusic = List<String>.empty().obs;
          for(var item in listOfMusic){
            if(item.selected.value){
              arrOfMusic.add(item.title);
            }
          }
          createBecomePartner.value.music = arrOfMusic;

         /* ///List of Entertainment
          RxList<String> arrOfEntertainment = List<String>.empty().obs;
          for(var item in listOfEntertainment){
            if(item.selected.value){
              arrOfEntertainment.add(item.title);
            }
          }*/
          createBecomePartner.value.entertainment = [entertainmentController.value.text];

          int admissionFee = int.parse(admissionFeeController.value.text.replaceAll(RegExp(r"[^\w\s]"), ""));
          ///Admission fee
          createBecomePartner.value.admissionFee = AdmissionFee(
            male : Male(free: admissionFee>0?false:true,amount: admissionFee),
            female : Male(free: admissionFee>0?false:true,amount: admissionFee),
          );

          ///Business hours
          RxList<BusinessWeek> arrOfBusinessTiming = List<BusinessWeek>.empty().obs;
          for(var item in listOfTiming){
            arrOfBusinessTiming.add(
              BusinessWeek(
                  isClose: item.isClose.value,
                  bussinessDay: item.title.name.toLowerCase(),
                  startTime: item.startTime!.value.isNotEmpty?item.startTimeUTC!.value.toString():"",
                  endTime: item.endTime!.value.isNotEmpty?item.endTimeUTC!.value.toString():""
              )
            );
          }

          createBecomePartner.value.businessWeek = arrOfBusinessTiming;

          ///Social links
          RxList<Social> arrOfSocial = List<Social>.empty().obs;
          if(facebookController.value.text.isNotEmpty){
            arrOfSocial.add(Social(type: "facebook",url: facebookController.value.text));
          }
          if(instaController.value.text.isNotEmpty){
            arrOfSocial.add(Social(type: "instagram",url: instaController.value.text));
          }
          if(snapchatController.value.text.isNotEmpty){
            arrOfSocial.add(Social(type: "snapchat",url: snapchatController.value.text));
          }
          createBecomePartner.value.social = arrOfSocial;

          ///List of images
          await uploadEventImages();

          log(jsonEncode(createBecomePartner.value.toJson()));
          bool result = await onCreateBusiness(((createBecomePartner.value.toJson())),"register");

          if (result) {
            isLoading.value = false;
            AppNavigator.navigateToNamed(AppRoutes.successView,arguments: {
              Constants.paramType:Constants.PUSH_BUSINESS,
            });
          } else {
            isLoading.value = false;
          }
        }else{
          Toast().error(massage: "Images are required");
        }
      }else{
        Toast().error(massage: "Open Timings are required");
      }
    }

  }

  onCreateOrUpdateClubBar(bool isEdit) async {
    if (formKey.currentState!.validate()) {
      if(checkTiming()) {
        if(arrOfImage.isNotEmpty) {

          createBecomePartner.value.bussinessName = clubNameController.value.text;
          createBecomePartner.value.place = locationController.value.text;
          createBecomePartner.value.bussinessCategory = clubTypeController.value.text.toLowerCase();
          createBecomePartner.value.maxParticipants = int.parse(maxCapacityController.value.text);
         //createBecomePartner.value.ageLimit = ageLimitController.value.text;
          createBecomePartner.value.cancelationPolicy = "24 hrs";
          createBecomePartner.value.note = descController.value.text;


          ///List of Music
          RxList<String> arrOfMusic = List<String>.empty().obs;
          for(var item in listOfMusic){
            if(item.selected.value){
              arrOfMusic.add(item.title);
            }
          }
          createBecomePartner.value.music = arrOfMusic;

          ///List of Entertainment
        /*  RxList<String> arrOfEntertainment = List<String>.empty().obs;
          for(var item in listOfEntertainment){
            if(item.selected.value){
              arrOfEntertainment.add(item.title);
            }
          }
          createBecomePartner.value.entertainment = arrOfEntertainment;*/
          createBecomePartner.value.entertainment = [entertainmentController.value.text];

          int admissionFee = int.parse(admissionFeeController.value.text.replaceAll(RegExp(r"[^\w\s]"), ""));
          ///Admission fee
          createBecomePartner.value.admissionFee = AdmissionFee(
            male : Male(free: admissionFee>0?false:true,amount: admissionFee),
            female : Male(free: admissionFee>0?false:true,amount: admissionFee),
          );

          ///Business hours
          RxList<BusinessWeek> arrOfBusinessTiming = List<BusinessWeek>.empty().obs;
          for(var item in listOfTiming){
            arrOfBusinessTiming.add(
                BusinessWeek(
                    isClose: item.isClose.value,
                    bussinessDay: item.title.name.toLowerCase(),
                    startTime: item.startTime!.value.isNotEmpty?item.startTimeUTC!.value.toString():"",
                    endTime: item.endTime!.value.isNotEmpty?item.endTimeUTC!.value.toString():""
                )
            );
          }

          createBecomePartner.value.businessWeek = arrOfBusinessTiming;

          ///Social links
          RxList<Social> arrOfSocial = List<Social>.empty().obs;
          if(facebookController.value.text.isNotEmpty){
            arrOfSocial.add(Social(type: "facebook",url: facebookController.value.text));
          }
          if(instaController.value.text.isNotEmpty){
            arrOfSocial.add(Social(type: "instagram",url: instaController.value.text));
          }
          if(snapchatController.value.text.isNotEmpty){
            arrOfSocial.add(Social(type: "snapchat",url: snapchatController.value.text));
          }
          createBecomePartner.value.social = arrOfSocial;

          ///List of images
          await uploadEventImages();

          log(jsonEncode(createBecomePartner.value.toJson()));
           await isEdit
              ?onUpdateBusiness(createBecomePartner.value.toJson(),eventId:model!.value.sId!).then((value) {
             if (value) {
               isLoading.value = false;
               Get.back(result: value);
             } else {
               isLoading.value = false;
             }
           })
              :onCreateBusiness((createBecomePartner.value.toJson()),"club").then((value){

             if (value) {
               isLoading.value = false;
               Util.showAlert(
                   title: "Submitted successfully!",
                   subTitle: "Once Admin Approved you can manage your club/bar .");
               Timer(const Duration(milliseconds: 3000), () {

               });
             } else {
               isLoading.value = false;
             }
           });

        }else{
          Toast().error(massage: "Images are required");
        }
      }else{
        Toast().error(massage: "Open Timings are required");
      }
    }

  }

  uploadEventImages() async {
    isLoading.value = true;
    List<String> imagesURL = await onUploadPicture(imageFileList: arrOfImage.value);
    createBecomePartner.value.photos = imagesURL;
    createBecomePartner.value.businessProfile = imagesURL.isNotEmpty ? imagesURL[0] : "";
    print("upload ImagesURL Length ${imagesURL.length}");
  }


  bool checkTiming(){
    var isValid = true;
    for(var item in listOfTiming){
      if(!item.isClose.value){
        if(item.startTime!.value.isNotEmpty && item.endTime!.value.isNotEmpty){
          isValid = true;
        }else{
          isValid = false;
        }
      }
    }
    return isValid;

  }

}




enum Weekdays {
  Sunday,
  Monday,
  Tuesday,
  Wednesday,
  Thursday,
  Friday,
  Saturday,
}
