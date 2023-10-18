class ResponseResourceName {
  String? message;
  int? status;
  List<DataResourceName>? data;

  ResponseResourceName({this.message, this.status, this.data});

  ResponseResourceName.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataResourceName>[];
      json['data'].forEach((v) {
        data!.add(DataResourceName.fromJson(v));
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

class DataResourceName {
  int? id;
  String? resourceName;

  DataResourceName({this.id, this.resourceName});

  DataResourceName.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resourceName = json['resource_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['resource_name'] = resourceName;
    return data;
  }
}
