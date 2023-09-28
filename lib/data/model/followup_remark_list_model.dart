class FollowupRemarkListModel {
  String? message;
  int? status;
  Data? data;

  FollowupRemarkListModel({this.message, this.status, this.data});

  FollowupRemarkListModel.fromJson(Map<String, dynamic> json) {
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
  List<FollowupReamrkList>? followupReamrkList;

  Data({this.followupReamrkList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['followup_reamrk_list'] != null) {
      followupReamrkList = <FollowupReamrkList>[];
      json['followup_reamrk_list'].forEach((v) {
        followupReamrkList!.add(FollowupReamrkList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (followupReamrkList != null) {
      data['followup_reamrk_list'] =
          followupReamrkList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FollowupReamrkList {
  int? id;
  int? enquiryId;
  dynamic deviceId;
  String? comments;
  String? commentedBy;
  String? commentedId;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  String? attachment;
  String? type;

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
        this.updatedAt,
        this.attachment,
        this.type,
      });

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
    attachment = json['attachment'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['enquiry_id'] = enquiryId;
    data['device_id'] = deviceId;
    data['comments'] = comments;
    data['commented_by'] = commentedBy;
    data['commented_id'] = commentedId;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['attachment'] = attachment;
    data['type'] = type;
    return data;
  }
}
