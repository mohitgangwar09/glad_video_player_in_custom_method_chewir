class ResponseMaterialType {
  String? message;
  int? status;
  List<DataMaterialType>? data;

  ResponseMaterialType({this.message, this.status, this.data});

  ResponseMaterialType.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataMaterialType>[];
      json['data'].forEach((v) {
        data!.add(DataMaterialType.fromJson(v));
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

class DataMaterialType {
  int? id;
  String? name;

  DataMaterialType({this.id, this.name});

  DataMaterialType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['material_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['material_name'] = name;
    return data;
  }
}
