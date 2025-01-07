class EventParticipantsModel {
  String? sId;
  bool? isNotiReminder;
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

  EventParticipantsModel(
      {this.sId,
        this.isNotiReminder,
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
        this.user});

  EventParticipantsModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isNotiReminder = json['isNotiReminder'];
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


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['isNotiReminder'] = this.isNotiReminder;
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
    return data;
  }

  static List<EventParticipantsModel> fromJsonToList(List<dynamic> emote) => emote
      .map<EventParticipantsModel>((item) => EventParticipantsModel.fromJson(item))
      .toList();
}

class User {
  String? sId;
  String? username;
  String? email;
  Profile? profile;

  User({this.sId, this.username, this.email, this.profile});

  User.fromJson(Map<String, dynamic> json) {
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
  String? sId;
  String? profileImage;
  String? email;
  String? description;
  String? age;
  String? gender;
  String? membershipType;
  String? phoneNumber;
  String? location;
  List<String>? hobbies;
  List<String>? interests;
  bool? isPrivate;
  String? phoneCode;
  String? username;
  String? userId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Profile(
      {this.sId,
        this.profileImage,
        this.email,
        this.description,
        this.age,
        this.gender,
        this.membershipType,
        this.phoneNumber,
        this.location,
        this.hobbies,
        this.interests,
        this.isPrivate,
        this.phoneCode,
        this.username,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Profile.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profileImage = json['profileImage'];
    email = json['email'];
    description = json['description'];
    age = json['age'];
    gender = json['gender'];
    membershipType = json['membershipType'];
    phoneNumber = json['phoneNumber'];
    location = json['location'];
    hobbies = json['hobbies'].cast<String>();
    interests = json['interests'].cast<String>();
    isPrivate = json['isPrivate'];
    phoneCode = json['phoneCode'];
    username = json['username'];
    userId = json['userId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['profileImage'] = this.profileImage;
    data['email'] = this.email;
    data['description'] = this.description;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['membershipType'] = this.membershipType;
    data['phoneNumber'] = this.phoneNumber;
    data['location'] = this.location;
    data['hobbies'] = this.hobbies;
    data['interests'] = this.interests;
    data['isPrivate'] = this.isPrivate;
    data['phoneCode'] = this.phoneCode;
    data['username'] = this.username;
    data['userId'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}