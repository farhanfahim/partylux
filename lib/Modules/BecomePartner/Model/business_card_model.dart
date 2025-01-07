// To parse this JSON data, do
//
//     final createEventCard = createEventCardFromJson(jsonString);

class CreateBusinessCard {
  String? id;
  String? eventId;
  List<BusinessCard> cards;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  CreateBusinessCard({
    this.id,
    this.eventId,
    required this.cards,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory CreateBusinessCard.fromJson(Map<String, dynamic> json) =>
      CreateBusinessCard(
        id: json["_id"] ?? "",
        eventId: json["eventId"] ?? "",
        cards: List<BusinessCard>.from(
            json["cards"].map((x) => BusinessCard.fromJson(x))),
        userId: json["userId"] ?? "",
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  static Map<String, dynamic> toJson(CreateBusinessCard createEventCard) => {
        "eventId": createEventCard.eventId,
        "cards":
            List<dynamic>.from(createEventCard.cards.map((x) => x.toJson())),
      };

  factory CreateBusinessCard.fromEmpty() {
    return CreateBusinessCard(
      eventId: "",
      cards: [],
    );
  }
}

class BusinessCard {
  List<String> services;
  String? id;
  String vipcardName;
  int price;

  BusinessCard({
    required this.services,
    this.id,
    required this.vipcardName,
    required this.price,
  });

  factory BusinessCard.fromJson(Map<String, dynamic> json) => BusinessCard(
        services: List<String>.from(json["services"].map((x) => x)),
        id: json["_id"],
        vipcardName: json["vipcardName"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "vipcardName": vipcardName,
        "price": price,
        "services": List<dynamic>.from(services.map((x) => x)),
      };

  factory BusinessCard.fromEmpty() {
    return BusinessCard(
      vipcardName: "",
      price: 0,
      services: [],
    );
  }
}
