class CardModel {
  String? sId;
  String? cardNumber;
  String? fingerprint;
  String? brand;
  String? pmId;
  int? expMonth;
  int? expYear;
  Null? deletedAt;
  String? userId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CardModel(
      {this.sId,
        this.cardNumber,
        this.fingerprint,
        this.brand,
        this.pmId,
        this.expMonth,
        this.expYear,
        this.deletedAt,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  CardModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    cardNumber = json['card_number'];
    fingerprint = json['fingerprint'];
    brand = json['brand'];
    pmId = json['pm_id'];
    expMonth = json['exp_month'];
    expYear = json['exp_year'];
    deletedAt = json['deletedAt'];
    userId = json['user_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['card_number'] = this.cardNumber;
    data['fingerprint'] = this.fingerprint;
    data['brand'] = this.brand;
    data['pm_id'] = this.pmId;
    data['exp_month'] = this.expMonth;
    data['exp_year'] = this.expYear;
    data['deletedAt'] = this.deletedAt;
    data['user_id'] = this.userId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}