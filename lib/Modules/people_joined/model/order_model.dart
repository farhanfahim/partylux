import 'package:partylux/Modules/Home%20Module/Model/event_model.dart';


class OrderModel {

  static const STATUS_APPROVED="approved",STATUS_PENDING="pending",STATUS_RESERVED="reserved",PAID="paid",UNPAID="unpaid";

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
  double? price;
  double? commissionPercent;
  double? commissionAmount;
  double? amountAfterCommission;
  String? createdAt;
  String? updatedAt;
  int? iV;
  User? user;
  EventModel? event;
  Host? host;

  OrderModel(
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
        this.price,
        this.commissionPercent,
        this.commissionAmount,
        this.amountAfterCommission,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.user,
        this.event,
        this.host});

  OrderModel.fromJson(Map<String, dynamic> json) {
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
    price = (json['price'] as num).toDouble();
    commissionPercent = (json['commission_percent'] as num).toDouble();
    commissionAmount = (json['commission_amount'] as num).toDouble();
    amountAfterCommission = (json['amount_after_commission'] as num).toDouble();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    event = json['event'] != null ? new EventModel.fromJson(json['event']) : null;
    host = json['host'] != null ? new Host.fromJson(json['host']) : null;
  }

  static List<OrderModel> fromJsonToList(List<dynamic> emote) => emote
      .map<OrderModel>((item) => OrderModel.fromJson(item))
      .toList();

}

class User {
  String? sId;
  String? stripeCustomerId;
  String? connectedAccountId;
  String? role;
  bool? isVerified;
  bool? isApproved;
  bool? isProfile;
  String? profileImage;
  String? profileId;
  List<String>? favoriteClubs;
  List<String>? favoriteBars;
  List<String>? favoriteEvent;
  String? username;
  String? email;
  String? password;
  String? otp;
  String? userLoginType;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isNotifyMe;
  bool? isPushNotification;

  User(
      {this.sId,
        this.stripeCustomerId,
        this.connectedAccountId,
        this.role,
        this.isVerified,
        this.isApproved,
        this.isProfile,
        this.profileImage,
        this.profileId,
        this.favoriteClubs,
        this.favoriteBars,
        this.favoriteEvent,
        this.username,
        this.email,
        this.password,
        this.otp,
        this.userLoginType,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.isNotifyMe,
        this.isPushNotification});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    stripeCustomerId = json['stripe_customer_id'];
    connectedAccountId = json['connected_account_id'];
    role = json['role'];
    isVerified = json['isVerified'];
    isApproved = json['isApproved'];
    isProfile = json['isProfile'];
    profileImage = json['profileImage'];
    profileId = json['profileId'];
    favoriteClubs = json['favoriteClubs'].cast<String>();
    if (json['favoriteBars'] != null) {
      favoriteBars = [];
      json['favoriteBars'].forEach((v) {
        favoriteBars!.add(v);
      });
    }
    if (json['favoriteEvent'] != null) {
      favoriteEvent = [];
      json['favoriteEvent'].forEach((v) {
        favoriteEvent!.add(v);
      });
    }
    username = json['username'];
    email = json['email'];
    password = json['password'];
    otp = json['otp'];
    userLoginType = json['userLoginType'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isNotifyMe = json['isNotifyMe'];
    isPushNotification = json['isPushNotification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['stripe_customer_id'] = this.stripeCustomerId;
    data['connected_account_id'] = this.connectedAccountId;
    data['role'] = this.role;
    data['isVerified'] = this.isVerified;
    data['isApproved'] = this.isApproved;
    data['isProfile'] = this.isProfile;
    data['profileImage'] = this.profileImage;
    data['profileId'] = this.profileId;
    data['favoriteClubs'] = this.favoriteClubs;
    if (this.favoriteBars != null) {
      data['favoriteBars'] = this.favoriteBars!.map((v) => v).toList();
    }
    if (this.favoriteEvent != null) {
      data['favoriteEvent'] =
          this.favoriteEvent!.map((v) => v).toList();
    }
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['otp'] = this.otp;
    data['userLoginType'] = this.userLoginType;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['isNotifyMe'] = this.isNotifyMe;
    data['isPushNotification'] = this.isPushNotification;
    return data;
  }
}


class Location {
  String? radius;
  String? pinLocation;
  String? type;
  List<double>? coordinates;

