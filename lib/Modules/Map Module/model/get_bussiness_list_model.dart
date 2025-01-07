// To parse this JSON data, do
//
//     final getBussniessListModel = getBussniessListModelFromJson(jsonString);

import 'dart:convert';

GetBussniessListModel getBussniessListModelFromJson(String str) =>
    GetBussniessListModel.fromJson(json.decode(str));

String getBussniessListModelToJson(GetBussniessListModel data) =>
    json.encode(data.toJson());

class GetBussniessListModel {
  bool? error;
  int? status;
  String? msg;
  List<Datum>? data;

  GetBussniessListModel({
    this.error,
    this.status,
    this.msg,
    this.data,
  });

  factory GetBussniessListModel.fromJson(Map<String, dynamic> json) =>
      GetBussniessListModel(
        error: json["error"],
        status: json["status"],
        msg: json["msg"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "status": status,
        "msg": msg,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? id;
  Location? location;
  AdmissionFee? admissionFee;
  List<String>? photos;
  String? businessProfile;
  String? bussinessStatus;
  String? maxParticipants;
  String? note;
  String? businessState;
  List<String>? music;
  List<String>? entertainment;
  List<String>? disclaimer;
  bool? vipAccess;
  String? ageLimit;
  String? bussinessName;
  String? cancelationPolicy;
  List<BusinessWeek>? businessWeek;
  String? bussinessCategory;
  String? place;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  UserDetail? userDetail;

  Datum({
    this.id,
    this.location,
    this.admissionFee,
    this.photos,
    this.businessProfile,
    this.bussinessStatus,
    this.maxParticipants,
    this.note,
    this.businessState,
    this.music,
    this.entertainment,
    this.disclaimer,
    this.vipAccess,
    this.ageLimit,
    this.bussinessName,
    this.cancelationPolicy,
    this.businessWeek,
    this.bussinessCategory,
    this.place,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.userDetail,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        admissionFee: json["admissionFee"] == null
            ? null
            : AdmissionFee.fromJson(json["admissionFee"]),
        photos: json["photos"] == null
            ? []
            : List<String>.from(json["photos"]!.map((x) => x)),
        businessProfile: json["businessProfile"],
        bussinessStatus: json["bussinessStatus"],
        maxParticipants: json["maxParticipants"],
        note: json["note"],
        businessState: json["businessState"],
        music: json["music"] == null
            ? []
            : List<String>.from(json["music"]!.map((x) => x)),
        entertainment: json["entertainment"] == null
            ? []
            : List<String>.from(json["entertainment"]!.map((x) => x)),
        disclaimer: json["disclaimer"] == null
            ? []
            : List<String>.from(json["disclaimer"]!.map((x) => x)),
        vipAccess: json["vipAccess"],
        ageLimit: json["ageLimit"],
        bussinessName: json["bussinessName"],
        cancelationPolicy: json["cancelationPolicy"],
        businessWeek: json["businessWeek"] == null
            ? []
            : List<BusinessWeek>.from(
                json["businessWeek"]!.map((x) => BusinessWeek.fromJson(x))),
        bussinessCategory: json["bussinessCategory"],
        place: json["place"],
        userId: json["userId"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        userDetail: json["userDetail"] == null
            ? null
            : UserDetail.fromJson(json["userDetail"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "location": location?.toJson(),
        "admissionFee": admissionFee?.toJson(),
        "photos":
            photos == null ? [] : List<dynamic>.from(photos!.map((x) => x)),
        "businessProfile": businessProfile,
        "bussinessStatus": bussinessStatus,
        "maxParticipants": maxParticipants,
        "note": note,
        "businessState": businessState,
        "music": music == null ? [] : List<dynamic>.from(music!.map((x) => x)),
        "entertainment": entertainment == null
            ? []
            : List<dynamic>.from(entertainment!.map((x) => x)),
        "disclaimer": disclaimer == null
            ? []
            : List<dynamic>.from(disclaimer!.map((x) => x)),
        "vipAccess": vipAccess,
        "ageLimit": ageLimit,
        "bussinessName": bussinessName,
        "cancelationPolicy": cancelationPolicy,
        "businessWeek": businessWeek == null
            ? []
            : List<dynamic>.from(businessWeek!.map((x) => x.toJson())),
        "bussinessCategory": bussinessCategory,
        "place": place,
        "userId": userId,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
        "userDetail": userDetail?.toJson(),
      };
}

class AdmissionFee {
  Male? male;
  Male? female;

  AdmissionFee({
    this.male,
    this.female,
  });

  factory AdmissionFee.fromJson(Map<String, dynamic> json) => AdmissionFee(
        male: json["male"] == null ? null : Male.fromJson(json["male"]),
        female: json["female"] == null ? null : Male.fromJson(json["female"]),
      );

  Map<String, dynamic> toJson() => {
        "male": male?.toJson(),
        "female": female?.toJson(),
      };
}

class Male {
  bool? free;
  int? amount;

  Male({
    this.free,
    this.amount,
  });

  factory Male.fromJson(Map<String, dynamic> json) => Male(
        free: json["free"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "free": free,
        "amount": amount,
      };
}

class BusinessWeek {
  String? bussinessDay;
  DateTime? startTime;
  DateTime? endTime;
  bool? isClose;
  String? id;

  BusinessWeek({
    this.bussinessDay,
    this.startTime,
    this.endTime,
    this.isClose,
    this.id,
  });

  factory BusinessWeek.fromJson(Map<String, dynamic> json) => BusinessWeek(
        bussinessDay: json["bussinessDay"],
        startTime: json["startTime"] == null
            ? null
            : DateTime.parse(json["startTime"]),
        endTime:
            json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
        isClose: json["isClose"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "bussinessDay": bussinessDay,
        "startTime": startTime?.toIso8601String(),
        "endTime": endTime?.toIso8601String(),
        "isClose": isClose,
        "_id": id,
      };
}

class Location {
  String? type;
  List<double>? coordinates;
  String? radius;

  Location({
    this.type,
    this.coordinates,
    this.radius,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates: json["coordinates"] == null
            ? []
            : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
        radius: json["radius"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x)),
        "radius": radius,
      };
}

class UserDetail {
  String? id;
  String? username;
  String? email;
  Profile? profile;

  UserDetail({
    this.id,
    this.username,
    this.email,
    this.profile,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        id: json["_id"],
        username: json["username"],
        email: json["email"],
        profile:
            json["profile"] == null ? null : Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "email": email,
        "profile": profile?.toJson(),
      };
}

class Profile {
  String? profileImage;
  String? description;
  String? age;
  String? gender;
  String? phoneNumber;
  String? location;
  List<String>? hobbies;
  List<String>? interests;
  bool? isPrivate;
  String? phoneCode;
  List<dynamic>? joinedEvents;

  Profile({
    this.profileImage,
    this.description,
    this.age,
    this.gender,
    this.phoneNumber,
    this.location,
    this.hobbies,
    this.interests,
    this.isPrivate,
    this.phoneCode,
    this.joinedEvents,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        profileImage: json["profileImage"],
        description: json["description"],
        age: json["age"],
        gender: json["gender"],
        phoneNumber: json["phoneNumber"],
        location: json["location"],
        hobbies: json["hobbies"] == null
            ? []
            : List<String>.from(json["hobbies"]!.map((x) => x)),
        interests: json["interests"] == null
            ? []
            : List<String>.from(json["interests"]!.map((x) => x)),
        isPrivate: json["isPrivate"],
        phoneCode: json["phoneCode"],
        joinedEvents: json["joinedEvents"] == null
            ? []
            : List<dynamic>.from(json["joinedEvents"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "profileImage": profileImage,
        "description": description,
        "age": age,
        "gender": gender,
        "phoneNumber": phoneNumber,
        "location": location,
        "hobbies":
            hobbies == null ? [] : List<dynamic>.from(hobbies!.map((x) => x)),
        "interests": interests == null
            ? []
            : List<dynamic>.from(interests!.map((x) => x)),
        "isPrivate": isPrivate,
        "phoneCode": phoneCode,
        "joinedEvents": joinedEvents == null
            ? []
            : List<dynamic>.from(joinedEvents!.map((x) => x)),
      };
}
