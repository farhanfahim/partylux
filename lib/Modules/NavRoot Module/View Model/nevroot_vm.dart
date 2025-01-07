import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/constants.dart';
import 'package:partylux/Modules/NavRoot%20Module/Service/navroot_service.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
as bg;

import 'package:http/http.dart' as http;
import 'package:partylux/Utils/navigation.dart';
import 'package:partylux/service/applinker.dart';
import '../../../Constants/strings.dart';
import '../../../Utils/Common/custom_location_dialog.dart';
import '../../../Utils/Network/api_urls.dart';
import '../../../Utils/Network/cache_handler.dart';
import '../../add_location_picker/model/local_location.dart';

class NavRootViewModel extends GetxController with NavRootService implements DeepLinkHandler{


  int? map;
  final Applinker unilinker=Applinker();

  RxInt selectedIndex = 0.obs;
  PageController pageController = PageController();
  LocationPermission? permission;
  RxBool? isMoving = false.obs;
  RxBool? enabled = false.obs;

  String? initialLink;

  void changePage(index) {
    pageController.jumpToPage(index);
  }

  @override
  Future<void> onInit() async {
    var arguments=Get.arguments;
    print("arg are: ${arguments}");
    initialLink=arguments?[Constants.paramFrom];
    map=arguments?[Constants.paramFrom2];
    super.onInit();
    bool enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) {
      try {
        await Geolocator.getCurrentPosition();
        enabled = true;
      } catch (e) {

      }
    }

    _configureBackgroundGeolocation();
    _configureBackgroundFetch();

