class ResponsePriceAttribute {
  String? message;
  int? status;
  DataPrice? data;

  ResponsePriceAttribute({this.message, this.status, this.data});

  ResponsePriceAttribute.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? DataPrice.fromJson(json['data']) : null;
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

class DataPrice {
  dynamic id;
  dynamic farmerId;
  dynamic projectMilestoneId;
  dynamic resourceTypeId;
  dynamic projectUomId;
  dynamic resourceCapacityId;
  dynamic resourcePrice;
  dynamic uomName;
  dynamic isDefault;
  dynamic status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic createdAt;
  dynamic updatedAt;

  DataPrice(
      {this.id,
        this.farmerId,
        this.projectMilestoneId,
        this.resourceTypeId,
        this.projectUomId,
        this.resourceCapacityId,
        this.resourcePrice,
        this.isDefault,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.uomName,
        this.updatedAt});

  DataPrice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    projectMilestoneId = json['project_milestone_id'];
    resourceTypeId = json['resource_type_id'];
    projectUomId = json['project_uom_id'];
    resourceCapacityId = json['resource_capacity_id'];
    resourcePrice = json['resource_price'];
    isDefault = json['is_default'];
    status = json['status'];
    uomName = json['uom_name'];
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
    data['project_milestone_id'] = projectMilestoneId;
    data['resource_type_id'] = resourceTypeId;
    data['project_uom_id'] = projectUomId;
    data['resource_capacity_id'] = resourceCapacityId;
    data['resource_price'] = resourcePrice;
    data['is_default'] = isDefault;
    data['status'] = status;
    data['uom_name'] = uomName;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
