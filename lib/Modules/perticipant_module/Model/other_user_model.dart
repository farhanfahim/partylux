class OtherUserModel {
  String? sId;
  String? profileImage;
  String? email;
  String? description;
  String? age;
  String? gender;
  String? phoneNumber;
  String? location;
  List<String>? hobbies;
  List<String>? interests;
  bool? isPrivate;
  String? phoneCode;
  String? username;
  String? userId;

  OtherUserModel(
      {this.sId,
        this.profileImage,
        this.email,
        this.description,
        this.age,
        this.gender,
        this.phoneNumber,
        this.location,
        this.hobbies,
        this.interests,
        this.isPrivate,
        this.phoneCode,
        this.username,
        this.userId, });

  OtherUserModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profileImage = json['profileImage'];
    email = json['email'];
    description = json['description'];
    age = json['age'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    location = json['location'];
    hobbies = json['hobbies'].cast<String>();
    interests = json['interests'].cast<String>();
    isPrivate = json['isPrivate'];
    phoneCode = json['phoneCode'];
    username = json['username'];
    userId = json['userId'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['profileImage'] = this.profileImage;
    data['email'] = this.email;
    data['description'] = this.description;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['phoneNumber'] = this.phoneNumber;
    data['location'] = this.location;
    if (this.hobbies != null) {
      data['hobbies'] = this.hobbies;
    }
    if (this.interests != null) {
      data['interests'] = this.interests;
    }
    data['isPrivate'] = this.isPrivate;
    data['phoneCode'] = this.phoneCode;
    data['username'] = this.username;
    data['userId'] = this.userId;
    return data;
  }

  factory OtherUserModel.fromEmpty() {
    return OtherUserModel(
      sId: "",
      userId: "",
      username: "",
      email: "",
      profileImage: "",
      description: "",
      age: "",
      gender: "",
      phoneNumber: "",
      location: "",
      hobbies: [],
      interests: [],
      isPrivate: false,


    );
  }
}