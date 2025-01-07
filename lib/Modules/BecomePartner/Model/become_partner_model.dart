// To parse this JSON data, do
//
//     final becomePartnerModel = becomePartnerModelFromJson(jsonString);

import 'package:partylux/models/dropdown.dart';

import 'business_card_model.dart';

class BecomePartnerModel extends DropDownItem{

  static const TYPE_CLUB="club",TYPE_BAR="bar";

  BusinessLocation? location;
  AdmissionFee? admissionFee;
  List<String>? photos;
  String? businessProfile;
  String? bussinessStatus;
  String? businessState;
  int? maxParticipants;
  String? note;
  BusinessVipModel? vips;
  List<String>? music;
  List<String>? entertainment;
  List<String>? disclaimer;
  bool? vipAccess;
  String? ageLimit;
  String? id;
  String? place;
  String? cancelationPolicy;
  List<BusinessWeek>? businessWeek;
  String? bussinessName;
  String? bussinessCategory;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserDetail userDetail;
  List<Social>? social;
  int? iV;

  BecomePartnerModel({
    this.location,
    this.admissionFee,
    this.photos,
    this.businessProfile,
    this.bussinessStatus,
    this.maxParticipants,
    this.note,
    this.music,
    this.entertainment,
    this.disclaimer,
    this.vipAccess,
    this.ageLimit,
    this.id,
    this.place,
    this.cancelationPolicy,
    this.businessWeek,
    this.bussinessName,
    this.bussinessCategory,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.businessState,
    this.vips,
    this.social,
    required this.userDetail,
  }):super(id: id,text: bussinessName);

  factory BecomePartnerModel.fromJson(Map<String, dynamic> json) =>
      BecomePartnerModel(
        location: json["location"] == null
            ? BusinessLocation.fromEmpty()
            : BusinessLocation.fromJson(json["location"]),
        admissionFee: json["admissionFee"] == null
            ? AdmissionFee.fromEmpty()
            : AdmissionFee.fromJson(json["admissionFee"]),
        photos: json["photos"] == null
            ? []
            : List<String>.from(json["photos"]!.map((x) => x)),
        businessProfile: json["businessProfile"] ?? "",
        bussinessStatus: json["bussinessStatus"] ?? "",
        businessState: json["businessState"] ?? "",
        maxParticipants: json["maxParticipants"],
        note: json["note"] ?? "",
        music: json["music"] == null
            ? []
            : List<String>.from(json["music"]!.map((x) => x)),
        entertainment: json["entertainment"] == null
            ? []
            : List<String>.from(json["entertainment"]!.map((x) => x)),
        disclaimer: json["disclaimer"] == null
            ? []
            : List<String>.from(json["disclaimer"]!.map((x) => x)),
        vipAccess: json["vipAccess"] ?? false,
        ageLimit: json["ageLimit"] ?? "",
        id: json["_id"] ?? "",
        place: json["place"] ?? "",
        cancelationPolicy: json["cancelationPolicy"] ?? "",
        businessWeek: json["businessWeek"] == null
            ? []
            : List<BusinessWeek>.from(
                json["businessWeek"]!.map((x) => BusinessWeek.fromJson(x))),

        social: json["social"] == null
            ? []
            : List<Social>.from(
                json["social"]!.map((x) => Social.fromJson(x))),

        bussinessName: json["bussinessName"] ?? "",
        bussinessCategory: json["bussinessCategory"] ?? "",
        userId: json["userId"] ?? "",
        createdAt: json["createdAt"] == null
            ? DateTime.now()
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? DateTime.now()
            : DateTime.parse(json["updatedAt"]),
        userDetail: json["userDetail"] != null
            ? UserDetail.fromJson(json["userDetail"])
            : UserDetail.fromEmpty(),
        vips: json["vips"] == null
            ? null
            : BusinessVipModel.fromJson(json["vips"]),
      );

  static List<BecomePartnerModel> fromJsonToList(List<dynamic> emote) => emote
      .map<BecomePartnerModel>((item) => BecomePartnerModel.fromJson(item))
      .toList();

