class InviteExpert {
  String? message;
  int? status;
  Data? data;

  InviteExpert({this.message, this.status, this.data});

  InviteExpert.fromJson(Map<String, dynamic> json) {
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
  int? id;
  Null? farmerId;
  int? ddeId;
  String? deviceId;
  Null? supplierCode;
  Null? userId;
  String? name;
  String? mobile;
  String? address;
  double? lat;
  double? lang;
  String? comment;
  String? status;
  Null? createdBy;
  Null? updatedBy;
  Null? deletedBy;
  String? createdAt;
  String? updatedAt;
  Null? closedAt;
  DairyDevelopmentExecutive? dairyDevelopmentExecutive;

  Data(
      {this.id,
        this.farmerId,
        this.ddeId,
        this.deviceId,
        this.supplierCode,
        this.userId,
        this.name,
        this.mobile,
        this.address,
        this.lat,
        this.lang,
        this.comment,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.closedAt,
        this.dairyDevelopmentExecutive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    ddeId = json['dde_id'];
    deviceId = json['device_id'];
    supplierCode = json['supplier_code'];
    userId = json['user_id'];
    name = json['name'];
    mobile = json['mobile'];
    address = json['address'];
    lat = json['lat'];
    lang = json['lang'];
    comment = json['comment'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    closedAt = json['closed_at'];
    dairyDevelopmentExecutive = json['dairy_development_executive'] != null
        ? new DairyDevelopmentExecutive.fromJson(
        json['dairy_development_executive'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['farmer_id'] = this.farmerId;
    data['dde_id'] = this.ddeId;
    data['device_id'] = this.deviceId;
    data['supplier_code'] = this.supplierCode;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lang'] = this.lang;
    data['comment'] = this.comment;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_by'] = this.deletedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['closed_at'] = this.closedAt;
    if (this.dairyDevelopmentExecutive != null) {
      data['dairy_development_executive'] =
          this.dairyDevelopmentExecutive!.toJson();
    }
    return data;
  }
}

class DairyDevelopmentExecutive {
  int? id;
  String? name;
  int? userId;
  int? mccId;
  Null? latitude;
  Null? longitude;
  Null? phone;
  String? email;
  String? gender;
  Null? dob;
  Null? memberSince;
  String? status;
  Null? createdBy;
  Null? updatedBy;
  Null? deletedBy;
  Null? createdAt;
  Null? updatedAt;
  Null? image;

  DairyDevelopmentExecutive(
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
        this.image});

  DairyDevelopmentExecutive.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['mcc_id'] = this.mccId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['member_since'] = this.memberSince;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_by'] = this.deletedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    return data;
  }
}