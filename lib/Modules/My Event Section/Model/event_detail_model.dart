import '../../My Business/Model/business_detail_model.dart';
import '../../create_business/model/become_partner_model.dart';

class EventDetailModel {
  String? sId;
  Location? location;
  AdmissionFee? admissionFee;
  String? eventProfile;
  List<String>? entrenceCode;
  String? startDateTime;
  String? endDateTime;
  int? reminder;
  String? cashApp;
  String? venmo;
  String? benifitPay;
  String? eventCategory;
  int? maxParticipants;
  int? maxGuest;
  String? note;
  String? eventState;
  List<String>? music;
  List<Social>? social;
  List<String>? entertainment;
  bool? vipAccess;
  String? ageLimit;
  String? name;
  String? place;
  String? partnerId;
  String? eventType;
  int? stopBooking;
  String? userId;
  String? createdAt;
  String? updatedAt;
  int? iV;
  UserDetail? userDetail;
  int? totalCount;
  int? maleCount;
  int? femaleCount;
  String? reservedStatus;
  List<GetTotalOrdersSummary>? getTotalOrdersSummary;
  bool? isFavourite;

  int? cancelPolicy;

  EventDetailModel(
      {this.sId,
        this.location,
        this.admissionFee,
        this.eventProfile,
        this.entrenceCode,
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
        this.place,
        this.partnerId,
        this.eventType,
        this.stopBooking,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.userDetail,
        this.totalCount,
        this.maleCount,
        this.femaleCount,
        this.reservedStatus,
        this.getTotalOrdersSummary,this.cancelPolicy,
        this.isFavourite});

  EventDetailModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    admissionFee = json['admissionFee'] != null
        ? new AdmissionFee.fromJson(json['admissionFee'])
        : null;
    eventProfile = json['eventProfile'];
    entrenceCode = json['entrenceCode'].cast<String>();
    startDateTime = json['startDateTime'];
    endDateTime = json['endDateTime'];
    reminder = json['reminder'];
    cashApp = json['cashApp'];
    venmo = json['venmo'];
    benifitPay = json['benifitPay'];
    eventCategory = json['eventCategory'];
    maxParticipants = json['maxParticipants'];
    maxGuest = json['maxGuest'];
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
    name = json['name'];
    place = json['place'];
    partnerId = json['partnerId'];
    eventType = json['eventType'];
    stopBooking = json['stopBooking'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    userDetail = json['userDetail'] != null
        ? new UserDetail.fromJson(json['userDetail'])
        : null;
    totalCount = json['totalCount'];
    maleCount = json['maleCount'];
    femaleCount = json['femaleCount'];
    reservedStatus = json['reservedStatus'];

    if (json['getTotalOrdersSummary'] != null) {
      getTotalOrdersSummary = <GetTotalOrdersSummary>[];
      json['getTotalOrdersSummary'].forEach((v) {
        getTotalOrdersSummary!.add(new GetTotalOrdersSummary.fromJson(v));
      });
    }
    isFavourite = json['isFavourite'];
    cancelPolicy=json["cancelationPolicy"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.admissionFee != null) {
      data['admissionFee'] = this.admissionFee!.toJson();
    }
    data['eventProfile'] = this.eventProfile;
    if (this.entrenceCode != null) {
      data['entrenceCode'] = this.entrenceCode;
    }
    data['startDateTime'] = this.startDateTime;
    data['endDateTime'] = this.endDateTime;
    data['reminder'] = this.reminder;
    data['cashApp'] = this.cashApp;
    data['venmo'] = this.venmo;
    data['benifitPay'] = this.benifitPay;
    data['eventCategory'] = this.eventCategory;
    data['maxParticipants'] = this.maxParticipants;
    data['maxGuest'] = this.maxGuest;
    data['note'] = this.note;
    data['eventState'] = this.eventState;
    data['music'] = this.music!;
    if (this.social != null) {
      data['social'] = this.social!.map((v) => v.toJson()).toList();
    }
    data['entertainment'] = this.entertainment;
    data['vipAccess'] = this.vipAccess;
    data['ageLimit'] = this.ageLimit;
    data['name'] = this.name;
    data['place'] = this.place;
    data['partnerId'] = this.partnerId;
    data['eventType'] = this.eventType;
    data['stopBooking'] = this.stopBooking;
    data['userId'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.userDetail != null) {
      data['userDetail'] = this.userDetail!.toJson();
    }
    data['totalCount'] = this.totalCount;
    data['maleCount'] = this.maleCount;
    data['femaleCount'] = this.femaleCount;
    data['reservedStatus'] = this.reservedStatus;
    if (this.getTotalOrdersSummary != null) {
      data['getTotalOrdersSummary'] =
          this.getTotalOrdersSummary!.map((v) => v.toJson()).toList();
    }
    data['isFavourite'] = this.isFavourite;
    data["cancelationPolicy"]=this.cancelPolicy;
    return data;
  }
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
        this.phoneCode});

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

