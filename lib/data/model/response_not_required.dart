class ResponseNotRequiredData {
  String? message;
  int? status;
  Data? data;

  ResponseNotRequiredData({this.message, this.status, this.data});

  ResponseNotRequiredData.fromJson(Map<String, dynamic> json) {
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
  dynamic id;
  dynamic farmerId;
  dynamic farmerProjectId;
  dynamic farmerMilestoneId;
  dynamic milestoneId;
  String? resourceName;
  String? resourceType;
  String? resourceCapacity;
  String? resourceUom;
  dynamic resourcePrice;
  dynamic resourceSize;
  double? resourceValue;
  String? status;
  dynamic notRequired;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.farmerId,
        this.farmerProjectId,
        this.farmerMilestoneId,
        this.milestoneId,
        this.resourceName,
        this.resourceType,
        this.resourceCapacity,
        this.resourceUom,
        this.resourcePrice,
        this.resourceSize,
        this.resourceValue,
        this.status,
        this.notRequired,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    farmerProjectId = json['farmer_project_id'];
    farmerMilestoneId = json['farmer_milestone_id'];
    milestoneId = json['milestone_id'];
    resourceName = json['resource_name'];
    resourceType = json['resource_type'];
    resourceCapacity = json['resource_capacity'];
    resourceUom = json['resource_uom'];
    resourcePrice = json['resource_price'];
    resourceSize = json['resource_size'];
    resourceValue = json['resource_value'];
    status = json['status'];
    notRequired = json['not_required'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['farmer_id'] = farmerId;
    data['farmer_project_id'] = farmerProjectId;
    data['farmer_milestone_id'] = farmerMilestoneId;
    data['milestone_id'] = milestoneId;
    data['resource_name'] = resourceName;
    data['resource_type'] = resourceType;
    data['resource_capacity'] = resourceCapacity;
    data['resource_uom'] = resourceUom;
    data['resource_price'] = resourcePrice;
    data['resource_size'] = resourceSize;
    data['resource_value'] = resourceValue;
    data['status'] = status;
    data['not_required'] = notRequired;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
