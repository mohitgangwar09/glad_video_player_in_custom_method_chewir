class AddFollowupRemarkModel {
  String? message;
  int? status;
  Data? data;

  AddFollowupRemarkModel({this.message, this.status, this.data});

  AddFollowupRemarkModel.fromJson(Map<String, dynamic> json) {
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
  Enquiry? enquiry;

  Data({this.enquiry});

  Data.fromJson(Map<String, dynamic> json) {
    enquiry =
    json['enquiry'] != null ? new Enquiry.fromJson(json['enquiry']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.enquiry != null) {
      data['enquiry'] = this.enquiry!.toJson();
    }
    return data;
  }
}

class Enquiry {
  String? enquiryId;
  String? comments;
  String? commentedBy;
  String? commentedId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Enquiry(
      {this.enquiryId,
        this.comments,
        this.commentedBy,
        this.commentedId,
        this.updatedAt,
        this.createdAt,
        this.id});

  Enquiry.fromJson(Map<String, dynamic> json) {
    enquiryId = json['enquiry_id'];
    comments = json['comments'];
    commentedBy = json['commented_by'];
    commentedId = json['commented_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['enquiry_id'] = this.enquiryId;
    data['comments'] = this.comments;
    data['commented_by'] = this.commentedBy;
    data['commented_id'] = this.commentedId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
