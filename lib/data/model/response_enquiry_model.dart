class ResponseEnquiryModel {
  String? message;
  int? status;
  List<DataEnquiryModel>? data;

  ResponseEnquiryModel({this.message, this.status, this.data});

  ResponseEnquiryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataEnquiryModel>[];
      json['data'].forEach((v) {
        data!.add(DataEnquiryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataEnquiryModel {
  int? id;
  dynamic farmerId;
  int? ddeId;
  String? deviceId;
  dynamic supplierCode;
  dynamic userId;
  String? name;
  String? mobile;
  String? address;
  dynamic lat;
  dynamic lang;
  String? comment;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  dynamic closedAt;

  DataEnquiryModel(
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

  DataEnquiryModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['farmer_id'] = farmerId;
    data['dde_id'] = ddeId;
    data['device_id'] = deviceId;
    data['supplier_code'] = supplierCode;
    data['user_id'] = userId;
    data['name'] = name;
    data['mobile'] = mobile;
    data['address'] = address;
    data['lat'] = lat;
    data['lang'] = lang;
    data['comment'] = comment;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['closed_at'] = closedAt;
    return data;
  }
}