  Location({this.radius, this.pinLocation, this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    radius = json['radius'];
    pinLocation = json['pinLocation'];
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['radius'] = this.radius;
    data['pinLocation'] = this.pinLocation;
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

class AdmissionFee {
  Male? male;
  Male? female;

  AdmissionFee({this.male, this.female});

  AdmissionFee.fromJson(Map<String, dynamic> json) {
    male = json['male'] != null ? new Male.fromJson(json['male']) : null;
    female = json['female'] != null ? new Male.fromJson(json['female']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.male != null) {
      data['male'] = this.male!.toJson();
    }
    if (this.female != null) {
      data['female'] = this.female!.toJson();
    }
    return data;
  }
}

class Male {
  bool? free;
  int? amount;

  Male({this.free, this.amount});

  Male.fromJson(Map<String, dynamic> json) {
    free = json['free'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['free'] = this.free;
    data['amount'] = this.amount;
    return data;
  }
}

class Host {
  String? sId;
  String? role;
  bool? isVerified;
  bool? isApproved;
  bool? isProfile;
  String? profileImage;
  String? profileId;
  String? username;
  String? email;
  String? password;
  String? otp;
  String? userLoginType;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? stripeCustomerId;
  String? connectedAccountId;
  bool? isNotifyMe;
  bool? isPushNotification;

  Host(
      {this.sId,
        this.role,
        this.isVerified,
        this.isApproved,
        this.isProfile,
        this.profileImage,
        this.profileId,
        this.username,
        this.email,
        this.password,
        this.otp,
        this.userLoginType,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.stripeCustomerId,
        this.connectedAccountId,
        this.isNotifyMe,
        this.isPushNotification});

  Host.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    role = json['role'];
    isVerified = json['isVerified'];
    isApproved = json['isApproved'];
    isProfile = json['isProfile'];
    profileImage = json['profileImage'];
    profileId = json['profileId'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    otp = json['otp'];
    userLoginType = json['userLoginType'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    stripeCustomerId = json['stripe_customer_id'];
    connectedAccountId = json['connected_account_id'];
    isNotifyMe = json['isNotifyMe'];
    isPushNotification = json['isPushNotification'];
  }

}


/*

class OrderModel {
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
  int? price;
  int? commissionPercent;
  int? commissionAmount;
  int? amountAfterCommission;
  String? createdAt;
  String? updatedAt;
  int? iV;
  User? user;
  Event? event;
  Host? host;

  OrderModel(
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
        this.price,
        this.commissionPercent,
        this.commissionAmount,
        this.amountAfterCommission,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.user,
        this.event,
        this.host});

  OrderModel.fromJson(Map<String, dynamic> json) {
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
    price = json['price'];
    commissionPercent = json['commission_percent'];
    commissionAmount = json['commission_amount'];
    amountAfterCommission = json['amount_after_commission'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    event = json['event'] != null ? new Event.fromJson(json['event']) : null;
    host = json['host'] != null ? new Host.fromJson(json['host']) : null;
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
    data['price'] = this.price;
    data['commission_percent'] = this.commissionPercent;
    data['commission_amount'] = this.commissionAmount;
    data['amount_after_commission'] = this.amountAfterCommission;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.event != null) {
      data['event'] = this.event!.toJson();
    }
    if (this.host != null) {
      data['host'] = this.host!.toJson();
    }
    return data;
  }
}

class User {
  String? sId;
  String? stripeCustomerId;
  String? connectedAccountId;
  String? role;
  bool? isVerified;
  bool? isApproved;
  bool? isProfile;
  String? profileImage;
  String? profileId;
  List<String>? favoriteClubs;
  List<Null>? favoriteBars;
  List<Null>? favoriteEvent;
  String? username;
  String? email;
  String? password;
  String? otp;
  String? userLoginType;
  List<Null>? refreshTokens;
  String? createdAt;
  String? updatedAt;
  int? iV;
  bool? isNotifyMe;
  bool? isPushNotification;

  User(
      {this.sId,
        this.stripeCustomerId,
        this.connectedAccountId,
        this.role,
        this.isVerified,
        this.isApproved,
        this.isProfile,
        this.profileImage,
        this.profileId,
        this.favoriteClubs,
        this.favoriteBars,
        this.favoriteEvent,
        this.username,
        this.email,
        this.password,
        this.otp,
        this.userLoginType,
        this.refreshTokens,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.isNotifyMe,
        this.isPushNotification});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    stripeCustomerId = json['stripe_customer_id'];
    connectedAccountId = json['connected_account_id'];
    role = json['role'];
    isVerified = json['isVerified'];
    isApproved = json['isApproved'];
    isProfile = json['isProfile'];
    profileImage = json['profileImage'];
    profileId = json['profileId'];
    favoriteClubs = json['favoriteClubs'].cast<String>();
    if (json['favoriteBars'] != null) {
      favoriteBars = <Null>[];
      json['favoriteBars'].forEach((v) {
        favoriteBars!.add(new Null.fromJson(v));
      });
    }
    if (json['favoriteEvent'] != null) {
      favoriteEvent = <Null>[];
      json['favoriteEvent'].forEach((v) {
        favoriteEvent!.add(new Null.fromJson(v));
      });
    }
    username = json['username'];
    email = json['email'];
    password = json['password'];
    otp = json['otp'];
    userLoginType = json['userLoginType'];
    if (json['refreshTokens'] != null) {
      refreshTokens = <Null>[];
      json['refreshTokens'].forEach((v) {
        refreshTokens!.add(new Null.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isNotifyMe = json['isNotifyMe'];
    isPushNotification = json['isPushNotification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['stripe_customer_id'] = this.stripeCustomerId;
    data['connected_account_id'] = this.connectedAccountId;
    data['role'] = this.role;
    data['isVerified'] = this.isVerified;
    data['isApproved'] = this.isApproved;
    data['isProfile'] = this.isProfile;
    data['profileImage'] = this.profileImage;
    data['profileId'] = this.profileId;
    data['favoriteClubs'] = this.favoriteClubs;
    if (this.favoriteBars != null) {
      data['favoriteBars'] = this.favoriteBars!.map((v) => v.toJson()).toList();
    }
    if (this.favoriteEvent != null) {
      data['favoriteEvent'] =
          this.favoriteEvent!.map((v) => v.toJson()).toList();
    }
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['otp'] = this.otp;
    data['userLoginType'] = this.userLoginType;
    if (this.refreshTokens != null) {
      data['refreshTokens'] =
          this.refreshTokens!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['isNotifyMe'] = this.isNotifyMe;
    data['isPushNotification'] = this.isPushNotification;
    return data;
  }
}

class Event {
  String? sId;
  Location? location;
  AdmissionFee? admissionFee;
  List<Null>? photos;
  String? eventProfile;
  List<Null>? entrenceCode;
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
  List<Null>? music;
  List<Null>? social;
  List<String>? entertainment;
  List<Null>? disclaimer;
  bool? vipAccess;
  String? ageLimit;
  String? name;
  String? place;
  String? partnerId;
  String? eventType;
  int? stopBooking;
  int? cancelationPolicy;
  String? userId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Event(
      {this.sId,
        this.location,
        this.admissionFee,
        this.photos,
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
        this.disclaimer,
        this.vipAccess,
        this.ageLimit,
        this.name,
        this.place,
        this.partnerId,
        this.eventType,
        this.stopBooking,
        this.cancelationPolicy,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Event.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    admissionFee = json['admissionFee'] != null
        ? new AdmissionFee.fromJson(json['admissionFee'])
        : null;
    if (json['photos'] != null) {
      photos = <Null>[];
      json['photos'].forEach((v) {
        photos!.add(new Null.fromJson(v));
      });
    }
    eventProfile = json['eventProfile'];
    if (json['entrenceCode'] != null) {
      entrenceCode = <Null>[];
      json['entrenceCode'].forEach((v) {
        entrenceCode!.add(new Null.fromJson(v));
      });
    }
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
    if (json['music'] != null) {
      music = <Null>[];
      json['music'].forEach((v) {
        music!.add(new Null.fromJson(v));
      });
    }
    if (json['social'] != null) {
      social = <Null>[];
      json['social'].forEach((v) {
        social!.add(new Null.fromJson(v));
      });
    }
    entertainment = json['entertainment'].cast<String>();
    if (json['disclaimer'] != null) {
      disclaimer = <Null>[];
      json['disclaimer'].forEach((v) {
        disclaimer!.add(new Null.fromJson(v));
      });
    }
    vipAccess = json['vipAccess'];
    ageLimit = json['ageLimit'];
    name = json['name'];
    place = json['place'];
    partnerId = json['partnerId'];
    eventType = json['eventType'];
    stopBooking = json['stopBooking'];
    cancelationPolicy = json['cancelationPolicy'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
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
    if (this.photos != null) {
      data['photos'] = this.photos!.map((v) => v.toJson()).toList();
    }
    data['eventProfile'] = this.eventProfile;
    if (this.entrenceCode != null) {
      data['entrenceCode'] = this.entrenceCode!.map((v) => v.toJson()).toList();
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
    if (this.music != null) {
      data['music'] = this.music!.map((v) => v.toJson()).toList();
    }
    if (this.social != null) {
      data['social'] = this.social!.map((v) => v.toJson()).toList();
    }
    data['entertainment'] = this.entertainment;
    if (this.disclaimer != null) {
      data['disclaimer'] = this.disclaimer!.map((v) => v.toJson()).toList();
    }
    data['vipAccess'] = this.vipAccess;
    data['ageLimit'] = this.ageLimit;
    data['name'] = this.name;
    data['place'] = this.place;
    data['partnerId'] = this.partnerId;
    data['eventType'] = this.eventType;
    data['stopBooking'] = this.stopBooking;
    data['cancelationPolicy'] = this.cancelationPolicy;
    data['userId'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Location {
  String? radius;
  String? pinLocation;
  String? type;
  List<double>? coordinates;

  Location({this.radius, this.pinLocation, this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    radius = json['radius'];
    pinLocation = json['pinLocation'];
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['radius'] = this.radius;
    data['pinLocation'] = this.pinLocation;
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

class AdmissionFee {
  Male? male;
  Male? female;

  AdmissionFee({this.male, this.female});

  AdmissionFee.fromJson(Map<String, dynamic> json) {
    male = json['male'] != null ? new Male.fromJson(json['male']) : null;
    female = json['female'] != null ? new Male.fromJson(json['female']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.male != null) {
      data['male'] = this.male!.toJson();
    }
    if (this.female != null) {
      data['female'] = this.female!.toJson();
    }
    return data;
  }
}

class Male {
  bool? free;
  int? amount;

  Male({this.free, this.amount});

  Male.fromJson(Map<String, dynamic> json) {
    free = json['free'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['free'] = this.free;
    data['amount'] = this.amount;
    return data;
  }
}

class Host {
  String? sId;
  String? role;
  bool? isVerified;
  bool? isApproved;
  bool? isProfile;
  String? profileImage;
  String? profileId;
  String? username;
  String? email;
  String? password;
  String? otp;
  String? userLoginType;
  List<Null>? refreshTokens;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? stripeCustomerId;
  String? connectedAccountId;
  bool? isNotifyMe;
  bool? isPushNotification;

  Host(
      {this.sId,
        this.role,
        this.isVerified,
        this.isApproved,
        this.isProfile,
        this.profileImage,
        this.profileId,
        this.username,
        this.email,
        this.password,
        this.otp,
        this.userLoginType,
        this.refreshTokens,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.stripeCustomerId,
        this.connectedAccountId,
        this.isNotifyMe,
        this.isPushNotification});

  Host.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    role = json['role'];
    isVerified = json['isVerified'];
    isApproved = json['isApproved'];
    isProfile = json['isProfile'];
    profileImage = json['profileImage'];
    profileId = json['profileId'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    otp = json['otp'];
    userLoginType = json['userLoginType'];
    if (json['refreshTokens'] != null) {
      refreshTokens = <Null>[];
      json['refreshTokens'].forEach((v) {
        refreshTokens!.add(new Null.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    stripeCustomerId = json['stripe_customer_id'];
    connectedAccountId = json['connected_account_id'];
    isNotifyMe = json['isNotifyMe'];
    isPushNotification = json['isPushNotification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['role'] = this.role;
    data['isVerified'] = this.isVerified;
    data['isApproved'] = this.isApproved;
    data['isProfile'] = this.isProfile;
    data['profileImage'] = this.profileImage;
    data['profileId'] = this.profileId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['otp'] = this.otp;
    data['userLoginType'] = this.userLoginType;
    if (this.refreshTokens != null) {
      data['refreshTokens'] =
          this.refreshTokens!.map((v) => v.toJson()).toList();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['stripe_customer_id'] = this.stripeCustomerId;
    data['connected_account_id'] = this.connectedAccountId;
    data['isNotifyMe'] = this.isNotifyMe;
    data['isPushNotification'] = this.isPushNotification;
    return data;
  }
}


class OrderModel {



  String? orderStatus;
  String? paymentStatus;
  String? paymentId;
  int? checkinStatus;
  String? lastCheckedIn;
  String? sId;
  UserId? userId;
  String? gender;
  EventModel? eventId;

  OrderModel(
      {
        this.orderStatus,
        this.paymentStatus,
        this.paymentId,
        this.checkinStatus,
        this.lastCheckedIn,
        this.sId,
        this.userId,
        this.gender,});

  OrderModel.fromJson(Map<String, dynamic> json,{bool addEvent=true,}) {
    orderStatus = json['orderStatus'];
    paymentStatus = json['payment_status'];
    paymentId = json['paymentId'];
    checkinStatus = json['checkinStatus'];
    lastCheckedIn = json['lastCheckedIn'];
    sId = json['_id'];
    if(addEvent) {
     // userId = json['userId'] != null ? new UserId.fromJson(json['userId']) : null;
      userId = json['host'] != null ? new UserId.fromJson(json['userId']) : null;
    }
    gender = json['gender'];
    if(addEvent) {
      eventId = json["eventId"] != null ? EventModel.fromJson(json["eventId"]) : null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderStatus'] = this.orderStatus;
    data['payment_status'] = this.paymentStatus;
    data['paymentId'] = this.paymentId;
    data['checkinStatus'] = this.checkinStatus;
    data['lastCheckedIn'] = this.lastCheckedIn;
    data['_id'] = this.sId;
    if (this.userId != null) {
      data['userId'] = this.userId!.toJson();
    }
    data['gender'] = this.gender;
    return data;
  }

  static List<OrderModel> fromJsonToList(List<dynamic> emote) => emote
      .map<OrderModel>((item) => OrderModel.fromJson(item))
      .toList();
}


class UserId {
  String? stripeCustomerId;
  String? role;
  bool? isVerified;
  bool? isApproved;
  bool? isProfile;
  String? profileImage;
  String? profileId;
  String? sId;
  String? username;

  UserId(
      {this.stripeCustomerId,
        this.role,
        this.isVerified,
        this.isApproved,
        this.isProfile,
        this.profileImage,
        this.profileId,
        this.sId,
        this.username, });

  UserId.fromJson(Map<String, dynamic> json) {
    stripeCustomerId = json['stripe_customer_id'];
    role = json['role'];
    isVerified = json['isVerified'];
    isApproved = json['isApproved'];
    isProfile = json['isProfile'];
    profileImage = json['profileImage'];
    profileId = json['profileId'];
    sId = json['_id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stripe_customer_id'] = this.stripeCustomerId;
    data['role'] = this.role;
    data['isVerified'] = this.isVerified;
    data['isApproved'] = this.isApproved;
    data['isProfile'] = this.isProfile;
    data['profileImage'] = this.profileImage;
    data['profileId'] = this.profileId;
    data['_id'] = this.sId;
    data['username'] = this.username;
    return data;
  }
}*/
