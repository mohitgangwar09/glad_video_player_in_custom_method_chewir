class ResponseTestimonial {
  String? message;
  int? status;
  Data? data;

  ResponseTestimonial({this.message, this.status, this.data});

  ResponseTestimonial.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['type'] = this.type;
    data['attachment'] = this.attachment;
    data['user_id'] = this.userId;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}