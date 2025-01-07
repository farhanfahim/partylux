// To parse this JSON data, do
//
//     final eTickerModel = eTickerModelFromJson(jsonString);

import 'dart:convert';

ETickerModel eTickerModelFromJson(String str) =>
    ETickerModel.fromJson(json.decode(str));

String eTickerModelToJson(ETickerModel data) => json.encode(data.toJson());

class ETickerModel {
  bool? error;
  int? status;
  String? msg;
  Data? data;

  ETickerModel({
    this.error,
    this.status,
    this.msg,
    this.data,
  });

  factory ETickerModel.fromJson(Map<String, dynamic> json) => ETickerModel(
        error: json["error"],
        status: json["status"],
        msg: json["msg"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "status": status,
        "msg": msg,
        "data": data?.toJson(),
      };
}

class Data {
  int? eventPrice;
  int? feePercentage;
  String? eventName;
  String? currency;
  String? mode;
  String? paymentStatus;
  List<String>? paymentMethodTypes;
  String? paymentUrl;
  String? id;
  String? eventSubscriber;
  String? customerId;
  String? paymentIntent;
  String? eventId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Data({
    this.eventPrice,
    this.feePercentage,
    this.eventName,
    this.currency,
    this.mode,
    this.paymentStatus,
    this.paymentMethodTypes,
    this.paymentUrl,
    this.id,
    this.eventSubscriber,
    this.customerId,
    this.paymentIntent,
    this.eventId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        eventPrice: json["eventPrice"],
        feePercentage: json["fee_percentage"],
        eventName: json["eventName"],
        currency: json["currency"],
        mode: json["mode"],
        paymentStatus: json["paymentStatus"],
        paymentMethodTypes: json["paymentMethodTypes"] == null
            ? []
            : List<String>.from(json["paymentMethodTypes"]!.map((x) => x)),
        paymentUrl: json["paymentUrl"],
        id: json["_id"],
        eventSubscriber: json["eventSubscriber"],
        customerId: json["customerId"],
        paymentIntent: json["paymentIntent"],
        eventId: json["eventId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "eventPrice": eventPrice,
        "fee_percentage": feePercentage,
        "eventName": eventName,
        "currency": currency,
        "mode": mode,
        "paymentStatus": paymentStatus,
        "paymentMethodTypes": paymentMethodTypes == null
            ? []
            : List<dynamic>.from(paymentMethodTypes!.map((x) => x)),
        "paymentUrl": paymentUrl,
        "_id": id,
        "eventSubscriber": eventSubscriber,
        "customerId": customerId,
        "paymentIntent": paymentIntent,
        "eventId": eventId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}
