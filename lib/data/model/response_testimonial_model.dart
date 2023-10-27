class ResponseTestimonial {
  String? message;
  int? status;
  Data? data;

  ResponseTestimonial({this.message, this.status, this.data});

  ResponseTestimonial.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? description;
  String? type;
  String? attachment;
  int? userId;
  int? createdBy;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.description,
        this.type,
        this.attachment,
        this.userId,
        this.createdBy,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    type = json['type'];
    attachment = json['attachment'];
    userId = json['user_id'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['type'] = type;
    data['attachment'] = attachment;
    data['user_id'] = userId;
    data['created_by'] = createdBy;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}