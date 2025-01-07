// To parse this JSON data, do
//
//     final createEventModel = createEventModelFromJson(jsonString);
class CreateEventModel {
  LocationModel? location;
  AdmissionFee? admissionFee;
  List<String>? photos;
  String? eventProfile;
  String? startDateTime;
  String? endDateTime;
  String? eventCategory;
  String? maxParticipants;
  String? note;
  String? eventState;
  List<String>? music;
  List<String>? entertainment;
  List<String>? disclaime;
  String? ageLimit;
  bool? vipAccess;
  String? id;
  String? name;
  String? place;
  String? cancelationPolicy;
  String? userId;
  List<Participant>? participants;
  String? createdAt;
  String? updatedAt;
  Vips? vips;
  UserDetail? userDetail;
  String? eventType;
  List<EntrenceCode>? entrenceCode;
  List<EventSubscriptions>? eventSubscriptions;

  //   "entrenceCode" : [
// {

//    "type" : "free", //  enum: ['normal' , "free" , "discount"],
//    "price" : 0
//   },
//   {

//    "type" : "discount",
//    "price" : 100
//   }
//   ],

  CreateEventModel({
    this.location,
    this.admissionFee,
    this.photos,
    this.eventProfile,
    this.startDateTime,
    this.endDateTime,
    this.eventCategory,
    this.maxParticipants,
    this.note,
    this.eventState,
    this.music,
    this.entertainment,
    this.disclaime,
    this.ageLimit,
    this.vipAccess,
    this.id,
    this.name,
    this.place,
    this.cancelationPolicy,
    this.userId,
    this.participants,
    this.createdAt,
    this.updatedAt,
    this.vips,
    this.userDetail,
    this.eventType,
    this.entrenceCode,
    this.eventSubscriptions
  });

  factory CreateEventModel.fromJson(Map<String, dynamic> json) =>
      CreateEventModel(
        location: json["location"] != null
            ? LocationModel.fromJson(json["location"])
            : LocationModel.fromEmpty(),
        admissionFee: json["admissionFee"] != null
            ? AdmissionFee.fromJson(json["admissionFee"])
            : AdmissionFee.fromEmpty(),
        photos: json["photos"] != null
            ? List<String>.from(json["photos"].map((x) => x))
            : [],
        eventProfile: json["eventProfile"] ?? "",
        startDateTime: json["startDateTime"] ?? "",
        endDateTime: json["endDateTime"] ?? "",
        // startDate: json["startDate"] ?? "",
        // endDate: json["endDate"] ?? "",
        // startTime: json["startTime"] ?? "",
        // endTime: json["endTime"] ?? "",
        eventCategory: json["eventCategory"] ?? "",
        maxParticipants: json["maxParticipants"] ?? "",
        note: json["note"] ?? "",
        eventState: json["eventState"] ?? "",
        music: json["music"] != null
            ? List<String>.from(json["music"].map((x) => x))
            : [],
        entertainment: json["entertainment"] != null
            ? List<String>.from(json["entertainment"].map((x) => x))
            : [],
        disclaime: json["disclaimer"] != null
            ? List<String>.from(json["disclaimer"].map((x) => x))
            : [],
        ageLimit: json["ageLimit"] ?? "",
        vipAccess: json["vipAccess"] ?? false,
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        place: json["place"] ?? "",
        cancelationPolicy: json["cancelationPolicy"] ?? "",
        userId: json["userId"] ?? "",
        participants: json["participants"] != null
            ? Participant.fromJsonToList(json["participants"])
            : [],
        createdAt: json["createdAt"] ?? "",
        updatedAt: json["updatedAt"] ?? "",
        vips: json["vips"] != null
            ? Vips.fromJson(json["vips"])
            : Vips.fromEmpty(),
        userDetail: json["userDetail"] != null
            ? UserDetail.fromJson(json["userDetail"])
            : UserDetail.fromEmpty(),
        eventType: json["eventType"] ?? "",
        entrenceCode: json["entrenceCode"] != null
            ? EntrenceCode.fromJsonToList(json["entrenceCode"])
            : [],
        eventSubscriptions: json["eventSubscriptions"] != null
            ? EventSubscriptions.fromJsonToList(json["eventSubscriptions"])
            : [],
      );

