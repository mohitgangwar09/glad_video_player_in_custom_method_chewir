class ResponseBreed {
  String? message;
  int? status;
  List<DataBreed>? data;

  ResponseBreed({this.message, this.status, this.data});

  ResponseBreed.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataBreed>[];
      json['data'].forEach((v) {
        data!.add(DataBreed.fromJson(v));
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

class DataBreed {
  int? id;
  String? name;

  DataBreed({this.id, this.name});

  DataBreed.fromJson(Map<String, dynamic> json) {
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
