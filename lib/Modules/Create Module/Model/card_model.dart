// To parse this JSON data, do
//
//     final createEventCard = createEventCardFromJson(jsonString);

class CreateEventCard {
  String? id;
  String? eventId;
  List<EventCard> cards;
  String? userId;
  DateTime? createdAt;
  DateTime? updatedAt;

  CreateEventCard({
    this.id,
    this.eventId,
    required this.cards,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  factory CreateEventCard.fromJson(Map<String, dynamic> json) =>
      CreateEventCard(
        id: json["_id"] ?? "",
        eventId: json["eventId"] ?? "",
        cards: List<EventCard>.from(
            json["cards"].map((x) => EventCard.fromJson(x))),
        userId: json["userId"] ?? "",
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  static Map<String, dynamic> toJson(CreateEventCard createEventCard) => {
        "eventId": createEventCard.eventId,
        "cards":
            List<dynamic>.from(createEventCard.cards.map((x) => x.toJson())),
      };

  factory CreateEventCard.fromEmpty() {
    return CreateEventCard(
      eventId: "",
      cards: [],
    );
  }
}

class EventCard {
  List<String> services;
  String? id;
  String vipcardName;
  int price;

  EventCard({
    required this.services,
    this.id,
    required this.vipcardName,
    required this.price,
  });

  factory EventCard.fromJson(Map<String, dynamic> json) => EventCard(
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

  factory EventCard.fromEmpty() {
    return EventCard(
      vipcardName: "",
      price: 0,
      services: [],
    );
  }
}
