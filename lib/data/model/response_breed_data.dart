class ResponseBreedData {
  String? message;
  int? status;
  List<DataBreedData>? data;

  ResponseBreedData({this.message, this.status, this.data});

  ResponseBreedData.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataBreedData>[];
      json['data'].forEach((v) {
        data!.add(DataBreedData.fromJson(v));
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

class DataBreedData {
  int? id;
  String? name;

  DataBreedData({this.id, this.name});

  DataBreedData.fromJson(Map<String, dynamic> json) {
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
