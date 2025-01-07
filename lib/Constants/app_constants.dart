import 'package:flutter/material.dart';

abstract class AppConstants {
  /*
    App Name
  */
  static const String appName = 'Party Lux';

  /*
    In OverAll App outline and rounded Radius 
  */
  static const Radius outlineWidgetRadius = Radius.circular(10);
  static const Radius roundedWidgetRadius = Radius.circular(12);

  /*
    Base-URL of Server Side APIs.
  */
  //static const String baseURL = "https://partlux-backend.tekstagearea.com/v1/";
  static const String baseURL = "https://api.partylux.app/v1/";
      // "http://192.168.0.157:8080/v1/"; //=>>  LocalHost
  //"https://backend-partylux-staging.up.railway.app/v1/"; //=>>  Client Staging
  // "https://backend-partylux-production.up.railway.app/v1/"; //=>>  Dev Server

  /*
    Google Map API Key for access Map 
  */
  // static String map_apikey = 'AIzaSyCzc4Gml6I-lOx0NmL7jl6Zfi3iKA85wkM';
  static String map_apikey = 'AIzaSyC_CF3AqDcZVJSiaG8shBYlFrMUDuQSavs';
  static String applePayMerchantId = 'merchant.com.partylux.dev';
  static String googlePayMerchantId = 'BCR2DN4TYGE3R3KM';

  //static const stripePublicKey="pk_test_51NQC3nEQeufHHynAJbBSYy1WM2FllcNHTD3yUIo9SRypM8Fdn4wkGvFhBVrQ1UoPbWUEhMXGsFofs5CzA9tk1G6q00kkK4NUzt";
  //static const stripePublicKey="pk_test_51NBJZdHRtdBzjprBPG0SbOHT09ijD1HmCkeDisFEAGtrqKzjDtqSZydM3AP1qJ5xrFJUyx3MONmdngA9LxZpVHKH009Gpsh8eP";
  static const stripePublicKey="pk_live_51NBJZdHRtdBzjprBATTAOv4tdyL7wKPd0Lj1Q58pjKvAbjAqGckpG5jeE28aICy6AX8AVGZ2iSGCp6yKPmygoXrs009Lrpp6sA";

  static const notificationChannelId='party_lux';
  static const notificationChannelName="Party Lux";
  static const notificationChannelDescription='This channel is used for important notifications.';

  static const defaultNotificationSound="ringtone1";

  /*
    Initial Camera Position Lat and Lng 
    In any case, if device not getting LatLng then by defult this latlng use. 
  */
  // static const LatLng initialCameraPosition = const LatLng(28.4212, 70.2989);
}