  static Map<String, dynamic> toJson(BecomePartnerModel becomePartnerModel) => {
        "place": becomePartnerModel.place,
        "cancelationPolicy": becomePartnerModel.cancelationPolicy,
        "businessWeek": becomePartnerModel.businessWeek == null
            ? []
            : List<dynamic>.from(
                becomePartnerModel.businessWeek!.map((x) => x.toJson())),

        "social": becomePartnerModel.social == null
            ? []
            : List<dynamic>.from(
            becomePartnerModel.social!.map((x) => x.toJson())),

        "maxParticipants": becomePartnerModel.maxParticipants,
        "note": becomePartnerModel.note,
        "admissionFee": becomePartnerModel.admissionFee?.toJson(),
        "music": becomePartnerModel.music == null
            ? []
            : List<dynamic>.from(becomePartnerModel.music!.map((x) => x)),
        "disclaimer": becomePartnerModel.disclaimer == null
            ? []
            : List<dynamic>.from(becomePartnerModel.disclaimer!.map((x) => x)),
        "location": becomePartnerModel.location?.toJson(),
        "entertainment": becomePartnerModel.entertainment == null
            ? []
            : List<dynamic>.from(
                becomePartnerModel.entertainment!.map((x) => x)),
        "ageLimit": becomePartnerModel.ageLimit,
        "photos": becomePartnerModel.photos == null
            ? []
            : List<dynamic>.from(becomePartnerModel.photos!.map((x) => x)),
        "businessProfile": becomePartnerModel.businessProfile,
        "bussinessName": becomePartnerModel.bussinessName,
        "bussinessCategory": becomePartnerModel.bussinessCategory,
      };

  static Map<String, dynamic> toJsonBusinessWeek(
          List<BusinessWeek> businessWeek, String bussinessCategory) =>
      {
        "businessWeek": businessWeek.isEmpty
            ? []
            : List<dynamic>.from(businessWeek.map((x) => x.toJson())),
        "bussinessCategory": bussinessCategory,
      };

  factory BecomePartnerModel.fromEmpty() => BecomePartnerModel(
        place: "",
        cancelationPolicy: "",
        businessWeek: [],
        maxParticipants: 0,
        note: "",
        admissionFee: AdmissionFee.fromEmpty(),
        music: [],
        disclaimer: [],
        location: BusinessLocation.fromEmpty(),
        entertainment: [],
        ageLimit: "",
        photos: [],
        businessProfile: "",
        bussinessName: "",
        bussinessCategory: "",
        userDetail: UserDetail.fromJson({}),
      );
}

class UserDetail {
  String id;
  String username;
  Profile profile;
  String? email;

  UserDetail({
    required this.id,
    required this.username,
    required this.profile,
    this.email,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        id: json["_id"] ?? "",
        username: json["username"] ?? "",
        profile: json["profile"] != null
            ? Profile.fromJson(json["profile"])
            : Profile.fromEmpty(),
        email: json["email"] ?? "",
      );
  factory UserDetail.fromEmpty() => UserDetail(
        id: "",
        username: "",
        profile: Profile.fromEmpty(),
        email: "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "username": username,
        "profile": profile.toJson(),
        "email": email,
      };
}

class Profile {
  String profileImage;
  String description;
  String age;
  String gender;
  String phoneNumber;
  String location;
  List<String> hobbies;
  List<String> interests;
  bool isPrivate;
  String phoneCode;
  List<dynamic> joinedEvents;

