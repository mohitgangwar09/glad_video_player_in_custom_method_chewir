class ResponseOtpModel {
  String? message;
  int? status;
  dynamic data;

  ResponseOtpModel({this.message, this.status, this.data});

  ResponseOtpModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    data['data'] = this.data;
    return data;
  }
}
