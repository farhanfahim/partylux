// ignore_for_file: invalid_use_of_protected_member

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Modules/Create%20Module/Model/card_model.dart';
import 'package:partylux/Modules/Create%20Module/Model/create_model.dart';
import 'package:partylux/Modules/Create%20Module/Service/create_event_service.dart';
import 'package:partylux/Modules/Create%20Module/View%20Model/google_map_vm.dart';
import 'package:partylux/Modules/Home%20Module/View%20Model/home_vm.dart';
import 'package:partylux/Modules/Profile%20Module/Profile%20Section/Model/google_map_model.dart';
import 'package:partylux/Modules/Profile%20Module/Profile%20Section/Service/google_map_service.dart';
import 'package:partylux/Utils/Network/tost.dart';
import 'package:partylux/Utils/Theme/app_config.dart';

import '../../../Constants/strings.dart';
import '../../../Utils/Common/custom_location_dialog.dart';

class CreateViewModel extends GetxController with CreateEventService {
  final ImagePicker _picker = ImagePicker();

  Rx<CreateEventModel> createEvent = CreateEventModel.fromEmpty().obs;

  // final _googleMapVM = Get.find<PlacesSearchViewModel>();
  final _googleMapVM = Get.isRegistered<PlacesSearchViewModel>()
      ? Get.find<PlacesSearchViewModel>()
      : Get.put(PlacesSearchViewModel());

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentLocation();
  }

  RxDouble currentLat = 0.0.obs;
  RxDouble currentLong = 0.0.obs;

  LocationPermission? permission;
  getCurrentLocation() async {
    permission = await Geolocator.checkPermission();
    if (permission != LocationPermission.denied) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print("First Time =>> ${position.latitude}  ${position.longitude}");

      currentLat.value = position.latitude;
      currentLong.value = position.longitude;
      await moveToCameraLocation(
        latLng: LatLng(position.latitude, position.longitude),
      );
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

                currentLat.value = position.latitude;
                currentLong.value = position.longitude;
                await moveToCameraLocation(
                  latLng: LatLng(position.latitude, position.longitude),
                );
                Get.back();
              },onReject:(){
              Get.back();
              Get.toNamed(AppRoutes.enableLocationServices);
            }
            );
          });

    }
  }

//=======================================================//
/* Select Party Mode */ //==================>>>>
  RxString partyMode = "houseParty".obs;

  void selectPartyMode() {
    if (partyMode.isNotEmpty) {
      createEvent.value.eventCategory = partyMode.value;
      Get.toNamed(AppRoutes.SELECT_EVENT_GALLERY);
    } else {
      Toast().error(massage: "Please select party mode");
    }
  }

  void eventSelectUserRole() {
    createEvent.value.eventCategory = partyMode.value;
    Get.toNamed(AppRoutes.SELECT_EVENT_GALLERY);
  }

//=======================================================//
/* Select Party Gellary Images */ //==================>>>>
  final formKeyEventName = GlobalKey<FormState>();
  final formKeyEventDiscription = GlobalKey<FormState>();
  Rx<TextEditingController> eventName = TextEditingController().obs;
  Rx<TextEditingController> eventdiscription = TextEditingController().obs;
  RxString eventType = "public".obs;

  // &&
  //       formKeyEventDiscription.currentState!.validate()
  RxList<String> imagesList = <String>[].obs;

  // Pick Multi Image Gallery Open Method
  void eventImage() async {
    final List<XFile> images = await _picker.pickMultiImage(imageQuality: 50);
    if (images.isNotEmpty) {
      imagesList.value
          .addAll(images.asMap().entries.map((it) => it.value.path).toList());
      imagesList.refresh();
    } else {
      print('No image selected.');
    }
  }

  void selectPartyImages() {
    if (formKeyEventName.currentState!.validate()) {
      if (imagesList.length < 1) {
        Toast().error(massage: "Please select party images");
        return;
      }
      print("Successfully Data collect");
      createEvent.value.name = eventName.value.text;
      createEvent.value.eventCategory = partyMode.value;
      createEvent.value.eventType = eventType.value;
      createEvent.value.note = eventdiscription.value.text;
      Get.toNamed(AppRoutes.SELECT_START_DATE_TIME,
          arguments: [partyMode.value]);
    }
  }

