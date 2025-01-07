// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'dart:developer';

import 'package:partylux/Modules/Auth%20Module/Models/usermodel.dart';
import 'package:partylux/Modules/add_location_picker/model/local_location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Modules/BecomePartner/Model/become_partner_model.dart';

class DatabaseHandler {
  Future<bool> isExists(String inputString) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var check = prefs.getString(inputString);
    return check == null ? false : true;
  }

//? < = = = = = = = = = = = Current User Data = = = = = = = = = = = = = = = >

  setUserData(Map<String, dynamic> myData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String rawJson = jsonEncode(myData);
    bool result = await prefs.setString('userImformation', rawJson);
    print("Saved User Data $result.");
  }

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await prefs.getString('userImformation');
    log("user data: ${response}");
    UserModel data = response != null
        ? UserModel.fromJson(jsonDecode(response))
        : UserModel.fromEmpty();
    return data;
    // response != null ? jsonDecode(response) : null;
  }

  //? < = = = = = = = = = = = GeoFencing Store = = = = = = = = = = = = = = = >

  setGeoFencingData(List<BecomePartnerModel> myData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonList =
        myData.map((item) => BecomePartnerModel.toJson(item)).toList();
    String rawJson = jsonEncode(jsonList);
    bool result = await prefs.setString('geoFencing', rawJson);
    print("Saved User Data $result.");
  }

  getGeoFencingData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await prefs.getString('geoFencing');
    print(response);
    List<BecomePartnerModel> data = response != null
        ? BecomePartnerModel.fromJsonToList(jsonDecode(response))
        : [];
    return data;
    // response != null ? jsonDecode(response) : null;
  }

  //? < = = = = = = = = = = = Current User Email = = = = = = = = = = = = = = = >

  setCurrentEmail(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var val = await prefs.setString('currentemail', value);
    print("currentemail  is $val");
  }

  getCurrentEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = prefs.getString('currentemail') ?? "";
    return response;
  }

  //? < = = = = = = = = = = = On Boarding value = = = = = = = = = = = = = = = >

  setOnBoarding(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var val = await prefs.setBool('OnBoarding', value);
    print("Stay OnBoarding value is $val");
  }

  getOnBoarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = prefs.getBool('OnBoarding') ?? false;
    return response;
  }

  //? < = = = = = = = = = = = Radius value = = = = = = = = = = = = = = = >

  setRadius(double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var val = await prefs.setDouble('radius', value);
    print("radius value is $val");
  }

  getRadius() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = prefs.getDouble('radius') ?? 30;
    return response;
  }

  //? < = = = = = = = = = = = Location value = = = = = = = = = = = = = = = >

  setLocation(Map<String, dynamic> myData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String rawJson = jsonEncode(myData);
    await prefs.setString('prediction', rawJson);
  }

  getLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await prefs.getString('prediction');
    print(response);
    LocalLocation data = response != null
        ? LocalLocation.fromJson(jsonDecode(response))
        : LocalLocation();
    return data;
  }

//? < = = = = = = = = = = = User Access Token = = = = = = = = = = = = = = = >
  setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = await prefs.setString('token', token);
    print("token saved " + result.toString());
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = prefs.getString('token') ?? "";
    return response;
  }

//? < = = = = = = = = = = = User Access Token = = = = = = = = = = = = = = = >
  setTempToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = await prefs.setString('tempToken', token);
    print("token saved " + result.toString());
  }

  getTempToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = prefs.getString('tempToken') ?? "";
    return response;
  }

  removeTempToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = await prefs.remove("user");
    print("token Removed " + result.toString());
  }

  // ? < = = = = = = = = = = = User FCM = = = = = = = = = = = = = = = >
  setFCMToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = await prefs.setString('FCM', token);
    print("fcm saved " + result.toString());
  }

  getFCMToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = prefs.getString('FCM') ?? "";
    return response;
  }
  // ? < = = = = = = = = = = = Push Notification = = = = = = = = = = = = = = = >
  setNotification(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = await prefs.setBool('isNotification', value);
    print("fcm saved " + result.toString());
  }

  getNotification() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = prefs.getBool('isNotification') ?? false;
    return response;
  }

  setEventType(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = await prefs.setString('eventType', value);
    print("fcm saved " + result.toString());
  }

  getEventType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = prefs.getString('eventType') ?? "";
    return response;
  }

  setActionID(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = await prefs.setString('actionId', value);
    print("fcm saved " + result.toString());
  }

  getActionID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = prefs.getString('actionId') ?? "";
    return response;
  }

//? < = = = = = = = = = = = Logout = = = = = = = = = = = = =>
  logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
