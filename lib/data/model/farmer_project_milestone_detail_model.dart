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
  dynamic projectId;
  dynamic milestoneCode;
  String? milestoneTitle;
  String? milestoneDescription;
  dynamic milestoneDuration;
  dynamic resourceType;
  dynamic resourceCapcity;
  dynamic resourcePrice;
  dynamic resourceQty;
  dynamic resourceUom;
  dynamic milestoneValue;
  dynamic milestoneDueDate;
  String? milestoneStatus;
  dynamic completionDate;
  dynamic approvalDate;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic createdAt;
  dynamic updatedAt;
  List<FarmerProjectResources>? farmerProjectResourcePrice;
  List<FarmerProjectTask>? farmerProjectTask;

  MilestoneDetails(
      {this.id,
        this.farmerId,
        this.farmerProjectId,
        this.projectId,
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
        this.milestoneDueDate});

  MilestoneDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    farmerProjectId = json['farmer_project_id'];
    projectId = json['project_id'];
    milestoneCode = json['milestone_code'];
    milestoneTitle = json['milestone_title'];
    milestoneDescription = json['milestone_description'];
    milestoneDuration = json['milestone_duration'];
    resourceType = json['resource_type'];
    resourceCapcity = json['resource_capcity'];
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
    milestoneDueDate = json['milestone_due_date'];
    if (json['farmer_project_resources'] != null) {
      farmerProjectResourcePrice = <FarmerProjectResources>[];
      json['farmer_project_resources'].forEach((v) {
        farmerProjectResourcePrice!.add(FarmerProjectResources.fromJson(v));
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
    data['project_id'] = projectId;
    data['milestone_code'] = milestoneCode;
    data['milestone_title'] = milestoneTitle;
    data['milestone_description'] = milestoneDescription;
    data['milestone_duration'] = milestoneDuration;
    data['resource_type'] = resourceType;
    data['resource_capcity'] = resourceCapcity;
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
  dynamic milestoneId;
  String? resourceName;
  String? resourceType;
  dynamic resourceCapacity;
  dynamic resourceUom;
  dynamic resourcePrice;
  dynamic resourceSize;
  dynamic resourceValue;
  String? status;
  dynamic notRequired;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic createdAt;
  String? updatedAt;

  FarmerProjectResources(
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

  FarmerProjectResources.fromJson(Map<String, dynamic> json) {
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

class FarmerProjectTask {
  dynamic id;
  dynamic farmerId;
  dynamic farmerProjectId;
  dynamic farmerMilestoneId;
  String? taskName;
  dynamic taskPicture;
  String? taskStatus;
  String? remarks;
  dynamic taskCompletionDate;
  dynamic taskApproveRejectDate;
  dynamic approveRejectRemarks;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  String? pictures;
  List<Media>? media;

  FarmerProjectTask(
      {this.id,
        this.farmerId,
        this.farmerProjectId,
        this.farmerMilestoneId,
        this.taskName,
        this.taskPicture,
        this.taskStatus,
        this.remarks,
        this.taskCompletionDate,
        this.taskApproveRejectDate,
        this.approveRejectRemarks,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.pictures,
        this.media});

  FarmerProjectTask.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    farmerProjectId = json['farmer_project_id'];
    farmerMilestoneId = json['farmer_milestone_id'];
    taskName = json['task_name'];
    taskPicture = json['task_picture'];
    taskStatus = json['task_status'];
    remarks = json['remarks'];
    taskCompletionDate = json['task_completion_date'];
    taskApproveRejectDate = json['task_approve_reject_date'];
    approveRejectRemarks = json['approve_reject_remarks'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pictures = json['pictures'];
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(Media.fromJson(v));
      });
    }
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
    data['remarks'] = remarks;
    data['task_completion_date'] = taskCompletionDate;
    data['task_approve_reject_date'] = taskApproveRejectDate;
    data['approve_reject_remarks'] = approveRejectRemarks;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['pictures'] = pictures;
    if (media != null) {
      data['media'] = media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Media {
  dynamic id;
  String? modelType;
  dynamic modelId;
  String? uuid;
  String? collectionName;
  String? name;
  String? fileName;
  String? mimeType;
  String? disk;
  String? conversionsDisk;
  dynamic size;
  List<dynamic>? manipulations;
  List<dynamic>? customProperties;
  List<dynamic>? generatedConversions;
  List<dynamic>? responsiveImages;
  dynamic orderColumn;
  String? createdAt;
  String? updatedAt;
  String? originalUrl;
  String? previewUrl;

  Media(
      {this.id,
        this.modelType,
        this.modelId,
        this.uuid,
        this.collectionName,
        this.name,
        this.fileName,
        this.mimeType,
        this.disk,
        this.conversionsDisk,
        this.size,
        this.manipulations,
        this.customProperties,
        this.generatedConversions,
        this.responsiveImages,
        this.orderColumn,
        this.createdAt,
        this.updatedAt,
        this.originalUrl,
        this.previewUrl});

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelType = json['model_type'];
    modelId = json['model_id'];
    uuid = json['uuid'];
    collectionName = json['collection_name'];
    name = json['name'];
    fileName = json['file_name'];
    mimeType = json['mime_type'];
    disk = json['disk'];
    conversionsDisk = json['conversions_disk'];
    size = json['size'];
    orderColumn = json['order_column'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    originalUrl = json['original_url'];
    previewUrl = json['preview_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['model_type'] = modelType;
    data['model_id'] = modelId;
    data['uuid'] = uuid;
    data['collection_name'] = collectionName;
    data['name'] = name;
    data['file_name'] = fileName;
    data['mime_type'] = mimeType;
    data['disk'] = disk;
    data['conversions_disk'] = conversionsDisk;
    data['size'] = size;
    data['order_column'] = orderColumn;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['original_url'] = originalUrl;
    data['preview_url'] = previewUrl;
    return data;
  }
}
