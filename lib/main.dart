// ignore_for_file: unused_element

import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:partylux/Constants/app_constants.dart';
import 'package:partylux/Constants/app_pages.dart';
import 'package:partylux/Constants/app_routes.dart';
import 'package:partylux/Constants/color.dart';
import 'package:partylux/Utils/Common/sizer.dart';
import 'package:partylux/Utils/Network/api_urls.dart';
import 'package:partylux/service/payment/stripe_service.dart';
import 'Constants/constants.dart';
import 'Utils/Network/cache_handler.dart';
import 'Utils/Theme/themes.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart' as bg;

import 'Utils/Util.dart';
import 'Utils/navigation.dart';
import 'models/extra_payload.dart';




// [Android-only] This "Headless Task" is run when the Android app
// is terminated with enableHeadless: true

/// Receive events from BackgroundGeolocation in Headless state.
@pragma('vm:entry-point')
void backgroundGeolocationHeadlessTask(bg.HeadlessEvent headlessEvent) async {
  print('📬 --> $headlessEvent');

  switch (headlessEvent.name) {
    case bg.Event.BOOT:
      bg.State state = await bg.BackgroundGeolocation.state;
      print("📬 didDeviceReboot: ${state.didDeviceReboot}");
      break;
    case bg.Event.TERMINATE:
      bg.State state = await bg.BackgroundGeolocation.state;
      if (state.stopOnTerminate!) {
        // Don't request getCurrentPosition when stopOnTerminate: true
        return;
      }
      try {
        bg.Location location =
        await bg.BackgroundGeolocation.getCurrentPosition(
            samples: 1,
        );
        print("[getCurrentPosition] Headless: $location");
      } catch (error) {
        print("[getCurrentPosition] Headless ERROR: $error");
      }

      break;
    case bg.Event.HEARTBEAT:
      try {
        bg.Location location = await bg.BackgroundGeolocation.getCurrentPosition(
            samples: 2,
            timeout: 10,
        );

        print('[getCurrentPosition] Headless: $location');
      } catch (error) {
        print('[getCurrentPosition] Headless ERROR: $error');
      }
      break;
    case bg.Event.LOCATION:
      bg.Location location = headlessEvent.event;
      print(location);
      break;
    case bg.Event.MOTIONCHANGE:
      bg.Location location = headlessEvent.event;
      print(location);
      break;
    case bg.Event.GEOFENCE:
      bg.GeofenceEvent geofenceEvent = headlessEvent.event;
      print(geofenceEvent);
      break;
    case bg.Event.GEOFENCESCHANGE:
      bg.GeofencesChangeEvent event = headlessEvent.event;
      print(event);
      break;
    case bg.Event.SCHEDULE:
      bg.State state = headlessEvent.event;
      print(state);
      break;
    case bg.Event.ACTIVITYCHANGE:
      bg.ActivityChangeEvent event = headlessEvent.event;
      print(event);
      break;
    case bg.Event.HTTP:
      bg.HttpEvent response = headlessEvent.event;
      print(response);
      break;
    case bg.Event.POWERSAVECHANGE:
      bool enabled = headlessEvent.event;
      print(enabled);
      break;
    case bg.Event.CONNECTIVITYCHANGE:
      bg.ConnectivityChangeEvent event = headlessEvent.event;
      print(event);
      break;
    case bg.Event.ENABLEDCHANGE:
      bool enabled = headlessEvent.event;
      print(enabled);
      break;
  }
}

/// Receive events from BackgroundFetch in Headless state.
@pragma('vm:entry-point')
void backgroundFetchHeadlessTask(HeadlessTask task) async {
  String taskId = task.taskId;

  // Is this a background_fetch timeout event?  If so, simply #finish and bail-out.
  if (task.timeout) {
    print("[BackgroundFetch] HeadlessTask TIMEOUT: $taskId");
    BackgroundFetch.finish(taskId);
    return;
  }

  print("[BackgroundFetch] HeadlessTask: $taskId");

  try {
    var location = await bg.BackgroundGeolocation.getCurrentPosition(
        samples: 2,
        extras: {
          "event": "background-fetch",
          "headless": true
        }
    );
    print("[location] $location");
  } catch(error) {
    print("[location] ERROR: $error");
  }

  BackgroundFetch.finish(taskId);
}


/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print('Handling a background message ${message.notification}');

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness:
          Platform.isIOS ? Brightness.dark : Brightness.light,
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark,
    ),
  );

  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  await StripeService.init();
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

