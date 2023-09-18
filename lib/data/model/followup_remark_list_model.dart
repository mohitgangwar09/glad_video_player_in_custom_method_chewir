class FollowupRemarkListModel {
  String? message;
  int? status;
  Data? data;

  FollowupRemarkListModel({this.message, this.status, this.data});

  FollowupRemarkListModel.fromJson(Map<String, dynamic> json) {
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
  List<FollowupReamrkList>? followupReamrkList;

  Data({this.followupReamrkList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['followup_reamrk_list'] != null) {
      followupReamrkList = <FollowupReamrkList>[];
      json['followup_reamrk_list'].forEach((v) {
        followupReamrkList!.add(new FollowupReamrkList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.followupReamrkList != null) {
      data['followup_reamrk_list'] =
          this.followupReamrkList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FollowupReamrkList {
  int? id;
  int? enquiryId;
  Null? deviceId;
  String? comments;
  String? commentedBy;
  String? commentedId;
  String? status;
  Null? createdBy;
  Null? updatedBy;
  Null? deletedBy;
  String? createdAt;
  String? updatedAt;

  FollowupReamrkList(
      {this.id,
        this.enquiryId,
        this.deviceId,
        this.comments,
        this.commentedBy,
        this.commentedId,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt});

  FollowupReamrkList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    enquiryId = json['enquiry_id'];
    deviceId = json['device_id'];
    comments = json['comments'];
    commentedBy = json['commented_by'];
    commentedId = json['commented_id'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['enquiry_id'] = this.enquiryId;
    data['device_id'] = this.deviceId;
    data['comments'] = this.comments;
    data['commented_by'] = this.commentedBy;
    data['commented_id'] = this.commentedId;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_by'] = this.deletedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
