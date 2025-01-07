class ExtraPayload {
  String? title;
  String? content;
  String? actionId;
  String? eventName;

  ExtraPayload(
      {this.title,
        this.content,
        this.actionId,
        this.eventName,});

  ExtraPayload.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    actionId = json['actionId'];
    eventName = json['eventName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['actionId'] = this.actionId;
    data['eventName'] = this.eventName;
    return data;
  }
}
