class FarmerProjectMilestoneDetailModel {
  String? message;
  int? status;
  Data? data;

  FarmerProjectMilestoneDetailModel({this.message, this.status, this.data});

  FarmerProjectMilestoneDetailModel.fromJson(Map<String, dynamic> json) {
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
  List<MilestoneDetails>? milestoneDetails;

  Data({this.milestoneDetails});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['milestone_details'] != null) {
      milestoneDetails = <MilestoneDetails>[];
      json['milestone_details'].forEach((v) {
        milestoneDetails!.add(MilestoneDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (milestoneDetails != null) {
      data['milestone_details'] =
          milestoneDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MilestoneDetails {
  dynamic id;
  dynamic farmerId;
  dynamic farmerProjectId;
  String? milestoneCode;
  String? milestoneTitle;
  String? milestoneDescription;
  dynamic milestoneDuration;
  dynamic resourceType;
  dynamic resourceTypeName;
  dynamic resourceCapcity;
  dynamic resourceCapacityName;
  dynamic resourceUomName;
  dynamic resourcePrice;
  dynamic resourceQty;
  dynamic resourceUom;
  dynamic milestoneValue;
  String? milestoneStatus;
  dynamic completionDate;
  dynamic approvalDate;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  List<FarmerProjectResources>? farmerProjectResourcePrice;
  List<FarmerProjectTask>? farmerProjectTask;

  MilestoneDetails(
      {this.id,
        this.farmerId,
        this.farmerProjectId,
        this.milestoneCode,
        this.milestoneTitle,
        this.milestoneDescription,
        this.milestoneDuration,
        this.resourceType,
        this.resourceCapcity,
        this.resourcePrice,
        this.resourceQty,
        this.resourceUom,
        this.milestoneValue,
        this.milestoneStatus,
        this.completionDate,
        this.approvalDate,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.farmerProjectResourcePrice,
        this.farmerProjectTask,
        this.resourceCapacityName,
        this.resourceTypeName,
        this.resourceUomName,
      });

  MilestoneDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    farmerProjectId = json['farmer_project_id'];
    milestoneCode = json['milestone_code'];
    milestoneTitle = json['milestone_title'];
    milestoneDescription = json['milestone_description'];
    milestoneDuration = json['milestone_duration'];
    resourceType = json['resource_type'];
    resourceTypeName = json['resource_type_name'];
    resourceCapcity = json['resource_capcity'];
    resourceCapacityName = json['resource_type_capcity'];
    resourceUomName = json['resource_uom_name'];
    resourcePrice = json['resource_price'];
    resourceQty = json['resource_qty'];
    resourceUom = json['resource_uom'];
    milestoneValue = json['milestone_value'];
    milestoneStatus = json['milestone_status'];
    completionDate = json['completion_date'];
    approvalDate = json['approval_date'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['farmer_project_resources'] != null) {
      farmerProjectResourcePrice = <FarmerProjectResources>[];
      json['farmer_project_resources'].forEach((v) {
        farmerProjectResourcePrice!
            .add(FarmerProjectResources.fromJson(v));
      });
    }
    if (json['farmer_project_task'] != null) {
      farmerProjectTask = <FarmerProjectTask>[];
      json['farmer_project_task'].forEach((v) {
        farmerProjectTask!.add(FarmerProjectTask.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['farmer_id'] = farmerId;
    data['farmer_project_id'] = farmerProjectId;
    data['milestone_code'] = milestoneCode;
    data['milestone_title'] = milestoneTitle;
    data['milestone_description'] = milestoneDescription;
    data['milestone_duration'] = milestoneDuration;
    data['resource_type'] = resourceType;
    data['resource_capcity'] = resourceCapcity;
    data['resource_type_name'] = resourceTypeName;
    data['resource_type_capcity'] = resourceCapacityName;
    data['resource_uom_name'] = resourceUomName;
    data['resource_price'] = resourcePrice;
    data['resource_qty'] = resourceQty;
    data['resource_uom'] = resourceUom;
    data['milestone_value'] = milestoneValue;
    data['milestone_status'] = milestoneStatus;
    data['completion_date'] = completionDate;
    data['approval_date'] = approvalDate;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (farmerProjectResourcePrice != null) {
      data['farmer_project_resources'] =
          farmerProjectResourcePrice!.map((v) => v.toJson()).toList();
    }
    if (farmerProjectTask != null) {
      data['farmer_project_task'] =
          farmerProjectTask!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FarmerProjectResources {
  dynamic id;
  dynamic farmerId;
  dynamic farmerProjectId;
  dynamic farmerMilestoneId;
  dynamic resourceName;
  dynamic resourceType;
  dynamic resourceCapacity;
  dynamic resourceUom;
  dynamic resourcePrice;
  dynamic resourceSize;
  dynamic resourceValue;
  dynamic status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic createdAt;
  dynamic updatedAt;

  FarmerProjectResources(
      {this.id,
        this.farmerId,
        this.farmerProjectId,
        this.farmerMilestoneId,
        this.resourceName,
        this.resourceType,
        this.resourceCapacity,
        this.resourceUom,
        this.resourcePrice,
        this.resourceSize,
        this.resourceValue,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt});

  FarmerProjectResources.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    farmerProjectId = json['farmer_project_id'];
    farmerMilestoneId = json['farmer_milestone_id'];
    resourceName = json['resource_name'];
    resourceType = json['resource_type'];
    resourceCapacity = json['resource_capacity'];
    resourceUom = json['resource_uom'];
    resourcePrice = json['resource_price'];
    resourceSize = json['resource_size'];
    resourceValue = json['resource_value'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['farmer_id'] = this.farmerId;
    data['farmer_project_id'] = this.farmerProjectId;
    data['farmer_milestone_id'] = this.farmerMilestoneId;
    data['resource_name'] = this.resourceName;
    data['resource_type'] = this.resourceType;
    data['resource_capacity'] = this.resourceCapacity;
    data['resource_uom'] = this.resourceUom;
    data['resource_price'] = this.resourcePrice;
    data['resource_size'] = this.resourceSize;
    data['resource_value'] = this.resourceValue;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_by'] = this.deletedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class FarmerProjectTask {
  dynamic id;
  dynamic farmerId;
  dynamic farmerProjectId;
  dynamic farmerMilestoneId;
  String? taskName;
  dynamic taskPicture;
  String? taskStatus;
  dynamic taskCompletionDate;
  dynamic taskApprovalDate;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;

  FarmerProjectTask(
      {this.id,
        this.farmerId,
        this.farmerProjectId,
        this.farmerMilestoneId,
        this.taskName,
        this.taskPicture,
        this.taskStatus,
        this.taskCompletionDate,
        this.taskApprovalDate,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt});

  FarmerProjectTask.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    farmerProjectId = json['farmer_project_id'];
    farmerMilestoneId = json['farmer_milestone_id'];
    taskName = json['task_name'];
    taskPicture = json['task_picture'];
    taskStatus = json['task_status'];
    taskCompletionDate = json['task_completion_date'];
    taskApprovalDate = json['task_approval_date'];
    status = json['status'];
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
    data['task_name'] = taskName;
    data['task_picture'] = taskPicture;
    data['task_status'] = taskStatus;
    data['task_completion_date'] = taskCompletionDate;
    data['task_approval_date'] = taskApprovalDate;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
