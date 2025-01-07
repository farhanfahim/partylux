
import 'package:partylux/Modules/My%20Business/Model/business_detail_model.dart';
import 'package:partylux/Modules/add_location_picker/model/local_location.dart';
import 'package:partylux/Utils/Network/api_urls.dart';
import 'package:partylux/models/dropdown.dart';

class EventModel extends DropDownItem{

  static const TYPE_PUBLIC="public",TYPE_PRIVATE="private";

  static const CATEGORY_HOUSEPARTY='houseParty', CATEGORY_CLUB='club',
      CATEGORY_BAR='bar', CATEGORY_BEACH='beach';

  String? sId;
  //Location? location;
  LocalLocation? location;

  //AdmissionFee? admissionFee;

  bool? femaleFee,maleFee;
  double? maleAmount,femaleAmount;

  String? eventProfile;
  //List<String>? entrenceCode;
  String? partyCode;
  String? startDateTime;
  String? endDateTime;
  int? reminder;
  String? cashApp;
  String? venmo;
  String? benifitPay;
  String? eventCategory;
  int? maxParticipants;
  //int? maxGuest;
  ValueType<int>? maxGuest;
  String? note;
  String? eventState;
  List<String>? music;
  List<Social>? social;
  List<String>? entertainment;
  bool? vipAccess;
  String? ageLimit;
  String? name;
 // String? place;
  String? partnerId;
  String? eventType;
  //int? stopBooking;
  ValueType<int>? stopBooking,cancelPolicy;
  String? userId;
  String? createdAt;
  String? updatedAt;
  int? iV;
  UserDetail? userDetail;
  BusinessDetailModel? business;
  List<EventSubscriptions>? eventSubscriptions;

  // extra fields
  bool? maxCapacity,restrict1;
  bool? push;
  bool? ownCode,allowPayments;

  EventModel(
      {this.sId,
        this.location,this.partyCode,
       // this.admissionFee,
        this.eventProfile,
      //  this.entrenceCode,
        this.startDateTime,
        this.endDateTime,
        this.reminder,
        this.cashApp,
        this.venmo,
        this.benifitPay,
        this.eventCategory,
        this.maxParticipants,
        this.maxGuest,
        this.note,
        this.eventState,
        this.music,
        this.social,
        this.entertainment,
        this.vipAccess,
        this.ageLimit,
        this.name,
      //  this.place,
        this.partnerId,
        this.eventType,
        this.stopBooking,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.userDetail,
        this.business,
        this.eventSubscriptions,this.maxCapacity,this.restrict1,this.push,this.ownCode,this.cancelPolicy,
      //  this.partyCode,
        this.allowPayments}):super(id: sId,text: name);

