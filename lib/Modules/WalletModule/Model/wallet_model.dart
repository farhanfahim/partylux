class MyWalletModel {
  final num balance;
  final String id;
  final String userId;
  final List<Transacrion> transacrion;
  final DateTime createdAt;
  final DateTime updatedAt;

  MyWalletModel({
    required this.balance,
    required this.id,
    required this.userId,
    required this.transacrion,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MyWalletModel.fromJson(Map<String, dynamic> json) => MyWalletModel(
        balance: json["balance"] ?? 0,
        id: json["_id"] ?? "",
        userId: json["userId"] ?? "",
        transacrion: json["transacrion"] != null
            ? List<Transacrion>.from(
                json["transacrion"].map((x) => Transacrion.fromJson(x)))
            : [],
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : DateTime.now(),
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : DateTime.now(),
      );

  factory MyWalletModel.fromEmpty() => MyWalletModel(
        balance: 0,
        id: "",
        userId: "",
        transacrion: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "_id": id,
        "userId": userId,
        "transacrion": List<dynamic>.from(transacrion.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Transacrion {
  final String refund;
  final String transType;
  final String action;
  final num amount;
  final String id;
  final String eventId;
  final DateTime date;

  Transacrion({
    required this.refund,
    required this.transType,
    required this.action,
    required this.amount,
    required this.id,
    required this.eventId,
    required this.date,
  });

  factory Transacrion.fromJson(Map<String, dynamic> json) => Transacrion(
        refund: json["refund"] ?? "",
        transType: json["transType"] ?? "",
        action: json["action"] ?? "",
        amount: json["amount"] ?? 0,
        id: json["_id"] ?? "",
        eventId: json["eventId"] ?? "",
        date: json["date"] != null
            ? DateTime.parse(json["date"])
            : DateTime.now(),
      );

  factory Transacrion.fromEmpty(Map<String, dynamic> json) => Transacrion(
        refund: "",
        transType: "",
        action: "",
        amount: 0,
        id: "",
        eventId: "",
        date: DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        "refund": refund,
        "transType": transType,
        "action": action,
        "amount": amount,
        "_id": id,
        "eventId": eventId,
        "date": date.toIso8601String(),
      };
}
