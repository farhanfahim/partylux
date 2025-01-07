// To parse this JSON data, do
//
//     final becomePartnerModel = becomePartnerModelFromJson(jsonString);

import 'package:partylux/Modules/BecomePartner/Model/become_partner_model.dart';

class BecomePartnerParticeipantsModel {
  String? id;
  UserDetail userDetail;
  BecomePartnerParticeipantsModel({
    this.id,
    required this.userDetail,
  });

  factory BecomePartnerParticeipantsModel.fromJson(Map<String, dynamic> json) =>
      BecomePartnerParticeipantsModel(
        id: json["_id"] ?? "",
        userDetail: json["userDetail"] != null
            ? UserDetail.fromJson(json["userDetail"])
            : UserDetail.fromEmpty(),
      );

  static List<BecomePartnerParticeipantsModel> fromJsonToList(
          List<dynamic> emote) =>
      emote
          .map<BecomePartnerParticeipantsModel>(
              (item) => BecomePartnerParticeipantsModel.fromJson(item))
          .toList();

  factory BecomePartnerParticeipantsModel.fromEmpty() =>
      BecomePartnerParticeipantsModel(
        id: "",
        userDetail: UserDetail.fromJson({}),
      );
}
