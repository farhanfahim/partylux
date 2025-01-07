// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

// ignore_for_file: unnecessary_null_comparison

class UserModel {
  static String ROLE_USER = 'user', ROLE_BUSINESS = 'business';

  String? userId;
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
  String? authToken;
  bool? isNotifyMe;
  bool? isPushNotification;
  Profile? profile;

  UserModel(
      {this.sId,
      this.userId,
      this.stripeCustomerId,
      this.connectedAccountId,
      this.role,
      this.isVerified,
      this.isApproved,
      this.isProfile,
      this.profileImage,
      this.profileId,
      this.username,
      this.email,
      this.authToken,
      this.isNotifyMe,
      this.isPushNotification,
      this.profile});

  UserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    stripeCustomerId = json['stripe_customer_id'];
    connectedAccountId = json['connected_account_id'];
    role = json['role'];
    isVerified = json['isVerified'];
    isApproved = json['isApproved'];
    isProfile = json['isProfile'];
    profileImage = json['profileImage'];
    profileId = json['profileId'];
    username = json['username'];
    email = json['email'];
    authToken = json['authToken'];
    isNotifyMe = json['isNotifyMe'];
    isPushNotification = json['isPushNotification'];
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['_id'] = this.sId;
    data['stripe_customer_id'] = this.stripeCustomerId;
    data['connected_account_id'] = this.connectedAccountId;
    data['role'] = this.role;
    data['isVerified'] = this.isVerified;
    data['isApproved'] = this.isApproved;
    data['isProfile'] = this.isProfile;
    data['profileImage'] = this.profileImage;
    data['profileId'] = this.profileId;
    data['username'] = this.username;
    data['email'] = this.email;
    data['authToken'] = this.authToken;
    data['isNotifyMe'] = this.isNotifyMe;
    data['isPushNotification'] = this.isPushNotification;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    return data;
  }

  static Map<String, dynamic> toJsonUpdateProfile(UserModel userModel) => {
        "userId": userModel.sId,
        "username": userModel.username,
        "profileImage": userModel.profileImage,
        "phoneNumber": userModel.profile!.phoneNumber,
        "description": userModel.profile!.description,
        "gender": userModel.profile!.gender,
        "phoneCode": userModel.profile!.phoneCode,
        "age": userModel.profile!.age,
        "hobbies": userModel.profile!.hobbies == null
            ? []
            : List<dynamic>.from(userModel.profile!.hobbies!.map((x) => x)),
        "interests": userModel.profile!.interests == null
            ? []
            : List<dynamic>.from(userModel.profile!.interests!.map((x) => x)),
        "location": userModel.profile!.location,
      };

  static Map<String, dynamic> toJsonUpdateNotificationSetting(
          UserModel userModel) =>
      {
        "isPushNotification": userModel.isPushNotification,
        "isNotifyMe": userModel.isNotifyMe,
      };

  factory UserModel.fromEmpty() {
    return UserModel(
      sId: "",
      stripeCustomerId: "",
      connectedAccountId: "",
      username: "",
      email: "",
      role: "",
      isProfile: false,
      isVerified: false,
      isApproved: false,
      isNotifyMe: false,
      isPushNotification: false,
      profileImage: "",
    );
  }
}

class Profile {
  String? profileImage;
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
  List<String>? joinedEvents;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Profile({
    this.profileImage,
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
    this.joinedEvents,
  });

  Profile.fromJson(Map<String, dynamic> json) {
    profileImage = json['profileImage'];
    description = json['description'];
    age = json['age'];
    gender = json['gender'];
    membershipType = json['membershipType'];
    phoneNumber = json['phoneNumber'];
    location = json['location'];
    hobbies = json['hobbies'].cast<String>();
    interests = json['interests'].cast<String>();
    joinedEvents = json['joinedEvents'].cast<String>();
    isPrivate = json['isPrivate'];
    phoneCode = json['phoneCode'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profileImage'] = this.profileImage;
    data['description'] = this.description;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['membershipType'] = this.membershipType;
    data['phoneNumber'] = this.phoneNumber;
    data['location'] = this.location;
    data['hobbies'] = this.hobbies;
    data['interests'] = this.interests;
    data['joinedEvents'] = this.joinedEvents;
    data['isPrivate'] = this.isPrivate;
    data['phoneCode'] = this.phoneCode;
    data['username'] = this.username;
    return data;
  }
}
