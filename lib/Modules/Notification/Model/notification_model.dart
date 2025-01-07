class NotificationModel {
  String? sId;
  String? role;
  bool? isReadAll;
  String? fcmToken;
  String? user;
  Types? types;
  String? createdAt;
  String? updatedAt;
  int? iV;

  NotificationModel(
      {this.sId,
        this.role,
        this.isReadAll,
        this.fcmToken,
        this.user,
        this.types,
        this.createdAt,
        this.updatedAt,
        this.iV});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    role = json['role'];
    isReadAll = json['isReadAll'];
    fcmToken = json['fcmToken'];
    user = json['user'];
    types = json['types'] != null ? new Types.fromJson(json['types']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['role'] = this.role;
    data['isReadAll'] = this.isReadAll;
    data['fcmToken'] = this.fcmToken;
    data['user'] = this.user;
    if (this.types != null) {
      data['types'] = this.types!.toJson();
    }
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }


  static List<NotificationModel> fromJsonToList(List<dynamic> emote) => emote
      .map<NotificationModel>((item) => NotificationModel.fromJson(item))
      .toList();
}

class Types {
  List<NotificationType>? today;
  List<NotificationType>? yesterday;
  List<NotificationType>? thisWeek;
  List<NotificationType>? older;

  Types({this.today, this.yesterday, this.thisWeek, this.older});

  Types.fromJson(Map<String, dynamic> json) {
    if (json['today'] != null) {
      today = <NotificationType>[];
      json['today'].forEach((v) {
        today!.add(new NotificationType.fromJson(v));
      });
    }
    if (json['yesterday'] != null) {
      yesterday = <NotificationType>[];
      json['yesterday'].forEach((v) {
        yesterday!.add(new NotificationType.fromJson(v));
      });
    }
    if (json['this_week'] != null) {
      thisWeek = <NotificationType>[];
      json['this_week'].forEach((v) {
        thisWeek!.add(new NotificationType.fromJson(v));
      });
    }
    if (json['older'] != null) {
      older = <NotificationType>[];
      json['older'].forEach((v) {
        older!.add(new NotificationType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.today != null) {
      data['today'] = this.today!.map((v) => v.toJson()).toList();
    }
    if (this.yesterday != null) {
      data['yesterday'] = this.yesterday!.map((v) => v.toJson()).toList();
    }
    if (this.thisWeek != null) {
      data['this_week'] = this.thisWeek!.map((v) => v.toJson()).toList();
    }
    if (this.older != null) {
      data['older'] = this.older!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationType {
  String? title;
  bool? isRead;
  String? content;
  String? actionId;
  String? eventName;
  String? sId;
  String? createdAt;

  NotificationType(
      {this.title,
        this.isRead,
        this.content,
        this.actionId,
        this.eventName,
        this.sId,
        this.createdAt});

  NotificationType.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    isRead = json['isRead'];
    content = json['content'];
    actionId = json['actionId'];
    eventName = json['eventName'];
    sId = json['_id'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['isRead'] = this.isRead;
    data['content'] = this.content;
    data['actionId'] = this.actionId;
    data['eventName'] = this.eventName;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    return data;
  }
}