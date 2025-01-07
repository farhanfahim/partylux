import '../../create_business/model/become_partner_model.dart';

class BusinessDetailModel {
  String? sId;
  Location? location;
  AdmissionFee? admissionFee;
  List<String>? photos;
  String? businessProfile;
  String? bussinessStatus;
  int? maxParticipants;
  String? note;
  String? businessState;
  List<String>? music;
  List<String>? entertainment;
  List<Social>? social;
  bool? vipAccess;
  String? ageLimit;
  String? place;
  List<BusinessWeek>? businessWeek;
  String? bussinessName;
  String? bussinessCategory;
  String? userId;
  String? createdAt;
  String? updatedAt;
  UserDetail? userDetail;
  List<UpcomingEvents>? upcomingEvents;
  int? totalCount;
  int? maleCount;
  int? femaleCount;
  bool? ispurchased;
  LiveParticipants? liveParticipants;
  List<GetTotalOrdersSummary>? getTotalOrdersSummary;
  bool? isFavourite;

  BusinessDetailModel({this.sId, this.location, this.admissionFee, this.photos, this.businessProfile, this.bussinessStatus, this.maxParticipants, this.note, this.businessState, this.music, this.entertainment,this.social, this.vipAccess, this.ageLimit, this.place, this.businessWeek, this.bussinessName, this.bussinessCategory, this.userId, this.createdAt, this.updatedAt, this.userDetail, this.upcomingEvents, this.totalCount, this.maleCount, this.femaleCount, this.ispurchased,
    this.getTotalOrdersSummary,this.liveParticipants,this.isFavourite});

  BusinessDetailModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    location = json['location'] != null ? new Location.fromJson(json['location']) : null;
    admissionFee = json['admissionFee'] != null ? new AdmissionFee.fromJson(json['admissionFee']) : null;
    photos = json['photos'].cast<String>();
    businessProfile = json['businessProfile'];
    bussinessStatus = json['bussinessStatus'];
    maxParticipants = json['maxParticipants'];
    note = json['note'];
    businessState = json['businessState'];
    music = json['music'].cast<String>();
    entertainment = json['entertainment'].cast<String>();
    if (json['social'] != null) {
      social = <Social>[];
      json['social'].forEach((v) { social!.add(new Social.fromJson(v)); });
    }
    vipAccess = json['vipAccess'];
    ageLimit = json['ageLimit'];
    place = json['place'];
    if (json['businessWeek'] != null) {
      businessWeek = <BusinessWeek>[];
      json['businessWeek'].forEach((v) { businessWeek!.add(new BusinessWeek.fromJson(v)); });
    }
    bussinessName = json['bussinessName'];
    bussinessCategory = json['bussinessCategory'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userDetail = json['userDetail'] != null ? new UserDetail.fromJson(json['userDetail']) : null;
    if (json['upcomingEvents'] != null) {
      upcomingEvents = <UpcomingEvents>[];
      json['upcomingEvents'].forEach((v) { upcomingEvents!.add(new UpcomingEvents.fromJson(v)); });
    }
    totalCount = json['totalCount'];
    maleCount = json['maleCount'];
    femaleCount = json['femaleCount'];
    ispurchased = json['ispurchased'];
    if (json['getTotalOrdersSummary'] != null) {
      getTotalOrdersSummary = <GetTotalOrdersSummary>[];
      json['getTotalOrdersSummary'].forEach((v) {
        getTotalOrdersSummary!.add(new GetTotalOrdersSummary.fromJson(v));
      });
    }
    liveParticipants = json['liveParticipants'] != null ? new LiveParticipants.fromJson(json['liveParticipants']) : null;
    isFavourite = json['isFavourite'];
    ;
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
    data['photos'] = this.photos;
    data['businessProfile'] = this.businessProfile;
    data['bussinessStatus'] = this.bussinessStatus;
    data['maxParticipants'] = this.maxParticipants;
    data['note'] = this.note;
    data['businessState'] = this.businessState;
    data['music'] = this.music;
    data['entertainment'] = this.entertainment;
    if (this.social != null) {
      data['social'] = this.social!.map((v) => v.toJson()).toList();
    }
    data['vipAccess'] = this.vipAccess;
    data['ageLimit'] = this.ageLimit;
    data['place'] = this.place;
    if (this.businessWeek != null) {
      data['businessWeek'] = this.businessWeek!.map((v) => v.toJson()).toList();
    }
    data['bussinessName'] = this.bussinessName;
    data['bussinessCategory'] = this.bussinessCategory;
    data['userId'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.userDetail != null) {
      data['userDetail'] = this.userDetail!.toJson();
    }
    if (this.upcomingEvents != null) {
      data['upcomingEvents'] = this.upcomingEvents!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = this.totalCount;
    data['maleCount'] = this.maleCount;
    data['femaleCount'] = this.femaleCount;
    data['ispurchased'] = this.ispurchased;
    if (this.getTotalOrdersSummary != null) {
      data['getTotalOrdersSummary'] =
          this.getTotalOrdersSummary!.map((v) => v.toJson()).toList();
    };
    data['isFavourite'] = this.isFavourite;
    data['liveParticipants'] = this.liveParticipants;
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
    profile = json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
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
  bool? isPrivate;
  String? phoneCode;

  Profile(
      {this.profileImage,
        this.description,
        this.age,
        this.gender,
        this.phoneNumber,
        this.location,
        this.isPrivate,
        this.phoneCode});

  Profile.fromJson(Map<String, dynamic> json) {
    profileImage = json['profileImage'];
    description = json['description'];
    age = json['age'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    location = json['location'];
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
    data['isPrivate'] = this.isPrivate;
    data['phoneCode'] = this.phoneCode;
    return data;
  }
}


class UpcomingEvents {
  String? sId;
  String? media;
  String? eventDate;
  String? mediaType;
  String? fromTime;
  String? toTime;
  String? description;
  int? admissionFee;
  String? partnerId;
  List<String>? hidden;
  String? eventId;
  String? userId;
  String? createdAt;
  String? updatedAt;
  int? iV;
  List<EventDetails>? eventDetails;

  UpcomingEvents({this.sId, this.media, this.mediaType,this.eventDate, this.fromTime, this.toTime, this.description, this.admissionFee, this.partnerId,this.hidden, this.eventId, this.userId, this.createdAt, this.updatedAt, this.iV,
    this.eventDetails});

  UpcomingEvents.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    media = json['media'];
    eventDate = json['eventDate'];
    mediaType = json['mediaType'];
    fromTime = json['fromTime'];
    toTime = json['toTime'];
    description = json['description'];
    admissionFee = json['admissionFee'];
    partnerId = json['partnerId'];
    hidden = json['hidden'].cast<String>();
    eventId = json['eventId'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    if (json['eventDetails'] != null) {
      eventDetails = <EventDetails>[];
      json['eventDetails'].forEach((v) {
        eventDetails!.add(new EventDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['media'] = this.media;
    data['eventDate'] = this.eventDate;
    data['mediaType'] = this.mediaType;
    data['fromTime'] = this.fromTime;
    data['toTime'] = this.toTime;
    data['description'] = this.description;
    data['admissionFee'] = this.admissionFee;
    data['partnerId'] = this.partnerId;
    data['hidden'] = this.hidden;
    data['eventId'] = this.eventId;
    data['userId'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.eventDetails != null) {
      data['eventDetails'] = this.eventDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

class EventDetails {
  String? sId;
  Location? location;
  AdmissionFee? admissionFee;
  List<String>? photos;
  String? eventProfile;
  String? startDateTime;
  String? endDateTime;
  String? name;
  String? place;

  EventDetails(
      {this.sId,
        this.location,
        this.photos,
        this.eventProfile,
        this.startDateTime,
        this.endDateTime,
        this.name,
        this.place,});

  EventDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    admissionFee = json['admissionFee'] != null
        ? new AdmissionFee.fromJson(json['admissionFee'])
        : null;

    photos = json['photos'].cast<String>();
    eventProfile = json['eventProfile'];
    startDateTime = json['startDateTime'];
    endDateTime = json['endDateTime'];
    name = json['name'];
    place = json['place'];
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
    data['photos'] = this.photos!;
    data['eventProfile'] = this.eventProfile;
    data['startDateTime'] = this.startDateTime;
    data['endDateTime'] = this.endDateTime;
    data['name'] = this.name;
    data['place'] = this.place;
    return data;
  }


}

class LiveParticipants {
  int? liveTotalCount;
  int? liveMaleCount;
  int? liveFemaleCount;
  Profiles? profiles;

  LiveParticipants({this.liveTotalCount, this.liveMaleCount, this.liveFemaleCount, this.profiles});

  LiveParticipants.fromJson(Map<String, dynamic> json) {
    liveTotalCount = json['liveTotalCount'];
    liveMaleCount = json['liveMaleCount'];
    liveFemaleCount = json['liveFemaleCount'];
    profiles = json['profiles'] != null ? new Profiles.fromJson(json['profiles']) : null;
  }

}

class Profiles {
  List<LiveMale>? male;
  List<LiveFemales>? females;

  Profiles({this.male, this.females});

  Profiles.fromJson(Map<String, dynamic> json) {
    if (json['male'] != null) {
      male = <LiveMale>[];
      json['male'].forEach((v) { male!.add(new LiveMale.fromJson(v)); });
    }
    if (json['females'] != null) {
      females = <LiveFemales>[];
      json['females'].forEach((v) { females!.add(new LiveFemales.fromJson(v)); });
    }
  }

}

class LiveMale {
  String? profileImage;
  String? profileId;
  String? sId;
  String? username;

  LiveMale({this.profileImage, this.profileId, this.sId,this.username,});

  LiveMale.fromJson(Map<String, dynamic> json) {
    profileImage = json['profileImage'];
    profileId = json['profileId'];
    sId = json['_id'];
    username = json['username'];
  }

}

class LiveFemales {

  String? profileImage;
  String? profileId;
  String? sId;
  String? username;

  LiveFemales({this.profileImage, this.profileId, this.sId,this.username,});

  LiveFemales.fromJson(Map<String, dynamic> json) {
    profileImage = json['profileImage'];
    profileId = json['profileId'];
    sId = json['_id'];
    username = json['username'];
  }
}