  Profile({
    required this.profileImage,
    required this.description,
    required this.age,
    required this.gender,
    required this.phoneNumber,
    required this.location,
    required this.hobbies,
    required this.interests,
    required this.isPrivate,
    required this.phoneCode,
    required this.joinedEvents,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        profileImage: json["profileImage"] ?? "",
        description: json["description"] ?? "",
        age: json["age"] ?? "",
        gender: json["gender"] ?? "",
        phoneNumber: json["phoneNumber"] ?? "",
        location: json["location"] ?? "",
        hobbies: json["hobbies"] != null
            ? List<String>.from(json["hobbies"].map((x) => x))
            : [],
        interests: json["interests"] != null
            ? List<String>.from(json["interests"].map((x) => x))
            : [],
        isPrivate: json["isPrivate"] ?? false,
        phoneCode: json["phoneCode"] ?? "",
        joinedEvents: json["joinedEvents"] != null
            ? List<dynamic>.from(json["joinedEvents"].map((x) => x))
            : [],
      );

  factory Profile.fromEmpty() => Profile(
        profileImage: "",
        description: "",
        age: "",
        gender: "",
        phoneNumber: "",
        location: "",
        hobbies: [],
        interests: [],
        isPrivate: false,
        phoneCode: "",
        joinedEvents: [],
      );

  Map<String, dynamic> toJson() => {
        "profileImage": profileImage,
        "description": description,
        "age": age,
        "gender": gender,
        "phoneNumber": phoneNumber,
        "location": location,
        "hobbies": List<dynamic>.from(hobbies.map((x) => x)),
        "interests": List<dynamic>.from(interests.map((x) => x)),
        "isPrivate": isPrivate,
        "phoneCode": phoneCode,
        "joinedEvents": List<dynamic>.from(joinedEvents.map((x) => x)),
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

  factory AdmissionFee.fromEmpty() => AdmissionFee(
        male: Male.fromEmpty(),
        female: Male.fromEmpty(),
      );

  Map<String, dynamic> toJson() => {
        "male": male!.toJson(),
        "female": female!.toJson(),
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
        free: json["free"] ?? false,
        amount: json["amount"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "free": free,
        "amount": amount,
      };
  factory Male.fromEmpty() => Male(
        free: false,
        amount: 0,
      );
}

class BusinessWeek {
  bool? isClose;
  String? bussinessDay;
  dynamic startTime;
  dynamic endTime;

  BusinessWeek({
    this.isClose,
    this.bussinessDay,
    this.startTime,
    this.endTime,
  });

  factory BusinessWeek.fromJson(Map<String, dynamic> json) => BusinessWeek(
        isClose: json["isClose"],
        bussinessDay: json["bussinessDay"],
        startTime: json["startTime"],
        endTime: json["endTime"],
      );

  factory BusinessWeek.fromEmpty() => BusinessWeek(
        isClose: false,
        bussinessDay: "",
        startTime: "",
        endTime: "",
      );

  Map<String, dynamic> toJson() => {
        "isClose": isClose,
        "bussinessDay": bussinessDay,
        "startTime": startTime,
        "endTime": endTime,
      };
}

class BusinessLocation {
  String? type;
  List<double>? coordinates;
  String? radius;

  BusinessLocation({
    this.type,
    this.coordinates,
    this.radius,
  });

  factory BusinessLocation.fromJson(Map<String, dynamic> json) =>
      BusinessLocation(
        type: json["type"],
        coordinates: json["coordinates"] == null
            ? []
            : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
        radius: json["radius"],
      );

  factory BusinessLocation.fromEmpty() => BusinessLocation(
        type: "",
        coordinates: [],
        radius: "",
      );

  Map<String, dynamic> toJson() => {
        "type": "Point",
        "coordinates": coordinates == null
            ? []
            : List<dynamic>.from(coordinates!.map((x) => x)),
        "radius": "50",
      };
}

class BusinessVipModel {
  final List<BusinessCard> cards;
  final String userId;

  BusinessVipModel({
    required this.cards,
    required this.userId,
  });

  factory BusinessVipModel.fromJson(Map<String, dynamic> json) =>
      BusinessVipModel(
        cards: json["cards"] != null
            ? List<BusinessCard>.from(
                json["cards"].map((x) => BusinessCard.fromJson(x)))
            : [],
        userId: json["userId"] ?? "",
      );

  factory BusinessVipModel.fromEmpty() => BusinessVipModel(
        cards: [],
        userId: "",
      );

  Map<String, dynamic> toJson() => {
        "cards": List<dynamic>.from(cards.map((x) => x.toJson())),
        "userId": userId,
      };
}

class Social {
  String? type;
  String? url;

  Social({this.type, this.url});

  Social.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }
}