    if(map!=null){
      changePage(0);
    }
  }

  @override
  void onReady() {
    unilinker.startLinkStream(this);
    if(initialLink!=null){
      onLinkTap(initialLink!);
    }
    super.onReady();
  }

  @override
  void onClose() {
    unilinker.cancelLinkStream();
    super.onClose();
  }

  @override
  void onLinkTap(String link) {
    if(link.contains("event")){
      List list=link.split("/");
      String id=list.last;
      print("frhn $id");
      AppNavigator.navigateToNamed(AppRoutes.myEvent,
          arguments: [
            id,Constants.EVENT_UN_KNOWN,
          ]);
    }
  }


  void _configureBackgroundGeolocation() async {

    var token = await DatabaseHandler().getToken();
    bg.BackgroundGeolocation.onLocation(_onLocation, _onLocationError);
    bg.BackgroundGeolocation.onMotionChange(_onMotionChange);
    bg.BackgroundGeolocation.onActivityChange(_onActivityChange);
    bg.BackgroundGeolocation.onProviderChange(_onProviderChange);
    bg.BackgroundGeolocation.onHttp(_onHttp);
    bg.BackgroundGeolocation.onConnectivityChange(_onConnectivityChange);
    bg.BackgroundGeolocation.onHeartbeat(_onHeartbeat);
    bg.BackgroundGeolocation.onSchedule(_onSchedule);
    bg.BackgroundGeolocation.onPowerSaveChange(_onPowerSaveChange);
    bg.BackgroundGeolocation.onEnabledChange(_onEnabledChange);

    // 2.  Configure the plugin
    bg.BackgroundGeolocation.ready(bg.Config(
        reset: true,
        debug: false,
        logLevel: bg.Config.LOG_LEVEL_VERBOSE,
        desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
        distanceFilter: 0,
        locationUpdateInterval: 20000,
        fastestLocationUpdateInterval: -1,
        stopTimeout: 5,
        locationAuthorizationRequest: 'Always',
        backgroundPermissionRationale: bg.PermissionRationale(
            title: "Allow PartyLux to access this device's location even when the app is closed or not in use.",
            message: "This app collects location data to enable recording your trips to work and calculate distance-travelled.",
            positiveAction: 'Change to "{backgroundPermissionOptionLabel}"',
            negativeAction: 'Cancel'
        ),
        autoSync: true,
        method: "PATCH",
        headers: {
          "Accept": '*/*',
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${token.toString()}",
        },
        locationTemplate: '{ "lat": "<%= latitude %>", "lng": "<%= longitude %>" }',
        url: "${ApiManager.BASE_URL}mobile/users/update-coordinates",
        // Application options

        stopOnTerminate: false,
        startOnBoot: true,
        enableHeadless: true,
        disableElasticity: true,
        geofenceProximityRadius: 1000,
        desiredOdometerAccuracy: 100,
        heartbeatInterval: 60

    )).then((bg.State state) async {
      if (state.schedule!.isNotEmpty) {
        bg.BackgroundGeolocation.startSchedule();
      }
      enabled!.value = state.enabled;
      isMoving!.value = state.isMoving!;

    }).catchError((error) {
      print('[ready] ERROR: $error');
    });


  }

  void _configureBackgroundFetch() async {
    BackgroundFetch.configure(BackgroundFetchConfig(
        minimumFetchInterval: 15,
        startOnBoot: true,
        stopOnTerminate: false,
        enableHeadless: true,
        requiresStorageNotLow: false,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresDeviceIdle: false,
        requiredNetworkType: NetworkType.NONE
    ), (String taskId) async {
      print("[BackgroundFetch] received event $taskId");
      bg.Logger.debug("🔔 [BackgroundFetch start] " + taskId);

      if (taskId == 'flutter_background_fetch') {
        try {
          // Fetch current position
          var location = await bg.BackgroundGeolocation.getCurrentPosition(
              samples: 2,
              maximumAge: 1000 * 10,  // 30 seconds ago
              timeout: 30,
              desiredAccuracy: 40,
              extras: {
                "event": "background-fetch",
                "headless": false
              }
          );
          print("[location] $location");
        } catch(error) {
          print("[location] ERROR: $error");
        }

        // Test scheduling a custom-task in fetch event.
        BackgroundFetch.scheduleTask(TaskConfig(
            taskId: "com.transistorsoft.customtask",
            delay: 5000,
            periodic: false,
            forceAlarmManager: false,
            stopOnTerminate: false,
            enableHeadless: true
        ));
      }
      bg.Logger.debug("🔔 [BackgroundFetch finish] " + taskId);
      BackgroundFetch.finish(taskId);
    });
  }

  Future<void> _onLocation(bg.Location location) async {
    print('[${bg.Event.LOCATION}] - $location');

    LocalLocation pre = LocalLocation(
        type: "Point",
        coordinates: [location.coords.latitude ,location.coords.longitude],
        radius: "50",
        address: "");

    await DatabaseHandler().setLocation(pre.toJson());
  }

  void _onLocationError(bg.LocationError error) {
    print('[${bg.Event.LOCATION}] ERROR - $error');
  }

  void _onActivityChange(bg.ActivityChangeEvent event) {
    print('[${bg.Event.ACTIVITYCHANGE}] - $event');
  }

  void _onMotionChange(bg.Location location) {
    print('[${bg.Event.MOTIONCHANGE}] - $location');
    isMoving!.value = location.isMoving;
  }

  void _onProviderChange(bg.ProviderChangeEvent event) async {
    print('[${bg.Event.PROVIDERCHANGE}] - $event');

    if ((event.status == bg.ProviderChangeEvent.AUTHORIZATION_STATUS_ALWAYS) && (event.accuracyAuthorization == bg.ProviderChangeEvent.ACCURACY_AUTHORIZATION_REDUCED)) {
      // Supply "Purpose" key from Info.plist as 1st argument.
      bg.BackgroundGeolocation.requestTemporaryFullAccuracy("DemoPurpose").then((int accuracyAuthorization) {
        if (accuracyAuthorization == bg.ProviderChangeEvent.ACCURACY_AUTHORIZATION_FULL) {
          print("[requestTemporaryFullAccuracy] GRANTED:  $accuracyAuthorization");
        } else {
          print("[requestTemporaryFullAccuracy] DENIED:  $accuracyAuthorization");
        }
      }).catchError((error) {
        print("[requestTemporaryFullAccuracy] FAILED TO SHOW DIALOG: $error");
      });
    }
  }

  void _onHttp(bg.HttpEvent event) async {
    print('[${bg.Event.HTTP}] - $event');
  }

  void _onConnectivityChange(bg.ConnectivityChangeEvent event) {
    print('[${bg.Event.CONNECTIVITYCHANGE}] - $event');
  }

  void _onHeartbeat(bg.HeartbeatEvent event) async {
    print('[${bg.Event.HEARTBEAT}] - $event');
    // In onHeartbeat, if you intend to any kind of async task, first start a background-task:
    var taskId = await bg.BackgroundGeolocation.startBackgroundTask();

    // Now that we've initiated a background-task, call .getCurrentPosition()
    try {
      bg.Location location = await bg.BackgroundGeolocation.getCurrentPosition(
          samples: 2,
          timeout: 10,
          extras: {
            "event":"heartbeat"
          }
      );
      print("[heartbeat] getCurrentPosition: $location");
    } catch(e) {
      print("[heartbeat] getCurrentPosition ERROR: $e");
    }

    // Be sure to signal completion of your task.
    bg.BackgroundGeolocation.stopBackgroundTask(taskId);
  }

  void _onSchedule(bg.State state) {
    print('[${bg.Event.SCHEDULE}] - $state');
  }

  void _onEnabledChange(bool isEnable) {
    print('[${bg.Event.ENABLEDCHANGE}] - $enabled');
    enabled!.value = isEnable;
  }

  void _onPowerSaveChange(bool enabled) {
    print('[${bg.Event.POWERSAVECHANGE}] - $enabled');
  }


}
