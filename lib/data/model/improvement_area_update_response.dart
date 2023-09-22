class ImprovementAreaUpdateResponse {
  String? message;
  int? status;
  Data? data;

  ImprovementAreaUpdateResponse({this.message, this.status, this.data});

  ImprovementAreaUpdateResponse.fromJson(Map<String, dynamic> json) {
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
  List<ImprovementAreaData>? improvementAreaData;

  Data({this.improvementAreaData});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['improvementAreaData'] != null) {
      improvementAreaData = <ImprovementAreaData>[];
      json['improvementAreaData'].forEach((v) {
        improvementAreaData!.add(new ImprovementAreaData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.improvementAreaData != null) {
      data['improvementAreaData'] =
          this.improvementAreaData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImprovementAreaData {
  String? id;
  String? value;

  ImprovementAreaData({this.id, this.value});

  ImprovementAreaData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    return data;
  }
}
