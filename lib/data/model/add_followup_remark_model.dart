class AddFollowupRemarkModel {
  String? message;
  int? status;
  Data? data;

  AddFollowupRemarkModel({this.message, this.status, this.data});

  AddFollowupRemarkModel.fromJson(Map<String, dynamic> json) {
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
  Enquiry? enquiry;

  Data({this.enquiry});

  Data.fromJson(Map<String, dynamic> json) {
    enquiry =
    json['enquiry'] != null ? Enquiry.fromJson(json['enquiry']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (enquiry != null) {
      data['enquiry'] = enquiry!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['enquiry_id'] = enquiryId;
    data['comments'] = comments;
    data['commented_by'] = commentedBy;
    data['commented_id'] = commentedId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