//=======================================================//
/* Select Event Data Time */ //==================>>>>

  ///
  /// = >> This variables only for view
  ///
  RxString selectedDate = "".obs;
  RxInt selectedindex = 0.obs;
  /* Event Start time */
  RxInt selectedStartHour = 1.obs;
  RxInt selectedStartMin = 0.obs;
  RxString selectedStartSlot = "AM".obs;

  /* Event Start time */
  RxInt selectedEndHour = 4.obs;
  RxInt selectedEndMin = 0.obs;
  RxString selectedEndSlot = "AM".obs;

  ///
  /// = >> This variables only for view
  ///

  RxString startTime = "".obs;
  RxString endTime = "".obs;

  void selectStartPartyDateTime() {
    if (startTime.value.isEmpty) {
      Toast().error(massage: "Please select open Time");
      return;
    }
    if (endTime.value.isEmpty) {
      Toast().error(massage: "Please select close Time");
      return;
    }

      createEvent.value.startDateTime = startTime.value;
      createEvent.value.endDateTime = endTime.value;

    print("start ${createEvent.value.startDateTime}");
    print("end  ${createEvent.value.endDateTime}");
    Get.toNamed(AppRoutes.SELECT_LOCATION);
    // }
  }

//=======================================================//
/* Select Event Location */ //==================>>>>
  RxList<PlaceSearch> placesListData = <PlaceSearch>[].obs;

  PlaceModel? placeDetail;
  RxDouble lat = 0.0.obs;
  RxDouble lng = 0.0.obs;

  RxBool isKeyboard = false.obs;
  Rx<PlaceSearch> selectedLocation = PlaceSearch().obs;
  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxList<double> latlng = <double>[].obs;

  Rx<TextEditingController> placeName = TextEditingController().obs;
  Rx<TextEditingController> placeLat = TextEditingController().obs;
  Rx<TextEditingController> placeLong = TextEditingController().obs;

  void autocomplete(val) async {
    print("autocomplete $val");
    placesListData.value = await _googleMapVM.searchPerdictions(
      val,
      lat: lat.value.toString(),
      lng: lng.value.toString(),
    );
  }

  void setPlace(PlaceSearch placesData) async {
    selectedLocation.value = placesData;
    FocusManager.instance.primaryFocus?.unfocus();
    placesListData.value = <PlaceSearch>[];
    isKeyboard.value = false;
    searchController.value.text = selectedLocation.value.name;
    placeDetail =
        await GooglePlaceHandler().placeDetailSearch(placesData.placeId);

    final mapCont = Get.put(PlacesSearchViewModel());

    await mapCont.moveToCameraLocation(
      latLng: LatLng(placeDetail!.lat, placeDetail!.lng),
    );
  }

  GoogleMapController? _controller;
  moveToCameraLocation({required LatLng latLng}) {
    try {
      _controller!.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(latLng.latitude, latLng.longitude),
            zoom: 16.0,
          ),
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  void onLocatioSubmit() async {
    String data = await getLocationName(lat.value, lng.value);
    placeName.value.text = data;
    placeLat.value.text = lat.value.toString();
    placeLong.value.text = lng.value.toString();
    currentLat.value = lat.value;
    currentLong.value = lng.value;
    currentLat.refresh();
    currentLong.refresh();
    Get.back();
  }

  void selectedPartyLocation() async {
    latlng.value = [];
    latlng.add(double.parse(placeLat.value.text));
    latlng.add(double.parse(placeLong.value.text));
    if (latlng.length < 1) {
      Toast().error(massage: "Please select party location");
      return;
    }
    createEvent.value.place = placeName.value.text;
    createEvent.value.location = LocationModel(
      type: "Point",
      radius: 35.toString(),
      coordinates: latlng,
    );
    Get.toNamed(AppRoutes.SELECT_CANCEL_POLICY);
  }

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

//=======================================================//
/* Select Event Canselation Policies */ //==================>>>>
  RxString selectCancelPlane = "24 hrs".obs;

  void selectPartyCancelPolicies() {
    if (selectCancelPlane.value.isNotEmpty) {
      print("selectCancelPlane $selectCancelPlane");
      createEvent.value.cancelationPolicy = selectCancelPlane.value;
      Get.toNamed(AppRoutes.SELECT_ADMISSION_FEE);
    } else {
      Toast().error(massage: "Please select party Cancelation Policies");
    }
  }

//=======================================================//
/* Select Event Admission Fee for male, female */ //==================>>>>
  RxBool isMaleFree = true.obs;
  Rx<TextEditingController> maleAmount = TextEditingController().obs;
  RxBool isFemaleFree = true.obs;
  Rx<TextEditingController> femaleAmount = TextEditingController().obs;

  // For Private Events
  RxString normalCode = "".obs;
  RxBool isFreeParty = false.obs;
  RxString discountCode = "".obs;
  RxBool isFreeDiscount = false.obs;
  Rx<TextEditingController> privatePartyPrice = TextEditingController().obs;
  Rx<TextEditingController> partyDiscountPrice = TextEditingController().obs;
  void selectPartyAdmissionFee() {
    AdmissionFee admissionFee = AdmissionFee.fromEmpty();
    if(eventType.value == "public") {
      if (!isMaleFree.value && maleAmount.value.text.isEmpty) {
        Toast().error(massage: "Please Enter Amount for Male");
        return;
      }
      if(maleAmount.value.text.isNotEmpty) {
        if (int.parse(maleAmount.value.text) <= 0) {
          Toast().error(massage: "Please Enter Valid Amount for Male");
          return;
        }
      }
      if (!isFemaleFree.value && femaleAmount.value.text.isEmpty) {
        Toast().error(massage: "Please Enter Amount for Female");
        return;
      }
      if(femaleAmount.value.text.isNotEmpty) {
        if (int.parse(femaleAmount.value.text) <= 0) {
          Toast().error(massage: "Please Enter Valid Amount for Female");
          return;
        }
      }


      print("Success fully");

      admissionFee.male = Couple(
        free: isMaleFree.value,
        amount: !isMaleFree.value ? int.parse(maleAmount.value.text) : 0,
      );
      admissionFee.female = Couple(
        free: isFemaleFree.value,
        amount: !isFemaleFree.value ? int.parse(femaleAmount.value.text) : 0,
      );
    }
    List<EntrenceCode> entrenceCode = [];

    if (eventType.value == "private") {
      try {


        int value1 =0;
        if (!isFreeParty.value){
          if (privatePartyPrice.value.text.isNotEmpty){
            value1 = int.parse(privatePartyPrice.value.text);
            print("Parsed integer: $value1");
          }

          if(int.parse(privatePartyPrice.value.text)>0) {
            if (normalCode.value.isNotEmpty) {
              entrenceCode.add(
                EntrenceCode(
                    type: isFreeParty.value ? "free" : "normal",
                    amount: isFreeParty.value ? 0 : value1,
                    code: normalCode.value
                ),
              );
            } else {
              entrenceCode.add(
                EntrenceCode(
                  type: isFreeParty.value ? "free" : "normal",
                  amount: isFreeParty.value ? 0 : value1,
                ),
              );
            }
          }else{
            Toast().error(massage: "Please Enter Valid Amount");
            return;
          }
        }




          if (isFreeDiscount.value) {
            if(int.parse(partyDiscountPrice.value.text)>0) {

            int value2 = int.parse(partyDiscountPrice.value.text);
            print("Parsed integer: $value2");
            if (discountCode.value.isNotEmpty) {
              entrenceCode.add(
                EntrenceCode(
                    type: isFreeDiscount.value ? "discount" : "normal",
                    amount: value2,
                    code: discountCode.value
                ),
              );
            } else {
              entrenceCode.add(
                EntrenceCode(
                  type: isFreeDiscount.value ? "discount" : "normal",
                  amount: value2,
                ),
              );
            }

          }else{
              Toast().error(massage: "Please Enter Valid Amount");
              return;
            }
        }


        createEvent.value.entrenceCode = entrenceCode;
      } catch (e) {
        if (e is FormatException) {
          print(
              "The following FormatException was thrown while handling a gesture: $e");
          Toast().error(massage: "Please Enter Amount");
        } else {
          print("An unexpected error occurred: $e");
          Toast().error(massage: e.toString());
        }
        return;
      }
    }

    createEvent.value.admissionFee = admissionFee;

    Get.toNamed(AppRoutes.SELECT_PARTY_ESSENTIAL);
  }

//=======================================================//
/* Select Event Party Essentails */ //==================>>>>

  RxList<String> musicList = <String>[].obs;
  RxList<String> entertainmentList = <String>[].obs;
  RxList<String> disclaimerList = <String>[].obs;
  RxString ageLimit = "".obs;

  void selectPartyEssential() {
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
    createEvent.value.music = musicList.value;
    createEvent.value.entertainment = entertainmentList.value;
    createEvent.value.disclaime = disclaimerList.value;
    createEvent.value.ageLimit = ageLimit.value;
    Get.toNamed(AppRoutes.SELECT_PARTY_ATTENDANCE);
  }

  //=======================================================//
/* Select Event Maximum Attenddance */ //==================>>>>

  RxString maximumAttendance = "0-25 people".obs;

  void selectPartyMaximumAttendance(
    BuildContext context,
  ) {
    if (maximumAttendance.value.isEmpty) {
      Toast().error(massage: "Please select party attendance");
      return;
    }
    print("Success fully");
    createEvent.value.maxParticipants =
        maximumAttendance.value.replaceAll(" people", "");

    if (isUpdateEvent.value) {
      updateEventUploadData();
    } else {
      CreateEventUploadData(false);
    }

    // // Get.toNamed(AppRoutes.successfullyCreatedEvent);
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return BackdropFilter(
    //       filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
    //       child: AlertDialog(
    //         insetPadding: EdgeInsets.zero,
    //         actionsPadding: EdgeInsets.zero,
    //         contentPadding: EdgeInsets.zero,
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(20),
    //         ),
    //         backgroundColor: Color.fromARGB(255, 71, 8, 100),
    //         content: CreateEventPopup(
    //           noCallback: () {
    //             print("print");
    //             CreateEventUploadData(false);
    //           },
    //           yesCallback: () {
    //             CreateEventUploadData(true);
    //           },
    //         ),
    //       ),
    //     );
    //   },
    // );
  }

//=======================================================//
/* Select Event Upload Data */ //==================>>>>

  uploadEventImages() async {
    List<String> imagePaths = [];
    List<String> imagesURL = [];

    for (String path in imagesList) {
      bool _validURL = Uri.parse(path).isAbsolute;
      if (_validURL) {

        imagesURL.add(path);
      } else {

        imagePaths.add(path);
      }
    }

    List<String> temoImagesURL =
        await onUploadPicture(imageFileList: imagePaths);
    imagesURL.addAll(temoImagesURL);
    createEvent.value.photos = imagesURL;
    createEvent.value.eventProfile = imagesURL.isNotEmpty ? imagesURL[0] : "";
    print("❌❌upload ImagesURL Length ${imagesURL.length}");
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
    print("-=-=-=-=-=-=  ");
    var mapdata = await CreateEventModel.toJson(createEvent.value);
    print("-=-=-=-=-=-=  $mapdata");

    CreateEventModel result = await onCreateEvent(mapdata);

    if (result.name!.isNotEmpty) {
      createEvent.value = result;
      print("Success fully");
      EasyLoading.dismiss();
      if (isAddCard) {
        Get.toNamed(AppRoutes.partyMulitCard);
      } else {
        // Get.offAllNamed(AppRoutes.NAV_ROOT);
        Get.toNamed(AppRoutes.successfullyCreatedEvent);
      }
    } else {
      EasyLoading.dismiss();
    }
  }

  //=======================================================//
/* Select Update Event Upload Data */ //==================>>>>

  void updateEventUploadData() async {
    EasyLoading.show(
      status: 'Please Wait . . .',
      indicator: CupertinoActivityIndicator(
        color: AppColors.whiteText,
        radius: SizeConfig.screenWidth * 0.05,
      ),
    );
    await uploadEventImages();
    print("-=-=-=-=-=-=  ");
    var mapdata = await CreateEventModel.toJson(createEvent.value);
    print("-=-=-=-=-=-=  $mapdata");

    CreateEventModel result =
        await onUpdateEvent(mapdata, eventID: houseEventID.value);

    if (result.name!.isNotEmpty) {
      createEvent.value = result;
      print("Success fully");
      EasyLoading.dismiss();
      final _housePartyVM = Get.isRegistered<HomeViewModel>()
          ? Get.find<HomeViewModel>()
          : Get.put(HomeViewModel());
      //_housePartyVM.getEvent();
      Get.toNamed(AppRoutes.successfullyUpdatedEvent);
    } else {
      EasyLoading.dismiss();
    }
  }

  //=======================================================//
/* Selected Event Card Lists  and upload Card against Event */ //==================>>>>
  Rx<CreateEventCard> createdEventCards = CreateEventCard.fromEmpty().obs;
  RxBool loadingCardUpload = false.obs;

  void uploadEventCards() async {
    if (createdEventCards.value.cards.length < 1) {
      Toast().error(massage: "Please Add VIP card");
      return;
    }
    loadingCardUpload.value = true;
    createdEventCards.value.eventId = createEvent.value.id;

    var mapdata = await CreateEventCard.toJson(createdEventCards.value);
    print("object==>> $mapdata");
    var result = await onCreatedEventVIPCard(mapdata);
    loadingCardUpload.value = false;
    if (result.id!.isNotEmpty) {
      Get.offAllNamed(AppRoutes.NAV_ROOT);
    }
  }

  //=======================================================//
/* Selected Event against create Card  */ //==================>>>>

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

      EventCard cardDetail = EventCard(
          vipcardName: vipCardName.value.text,
          price: int.parse(vipCardPrice.value.text),
          services: vipCardServicesList.value);
      createdEventCards.value.cards.add(cardDetail);
      createdEventCards.refresh();
      vipCardName.value.text = "";
      vipCardPrice.value.text = "";
      vipCardServices.value.text = "";
      vipCardServicesList.value = <String>[];
      // createCardformKey.currentState!.reset();
      Get.back();
    }
  }

  void removeCardService(String s) {
    vipCardServicesList.value.remove(s);
    vipCardServicesList.refresh();
  }

  //////////////////////////////////////////////////////////////////
  ///                                                            ///
  ///                                                            ///
  ///                                                            ///
  ///                    Update House Party                      ///
  ///                                                            ///
  ///                                                            ///
  ///                                                            ///
  //////////////////////////////////////////////////////////////////

  RxBool isUpdateEvent = false.obs;
  RxString houseEventID = "".obs;
  void edit_Method(CreateEventModel data) async {
    print(data.startDateTime);
    isUpdateEvent.value = true;
    houseEventID.value = data.id!;
    partyMode.value = data.eventCategory!;

    ///
    ///==>> Evnet Detail
    ///
    eventName.value.text = data.name!;
    eventdiscription.value.text = data.note!;
    eventType.value = data.eventType!;
    imagesList.value = data.photos!;

    ///
    ///==> Event Timeing
    ///
    List<String> start = await timeFormateInParts(data.startDateTime!);
    List<String> end = await timeFormateInParts(data.endDateTime!);

    selectedindex.value = DateTime.parse(data.startDateTime!).day;
    selectedDate.value = start[3];

    /* Event Start time */
    selectedStartHour.value = int.parse(start[0]);
    selectedStartMin.value = int.parse(start[1]);
    selectedStartSlot.value = start[2];

    /* Event Start time */
    selectedEndHour.value = int.parse(end[0]);
    selectedEndMin.value = int.parse(end[1]);
    selectedEndSlot.value = end[2];

    if (selectedDate.value.isNotEmpty) {
      startTime.value = await formateMethod(
        hours: selectedStartHour.value.toString(),
        minutes: selectedStartMin.value.toString(),
        amPm: selectedStartSlot.value,
        date: selectedDate.value,
      );
      endTime.value = await formateMethod(
        hours: selectedEndHour.value.toString(),
        minutes: selectedEndMin.value.toString(),
        amPm: selectedEndSlot.value,
        date: selectedDate.value,
      );
    }

    ///
    ///==> Location
    ///
    placeName.value.text = data.place!;
    placeLat.value.text = data.location!.coordinates[0].toString();
    placeLong.value.text = data.location!.coordinates[1].toString();

    ///
    ///==> Cancel Policies
    ///
    selectCancelPlane.value = data.cancelationPolicy!;

    ///
    ///==> Admission Fee Public
    ///
    isMaleFree.value = data.admissionFee!.male.free;
    maleAmount.value.text = data.admissionFee!.male.amount==0?"":data.admissionFee!.male.amount.toString();
    isFemaleFree.value = data.admissionFee!.female.free;
    femaleAmount.value.text = data.admissionFee!.female.amount==0?"":data.admissionFee!.female.amount.toString();

    ///
    ///==> Admission Fee Private
    ///

    try {



      if (data.entrenceCode!.length > 1) {
        isFreeDiscount.value =
            data.entrenceCode![1].type == "discount" ? true : false;
        partyDiscountPrice.value.text = data.entrenceCode![1].amount.toString();
        normalCode.value = data.entrenceCode![1].code!;

      } else {
        isFreeDiscount.value = false;
        partyDiscountPrice.value.text = "";
        normalCode.value = data.entrenceCode![1].code!;

      }

      if (data.entrenceCode!.length > 0) {
        isFreeParty.value = data.entrenceCode![0].type == "free" ? true : false;
        normalCode.value = data.entrenceCode![0].code!;
        if(!isFreeParty.value){
          privatePartyPrice.value.text = data.entrenceCode![0].amount.toString();
        }else{
          privatePartyPrice.value.text = "";
        }

      } else {
        isFreeParty.value = false;
        privatePartyPrice.value.text = "";
        normalCode.value = data.entrenceCode![0].code!;
      }
    } catch (e) {
      print("object $e");
    }

    ///
    ///==> Party Essential
    ///
    musicList.value = data.music!;
    entertainmentList.value = data.entertainment!;
    disclaimerList.value = data.disclaime!;
    ageLimit.value = data.ageLimit!;

    ///
    /// ==>
    ///
    if(data.maxParticipants == "unlimited"){
      maximumAttendance.value = "${data.maxParticipants}";
      print(data.maxParticipants);
    }else{
      maximumAttendance.value = "${data.maxParticipants} people";
      print(data.maxParticipants);
      print(data.maxParticipants);
    }
  }

  Future<String> formateMethod({
    required String hours,
    required String minutes,
    required String amPm,
    required String date,
  }) async {
    // Convert hours to a 24-hour format
    if (amPm == 'PM') {
      int hourInt = int.parse(hours);
      hours = (hourInt + 12).toString();
    }

    // Adjust the format pattern to match the actual format
    DateFormat inputFormat = DateFormat('yyyy-M-d HH:mm:ss.SSS');

    // Create a DateTime object
    DateTime dateTime = inputFormat.parse(
        '${selectedDate.value} ${hours.padLeft(2, '0')}:${minutes.padLeft(2, '0')}:00.000');

    String iso8601String =
    DateFormat('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'').format(dateTime);

    return iso8601String; // Output: 2023-05-02T10:30:00.000Z
  }

  ///
  /// House Event Time Formate
  ///
  Future<List<String>> timeFormateInParts(String dateTimeString) async {
    // Parse the string to DateTime
    DateTime dateTime = DateTime.parse(dateTimeString);

    // Format date
    String formattedDate =
        "${dateTime.year}-${dateTime.month}-${dateTime.day}";

    // Format time with AM/PM
    String houesTime = "${(dateTime.hour % 12).toString().padLeft(2, '0')}";
    String minuteTime = "${dateTime.minute.toString().padLeft(2, '0')}";
    String slotTime = "${dateTime.hour < 12 ? 'AM' : 'PM'}";

    print("Formatted Date: $formattedDate");
    print("Formatted Time: $houesTime : $minuteTime $slotTime");

    return [houesTime, minuteTime, slotTime, formattedDate];
  }


}
