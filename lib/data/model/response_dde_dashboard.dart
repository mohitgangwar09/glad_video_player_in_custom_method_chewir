class ResponseDdeDashboard {
  String? message;
  int? status;
  DataDdeDashboard? data;

  ResponseDdeDashboard({this.message, this.status, this.data});

  ResponseDdeDashboard.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? DataDdeDashboard.fromJson(json['data']) : null;
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

class DataDdeDashboard {
  Dde? dde;
  RagratingTypeStatus? ragratingTypeStatus;

  DataDdeDashboard({this.dde, this.ragratingTypeStatus});

  DataDdeDashboard.fromJson(Map<String, dynamic> json) {
    dde = json['dde'] != null ? Dde.fromJson(json['dde']) : null;
    ragratingTypeStatus = json['ragratingTypeStatus'] != null
        ? RagratingTypeStatus.fromJson(json['ragratingTypeStatus'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dde != null) {
      data['dde'] = dde!.toJson();
    }
    if (ragratingTypeStatus != null) {
      data['ragratingTypeStatus'] = ragratingTypeStatus!.toJson();
    }
    return data;
  }
}

class Dde {
  int? id;
  String? name;
  int? userId;
  int? mccId;
  dynamic latitude;
  dynamic longitude;
  dynamic phone;
  String? email;
  String? gender;
  dynamic dob;
  dynamic memberSince;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  dynamic updatedAt;
  dynamic image;
  dynamic profilePic;
  dynamic photo;

  Dde(
      {this.id,
        this.name,
        this.userId,
        this.mccId,
        this.latitude,
        this.longitude,
        this.phone,
        this.email,
        this.gender,
        this.dob,
        this.memberSince,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.image,
        this.profilePic,
        this.photo});

  Dde.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['user_id'];
    mccId = json['mcc_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    phone = json['phone'];
    email = json['email'];
    gender = json['gender'];
    dob = json['dob'];
    memberSince = json['member_since'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    profilePic = json['profile_pic'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['user_id'] = userId;
    data['mcc_id'] = mccId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['phone'] = phone;
    data['email'] = email;
    data['gender'] = gender;
    data['dob'] = dob;
    data['member_since'] = memberSince;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['image'] = image;
    return data;
  }
}

class RagratingTypeStatus {
  dynamic critical;
  dynamic average;
  dynamic satisfactory;
  dynamic mature;

  RagratingTypeStatus(
      {this.critical, this.average, this.satisfactory, this.mature});

  RagratingTypeStatus.fromJson(Map<String, dynamic> json) {
    critical = json['critical'];
    average = json['average'];
    satisfactory = json['satisfactory'];
    mature = json['mature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['critical'] = critical;
    data['average'] = average;
    data['satisfactory'] = satisfactory;
    data['mature'] = mature;
    return data;
  }
}