  static List<CreateEventModel> fromJsonToList(List<dynamic> emote) => emote
      .map<CreateEventModel>((item) => CreateEventModel.fromJson(item))
      .toList();

  static Map<String, dynamic> toJson(CreateEventModel createEventModel) => {
        "name": createEventModel.name,
        "eventCategory": createEventModel.eventCategory,
        "photos": List<dynamic>.from(createEventModel.photos!.map((x) => x)),
        "eventType": createEventModel.eventType,
        "eventProfile": createEventModel.eventProfile,
        "startDateTime": createEventModel.startDateTime,
        "endDateTime": createEventModel.endDateTime,
        "place": createEventModel.place,
        "location": createEventModel.location!.toJson(),
        "cancelationPolicy": createEventModel.cancelationPolicy,
        "maxParticipants": createEventModel.maxParticipants,
        "note": createEventModel.note,
        "ageLimit": createEventModel.ageLimit,
        "admissionFee": createEventModel.admissionFee!.toJson(),
        "music": List<dynamic>.from(createEventModel.music!.map((x) => x)),
        "entertainment":
            List<dynamic>.from(createEventModel.entertainment!.map((x) => x)),
        "disclaimer":
            List<dynamic>.from(createEventModel.disclaime!.map((x) => x)),
        "entrenceCode": createEventModel.eventType == "private"
            ? List<dynamic>.from(
                createEventModel.entrenceCode!.map((x) => x.toJson()))
            : [],
        //  EntrenceCode(type: type, amount: amount),
        // createEventModel.entrenceCode
      };

  factory CreateEventModel.fromEmpty() {
    return CreateEventModel(
      location: LocationModel.fromEmpty(),
      admissionFee: AdmissionFee.fromEmpty(),
      photos: [],
      eventProfile: "",
      startDateTime: "",
      endDateTime: "",
      eventCategory: "",
      maxParticipants: "",
      note: "",
      eventState: "",
      music: [],
      entertainment: [],
      disclaime: [],
      ageLimit: "",
      vipAccess: false,
      id: "",
      name: "",
      place: "",
      cancelationPolicy: "",
      userId: "",
      participants: [],
      createdAt: "",
      updatedAt: "",
    );
  }
}

class Participant {
  String participantId;
  String userId;
  String fullName;
  String city;
  String profileImage;
  String isAcceptedByOwner;
  bool isCanceledByParticipant;
  String id;

  Participant({
    required this.participantId,
    required this.userId,
    required this.fullName,
    required this.city,
    required this.profileImage,
    required this.isAcceptedByOwner,
    required this.isCanceledByParticipant,
    required this.id,
  });

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        participantId: json["participantId"] ?? "",
        userId: json["userId"] ?? "",
        fullName: json["fullName"] ?? "",
        city: json["city"] ?? "",
        profileImage: json["profileImage"] ?? "",
        isAcceptedByOwner: json["isAcceptedByOwner"] ?? "",
        isCanceledByParticipant: json["isCanceledByParticipant"] ?? false,
        id: json["_id"] ?? "",
      );
  static List<Participant> fromJsonToList(List<dynamic> emote) =>
      emote.map<Participant>((item) => Participant.fromJson(item)).toList();

  factory Participant.fromEmpty() => Participant(
        participantId: "",
        userId: "",
        fullName: "",
        city: "",
        profileImage: "",
        isAcceptedByOwner: "",
        isCanceledByParticipant: false,
        id: "",
      );
}

class AdmissionFee {
  Couple male;
  Couple female;
  // Couple couple;

  AdmissionFee({
    required this.male,
    required this.female,
    // required this.couple,
  });

  factory AdmissionFee.fromJson(Map<String, dynamic> json) => AdmissionFee(
        male: Couple.fromJson(json["male"]),
        female: Couple.fromJson(json["female"]),
        // couple: Couple.fromJson(json["couple"]),
      );

  Map<String, dynamic> toJson() => {
        "male": male.toJson(),
        "female": female.toJson(),
        // "couple": couple.toJson(),
      };
  factory AdmissionFee.fromEmpty() {
    return AdmissionFee(
      male: Couple.fromEmpty(),
      female: Couple.fromEmpty(),
      // couple: Couple.fromEmpty(),
    );
  }
}

class Couple {
  bool free;
  int amount;

  Couple({
    required this.free,
    required this.amount,
  });

