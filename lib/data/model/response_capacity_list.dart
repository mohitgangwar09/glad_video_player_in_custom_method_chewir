class ResponseCapacityList {
  String? message;
  int? status;
  List<DataCapacityList>? data;

  ResponseCapacityList({this.message, this.status, this.data});

  ResponseCapacityList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataCapacityList>[];
      json['data'].forEach((v) {
        data!.add(DataCapacityList.fromJson(v));
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

class DataCapacityList {
  int? id;
  String? resourceCapacity;

  DataCapacityList({this.id, this.resourceCapacity});

  DataCapacityList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    resourceCapacity = json['resource_capacity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['resource_capacity'] = resourceCapacity;
    return data;
  }
}
