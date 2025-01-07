// import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore_for_file: unused_local_variable

import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as DIO;
import 'package:partylux/Constants/app_constants.dart';
import 'package:partylux/Modules/Profile%20Module/Profile%20Section/Model/google_map_model.dart';

class GooglePlaceHandler {
  var client = http.Client();

  Future<List<PlaceSearch>> autoCompleteSearch(
    String value, {
    required String lat,
    required String lng,
    String region = "",
  }) async {
    List<PlaceSearch> placesList = [];
    String api_key = AppConstants.map_apikey;
    // String radius = AppConstants.autocomplete_radius.toString();
    String apiurl =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$value&key=$api_key";

    // String apiurl =
    // "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$value&strictbounds=true&location=$lat,$lng&types=restaurant|cafe|gym|bar|university&language=en&region=$region&key=$api_key";
    var dio = DIO.Dio();
    var result = await dio.get(
      apiurl,
      options: DIO.Options(
        headers: {
          "Accept": 'application/json',
        },
      ),
    );
    print(
        "autoCompleteSearch Response Code is =" + result.statusCode.toString());
    if (result.statusCode == 200) {
      if (result.data["predictions"].isNotEmpty) {
        placesList =
            PlaceSearch.jsonToAutoCompleteList(result.data["predictions"]);
      }
    }
    return placesList;
  }

  Future<PlaceModel> placeDetailSearch(String placeID) async {
    PlaceModel placeModel = PlaceModel.fromEmpty();
    String api_key = AppConstants.map_apikey;
    String apiurl =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeID&key=$api_key";
    var dio = DIO.Dio();
    var result = await dio.get(
      apiurl,
      options: DIO.Options(
        headers: {
          "Accept": 'application/json',
        },
      ),
    );
    print(
        "placeDetailSearch Response Code is =" + result.statusCode.toString());
    if (result.statusCode == 200) {
      placeModel = PlaceModel.fromJson(result.data["result"]);
    }
    return placeModel;
  }

  Future<List<NearBySearch>> nearBySearch({
    required String lat,
    required String lng,
    required String seachedResturantNearByID,
  }) async {
    // final _mapConstoller = Get.put(PlacesSearchViewModel());
    List<NearBySearch> nearbyScarchList = [];
    String api_key = AppConstants.map_apikey;
    // String radius = AppConstants.nearby_radius.toString();
    String apiurl =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&type=restaurant|cafe|gym|bar|university&language=en&key=$api_key";
    var dio = DIO.Dio();
    var result = await dio.get(
      apiurl,
      options: DIO.Options(
        headers: {
          "Accept": 'application/json',
        },
      ),
    );
    print("nearBySearch Response Code is =" + result.statusCode.toString());
    if (result.statusCode == 200) {
      if (result.data["results"].isNotEmpty) {
        nearbyScarchList =
            NearBySearch.jsonToNearBySearchList(result.data["results"]);
      } else {
        print("Result is empty");
      }
    }
    print("testIDs => ${nearbyScarchList[0].placeId.toString()}");
    print("testIDs => ${seachedResturantNearByID.toString()}");

    nearbyScarchList.sort(
      (a, b) {
        if (a.placeId == seachedResturantNearByID) {
          return -1; // move "hello" to the front
        } else if (b.placeId == seachedResturantNearByID) {
          return 1; // move "hello" to the front
        } else {
          return a.placeId.compareTo(b.placeId); // sort normally
        }
      },
    );
    // _mapConstoller.nearByListData.value = nearbyScarchList;

    // print("nearByListData length" +
    // _mapConstoller.nearByListData.length.toString());
    return nearbyScarchList;
  }
}