  factory Couple.fromJson(Map<String, dynamic> json) => Couple(
        free: json["free"] ?? false,
        amount: json["amount"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "free": free,
        "amount": amount,
      };
  factory Couple.fromEmpty() {
    return Couple(
      free: false,
      amount: 0,
    );
  }
}

class EntrenceCode {
  String type;
  int amount;
  String? id;
  String? code;

  EntrenceCode({
    required this.type,
    required this.amount,
    this.code,
    this.id,
  });

  factory EntrenceCode.fromJson(Map<String, dynamic> json) => EntrenceCode(
        type: json["type"] ?? false,
        amount: json["price"] ?? 0,
        id: json["_id"] ?? "",
        code: json["code"] ?? "",
      );

  static List<EntrenceCode> fromJsonToList(List<dynamic> emote) =>
      emote.map<EntrenceCode>((item) => EntrenceCode.fromJson(item)).toList();

  Map<String, dynamic> toJson() => {
        "type": type,
        "price": amount,
      };
  factory EntrenceCode.fromEmpty() {
    return EntrenceCode(
      type: "",
      amount: 0,
      id: "",
      code: "",
    );
  }
}

class LocationModel {
  String? pinLocation;
  String? radius;
  String type;
  List<double> coordinates;

  LocationModel({
    this.pinLocation,
    this.radius,
    required this.type,
    required this.coordinates,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        pinLocation: json["pinLocation"] ?? "",
        type: json["type"] ?? "",
        radius: json["radius"] ?? "",
        coordinates: json["coordinates"] != null
            ? List<double>.from(json["coordinates"].map((x) => x.toDouble()))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "radius": radius,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
  factory LocationModel.fromEmpty() {
    return LocationModel(
      pinLocation: "",
      type: "",
      radius: "",
      coordinates: [],
    );
  }
}

class UserDetail {
  String id;
  String username;
  String email;
  Profile profile;

  UserDetail({
    required this.id,
    required this.username,
    required this.email,
    required this.profile,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        id: json["_id"] ?? "",
        username: json["username"] ?? "",
        email: json["email"] ?? "",
        profile: json["profile"] != null
            ? Profile.fromJson(json["profile"])
            : Profile.fromEmpty(),
      );

  factory UserDetail.fromEmpty() => UserDetail(
        id: "",
        username: "",
        email: "",
        profile: Profile.fromEmpty(),
      );
}

class Profile {
  String profileImage;
  String description;
  String age;
  String gender;
  String phoneNumber;
  String location;
  List<dynamic> hobbies;
  List<String> interests;
  bool isPrivate;
  String phoneCode;
  List<String> joinedEvents;

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
            ? List<dynamic>.from(json["hobbies"].map((x) => x))
            : [],
        interests: json["interests"] != null
            ? List<String>.from(json["interests"].map((x) => x))
            : [],
        isPrivate: json["isPrivate"] ?? false,
        phoneCode: json["phoneCode"] ?? "",
        joinedEvents: json["joinedEvents"] != null
            ? List<String>.from(json["joinedEvents"].map((x) => x))
            : [],
      );
  factory Profile.fromEmpty() {
    return Profile(
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
  }
}

class Vips {
  List<Card> cards;
  String userId;

  Vips({
    required this.cards,
    required this.userId,
  });

  factory Vips.fromJson(Map<String, dynamic> json) => Vips(
        cards: json["cards"] != null
            ? List<Card>.from(json["cards"].map((x) => Card.fromJson(x)))
            : [],
        userId: json["userId"] ?? "",
      );

  // static List<Vips> fromJsonToList(List<dynamic> emote) =>
  //     emote.map<Vips>((item) => Vips.fromJson(item)).toList();

  factory Vips.fromEmpty() => Vips(
        cards: [],
        userId: "",
      );
}

class Card {
  List<String> services;
  String id;
  String vipcardName;
  int price;

  Card({
    required this.services,
    required this.id,
    required this.vipcardName,
    required this.price,
  });

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        services: json["services"] != null
            ? List<String>.from(json["services"].map((x) => x))
            : [],
        id: json["_id"] ?? "",
        vipcardName: json["vipcardName"] ?? "",
        price: json["price"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "services": List<dynamic>.from(services.map((x) => x)),
        "_id": id,
        "vipcardName": vipcardName,
        "price": price,
      };
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

