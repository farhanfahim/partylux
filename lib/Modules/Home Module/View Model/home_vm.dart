// ignore_for_file: unused_local_variable, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/constants.dart';
import 'package:partylux/Constants/strings.dart';
import 'package:partylux/Modules/Auth%20Module/Models/usermodel.dart';
import 'package:partylux/Modules/BecomePartner/Model/become_partner_model.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
as bg;
import 'package:partylux/Modules/Event%20Module/View%20Model/event_viewmodel.dart';
import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';
import 'package:partylux/Modules/Home%20Module/Service/home_service.dart';
import 'package:partylux/Utils/Network/cache_handler.dart';
import '../../../Utils/Common/custom_location_dialog.dart';
import '../../../Utils/Util.dart';
import '../../../Utils/navigation.dart';
import '../../../models/page_model.dart';
import '../../Map Module/View Model/map_view_model.dart';
import '../../NavRoot Module/View Model/nevroot_vm.dart';
import '../../Profile Module/Profile Section/View Model/profile_vm.dart';
import '../../add_location_picker/model/local_location.dart';
import '../Model/filter_model.dart';

class HomeViewModel extends GetxController
    with HomeService, GetTickerProviderStateMixin {
  RxString selectedEvent = AppStrings.clubs.obs;
  List<String> arrOfEvents = [
    AppStrings.clubs,
    AppStrings.houseParty,
    AppStrings.bars,
    AppStrings.beach
  ];
  RxBool isAllHomeLoading = false.obs;
  Rx<UserModel> userData = UserModel.fromEmpty().obs;
  RxList<BecomePartnerModel> topLiveClubsList = <BecomePartnerModel>[].obs;
  RxList<BecomePartnerModel> topLiveBarsList = <BecomePartnerModel>[].obs;
  RxList<EventModel> eventCategoryList = <EventModel>[].obs;


  final List<FilterModel> arrFilter = [
    FilterModel(isLocationSelected:true.obs,isPeopleSelected:true.obs,distance: 0.5,minPeople:0,maxPeople:25),
    FilterModel(isLocationSelected:false.obs,isPeopleSelected:false.obs,distance: 1,minPeople:25,maxPeople:50),
    FilterModel(isLocationSelected:false.obs,isPeopleSelected:false.obs,distance: 5,minPeople:50,maxPeople:100),
    FilterModel(isLocationSelected:false.obs,isPeopleSelected:false.obs,distance: 10,minPeople:100,maxPeople:200),
    FilterModel(isLocationSelected:false.obs,isPeopleSelected:false.obs,distance: 25,minPeople:200,maxPeople:50000),
  ];


  PageModel<EventModel>? paginatedEventsList;
  final _rootVM = Get.find<NavRootViewModel>();
  final _profileVM = Get.find<ProfileViewModel>();
  final _eventVM = Get.find<EventViewModel>();
  final mapEventVM = Get.find<MapEventViewModel>();

  RxDouble locationFilter = 0.5.obs;
  RxInt peopleCapacityMin = 0.obs;
  RxInt peopleCapacityMax = 25.obs;
  RxInt priceRangeMin = 10.obs;
  RxInt priceRangeMax = 150.obs;
  RxBool isLoadingFilter = false.obs;
  RxBool isFilterApply = false.obs;
  RxBool isLocationSelected = false.obs;
  RxBool isCapacitySelected = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();

    getUserDetail();


    await DatabaseHandler().getNotification().then((value) async {

      if(value) {
        await DatabaseHandler().setNotification(false);
        await DatabaseHandler().getEventType().then((value1) async {
          await DatabaseHandler().getActionID().then((value2) {

            if(value1 == Constants.PUSH_EVENT){
              Get.toNamed(
                  AppRoutes.myEvent, arguments: [value2, Constants.EVENT_UN_KNOWN]);
            }
            else if(value1 == Constants.PUSH_E_TICKET){
              Get.toNamed(
                AppRoutes.ticketDetailView, arguments: [value2,"normal"],
              );
            }
            else if(value1 == Constants.PUSH_PAYMENT){
              AppNavigator.navigateToNamed(AppRoutes.paymentMethodView, arguments: {
                Constants.paramFrom: true,
                Constants.paramFrom2: value2,
              });
            }
          });
        });
      }
    });
  }

  void _onClickEnable(enabled) async {
    if (enabled) {
      dynamic callback = (bg.State state) async {
        print('[start] success: $state');
        _rootVM.isMoving!.value = state.isMoving!;
        _rootVM.enabled!.value = state.enabled;
        _onClickChangePace();

      };
      bg.State state = await bg.BackgroundGeolocation.state;
      if (state.trackingMode == 1) {
        bg.BackgroundGeolocation.start().then(callback);
      } else {
        bg.BackgroundGeolocation.startGeofences().then(callback);
      }
    } else {
      dynamic callback = (bg.State state) {
        print('[stop] success: $state');
        _rootVM.isMoving!.value = state.isMoving!;
        _rootVM.enabled!.value = state.enabled;
      };
      bg.BackgroundGeolocation.stop().then(callback);
    }
  }

  void _onClickChangePace() {
    _rootVM.isMoving!.value = !_rootVM.isMoving!.value;

    bg.BackgroundGeolocation.changePace(_rootVM.isMoving!.value).then((bool isMoving) {

    }).catchError((e) {

    });
  }

  void getUserDetail() async {

    topLiveClubsList.clear();
    topLiveBarsList.clear();
    print("object");
    userData.value = await DatabaseHandler().getUserData();
    userData.refresh();
    UserModel result = await getUserProfile();
    userData.value = result;
    _profileVM.userProfileData.value = userData.value;
    mapEventVM.userData.value = userData.value;
    _eventVM.userData.value=userData.value;

    userData.refresh();
    _handleLocationPermission();

  }

  void getTopFiveLiveClubs() async {
    topLiveClubsList.value =
    await topLiveBusinesses(businessType: Constants.CATEGORY_CLUB);
    print(topLiveClubsList.length);
  }

  void getTopFiveLiveBars() async {
    topLiveBarsList.value =
    await topLiveBusinesses(businessType: Constants.CATEGORY_BAR);
    print(topLiveBarsList.length);
  }

  Future<void> getEvent({int length = 6, required String? categoryType}) async {
    isAllHomeLoading.value = true;
    eventCategoryList.value = <EventModel>[];

    LocalLocation localLocation = await DatabaseHandler().getLocation();
    if(localLocation.coordinates!=null){
      eventCategoryList.value = await events(
          length: length,
          categoryType: categoryType!
      );
    }

    isAllHomeLoading.value = false;

  }


  void navigateViewAllEvents() {
    if (selectedEvent.value == AppStrings.clubs) {
      Get.toNamed(AppRoutes.HOME_VIEWALL, arguments: Constants.CATEGORY_CLUB);
    } else if (selectedEvent.value == AppStrings.houseParty) {
      Get.toNamed(AppRoutes.HOME_VIEWALL,
          arguments: Constants.CATEGORY_HOUSE_PARTY);
    } else if (selectedEvent.value == AppStrings.bars) {
      Get.toNamed(AppRoutes.HOME_VIEWALL, arguments: Constants.CATEGORY_BAR);
    } else if (selectedEvent.value == AppStrings.beach) {
      Get.toNamed(AppRoutes.HOME_VIEWALL, arguments: Constants.CATEGORY_BEACH);
    }
  }



  Future _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    /*serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      isAllHomeLoading.value = false;
      return false;
    }*/
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      showDialog(
          context: Get.context!,
          barrierDismissible: false,
          builder: (context){
            return CustomLocationDialog(
                content: AppStrings.locationContent,
                onAccept: () async {
                  permission = await Geolocator.requestPermission();
                  _onClickEnable(true);
                  LocalLocation pre;

                  print("inside location granted");
                  await Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.low)
                      .then((value) async {
                    pre = LocalLocation(
                        type: "Point",
                        coordinates: [value.latitude, value.longitude],
                        radius: "30",
                        address: "");
                    await DatabaseHandler().setLocation(pre.toJson());
                    mapEventVM.localLocation = pre;
                    getTopFiveLiveClubs();
                    getTopFiveLiveBars();

                    if (selectedEvent.value == AppStrings.clubs) {
                      getEvent(length: 6, categoryType: Constants.CATEGORY_CLUB);
                    }
                    if (selectedEvent.value == AppStrings.houseParty) {
                      getEvent(length: 6, categoryType: Constants.CATEGORY_HOUSE_PARTY);
                    }
                    if (selectedEvent.value == AppStrings.bars) {
                      getEvent(length: 6, categoryType: Constants.CATEGORY_BAR);
                    }
                    if (selectedEvent.value == AppStrings.beach) {
                      getEvent(length: 6, categoryType: Constants.CATEGORY_BEACH);
                    }
                  }).catchError((e) {
                    print(e);
                  });
                  Get.back();
                },
                onReject:(){
                  isAllHomeLoading.value = false;
                  Get.back();
                }
            );
          });

    } else if (permission == LocationPermission.deniedForever) {
      return false;
    } else {
      _onClickEnable(true);
      LocalLocation pre;

      print("inside location granted");
      await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low)
          .then((value) async {
        pre = LocalLocation(
            type: "Point",
            coordinates: [value.latitude, value.longitude],
            radius: "30",
            address: "");
        await DatabaseHandler().setLocation(pre.toJson());
        mapEventVM.localLocation = pre;
        getTopFiveLiveClubs();
        getTopFiveLiveBars();

        if (selectedEvent.value == AppStrings.clubs) {
          getEvent(length: 6, categoryType: Constants.CATEGORY_CLUB);
        }
        if (selectedEvent.value == AppStrings.houseParty) {
          getEvent(length: 6, categoryType: Constants.CATEGORY_HOUSE_PARTY);
        }
        if (selectedEvent.value == AppStrings.bars) {
          getEvent(length: 6, categoryType: Constants.CATEGORY_BAR);
        }
        if (selectedEvent.value == AppStrings.beach) {
          getEvent(length: 6, categoryType: Constants.CATEGORY_BEACH);
        }
      }).catchError((e) {
        print(e);
      });
    }
  }

}
