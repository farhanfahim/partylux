class TicketModel {
  String? sId;
  String? eventType;
  String? orderStatus;
  String? eventDate;
  String? paymentStatus;
  String? eventId;
  String? userId;
  String? gender;
  num? price;
  User? user;
  Event? event;
  Host? host;

  TicketModel(
      {this.sId,
        this.eventType,
        this.orderStatus,
        this.eventDate,
        this.paymentStatus,
        this.eventId,
        this.userId,
        this.gender,
        this.price,
        this.user,
        this.event,
        this.host});

  TicketModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];

    eventType = json['eventType'];
    orderStatus = json['orderStatus'];
    eventDate = json['eventDate'];
    paymentStatus = json['payment_status'];

    eventId = json['eventId'];
    userId = json['userId'];
    gender = json['gender'];
    price = json['price'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    event = json['event'] != null ? new Event.fromJson(json['event']) : null;
    host = json['host'] != null ? new Host.fromJson(json['host']) : null;
  }

}

class User {
  String? sId;
  String? role;
  bool? isProfile;
  String? username;
  String? profileImage;

  User(
      {this.sId,
        this.role,
        this.isProfile,
        this.username,
        this.profileImage,});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    role = json['role'];
    isProfile = json['isProfile'];
    username = json['username'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['role'] = this.role;
    data['isProfile'] = this.isProfile;
    data['username'] = this.username;
    data['profileImage'] = this.profileImage;
    return data;
  }
}

class Event {
  String? sId;
  Location? location;
  AdmissionFee? admissionFee;
  String? eventProfile;
  String? startDateTime;
  String? endDateTime;
  String? eventCategory;
  int? maxParticipants;
  int? maxGuest;
  String? note;
  String? eventState;
  String? ageLimit;
  String? name;
  String? place;
  String? eventType;
  String? userId;

  Event(
      {this.sId,
        this.location,
        this.admissionFee,
        this.eventProfile,
        this.startDateTime,
        this.endDateTime,
        this.maxParticipants,
        this.maxGuest,
        this.note,
        this.eventState,
        this.ageLimit,
        this.name,
        this.place,
        this.eventType,
        this.userId,  });

  Event.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    admissionFee = json['admissionFee'] != null
        ? new AdmissionFee.fromJson(json['admissionFee'])
        : null;
    eventProfile = json['eventProfile'];
    startDateTime = json['startDateTime'];
    endDateTime = json['endDateTime'];
    eventCategory = json['eventCategory'];
    maxParticipants = json['maxParticipants'];
    maxGuest = json['maxGuest'];
    note = json['note'];
    eventState = json['eventState'];
    ageLimit = json['ageLimit'];
    name = json['name'];
    place = json['place'];
    eventType = json['eventType'];
    userId = json['userId'];
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
    data['startDateTime'] = this.startDateTime;
    data['endDateTime'] = this.endDateTime;
    data['eventCategory'] = this.eventCategory;
    data['maxParticipants'] = this.maxParticipants;
    data['maxGuest'] = this.maxGuest;
    data['note'] = this.note;
    data['eventState'] = this.eventState;
    data['ageLimit'] = this.ageLimit;
    data['name'] = this.name;
    data['place'] = this.place;
    data['eventType'] = this.eventType;
    data['userId'] = this.userId;
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
  String? profileImage;
  String? profileId;
  String? username;
  String? email;

  Host(
      {this.sId,
        this.profileImage,
        this.profileId,
        this.username,
        this.email });

  Host.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    profileImage = json['profileImage'];
    profileId = json['profileId'];
    username = json['username'];
    email = json['email'];
  }

}