class ResponseAddValue {
  String? message;
  int? status;
  Data? data;

  ResponseAddValue({this.message, this.status, this.data});

  ResponseAddValue.fromJson(Map<String, dynamic> json) {
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
  dynamic farmerId;
  dynamic milestoneTitle;
  dynamic milestoneDescription;
  dynamic milestoneDuration;
  dynamic farmerProjectId;
  dynamic milestoneValue;
  dynamic createdBy;
  dynamic updatedAt;
  dynamic createdAt;
  dynamic id;

  Data(
      {this.farmerId,
        this.milestoneTitle,
        this.milestoneDescription,
        this.milestoneDuration,
        this.farmerProjectId,
        this.milestoneValue,
        this.createdBy,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    farmerId = json['farmer_id'];
    milestoneTitle = json['milestone_title'];
    milestoneDescription = json['milestone_description'];
    milestoneDuration = json['milestone_duration'];
    farmerProjectId = json['farmer_project_id'];
    milestoneValue = json['milestone_value'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['farmer_id'] = farmerId;
    data['milestone_title'] = milestoneTitle;
    data['milestone_description'] = milestoneDescription;
    data['milestone_duration'] = milestoneDuration;
    data['farmer_project_id'] = farmerProjectId;
    data['milestone_value'] = milestoneValue;
    data['created_by'] = createdBy;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
