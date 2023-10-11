class ResponseResourceType {
  String? message;
  int? status;
  List<DataResourceType>? data;

  ResponseResourceType({this.message, this.status, this.data});

  ResponseResourceType.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataResourceType>[];
      json['data'].forEach((v) {
        data!.add(DataResourceType.fromJson(v));
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

class DataResourceType {
  int? id;
  String? name;

  DataResourceType({this.id, this.name});

  DataResourceType.fromJson(Map<String, dynamic> json) {
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
