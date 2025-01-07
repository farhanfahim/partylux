// ignore_for_file: library_prefixes, avoid_print, prefer_interpolation_to_compose_strings, body_might_complete_normally_catch_error

import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart' as DIO;
import 'package:partylux/Utils/Network/server_error.dart';
import 'package:partylux/Utils/Network/tost.dart';
import 'api_urls.dart';
import 'cache_handler.dart';

class API {
  Future<dynamic> barCodePost(String apiurl, var data, {String? tempToken}) async {
    ////°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°/////
    ///todo: API Token
    var token = tempToken ?? await DatabaseHandler().getToken();
    print("APIClient[Token] ==>> " + token.toString());
    print("APIClient[URL] ==>> " + ApiManager.BASE_URL + apiurl);
    print("APIClient[Map] ==>> " + data.toString());

    ////°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°/////
    //////todo: API Call
    try {
      var dio = DIO.Dio();
      var response = await dio.post(
        ApiManager.BASE_URL + apiurl,
        data: data,
        options: DIO.Options(headers: {
          "Accept": '*/*',
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${token.toString()}",
        }),
        onSendProgress: (int sent, int total) {
          debugPrint("total ${total.toString()} " "   sent ${sent.toString()}");
        },
      ).whenComplete(() {
        debugPrint("POST Complete:");
      }).catchError((onError) {
        debugPrint("POST Error: $onError");
        debugPrint("POST Error: ${onError}");
        // if (onError is SocketException) {
        //   debugPrint("No internet connection!");
        //   Toast().error(massage: "No internet connection!");
        // } else {
        if (onError is DIO.DioError) {
          if (ServerError.withError(error: onError).getErrorCode() == 401) {
            // onSessionExpirePopUp();
            Toast().error(
                massage: ServerError.withError(error: onError)
                    .getErrorMessage()
                    .toString());
          } else if (ServerError.withError(error: onError).getErrorCode() == 403) {
            //Toast().error(massage: "Not Valid");
          }else {
            Toast().error(
                massage: ServerError.withError(error: onError)
                    .getErrorMessage()
                    .toString());
          }
        }
        
      });
      print("object $response");
      return response;
    } catch (e) {
      print(['POST API exception get', e.toString()]);
    }
  }

  Future<dynamic> post(String apiurl, var data, {String? tempToken}) async {
    ////°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°/////
    ///todo: API Token
    var token = tempToken ?? await DatabaseHandler().getToken();
    print("APIClient[Token] ==>> " + token.toString());
    print("APIClient[URL] ==>> " + ApiManager.BASE_URL + apiurl);
    print("APIClient[Map] ==>> " + data.toString());

    ////°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°/////
    //////todo: API Call
    try {
      var dio = DIO.Dio();
      var response = await dio.post(
        ApiManager.BASE_URL + apiurl,
        data: data,
        options: DIO.Options(headers: {
          "Accept": '*/*',
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${token.toString()}",
        }),
        onSendProgress: (int sent, int total) {
          debugPrint("total ${total.toString()} " "   sent ${sent.toString()}");
        },
      ).whenComplete(() {
        debugPrint("POST Complete:");
      }).catchError((onError) {
        debugPrint("POSTA Error: $onError");
        debugPrint("POST Error: ${onError}");
        // if (onError is SocketException) {
        //   debugPrint("No internet connection!");
        //   Toast().error(massage: "No internet connection!");
        // } else {
        if (onError is DIO.DioException) {
          log("dio exception: ${onError}");
          log("dio exception is data: ${onError.response?.data}");

          if (ServerError.withError(error: onError).getErrorCode() == 401) {
            // onSessionExpirePopUp();
            Toast().error(
                massage: ServerError.withError(error: onError)
                    .getErrorMessage()
                    .toString());
          } /*else if (ServerError.withError(error: onError).getErrorCode() == 403) {
            Toast().error(massage: onError.response!.data['msg']);
          }*/else {
            Toast().error(
                massage: onError.response!.data["message"]);
          /*  Toast().error(
                massage: ServerError.withError(error: onError)
                    .getErrorMessage()
                    .toString());*/
          }
        }

      });
      print("object $response");
      return response;
    } catch (e) {
      print(['POST API exception get', e.toString()]);
    }
  }

  Future<dynamic> get(String apiurl, {String? tempToken,Map<String,dynamic>? queryParameters,}) async {
    ////°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°/////
    ///todo: API Token
    var token = tempToken ?? await DatabaseHandler().getToken();
    print("APIClient[Token] ==>> " + token.toString());
    print("APIClient[URL] ==>> " + ApiManager.BASE_URL + apiurl);

    print("token: $token");

    ////°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°/////
    //////todo: API Call
    try {
      var dio = DIO.Dio();
      var response = await dio
          .get(
        ApiManager.BASE_URL + apiurl,

        options: DIO.Options(headers: {
          "Accept": '*/*',
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${token.toString()}",
        }),
          queryParameters:queryParameters,
      )
          .whenComplete(() {
        debugPrint("POST Complete:");
      }).catchError((onError) {
        debugPrint("POST Error: $onError");
        if (onError is SocketException) {
          debugPrint("No internet connection!");
          Toast().error(massage: "No internet connection!");
        } else {
          if (onError is DIO.DioError) {
            if (ServerError.withError(error: onError).getErrorCode() == 401) {
              // onSessionExpirePopUp();
            }else if (ServerError.withError(error: onError).getErrorCode() == 404) {
              //Toast().error(massage: onError.response!.data['msg']);
            } else {

              Toast().error(
                  massage: ServerError.withError(error: onError)
                      .getErrorMessage()
                      .toString());
            }
          }
        }
      });
      return response;
    } catch (e) {
      print(['POST API exception get', e.toString()]);
    }
  }

