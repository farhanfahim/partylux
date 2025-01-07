// ignore_for_file: invalid_use_of_protected_member

import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/BecomePartner/Model/become_partner_model.dart';
import 'package:partylux/Modules/BecomePartner/Service/becomepartner_serivece.dart';
import 'package:partylux/Modules/BecomePartner/VIew/add_business_timing.dart';
import 'package:partylux/Modules/Create%20Module/View%20Model/google_map_vm.dart';
import 'package:partylux/Modules/Create%20Module/View/Components/create_event_popup.dart';
import 'package:partylux/Modules/Profile%20Module/Profile%20Section/Model/google_map_model.dart';
import 'package:partylux/Modules/Profile%20Module/Profile%20Section/Service/google_map_service.dart';
import 'package:partylux/Utils/Network/tost.dart';
import 'package:partylux/Utils/Theme/app_config.dart';

import '../../../Constants/strings.dart';
import '../../../Utils/Common/custom_location_dialog.dart';
import '../Model/business_card_model.dart';

class BecomePartnerViewModel extends GetxController with BecomePartnerService {
  LocationPermission? permission;
  final _googleMapVM = Get.isRegistered<PlacesSearchViewModel>()
      ? Get.find<PlacesSearchViewModel>()
      : Get.put(PlacesSearchViewModel());

  Rx<BecomePartnerModel> createBecomePartner =
      BecomePartnerModel.fromEmpty().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // Future.delayed(const Duration(seconds: 2), () {
    getCurrentLocation();
    // Get.offNamed(AppRoutes.ticketDetailView);
    // });
  }

  void getCurrentLocation() async {
    permission = await Geolocator.checkPermission();
    if (permission != LocationPermission.denied) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print("First Time =>> ${position.latitude}  ${position.longitude}");
      currentlat.value = position.latitude;
      currentlng.value = position.longitude;
    } else {
      showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (context){
            return CustomLocationDialog(
              content: AppStrings.locationContent,
              onAccept: () async {
                permission = await Geolocator.requestPermission();
                Position position = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high);
                print("First Time =>> ${position.latitude}  ${position.longitude}");
                currentlat.value = position.latitude;
                currentlng.value = position.longitude;
                Get.back();
              },onReject:(){
              Get.back();
            }
            );
          });


    }
  }

  RxList<PlaceSearch> placesListData = <PlaceSearch>[].obs;
  Rx<PlaceSearch> selectedLocation = PlaceSearch().obs;
  PlaceModel? placeDetail;
  void autocomplete(val) async {
    print("autocomplete $val");
    placesListData.value = await _googleMapVM.searchPerdictions(
      val,
      lat: "28.4212",
      lng: "70.2989",
    );
  }

  void setPlace(PlaceSearch placesData) async {
    selectedLocation.value = placesData;
    FocusManager.instance.primaryFocus?.unfocus();
    placesListData.value = <PlaceSearch>[];

    placeDetail =
        await GooglePlaceHandler().placeDetailSearch(placesData.placeId);
    // latlng.add(placeDetail!.lat);
    // latlng.add(placeDetail!.lng);
    // businessAddress.value.text = placeDetail!.formatted_address;
    print("placeDetail!.formatted_address ${placesData.placeId} =>>" +
        placeDetail!.formatted_address.toString());
  }

  ///
  ///
  ///
  /// Add Business Detail View Data Collect
  ///
  ///
  ///
  ///
  Rx<TextEditingController> businessName = TextEditingController().obs;
  Rx<TextEditingController> businessDescription = TextEditingController().obs;
  Rx<TextEditingController> businessAddress = TextEditingController().obs;
  Rx<TextEditingController> businessLat = TextEditingController().obs;
  Rx<TextEditingController> businessLong = TextEditingController().obs;
  RxString businessType = "club".obs;
  RxList<double> latlng = <double>[].obs;
  RxDouble currentlat = 0.0.obs;
  RxDouble currentlng = 0.0.obs;
  final formKey = GlobalKey<FormState>();

  void addbusinessDetailMethod() {
    if (formKey.currentState!.validate()) {
      if (businessAddress.value.text.isEmpty) {
        Toast().error(massage: "Please again select your Location");
        return;
      }
      latlng.value = [];
      latlng.add(double.parse(businessLat.value.text));
      latlng.add(double.parse(businessLong.value.text));
      latlng.refresh();
      createBecomePartner.value.bussinessName = businessName.value.text;
      createBecomePartner.value.bussinessCategory = businessType.value;
      createBecomePartner.value.note = businessDescription.value.text;
      createBecomePartner.value.place = businessAddress.value.text;
      createBecomePartner.value.location = BusinessLocation(
        coordinates: latlng.value,
      );
      Get.toNamed(AppRoutes.addBussinesDetailView);
    }
  }

  void onLocatioSubmit() async {
    String data = await getLocationName(currentlat.value, currentlng.value);
    businessAddress.value.text = data;
    businessLat.value.text = currentlat.value.toString();
    businessLong.value.text = currentlng.value.toString();
    // latlng.value = [];
    // latlng.add(currentlat.value);
    // latlng.add(currentlng.value);
    businessAddress.refresh();

    Get.back();
  }

  ///
  ///
  ///
  /// Add Business Graphic data
  ///
  ///
  ///
  ///
  ///
