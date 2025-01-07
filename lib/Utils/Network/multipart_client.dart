// ignore_for_file: library_prefixes, body_might_complete_normally_catch_error

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart' as DIO;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:partylux/Utils/Network/server_error.dart';
import 'package:partylux/Utils/Network/tost.dart';
import 'api_urls.dart';
import 'cache_handler.dart';

class MultiPartAPI {

  Future videoUpload(
    String apiurl,
    var data, {
    String? accessToken,
  }) async {
    print("URL ==>> " + ApiManager.BASE_URL + apiurl);
    FormData formData;
    String fileName = await data.split('/').last;
    String fileNameWithoutExt = await fileName.split('.').first;
    print("farhan $data");
    print("farhan $fileNameWithoutExt");
    print(data);
    formData = FormData.fromMap({
      "video": await MultipartFile.fromFile(data,filename:"${fileNameWithoutExt}.mp4",contentType: MediaType.parse("video/mp4")),
    });

    ////°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°/////
    //////todo: API Call
    try {
      var dio = DIO.Dio();
      var response = await dio.post(
        ApiManager.BASE_URL + apiurl,
        data: formData,
      ).whenComplete(() {
        debugPrint("POST Complete:");
      }).catchError((onError) {
        if(onError is DioException){
          debugPrint("frhn: ${onError.response?.data}");
        }
        debugPrint("POST Error: $onError");
        print(ServerError.withError(error: onError).getErrorCode());
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

  Future profileImage(
      String apiurl,
      var data, {
        String? accessToken,
      }) async {
    ////°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°/////
    ///todo: API Token
    var token = (accessToken != "" && accessToken != null)
        ? accessToken
        : await DatabaseHandler().getToken();
    print("Token ==>> " + token.toString());
    print("URL ==>> " + ApiManager.BASE_URL + apiurl);
    FormData formData;
    String fileName = await data.split('/').last;
    print("fileName $fileName");
    formData = FormData.fromMap({
      "photo": await MultipartFile.fromFile(data, filename: fileName),
    });
    print("key " + formData.files[0].key.toString());
    print("filename " + formData.files[0].value.filename.toString());

    ////°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°/////
    //////todo: API Call
    try {
      var dio = DIO.Dio();
      var response = await dio.post(
        ApiManager.BASE_URL + apiurl,
        data: formData,
        options: DIO.Options(headers: {
          "Accept": 'application/json',
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
        print(ServerError.withError(error: onError).getErrorCode());
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

  Future<List<String>> multiImageUpload(
    List<String> imagePathList, {
    String? accessToken,
  }) async {
    List<String> imageUrls = [];
    ////°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°/////
    var token = (accessToken != "" && accessToken != null)
        ? accessToken
        : await DatabaseHandler().getToken();
    print("Token ==>> " + token.toString());
    print(
      "URL ==>> " + ApiManager.BASE_URL + ApiManager.UPLOAD_MULTI_PHOTO,
    );
    print("imagePathList " + imagePathList.length.toString());
    for (String imagePath in imagePathList) {
      final mimeTypeData = lookupMimeType(File(imagePath).path, headerBytes: [0xFF, 0xD8])!.split('/');
      final imageUploadRequest = http.MultipartRequest(
        'POST',
        Uri.parse(
          ApiManager.BASE_URL + ApiManager.UPLOAD_MULTI_PHOTO,
        ),
      );

      imageUploadRequest.headers.addAll({
       // "Accept": 'application/json',
       // 'Content-Type': 'application/json',
        "Authorization": "Bearer ${token.toString()}",
      });

      print("mime data: ${mimeTypeData}");

      final file = await http.MultipartFile.fromPath(
        'uploadedImages',
        File(imagePath).path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
      );

      imageUploadRequest.files.add(file);

      try {
        final streamedResponse = await imageUploadRequest.send();
        final response = await http.Response.fromStream(streamedResponse);

        print("image response: ${response.body}");
        if (response.statusCode == 200) {
          print("Image uploaded successfully");
          imageUrls.add(jsonDecode(response.body)["data"][0]);
        } else {
          print("Image upload failed");
          Toast().error(massage: jsonDecode(response.body)["error"].toString());
         // error: {message: Multer uploading error: File too large}
        }
      } catch (e) {
        print(e.toString());
      }
    }
    return imageUrls;
  }
}