class GetTotalOrdersSummary {
  List<Females>? males;
  List<Females>? females;

  GetTotalOrdersSummary({this.males, this.females});

  GetTotalOrdersSummary.fromJson(Map<String, dynamic> json) {
    if (json['males'] != null) {
      males = <Females>[];
      json['males'].forEach((v) {
        males!.add(new Females.fromJson(v));
      });
    }
    if (json['females'] != null) {
      females = <Females>[];
      json['females'].forEach((v) {
        females!.add(new Females.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.males != null) {
      data['males'] = this.males!.map((v) => v.toJson()).toList();
    }
    if (this.females != null) {
      data['females'] = this.females!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Females {
  String? sId;
  String? eventType;
  String? orderStatus;
  String? eventDate;
  String? paymentStatus;
  String? paymentId;
  int? checkinStatus;
  String? lastCheckedIn;
  String? eventId;
  String? userId;
  String? gender;
  String? createdAt;
  String? updatedAt;
  int? iV;
  UserDetails? userDetails;

  Females(
      {this.sId,
        this.eventType,
        this.orderStatus,
        this.eventDate,
        this.paymentStatus,
        this.paymentId,
        this.checkinStatus,
        this.lastCheckedIn,
        this.eventId,
        this.userId,
        this.gender,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.userDetails});

  Females.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    eventType = json['eventType'];
    orderStatus = json['orderStatus'];
    eventDate = json['eventDate'];
    paymentStatus = json['payment_status'];
    paymentId = json['paymentId'];
    checkinStatus = json['checkinStatus'];
    lastCheckedIn = json['lastCheckedIn'];
    eventId = json['eventId'];
    userId = json['userId'];
    gender = json['gender'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    userDetails = json['userDetails'] != null
        ? new UserDetails.fromJson(json['userDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['eventType'] = this.eventType;
    data['orderStatus'] = this.orderStatus;
    data['eventDate'] = this.eventDate;
    data['payment_status'] = this.paymentStatus;
    data['paymentId'] = this.paymentId;
    data['checkinStatus'] = this.checkinStatus;
    data['lastCheckedIn'] = this.lastCheckedIn;
    data['eventId'] = this.eventId;
    data['userId'] = this.userId;
    data['gender'] = this.gender;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.userDetails != null) {
      data['userDetails'] = this.userDetails!.toJson();
    }
    return data;
  }
}

class UserDetails {
  String? sId;
  String? role;
  String? profileImage;
  String? profileId;
  String? username;
  String? email;
  int? iV;
  String? stripeCustomerId;
  String? connectedAccountId;

  UserDetails(
      {this.sId,
        this.role,
        this.profileImage,
        this.profileId,
        this.username,
        this.email,
        this.iV,
        this.stripeCustomerId,
        this.connectedAccountId});

  UserDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    role = json['role'];
    profileImage = json['profileImage'];
    profileId = json['profileId'];
    username = json['username'];
    email = json['email'];
    stripeCustomerId = json['stripe_customer_id'];
    connectedAccountId = json['connected_account_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['role'] = this.role;
    data['profileImage'] = this.profileImage;
    data['profileId'] = this.profileId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['__v'] = this.iV;
    data['stripe_customer_id'] = this.stripeCustomerId;
    data['connected_account_id'] = this.connectedAccountId;
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

