
class BecomePartnerModel {

  String? place;
  String? cancelationPolicy;
  List<Social>? social;
  String? username;
  String? email;
  String? password;
  List<BusinessWeek>? businessWeek;
  int? maxParticipants;
  String? note;
  AdmissionFee? admissionFee;
  List<String>? music;
  List<String>? disclaimer;
  Location? location;
  List<String>? entertainment;
  String? ageLimit;
  List<String>? photos;
  String? businessProfile;
  String? bussinessName;
  String? bussinessCategory;

  BecomePartnerModel(
      {this.place,
        this.cancelationPolicy,
        this.social,
        this.username,
        this.email,
        this.password,
        this.businessWeek,
        this.maxParticipants,
        this.note,
        this.admissionFee,
        this.music,
        this.disclaimer,
        this.location,
        this.entertainment,
        this.ageLimit,
        this.photos,
        this.businessProfile,
        this.bussinessName,
        this.bussinessCategory});

  BecomePartnerModel.fromJson(Map<String, dynamic> json) {
    place = json['place'];
    cancelationPolicy = json['cancelationPolicy'];
    if (json['social'] != null) {
      social = <Social>[];
      json['social'].forEach((v) {
        social!.add(new Social.fromJson(v));
      });
    }
    username = json['username'];
    email = json['email'];
    password = json['password'];
    if (json['businessWeek'] != null) {
      businessWeek = <BusinessWeek>[];
      json['businessWeek'].forEach((v) {
        businessWeek!.add(new BusinessWeek.fromJson(v));
      });
    }
    maxParticipants = json['maxParticipants'];
    note = json['note'];
    admissionFee = json['admissionFee'] != null
        ? new AdmissionFee.fromJson(json['admissionFee'])
        : null;
    music = json['music'].cast<String>();
    disclaimer = json['disclaimer'].cast<String>();
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    entertainment = json['entertainment'].cast<String>();
    ageLimit = json['ageLimit'];
    photos = json['photos'].cast<String>();
    businessProfile = json['businessProfile'];
    bussinessName = json['bussinessName'];
    bussinessCategory = json['bussinessCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['place'] = this.place;
    data['cancelationPolicy'] = this.cancelationPolicy;
    if (this.social != null) {
      data['social'] = this.social!.map((v) => v.toJson()).toList();
    }
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    if (this.businessWeek != null) {
      data['businessWeek'] = this.businessWeek!.map((v) => v.toJson()).toList();
    }
    data['maxParticipants'] = this.maxParticipants;
    data['note'] = this.note;
    if (this.admissionFee != null) {
      data['admissionFee'] = this.admissionFee!.toJson();
    }
    data['music'] = this.music;
    data['disclaimer'] = this.disclaimer;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['entertainment'] = this.entertainment;
    data['ageLimit'] = this.ageLimit;
    data['photos'] = this.photos;
    data['businessProfile'] = this.businessProfile;
    data['bussinessName'] = this.bussinessName;
    data['bussinessCategory'] = this.bussinessCategory;
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

class BusinessWeek {
  bool? isClose;
  String? bussinessDay;
  String? startTime;
  String? endTime;

  BusinessWeek({this.isClose, this.bussinessDay, this.startTime, this.endTime});

  BusinessWeek.fromJson(Map<String, dynamic> json) {
    isClose = json['isClose'];
    bussinessDay = json['bussinessDay'];
    startTime = json['startTime'];
    endTime = json['endTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isClose'] = this.isClose;
    data['bussinessDay'] = this.bussinessDay;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
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
  num? amount;

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

class Location {
  String? type;
  List<num>? coordinates;
  String? radius;

  Location({this.type, this.coordinates, this.radius});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<num>();
    radius = json['radius'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    data['radius'] = this.radius;
    return data;
  }
}