/*  channel = const AndroidNotificationChannel(
    '1', // id
    "Party Lux", // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.high,
  );*/

  channel = const AndroidNotificationChannel(
    AppConstants.notificationChannelId,
    AppConstants.notificationChannelName,
    description: AppConstants.notificationChannelDescription, // description
    importance: Importance.high,
    playSound: true,
    enableVibration: true,
    sound: const RawResourceAndroidNotificationSound(AppConstants.defaultNotificationSound),
  );

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  if (Platform.isAndroid) {
    var initializationSettingsAndroid =
    AndroidInitializationSettings('launcher_icon');
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid/*, iOS: initializationSettingsIOS*/);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (value) => onSelectNotification(value));
  }

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance
      .setForegroundNotificationPresentationOptions(
    alert: false,
    badge: true,
    sound: true,
  );

  runApp(MyApp());
  configLoading();


  /// Register BackgroundGeolocation headless-task.
  bg.BackgroundGeolocation.registerHeadlessTask(backgroundGeolocationHeadlessTask);

  /// Register BackgroundFetch headless-task.
  BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
}


Future<void> onSelectNotification(dynamic map1) async {


  var map = jsonDecode(map1);
  ExtraPayload payload = ExtraPayload.fromJson(map);

  print('payload ${payload.toJson()}');

  if(payload.eventName == Constants.PUSH_EVENT){
    Get.toNamed(
        AppRoutes.myEvent, arguments: [payload.actionId, Constants.EVENT_UN_KNOWN]);
  }
  else if(payload.eventName == Constants.PUSH_E_TICKET){
    Get.toNamed(
      AppRoutes.ticketDetailView, arguments: [payload.actionId,"normal"],
    );

  }
  else if(payload.eventName == Constants.PUSH_PAYMENT){
    AppNavigator.navigateToNamed(AppRoutes.paymentMethodView, arguments: {
      Constants.paramFrom: true,
      Constants.paramFrom2: payload.actionId,
    });
  }
  else{
    Get.offAllNamed(AppRoutes.NAV_ROOT);
  }
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..radius = 15.0
    ..userInteractions = true
    ..backgroundColor = AppColors.iconColor.withOpacity(0.2)
    ..dismissOnTap = true;
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {

    super.initState();
    initializeFB();

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print(message.notification!.title!);

        Future.delayed(const Duration(milliseconds: 500), () async {

          ExtraPayload payloadData = ExtraPayload.fromJson(message.data);
          await DatabaseHandler().setNotification(true);
          await DatabaseHandler().setEventType(payloadData.eventName!);
          await DatabaseHandler().setActionID(payloadData.actionId!);

        });
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {

      var map12 = (message.notification);


      if (map12 != null ) {
        flutterLocalNotificationsPlugin.show(
           // int.parse(channel.id),
            1,
            map12.title,
            map12.body,
            NotificationDetails(
              iOS: IOSNotificationDetails(
                badgeNumber: 0, presentAlert: true,
                presentBadge: true, presentSound: true,
                sound: "${AppConstants.defaultNotificationSound}.aiff",
              ),
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: 'launcher_icon',
                importance: Importance.max,
                priority: Priority.max,
                playSound: true,
                enableVibration: true,
                sound: const RawResourceAndroidNotificationSound(AppConstants.defaultNotificationSound),
              ),
            ),
            payload: Platform.isAndroid? jsonEncode(message.data) : null
        );


      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {

      ExtraPayload payload = ExtraPayload.fromJson(message.data);

      print('payload ${payload.toJson()}');

      if(payload.eventName == Constants.PUSH_EVENT){
        Get.toNamed(
            AppRoutes.myEvent, arguments: [payload.actionId, Constants.EVENT_UN_KNOWN]);
      }
      else if(payload.eventName == Constants.PUSH_E_TICKET){
        Get.toNamed(
          AppRoutes.ticketDetailView, arguments: [payload.actionId,"normal"],
        );
      }
      else if(payload.eventName == Constants.PUSH_PAYMENT){
        AppNavigator.navigateToNamed(AppRoutes.paymentMethodView, arguments: {
          Constants.paramFrom: true,
          Constants.paramFrom2: payload.actionId,
        });
      }
      else{
        Get.offAllNamed(AppRoutes.NAV_ROOT);
      }

    });
  }

  Future<void> initializeFB() async {

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    messaging.getToken().then((token) async {

      print('FCM Token: $token ');
      await DatabaseHandler().setFCMToken(token!);

    });
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Party Lux',
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: ThemeMode.dark,
        builder: (context, child) {
          var media=MediaQuery.of(context);
          print("media is: ${media.size}");
          AppSizer.initMedia(media);
          child = EasyLoading.init()(context, child);
          child = ScrollConfiguration(
            behavior: MyBehavior(),
            child: child,
          );
          return MediaQuery(
              data: media,
              child: media.size==Size.zero?const SizedBox.shrink():child);
        },
        getPages: AppPages.routes,
        initialRoute: AppRoutes.SPLASH_SCREEN,
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

