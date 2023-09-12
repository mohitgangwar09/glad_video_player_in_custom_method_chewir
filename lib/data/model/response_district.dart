class ResponseDistrict {
  String? message;
  int? status;
  List<DistrictData>? data;

  ResponseDistrict({this.message, this.status, this.data});

  ResponseDistrict.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DistrictData>[];
      json['data'].forEach((v) {
        data!.add(DistrictData.fromJson(v));
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

class DistrictData {
  int? id;
  String? name;

  DistrictData({this.id, this.name});

  DistrictData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