  EventModel.fromJson(Map<String, dynamic> json):super(id: json['_id'],text: json['name']) {
    sId = id;
    var location=json['location'];
    if(location!=null){
      this.location=LocalLocation.fromJson(location,address: json["place"]);
    }
    var admissionFee=json['admissionFee'];
    if(admissionFee!=null){
      var male=admissionFee["male"];
      var female=admissionFee["female"];
      maleFee=male["free"];
      maleAmount=(male["amount"] as num).toDouble();
      femaleFee=female["free"];
      femaleAmount=(female["amount"] as num).toDouble();
    }
    eventProfile = json['eventProfile'];
    List list=json['entrenceCode'].cast<String>();
    if(list.isNotEmpty){
      partyCode=list[0];
    }
    startDateTime = json['startDateTime'];
    endDateTime = json['endDateTime'];
    reminder = json['reminder'];
    cashApp = json['cashApp'];
    venmo = json['venmo'];
    benifitPay = json['benifitPay'];
    eventCategory = json['eventCategory'];
    maxParticipants = json['maxParticipants'];
   // maxGuest = ValueType(text: json['maxGuest'].toString(),value: json['maxGuest']);
    maxGuest = json['maxGuest']>0?ValueType(text: json['maxGuest'].toString(),value: json['maxGuest']):null;
    note = json['note'];
    eventState = json['eventState'];
    music = json['music'].cast<String>();
    if (json['social'] != null) {
      social = <Social>[];
      json['social'].forEach((v) {
        social!.add(new Social.fromJson(v));
      });
    }
    entertainment = json['entertainment'].cast<String>();
    vipAccess = json['vipAccess'];
    ageLimit = json['ageLimit'];
    name = text;
    //place = json['place'];
    partnerId = json['partnerId'];
    eventType = json['eventType'];
    stopBooking = json['stopBooking']>0?ValueType(text: json['stopBooking'].toString(),value: json['stopBooking']):null;
    cancelPolicy = json['cancelationPolicy']>0?ValueType(text: json['cancelationPolicy'].toString(),value: json['cancelationPolicy']):null;
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    userDetail = json['userDetail'] != null
        ? new UserDetail.fromJson(json['userDetail'])
        : null;
    business = json['business'] != null
        ? new BusinessDetailModel.fromJson(json['business'])
        : null;
    if (json['eventSubscriptions'] != null) {
      eventSubscriptions = <EventSubscriptions>[];
      json['eventSubscriptions'].forEach((v) {
        eventSubscriptions!.add(new EventSubscriptions.fromJson(v));
      });
    }
    maxCapacity=maxParticipants!>0;
    restrict1=maxGuest!=null && maxGuest!.value!>0;
    push=false;
    ownCode=false;
    allowPayments=(cashApp!.isNotEmpty || venmo!.isNotEmpty || benifitPay!.isNotEmpty);
  }


  static List<EventModel> fromJsonToList(List<dynamic> emote) => emote
      .map<EventModel>((item) => EventModel.fromJson(item))
      .toList();

  String get shareUrl => "${ApiManager.BASE_URL}${ApiManager.GET_EVENT_DETAIL}" + ("/$id");

}


class UserDetail {
  String? sId;
  String? username;
  String? email;
  Profile? profile;

  UserDetail({this.sId, this.username, this.email, this.profile});

  UserDetail.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    email = json['email'];
    profile =
    json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['username'] = this.username;
    data['email'] = this.email;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    return data;
  }
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

  Profile(
      {this.profileImage,
        this.description,
        this.age,
        this.gender,
        this.phoneNumber,
        this.location,
        this.hobbies,
        this.interests,
        this.isPrivate,
        this.phoneCode, });

  Profile.fromJson(Map<String, dynamic> json) {
    profileImage = json['profileImage'];
    description = json['description'];
    age = json['age'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    location = json['location'];
    hobbies = json['hobbies'].cast<String>();
    interests = json['interests'].cast<String>();
    isPrivate = json['isPrivate'];
    phoneCode = json['phoneCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profileImage'] = this.profileImage;
    data['description'] = this.description;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['phoneNumber'] = this.phoneNumber;
    data['location'] = this.location;
    data['hobbies'] = this.hobbies;
    data['interests'] = this.interests;
    data['isPrivate'] = this.isPrivate;
    data['phoneCode'] = this.phoneCode;
    return data;
  }
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


class EventSubscriptions {
  String? sId;
  String? genderType;
  String? participant;
  List<UserDetail>? participantDetails;

  EventSubscriptions(
      {this.sId, this.genderType, this.participant, this.participantDetails});

  static List<EventSubscriptions> fromJsonToList(List<dynamic> emote) =>
      emote.map<EventSubscriptions>((item) => EventSubscriptions.fromJson(item)).toList();

  EventSubscriptions.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    genderType = json['genderType'];
    participant = json['participant'];
    if (json['participantDetails'] != null) {
      participantDetails = <UserDetail>[];
      json['participantDetails'].forEach((v) {
        participantDetails!.add(new UserDetail.fromJson(v));
      });
    }
  }

}
