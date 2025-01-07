// To parse this JSON data, do
//
//     final faqsmodel = faqsmodelFromJson(jsonString);

class Faqsmodel {
  String question;
  String answer;
  String id;
  DateTime createdAt;
  DateTime updatedAt;

  Faqsmodel({
    required this.question,
    required this.answer,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Faqsmodel.fromJson(Map<String, dynamic> json) => Faqsmodel(
        question: json["question"] ?? "",
        answer: json["answer"] ?? "",
        id: json["_id"] ?? "",
        createdAt: json["createdAt"] != null
            ? DateTime.parse(json["createdAt"])
            : DateTime.now(),
        updatedAt: json["updatedAt"] != null
            ? DateTime.parse(json["updatedAt"])
            : DateTime.now(),
      );

  static List<Faqsmodel> fromJsonToList(List<dynamic> emote) =>
      emote.map<Faqsmodel>((item) => Faqsmodel.fromJson(item)).toList();

  factory Faqsmodel.fromEmpty() => Faqsmodel(
        question: "",
        answer: "",
        id: "",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
}
