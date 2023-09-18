class GuestDashboardModel {
  String? message;
  int? status;
  Data? data;

  GuestDashboardModel({this.message, this.status, this.data});

  GuestDashboardModel.fromJson(Map<String, dynamic> json) {
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
  DairyDevelopmentExecutive? dairyDevelopmentExecutive;
  Enquiry? enquiry;

  Data({this.dairyDevelopmentExecutive, this.enquiry});

  Data.fromJson(Map<String, dynamic> json) {
    dairyDevelopmentExecutive = json['dairyDevelopmentExecutive'] != null
        ? new DairyDevelopmentExecutive.fromJson(
        json['dairyDevelopmentExecutive'])
        : null;
    enquiry =
    json['enquiry'] != null ? new Enquiry.fromJson(json['enquiry']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dairyDevelopmentExecutive != null) {
      data['dairyDevelopmentExecutive'] =
          this.dairyDevelopmentExecutive!.toJson();
    }
    if (this.enquiry != null) {
      data['enquiry'] = this.enquiry!.toJson();
    }
    return data;
  }
}

class DairyDevelopmentExecutive {
  int? id;
  Null? phone;
  String? name;
  Null? createdAt;
  Null? distance;
  Null? image;

  DairyDevelopmentExecutive(
      {this.id,
        this.phone,
        this.name,
        this.createdAt,
        this.distance,
        this.image});

  DairyDevelopmentExecutive.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    name = json['name'];
    createdAt = json['created_at'];
    distance = json['distance'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['distance'] = this.distance;
    data['image'] = this.image;
    return data;
  }
}

class Enquiry {
  int? id;
  Null? farmerId;
  int? ddeId;
  String? deviceId;
  Null? supplierCode;
  Null? userId;
  String? name;
  String? mobile;
  String? address;
  int? lat;
  int? lang;
  String? comment;
  String? status;
  Null? createdBy;
  Null? updatedBy;
  Null? deletedBy;
  String? createdAt;
  String? updatedAt;
  Null? closedAt;

  Enquiry(
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
        this.closedAt});

  Enquiry.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