  Future delete(String apiurl, {var data, String? tempToken}) async {
    ////°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°/////
    ///todo: API Token
    var token = tempToken ?? await DatabaseHandler().getToken();
    print("APIClient[Token] ==>> " + token.toString());
    print("APIClient[URL] ==>> " + ApiManager.BASE_URL + apiurl);

    ////°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°/////
    //////todo: API Call
    try {
      var dio = DIO.Dio();
      var response = await dio
          .delete(
        ApiManager.BASE_URL + apiurl,
        data: data ?? null,
        options: DIO.Options(headers: {
          "Accept": '*/*',
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${token.toString()}",
        }),
      )
          .whenComplete(() {
        debugPrint("POST Complete:");
      }).catchError((onError) {
        debugPrint("POST Error: $onError");
        if (onError is SocketException) {
          debugPrint("No internet connection!");
          Toast().error(massage: "No internet connection!");
        } else {
          if (onError is DIO.DioError) {
            if (ServerError.withError(error: onError).getErrorCode() == 401) {
              // onSessionExpirePopUp();
            } else {
              Toast().error(
                  massage: ServerError.withError(error: onError)
                      .getErrorMessage()
                      .toString());
            }
          }
        }
      });
      return response;
    } catch (e) {
      print(['POST API exception get', e.toString()]);
    }
  }

  Future<dynamic> patch(String apiurl, var data, {String? tempToken}) async {
    ////°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°/////
    ///todo: API Token
    var token = tempToken ?? await DatabaseHandler().getToken();
    print("APIClient[Token] ==>> " + token.toString());
    print("APIClient[URL] ==>> " + ApiManager.BASE_URL + apiurl);
    print("APIClient[Map] ==>> " + data.toString());

    ////°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°/////
    //////todo: API Call
    try {
      var dio = DIO.Dio();
      var response = await dio.patch(
        ApiManager.BASE_URL + apiurl,
        data: data??null,
        options: DIO.Options(headers: {
          "Accept": '*/*',
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${token.toString()}",
        }),
        onSendProgress: (int sent, int total) {
          debugPrint("total ${total.toString()} " "   sent ${sent.toString()}");
        },
      ).whenComplete(() {
        debugPrint("POST Complete:");
      }).catchError((onError) {
        debugPrint("POST Error: $onError");
        if (onError is SocketException) {
          debugPrint("No internet connection!");
          Toast().error(massage: "No internet connection!");
        } else {
          if (onError is DIO.DioError) {
            if (ServerError.withError(error: onError).getErrorCode() == 401) {
              // onSessionExpirePopUp();
            } else {
              Toast().error(
                  massage: ServerError.withError(error: onError)
                      .getErrorMessage()
                      .toString());
            }
          }
        }
      });
      print("object $response");
      return response;
    } catch (e) {
      print(['POST API exception get', e.toString()]);
    }
  }

  Future<dynamic> put(String apiurl, var data, {String? tempToken}) async {
    ////°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°/////
    ///todo: API Token
    var token = tempToken ?? await DatabaseHandler().getToken();
    print("APIClient[Token] ==>> " + token.toString());
    print("APIClient[URL] ==>> " + ApiManager.BASE_URL + apiurl);
    print("APIClient[Map] ==>> " + data.toString());

    ////°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°/////
    //////todo: API Call
    try {
      var dio = DIO.Dio();
      var response = await dio.put(
        ApiManager.BASE_URL + apiurl,
        data: data,
        options: DIO.Options(headers: {
          "Accept": '*/*',
          'Content-Type': 'application/json',
          "Authorization": "Bearer ${token.toString()}",
        }),
        onSendProgress: (int sent, int total) {
          debugPrint("total ${total.toString()} " "   sent ${sent.toString()}");
        },
      ).whenComplete(() {
        debugPrint("POST Complete:");
      }).catchError((onError) {
        debugPrint("POST Error: $onError");
        if (onError is SocketException) {
          debugPrint("No internet connection!");
          Toast().error(massage: "No internet connection!");
        } else {
          if (onError is DIO.DioError) {
            if (ServerError.withError(error: onError).getErrorCode() == 401) {
              // onSessionExpirePopUp();
            } else {
              Toast().error(
                  massage: ServerError.withError(error: onError)
                      .getErrorMessage()
                      .toString());
            }
          }
        }
      });
      print("object $response");
      return response;
    } catch (e) {
      print(['POST API exception get', e.toString()]);
    }
  }
}
