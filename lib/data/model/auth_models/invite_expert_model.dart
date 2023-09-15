class InviteExpert {
  String? message;
  int? status;
  Data? data;

  InviteExpert({this.message, this.status, this.data});

  InviteExpert.fromJson(Map<String, dynamic> json) {
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
  String? farmerId;
  String? name;
  String? mobile;
  String? address;
  String? comment;
  String? supplierId;
  int? userId;
  int? createdBy;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.farmerId,
        this.name,
        this.mobile,
        this.address,
        this.comment,
        this.supplierId,
        this.userId,
        this.createdBy,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    farmerId = json['farmer_id'];
    name = json['name'];
    mobile = json['mobile'];
    address = json['address'];
    comment = json['comment'];
    supplierId = json['supplier_id'];
    userId = json['user_id'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['farmer_id'] = farmerId;
    data['name'] = name;
    data['mobile'] = mobile;
    data['address'] = address;
    data['comment'] = comment;
    data['supplier_id'] = supplierId;
    data['user_id'] = userId;
    data['created_by'] = createdBy;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}