// Pick Multi Image Gallery Open Method
  // RxList<File> imagesList = <File>[].obs;
  RxList<String> imagesPathList = <String>[].obs;
  final ImagePicker _picker = ImagePicker();
  void getEventImage() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      imagesPathList.value
          .addAll(images.asMap().entries.map((it) => it.value.path).toList());
      imagesPathList.refresh();
    } else {
      print('No image selected.');
    }
  }

  void addBusinessGraphicMethod() {
    if (imagesPathList.isEmpty) {
      Toast().error(massage: "Please Select Business Attachments");
      return;
    }

    Get.toNamed(AppRoutes.addBusinessTiming);
  }

  ///
  ///
  ///
  /// Add Business Timing Schedule
  ///
  ///
  ///
  ///

  RxBool isClose1 = false.obs;
  RxString bussinessDay1 = Weekdays.Saturday.name.obs;
  RxString startTime1 = "".obs;
  RxString endTime1 = "".obs;

  RxBool isClose2 = false.obs;
  RxString bussinessDay2 = Weekdays.Sunday.name.obs;
  RxString startTime2 = "".obs;
  RxString endTime2 = "".obs;

  RxBool isClose3 = false.obs;
  RxString bussinessDay3 = Weekdays.Monday.name.obs;
  RxString startTime3 = "".obs;
  RxString endTime3 = "".obs;

  RxBool isClose4 = false.obs;
  RxString bussinessDay4 = Weekdays.Tuesday.name.obs;
  RxString startTime4 = "".obs;
  RxString endTime4 = "".obs;

  RxBool isClose5 = false.obs;
  RxString bussinessDay5 = Weekdays.Wednesday.name.obs;
  RxString startTime5 = "".obs;
  RxString endTime5 = "".obs;

  RxBool isClose6 = false.obs;
  RxString bussinessDay6 = Weekdays.Thursday.name.obs;
  RxString startTime6 = "".obs;
  RxString endTime6 = "".obs;

  RxBool isClose7 = false.obs;
  RxString bussinessDay7 = Weekdays.Friday.name.obs;
  RxString startTime7 = "".obs;
  RxString endTime7 = "".obs;

  void addbusinessTimingMethod() {
    if (!isClose1.value) {
      if (startTime1.value.isEmpty || endTime1.value.isEmpty) {
        Toast()
            .error(massage: "Please Select ${Weekdays.Saturday.name} Timing");
        return;
      }
    }
    if (!isClose2.value) {
      if (startTime2.value.isEmpty || endTime2.value.isEmpty) {
        Toast().error(massage: "Please Select ${Weekdays.Sunday.name} Timing");
        return;
      }
    }
    if (!isClose3.value) {
      if (startTime3.value.isEmpty || endTime3.value.isEmpty) {
        Toast().error(massage: "Please Select ${Weekdays.Monday.name} Timing");
        return;
      }
    }

    if (!isClose4.value) {
      if (startTime4.value.isEmpty || endTime4.value.isEmpty) {
        Toast().error(massage: "Please Select ${Weekdays.Tuesday.name} Timing");
        return;
      }
    }
    if (!isClose5.value) {
      if (startTime5.value.isEmpty || endTime5.value.isEmpty) {
        Toast()
            .error(massage: "Please Select ${Weekdays.Wednesday.name} Timing");
        return;
      }
    }
    if (!isClose6.value) {
      if (startTime6.value.isEmpty || endTime6.value.isEmpty) {
        Toast()
            .error(massage: "Please Select ${Weekdays.Thursday.name} Timing");
        return;
      }
    }
    if (!isClose7.value) {
      if (startTime7.value.isEmpty || endTime7.value.isEmpty) {
        Toast().error(massage: "Please Select ${Weekdays.Friday.name} Timing");
        return;
      }
    }

    createBecomePartner.value.businessWeek = [
      BusinessWeek(
        isClose: isClose1.value,
        bussinessDay: bussinessDay1.value.toLowerCase(),
        startTime: startTime1.value,
        endTime: endTime1.value,
      ),
      BusinessWeek(
        isClose: isClose2.value,
        bussinessDay: bussinessDay2.value.toLowerCase(),
        startTime: startTime2.value,
        endTime: endTime2.value,
      ),
      BusinessWeek(
        isClose: isClose3.value,
        bussinessDay: bussinessDay3.value.toLowerCase(),
        startTime: startTime3.value,
        endTime: endTime3.value,
      ),
      BusinessWeek(
        isClose: isClose4.value,
        bussinessDay: bussinessDay4.value.toLowerCase(),
        startTime: startTime4.value,
        endTime: endTime4.value,
      ),
      BusinessWeek(
        isClose: isClose5.value,
        bussinessDay: bussinessDay5.value.toLowerCase(),
        startTime: startTime5.value,
        endTime: endTime5.value,
      ),
      BusinessWeek(
        isClose: isClose6.value,
        bussinessDay: bussinessDay6.value.toLowerCase(),
        startTime: startTime6.value,
        endTime: endTime6.value,
      ),
      BusinessWeek(
        isClose: isClose7.value,
        bussinessDay: bussinessDay7.value.toLowerCase(),
        startTime: startTime7.value,
        endTime: endTime7.value,
      ),
    ];

    Get.toNamed(AppRoutes.addBusinessAdmissionFee);
  }

  ///
  ///
  ///
  /// Add Business Admission Fee
  ///
  ///
  ///
  ///
  ///
  RxBool isMaleFree = true.obs;
  Rx<TextEditingController> maleAmount = TextEditingController().obs;
  RxBool isFemaleFree = true.obs;
  Rx<TextEditingController> femaleAmount = TextEditingController().obs;

  void addBusinessAdmissionFeeMethod() {
    if (!isMaleFree.value && maleAmount.value.text.isEmpty) {
      Toast().error(massage: "Please Enter Amount for Male");
      return;
    }
    if (!isFemaleFree.value && femaleAmount.value.text.isEmpty) {
      Toast().error(massage: "Please Enter Amount for Female");
      return;
    }

    AdmissionFee admissionFee = AdmissionFee.fromEmpty();
    admissionFee.male = Male(
      free: isMaleFree.value,
      amount: !isMaleFree.value ? int.parse(maleAmount.value.text) : 0,
    );
    admissionFee.female = Male(
      free: isFemaleFree.value,
      amount: !isFemaleFree.value ? int.parse(femaleAmount.value.text) : 0,
    );

    createBecomePartner.value.admissionFee = admissionFee;

    Get.toNamed(AppRoutes.addBusinessEssentails);
  }

  ///
  ///
  ///
  ///
  /// Add Business Essentail
  ///
  ///
  ///
  ///
  ///

  RxList<String> musicList = <String>[].obs;
  RxList<String> entertainmentList = <String>[].obs;
  RxList<String> disclaimerList = <String>[].obs;
  RxString ageLimit = "".obs;

  void addBusinessEssentailMethod() {
    if (musicList.length < 1) {
      Toast().error(massage: "Please select music essential");
      return;
    }
    if (entertainmentList.length < 1) {
      Toast().error(massage: "Please select Entertainment essential");
      return;
    }
    if (disclaimerList.length < 1) {
      Toast().error(massage: "Please select Disclaimer essential");
      return;
    }
    if (ageLimit.value.isEmpty) {
      Toast().error(massage: "Please select age limit");
      return;
    }

    print("Success fully");
    createBecomePartner.value.music = musicList.value;
    createBecomePartner.value.entertainment = entertainmentList.value;
    createBecomePartner.value.disclaimer = disclaimerList.value;
    createBecomePartner.value.ageLimit = ageLimit.value;
    Get.toNamed(AppRoutes.addBusinessAttendence);
  }

  ///
  ///
  ///
  ///
  /// Add Business attendence
  ///
  ///
  ///
  ///
  ///

  RxString maximumAttendance = "0-25 people".obs;

  void addBusinessAttendanceMethod(
    BuildContext context,
  ) {
    if (maximumAttendance.value.isEmpty) {
      Toast().error(massage: "Please select party attendance");
      return;
    }
    print("Success fully");
    createBecomePartner.value.maxParticipants =0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: AlertDialog(
            insetPadding: EdgeInsets.zero,
            actionsPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: Color.fromARGB(255, 71, 8, 100),
            content: CreateEventPopup(
              noCallback: () {
                print("print");
                if (isUpdateBusiness.value) {
                  UodateBusinessUploadData(false, eventId: businessID.value);
                } else {
                  CreateEventUploadData(false);
                }
              },
              yesCallback: () {
                if (isUpdateBusiness.value) {
                  UodateBusinessUploadData(true, eventId: businessID.value);
                } else {
                  CreateEventUploadData(true);
                }
              },
            ),
          ),
        );
      },
    );
  }

  ///
  ///
  ///
  ///
  /// Upload Become a Partner details
  ///
  ///
  ///
  ///
  ///
  RxBool isUploadLoading = false.obs;

  uploadEventImages() async {
    List<String> imagesURL =
        await onUploadPicture(imageFileList: imagesPathList.value);
    createBecomePartner.value.photos = imagesURL;
    createBecomePartner.value.businessProfile =
        imagesURL.isNotEmpty ? imagesURL[0] : "";
    createBecomePartner.value.cancelationPolicy = "24 hrs";
    print("upload ImagesURL Length ${imagesURL.length}");
  }

  void CreateEventUploadData(bool isAddCard) async {
    EasyLoading.show(
      status: 'Please Wait . . .',
      indicator: CupertinoActivityIndicator(
        color: AppColors.whiteText,
        radius: SizeConfig.screenWidth * 0.05,
      ),
    );
    await uploadEventImages();
    var mapdata = await BecomePartnerModel.toJson(createBecomePartner.value);
    print("-=-=-=-=-=-=  $mapdata");

   /* BecomePartnerModel result = await onCreateBusiness(mapdata);

    if (result.bussinessName!.isNotEmpty) {
      createBecomePartner.value = result;
      print("Success fully");
      EasyLoading.dismiss();
      if (isAddCard) {
        Get.toNamed(AppRoutes.addBusinessMultiCard);
      } else {
        Get.offAllNamed(AppRoutes.successfullyCreatedBusiness);
      }
    } else {
      EasyLoading.dismiss();
    }*/
  }

  ///
  ///
  ///
  ///
  /// Updata Business Become a Partner details
  ///
  ///
  ///
  ///
  ///

  void UodateBusinessUploadData(
    bool isAddCard, {
    required String eventId,
  }) async {
    createBecomePartner.value.cancelationPolicy = "24 hrs";
    EasyLoading.show(
      status: 'Please Wait . . .',
      indicator: CupertinoActivityIndicator(
        color: AppColors.whiteText,
        radius: SizeConfig.screenWidth * 0.05,
      ),
    );
    await uploadEventImages();
    var mapdata = await BecomePartnerModel.toJson(createBecomePartner.value);
    print("-=-=-=-=-=-=  $mapdata");

    /*BecomePartnerModel result =
        await onUpdateBusiness(mapdata, eventId: eventId);

    if (result.bussinessName!.isNotEmpty) {
      createBecomePartner.value = result;
      print("Success fully");
      EasyLoading.dismiss();
      if (isAddCard) {
        Get.toNamed(AppRoutes.addBusinessMultiCard);
      } else {
        Get.offAllNamed(AppRoutes.NAV_ROOT);
      }
    } else {
      EasyLoading.dismiss();
    }*/
  }

  ///
  ///
  ///
  ///
  /// add Business cards
  ///
  ///
  ///
  ///
  ///

  Rx<TextEditingController> vipCardName = TextEditingController().obs;
  Rx<TextEditingController> vipCardServices = TextEditingController().obs;
  Rx<TextEditingController> vipCardPrice = TextEditingController().obs;
  RxList<String> vipCardServicesList = <String>[].obs;

  final createCardformKey = GlobalKey<FormState>();
  void addServiceInList() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (vipCardServices.value.text.isNotEmpty) {
      vipCardServicesList.add(vipCardServices.value.text);
      vipCardServices.value.text = "";
      vipCardServicesList.refresh();
    } else {
      Toast().error(massage: "Please Enter Service Name");
    }
  }

  void addCardInCardList() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (createCardformKey.currentState!.validate()) {
      if (vipCardServicesList.length < 1) {
        Toast().error(massage: "Please Add Service");
        return;
      }

      BusinessCard cardDetail = BusinessCard(
        vipcardName: vipCardName.value.text,
        price: int.parse(vipCardPrice.value.text),
        services: vipCardServicesList.value,
      );
      createdEventCards.value.cards.add(cardDetail);
      createdEventCards.refresh();

      vipCardName.value.text = "";
      vipCardPrice.value.text = "";
      vipCardServices.value.text = "";
      vipCardServicesList.value = <String>[];
      // createCardformKey.currentState!.reset();
      print("object ${createdEventCards.value.cards.length}");
      Get.back();
    }
  }

  void removeCardService(String s) {
    vipCardServicesList.value.remove(s);
    vipCardServicesList.refresh();
  }

  ///
  ///
  ///
  ///
  /// Upload Business Card details
  ///
  ///
  ///
  ///
  ///

  RxBool loadingCardUpload = false.obs;

  Rx<CreateBusinessCard> createdEventCards = CreateBusinessCard.fromEmpty().obs;

  void uploadBusinessCards() async {
    if (createdEventCards.value.cards.length < 1) {
      Toast().error(massage: "Please Add VIP card");
      return;
    }
    loadingCardUpload.value = true;
    createdEventCards.value.eventId = createBecomePartner.value.id;

    var mapdata = await CreateBusinessCard.toJson(createdEventCards.value);
    print("object==>> $mapdata");
    var result = await onCreatedBusinessVIPCard(mapdata);
    loadingCardUpload.value = false;
    if (result.id!.isNotEmpty) {
      Get.offAllNamed(AppRoutes.successfullyCreatedBusiness);
    }
  }

  ///
  /// ==> Get Location Name Method Funcation
  ///

  Future<String> getLocationName(double latitude, double longitude) async {
    print("$latitude , $longitude");
    String address = "";
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      print(place);
      if (Platform.isIOS) {
        address =
            "${place.street} ${place.locality!} ${place.administrativeArea} ${place.country!}";
      } else {
        address =
            "${place.street} ${place.subAdministrativeArea!} ${place.administrativeArea} ${place.country!}";
      }
      return address;
    } on PlatformException catch (e) {
      print("Error during geocoding: ${e.message}");
    }
    return address;
  }

  //////////////////////////////////////////////////////////////////
  ///                                                            ///
  ///                                                            ///
  ///                                                            ///
  ///                    Business Edit Method                    ///
  ///                                                            ///
  ///                                                            ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////

  RxBool isUpdateBusiness = false.obs;
  RxString businessID = "".obs;

  void edit_Method(
    BecomePartnerModel data,
  ) {
    isUpdateBusiness.value = true;
    businessID.value = data.id!;

    ///
    ///==>> Business Detail
    ///
    businessName.value = TextEditingController(text: data.bussinessName);
    businessDescription.value = TextEditingController(text: data.note);
    businessAddress.value = TextEditingController(text: data.place);
    businessLat.value =
        TextEditingController(text: data.location!.coordinates![0].toString());
    businessLong.value =
        TextEditingController(text: data.location!.coordinates![1].toString());
    businessType.value = data.bussinessCategory!;
    latlng.value = data.location!.coordinates!;
    currentlat.value = data.location!.coordinates![0];
    currentlng.value = data.location!.coordinates![1];

    ///
    ///==>> Business Graphic
    ///

    imagesPathList.value = data.photos!;

    ///
    ///==>> Business Timing Schedule
    ///

    isClose1.value =
        findWeekObject(Weekdays.Saturday.name, data.businessWeek!).isClose!;
    bussinessDay1.value = Weekdays.Saturday.name;
    startTime1.value =
        findWeekObject(Weekdays.Saturday.name, data.businessWeek!).startTime!;
    endTime1.value =
        findWeekObject(Weekdays.Saturday.name, data.businessWeek!).endTime!;

    isClose2.value =
        findWeekObject(Weekdays.Sunday.name, data.businessWeek!).isClose!;
    bussinessDay2.value = Weekdays.Sunday.name;
    startTime2.value =
        findWeekObject(Weekdays.Sunday.name, data.businessWeek!).startTime!;
    endTime2.value =
        findWeekObject(Weekdays.Sunday.name, data.businessWeek!).endTime!;

    isClose3.value =
        findWeekObject(Weekdays.Monday.name, data.businessWeek!).isClose!;
    bussinessDay3.value = Weekdays.Monday.name;
    startTime3.value =
        findWeekObject(Weekdays.Monday.name, data.businessWeek!).startTime!;
    endTime3.value =
        findWeekObject(Weekdays.Monday.name, data.businessWeek!).endTime!;

    isClose4.value =
        findWeekObject(Weekdays.Tuesday.name, data.businessWeek!).isClose!;
    bussinessDay4.value = Weekdays.Tuesday.name;
    startTime4.value =
        findWeekObject(Weekdays.Tuesday.name, data.businessWeek!).startTime!;
    endTime4.value =
        findWeekObject(Weekdays.Tuesday.name, data.businessWeek!).endTime!;

    isClose5.value =
        findWeekObject(Weekdays.Wednesday.name, data.businessWeek!).isClose!;
    bussinessDay5.value = Weekdays.Wednesday.name;
    startTime5.value =
        findWeekObject(Weekdays.Wednesday.name, data.businessWeek!).startTime!;
    endTime5.value =
        findWeekObject(Weekdays.Wednesday.name, data.businessWeek!).endTime!;

    isClose6.value =
        findWeekObject(Weekdays.Thursday.name, data.businessWeek!).isClose!;
    bussinessDay6.value = Weekdays.Thursday.name;
    startTime6.value =
        findWeekObject(Weekdays.Thursday.name, data.businessWeek!).startTime!;
    endTime6.value =
        findWeekObject(Weekdays.Thursday.name, data.businessWeek!).endTime!;

    isClose7.value =
        findWeekObject(Weekdays.Friday.name, data.businessWeek!).isClose!;
    bussinessDay7.value = Weekdays.Friday.name;
    startTime7.value =
        findWeekObject(Weekdays.Friday.name, data.businessWeek!).startTime!;
    endTime7.value =
        findWeekObject(Weekdays.Friday.name, data.businessWeek!).endTime!;

    ///
    ///==>> Business Admission Fee
    ///

    isMaleFree.value = data.admissionFee!.male!.free!;
    maleAmount.value =
        TextEditingController(text: data.admissionFee!.male!.amount.toString());
    isFemaleFree.value = data.admissionFee!.female!.free!;
    femaleAmount.value = TextEditingController(
        text: data.admissionFee!.female!.amount.toString());

    ///
    ///==>> Business Essentails
    ///

    musicList.value = data.music!;
    entertainmentList.value = data.entertainment!;
    disclaimerList.value = data.disclaimer!;
    ageLimit.value = data.ageLimit!;

    ///
    ///==>> Business Detail
    ///
    maximumAttendance.value = "${data.maxParticipants!} people";
  }

  BusinessWeek findWeekObject(
      String weekName, List<BusinessWeek> businessDays) {
    BusinessWeek filteredDays = businessDays.where((day) {
      return day.bussinessDay!.toLowerCase() == weekName.toLowerCase();
    }).first;
    return filteredDays;
  }

  ///
  ///
  ///
  /// ==> Update  Business State
  ///
  ///
  ///
  ///

  Rx<BecomePartnerModel> businessWeekUpdate =
      BecomePartnerModel.fromEmpty().obs;

  Future<bool> businessStateUpdate({
    required BecomePartnerModel data,
    required bool isClose,
  }) async {
    EasyLoading.show(
      status: 'Please Wait . . .',
      indicator: CupertinoActivityIndicator(
        color: AppColors.whiteText,
        radius: SizeConfig.screenWidth * 0.05,
      ),
    );
    businessWeekUpdate.value.businessWeek =
        conpairBusinessDay(businessDays: data.businessWeek!, isClose: isClose);

    var weekData = await BecomePartnerModel.toJsonBusinessWeek(
      businessWeekUpdate.value.businessWeek!,
      data.bussinessCategory!,
    );

    print("-=-=-=-=-=-=  $weekData === ${data.id!}");

    /*BecomePartnerModel result =
        await onUpdateBusinessState(weekData, eventId: data.id!);

    if (result.bussinessName!.isNotEmpty) {
      print("Success fully");
      EasyLoading.dismiss();
      return true;
    } else {
      EasyLoading.dismiss();
    }*/
    return false;
  }

  List<BusinessWeek> conpairBusinessDay({
    required List<BusinessWeek> businessDays,
    required bool isClose,
  }) {
    List<BusinessWeek> tempData = [];
    for (int i = 0; i < businessDays.length; i++) {
      if (businessDays[i].bussinessDay!.toLowerCase() ==
          DateFormat('EEEE').format(DateTime.now()).toLowerCase()) {
        tempData.add(BusinessWeek(
          isClose: isClose,
          bussinessDay: businessDays[i].bussinessDay,
          startTime: businessDays[i].startTime,
          endTime: businessDays[i].endTime,
        ));
      } else {
        tempData.add(businessDays[i]);
      }
    }
    // BusinessWeek filteredDays = businessDays.where((day) {
    //   return day.bussinessDay!.toLowerCase() ==
    //       DateFormat('EEEE').format(DateTime.now()).toLowerCase();
    // }).first;

    // filteredDays.isClose = isClose;

    return tempData;
  }
}
