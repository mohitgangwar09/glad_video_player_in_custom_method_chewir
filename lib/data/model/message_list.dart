class MessageList {
  String? time;
  dynamic createdAt;
  String? messageType;
  String? date;
  String? text;
  String? file;
  String? userName;
  String? userType;
  dynamic messageCount;

  MessageList(
      {this.time,
        this.createdAt,
        this.messageType,
        this.date,
        this.text,
        this.file,
        this.userName,
        this.userType,
        this.messageCount});

  MessageList.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    createdAt = json['created_at'];
    messageType = json['message_type'];
    date = json['date'];
    text = json['text'];
    file = json['file'];
    userName = json['user_name'];
    userType = json['user_type'];
    messageCount = json['message_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = time;
    data['created_at'] = createdAt;
    data['message_type'] = messageType;
    data['date'] = date;
    data['text'] = text;
    data['file'] = file;
    data['user_name'] = userName;
    data['user_type'] = userType;
    data['message_count'] = messageCount;
    return data;
  }
}
