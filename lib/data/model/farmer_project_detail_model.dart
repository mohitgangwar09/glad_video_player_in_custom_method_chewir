class FarmerProjectDetailModel {
  String? message;
  dynamic status;
  Data? data;

  FarmerProjectDetailModel({this.message, this.status, this.data});

  FarmerProjectDetailModel.fromJson(Map<String, dynamic> json) {
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
  List<FarmerProject>? farmerProject;
  SupplierDetail? supplierDetail;
  Seller? seller;
  List<ProjectRating>? supplierRatingForDde;
  List<ProjectRating>? supplierRatingForFarmer;
  List<ProjectRating>? farmerRatingForDde;
  List<ProjectRating>? farmerRatingForSupplier;
  List<ProjectRating>? ddeRatingForSupplier;
  List<ProjectRating>? ddeRatingForFarmer;


  Data({this.farmerProject,this.supplierDetail,
  this.supplierRatingForDde,this.supplierRatingForFarmer,this.farmerRatingForDde,this.farmerRatingForSupplier,
  this.ddeRatingForSupplier,this.ddeRatingForFarmer});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['farmer-project'] != null) {
      farmerProject = <FarmerProject>[];
      json['farmer-project'].forEach((v) {
        farmerProject!.add(FarmerProject.fromJson(v));
      });
    }

    if (json['supplierRatingForDde'] != null) {
      supplierRatingForDde = <ProjectRating>[];
      json['supplierRatingForDde'].forEach((v) {
        supplierRatingForDde!.add(ProjectRating.fromJson(v));
      });
    }

    if (json['supplierRatingForFarmer'] != null) {
      supplierRatingForFarmer = <ProjectRating>[];
      json['supplierRatingForFarmer'].forEach((v) {
        supplierRatingForFarmer!.add(ProjectRating.fromJson(v));
      });
    }

    if (json['farmerRatingForDde'] != null) {
      farmerRatingForDde = <ProjectRating>[];
      json['farmerRatingForDde'].forEach((v) {
        farmerRatingForDde!.add(ProjectRating.fromJson(v));
      });
    }

    if (json['farmerRatingForSupplier'] != null) {
      farmerRatingForSupplier = <ProjectRating>[];
      json['farmerRatingForSupplier'].forEach((v) {
        farmerRatingForSupplier!.add(ProjectRating.fromJson(v));
      });
    }

    if (json['ddeRatingForSupplier'] != null) {
      ddeRatingForSupplier = <ProjectRating>[];
      json['ddeRatingForSupplier'].forEach((v) {
        ddeRatingForSupplier!.add(ProjectRating.fromJson(v));
      });
    }

    if (json['ddeRatingForFarmer'] != null) {
      ddeRatingForFarmer = <ProjectRating>[];
      json['ddeRatingForFarmer'].forEach((v) {
        ddeRatingForFarmer!.add(ProjectRating.fromJson(v));
      });
    }

    supplierDetail = json['supplier'] != null ? SupplierDetail.fromJson(json['supplier']) : null;
    seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (farmerProject != null) {
      data['farmer-project'] =
          farmerProject!.map((v) => v.toJson()).toList();
    }
    if (supplierRatingForDde != null) {
      data['supplierRatingForDde'] =
          supplierRatingForDde!.map((v) => v.toJson()).toList();
    }
    if (supplierRatingForFarmer != null) {
      data['supplierRatingForFarmer'] =
          supplierRatingForFarmer!.map((v) => v.toJson()).toList();
    }
    if (farmerRatingForDde != null) {
      data['farmerRatingForDde'] =
          farmerRatingForDde!.map((v) => v.toJson()).toList();
    }
    if (farmerRatingForSupplier != null) {
      data['farmerRatingForSupplier'] =
          farmerRatingForSupplier!.map((v) => v.toJson()).toList();
    }
    if (ddeRatingForSupplier != null) {
      data['ddeRatingForSupplier'] =
          ddeRatingForSupplier!.map((v) => v.toJson()).toList();
    }
    if (ddeRatingForFarmer != null) {
      data['ddeRatingForFarmer'] =
          ddeRatingForFarmer!.map((v) => v.toJson()).toList();
    }
    if (supplierDetail != null) {
      data['supplier'] = supplierDetail!.toJson();
    }
    if (seller != null) {
      data['seller'] = seller!.toJson();
    }
    return data;
  }
}

class FarmerProject {
  dynamic id;
  dynamic ddeId;
  dynamic farmerId;
  dynamic projectId;
  dynamic liveStockCartId;
  String? name;
  dynamic category;
  String? description;
  String? projectStatus;
  dynamic rejectStatus;
  dynamic rejectRemark;
  String? projectSubStatus;
  dynamic suggestionRank;
  dynamic initialYield;
  dynamic targetYield;
  dynamic investmentAmount;
  dynamic creditRatio;
  dynamic revenuePerYear;
  dynamic roiPerYear;
  dynamic farmerParticipation;
  dynamic gladCommisionPercentage;
  dynamic gladCommisionAmount;
  dynamic ddeCommisionPercentage;
  dynamic ddeCommisionAmount;
  dynamic loanAmount;
  dynamic repaymentMonths;
  dynamic emiAmount;
  dynamic incrementalProduction;
  String? repaymentStartDate;
  dynamic paymentStatus;
  dynamic photo;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic farmerParticipationStatus;
  String? createdAt;
  String? updatedAt;
  List<FarmerProjectMilestones>? farmerProjectMilestones;
  List<FarmerProjectPaymentTerms>? farmerProjectPaymentTerms;
  DairyDevelopMentExecutive? dairyDevelopMentExecutive;
  Kpi? kpi;
  DataLivestock? dataLivestock;
  ImprovementArea? improvementArea;
  FarmerMaster? farmerMaster;
  List<FarmerProjectLog>? farmerProjectLog;
  FarmerProjectKycDocument? farmerProjectKycDocument;
  List<FarmerLoanDocument>? farmerLoanDocument;
  List<FarmerProjectSurvey>? farmerProjectSurvey;


  FarmerProject(
      {this.id,
        this.ddeId,
        this.farmerId,
        this.projectId,
        this.name,
        this.category,
        this.description,
        this.projectStatus,
        this.projectSubStatus,
        this.suggestionRank,
        this.initialYield,
        this.targetYield,
        this.investmentAmount,
        this.creditRatio,
        this.revenuePerYear,
        this.roiPerYear,
        this.farmerParticipation,
        this.gladCommisionPercentage,
        this.gladCommisionAmount,
        this.ddeCommisionPercentage,
        this.ddeCommisionAmount,
        this.loanAmount,
        this.repaymentMonths,
        this.emiAmount,
        this.incrementalProduction,
        this.repaymentStartDate,
        this.photo,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.farmerProjectMilestones,
        this.dairyDevelopMentExecutive,
        this.kpi,
        this.rejectStatus,
        this.rejectRemark,
        this.farmerMaster,
        this.farmerProjectPaymentTerms,
        this.farmerProjectLog,
        this.farmerProjectKycDocument,
        this.farmerLoanDocument,
        this.farmerProjectSurvey,
        this.improvementArea,
        this.farmerParticipationStatus,
        this.dataLivestock,
        this.liveStockCartId,
        this.paymentStatus,
      });

  FarmerProject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ddeId = json['dde_id'];
    farmerId = json['farmer_id'];
    projectId = json['project_id'];
    name = json['name'];
    rejectStatus = json['reject_status'];
    rejectRemark = json['reject_remarks'];
    category = json['category'];
    paymentStatus = json['payment_status'];
    description = json['description'];
    projectStatus = json['project_status'];
    projectSubStatus = json['project_sub_status'];
    suggestionRank = json['suggestion_rank'];
    initialYield = json['initial_yield'];
    targetYield = json['target_yield'];
    investmentAmount = json['investment_amount'];
    creditRatio = json['credit_ratio'];
    revenuePerYear = json['revenue_per_year'];
    roiPerYear = json['roi_per_year'];
    farmerParticipation = json['farmer_participation'];
    gladCommisionPercentage = json['glad_commision_percentage'];
    gladCommisionAmount = json['glad_commision_amount'];
    ddeCommisionPercentage = json['dde_commision_percentage'];
    ddeCommisionAmount = json['dde_commision_amount'];
    loanAmount = json['loan_amount'];
    repaymentMonths = json['repayment_months'];
    emiAmount = json['emi_amount'];
    incrementalProduction = json['incremental_production'];
    repaymentStartDate = json['repayment_start_date'];
    photo = json['photo'];
    status = json['status'];
    liveStockCartId = json['live_stock_cart_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    farmerParticipationStatus = json['farmer_participation_status'];
    kpi = json['kpi'] != null ? Kpi.fromJson(json['kpi']) : null;
    improvementArea = json['improvement_area'] != null ? ImprovementArea.fromJson(json['improvement_area']) : null;
    farmerMaster = json['farmer_master'] != null ? FarmerMaster.fromJson(json['farmer_master']) : null;
    dataLivestock = json['live_stock_cart'] != null ? DataLivestock.fromJson(json['live_stock_cart']) : null;
    if (json['farmer_project_milestones'] != null) {
      farmerProjectMilestones = <FarmerProjectMilestones>[];
      json['farmer_project_milestones'].forEach((v) {
        farmerProjectMilestones!.add(FarmerProjectMilestones.fromJson(v));
      });
    }
    if (json['farmer_project_payment_terms'] != null) {
      farmerProjectPaymentTerms = <FarmerProjectPaymentTerms>[];
      json['farmer_project_payment_terms'].forEach((v) {
        farmerProjectPaymentTerms!
            .add(FarmerProjectPaymentTerms.fromJson(v));
      });
    }
    if (json['farmer_loan_document'] != null) {
      farmerLoanDocument = <FarmerLoanDocument>[];
      json['farmer_loan_document'].forEach((v) {
        farmerLoanDocument!
            .add(FarmerLoanDocument.fromJson(v));
      });
    }
    if (json['farmer_project_survey'] != null) {
      farmerProjectSurvey = <FarmerProjectSurvey>[];
      json['farmer_project_survey'].forEach((v) {
        farmerProjectSurvey!
            .add(FarmerProjectSurvey.fromJson(v));
      });
    }
    dairyDevelopMentExecutive = json['dairy_develop_ment_executive'] != null
        ? DairyDevelopMentExecutive.fromJson(
        json['dairy_develop_ment_executive'])
        : null;
    if (json['farmer_project_log'] != null) {
      farmerProjectLog = <FarmerProjectLog>[];
      json['farmer_project_log'].forEach((v) {
        farmerProjectLog!.add(FarmerProjectLog.fromJson(v));
      });
    }
    farmerProjectKycDocument = json['farmer_project_kyc_document'] != null
        ? FarmerProjectKycDocument.fromJson(
        json['farmer_project_kyc_document'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['dde_id'] = ddeId;
    data['farmer_id'] = farmerId;
    data['project_id'] = projectId;
    data['live_stock_cart_id'] = liveStockCartId;
    data['name'] = name;
    data['reject_status'] = rejectStatus;
    data['reject_remarks'] = rejectRemark;
    data['category'] = category;
    data['payment_status'] = paymentStatus;
    data['description'] = description;
    data['project_status'] = projectStatus;
    data['project_sub_status'] = projectSubStatus;
    data['suggestion_rank'] = suggestionRank;
    data['initial_yield'] = initialYield;
    data['target_yield'] = targetYield;
    data['investment_amount'] = investmentAmount;
    data['credit_ratio'] = creditRatio;
    data['revenue_per_year'] = revenuePerYear;
    data['roi_per_year'] = roiPerYear;
    data['farmer_participation'] = farmerParticipation;
    data['farmer_participation_status'] = farmerParticipationStatus;
    data['glad_commision_percentage'] = gladCommisionPercentage;
    data['glad_commision_amount'] = gladCommisionAmount;
    data['dde_commision_percentage'] = ddeCommisionPercentage;
    data['dde_commision_amount'] = ddeCommisionAmount;
    data['loan_amount'] = loanAmount;
    data['repayment_months'] = repaymentMonths;
    data['emi_amount'] = emiAmount;
    data['incremental_production'] = incrementalProduction;
    data['repayment_start_date'] = repaymentStartDate;
    data['photo'] = photo;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (farmerProjectMilestones != null) {
      data['farmer_project_milestones'] =
          farmerProjectMilestones!.map((v) => v.toJson()).toList();
    }
    if (dairyDevelopMentExecutive != null) {
      data['dairy_develop_ment_executive'] =
          dairyDevelopMentExecutive!.toJson();
    }
    if (kpi != null) {
      data['kpi'] = kpi!.toJson();
    }
    if (farmerProjectPaymentTerms != null) {
      data['farmer_project_payment_terms'] =
          farmerProjectPaymentTerms!.map((v) => v.toJson()).toList();
    }
    if (farmerLoanDocument != null) {
      data['farmer_loan_document'] =
          farmerLoanDocument!.map((v) => v.toJson()).toList();
    }
    if (farmerProjectSurvey != null) {
      data['farmer_project_survey'] =
          farmerProjectSurvey!.map((v) => v.toJson()).toList();
    }
    if (farmerMaster != null) {
      data['farmer_master'] = farmerMaster!.toJson();
    }
    if (dataLivestock != null) {
      data['live_stock_cart'] = dataLivestock!.toJson();
    }
    if (farmerProjectLog != null) {
      data['farmer_project_log'] =
          farmerProjectLog!.map((v) => v.toJson()).toList();
    }
    if (farmerProjectKycDocument != null) {
      data['farmer_project_kyc_document'] =
          farmerProjectKycDocument!.toJson();
    }
    return data;
  }
}

class FarmerDocuments {
  dynamic id;
  dynamic farmerId;
  dynamic personalIdName;
  String? docType;
  String? docNo;
  String? docName;
  String? docTypeNo;
  String? docTypeExpiryDate;
  String? docExpiryDate;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  List<DocumentFiles>? documentFiles;
  List<DocumentTypeFiles>? documentTypeFiles;
  String? profilePic;

  FarmerDocuments(
      {this.id,
        this.farmerId,
        this.personalIdName,
        this.docType,
        this.docNo,
        this.docName,
        this.docTypeNo,
        this.docTypeExpiryDate,
        this.docExpiryDate,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.documentFiles,
        this.documentTypeFiles,
        this.profilePic});

  FarmerDocuments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    personalIdName = json['personal_id_name'];
    docType = json['doc_type'];
    docNo = json['doc_no'];
    docName = json['doc_name'];
    docTypeNo = json['doc_type_no'];
    docTypeExpiryDate = json['doc_type_expiry_date'];
    docExpiryDate = json['doc_expiry_date'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['document_files'] != null) {
      documentFiles = <DocumentFiles>[];
      json['document_files'].forEach((v) {
        documentFiles!.add(DocumentFiles.fromJson(v));
      });
    }
    if (json['document_type_files'] != null) {
      documentTypeFiles = <DocumentTypeFiles>[];
      json['document_type_files'].forEach((v) {
        documentTypeFiles!.add(DocumentTypeFiles.fromJson(v));
      });
    }
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['farmer_id'] = farmerId;
    data['personal_id_name'] = personalIdName;
    data['doc_type'] = docType;
    data['doc_no'] = docNo;
    data['doc_name'] = docName;
    data['doc_type_no'] = docTypeNo;
    data['doc_type_expiry_date'] = docTypeExpiryDate;
    data['doc_expiry_date'] = docExpiryDate;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (documentFiles != null) {
      data['document_files'] =
          documentFiles!.map((v) => v.toJson()).toList();
    }
    if (documentTypeFiles != null) {
      data['document_type_files'] =
          documentTypeFiles!.map((v) => v.toJson()).toList();
    }
    data['profile_pic'] = profilePic;
    return data;
  }
}

class DocumentFiles {
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
  String? fullUrl;
  String? originalUrl;
  String? previewUrl;

  DocumentFiles(
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
        this.fullUrl,
        this.originalUrl,
        this.previewUrl});

  DocumentFiles.fromJson(Map<String, dynamic> json) {
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
    fullUrl = json['full_url'];
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
    data['full_url'] = fullUrl;
    data['original_url'] = originalUrl;
    data['preview_url'] = previewUrl;
    return data;
  }
}

class DocumentTypeFiles {
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
  String? fullUrl;
  String? originalUrl;
  String? previewUrl;

  DocumentTypeFiles(
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
        this.fullUrl,
        this.originalUrl,
        this.previewUrl});

  DocumentTypeFiles.fromJson(Map<String, dynamic> json) {
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
    fullUrl = json['full_url'];
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
    data['full_url'] = fullUrl;
    data['original_url'] = originalUrl;
    data['preview_url'] = previewUrl;
    return data;
  }
}

class FarmerProjectMilestones {
  dynamic id;
  dynamic farmerId;
  dynamic farmerProjectId;
  String? milestoneCode;
  String? milestoneTitle;
  String? milestoneDescription;
  dynamic milestoneDuration;
  dynamic resourceType;
  dynamic resourceCapcity;
  dynamic resourcePrice;
  dynamic resourceQty;
  dynamic resourceUom;
  dynamic milestoneValue;
  String? milestoneStatus;
  dynamic milestoneDueDate;
  dynamic completionDate;
  dynamic approvalDate;
  dynamic approvalRemarks;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  dynamic farmerProjectTaskCount;
  List<FarmerProjectTask>? farmerProjectTask;

  FarmerProjectMilestones(
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
        this.farmerProjectTaskCount,
        this.milestoneDueDate,
        this.farmerProjectTask,
        this.approvalRemarks});

  FarmerProjectMilestones.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    farmerProjectId = json['farmer_project_id'];
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
    approvalRemarks= json['approval_remarks'];
    farmerProjectTaskCount = json['farmer_project_task_count'];
    milestoneDueDate = json['milestone_due_date'];
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
    data['farmer_project_task_count'] = farmerProjectTaskCount;
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

class DairyDevelopMentExecutive {
  dynamic id;
  dynamic userId;
  String? name;
  String? phone;
  String? photo;
  dynamic address;

  DairyDevelopMentExecutive(
      {this.id, this.userId, this.name, this.phone, this.photo, this.address});

  DairyDevelopMentExecutive.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    phone = json['phone'];
    photo = json['photo'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['phone'] = phone;
    data['photo'] = photo;
    data['address'] = address;
    return data;
  }
}

class Kpi {
  dynamic investment;
  dynamic revenue;
  dynamic roi;
  dynamic farmerParticipation;
  dynamic loan;
  dynamic repayment;
  dynamic repaymentStartDate;
  dynamic emi;
  dynamic paidEmis;
  dynamic remainingEmiValue;
  dynamic currentYield;
  dynamic expectedYield;
  dynamic idealYield;
  dynamic targetFarmProduction;
  dynamic supplierPaidAmount;
  dynamic supplierDueAmount;
  dynamic supplierPendingAmount;
  dynamic milkSupplySixMonth;
  dynamic milkSupplyOneMonth;
  dynamic milkSupplyTwoWeek;

  Kpi(
      {this.investment,
        this.revenue,
        this.roi,
        this.farmerParticipation,
        this.loan,
        this.repayment,
        this.repaymentStartDate,
        this.emi,
        this.paidEmis,
        this.remainingEmiValue,
        this.currentYield,
        this.expectedYield,
        this.idealYield,
        this.targetFarmProduction,
        this.supplierPaidAmount,
        this.supplierDueAmount,
        this.supplierPendingAmount,
        this.milkSupplySixMonth,
        this.milkSupplyTwoWeek,
        this.milkSupplyOneMonth,
      });

  Kpi.fromJson(Map<String, dynamic> json) {
    investment = json['investment'];
    revenue = json['revenue'];
    roi = json['roi'];
    farmerParticipation = json['farmer_participation'];
    loan = json['loan'];
    repayment = json['repayment'];
    repaymentStartDate = json['repayment_start_date'];
    emi = json['emi'];
    paidEmis = json['paid_emis'];
    remainingEmiValue = json['remaining_emi_value'];
    currentYield = json['current_yield'];
    expectedYield = json['expected_yield'];
    idealYield = json['ideal_yield'];
    targetFarmProduction = json['target_farm_production'];
    supplierPaidAmount = json['supplier_paid_amount'];
    supplierDueAmount = json['supplier_due_amount'];
    supplierPendingAmount = json['supplier_pending_amount'];
    milkSupplySixMonth = json['milk_supply_six_month'];
    milkSupplyOneMonth = json['milk_supply_one_month'];
    milkSupplyTwoWeek = json['milk_supply_two_week'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['investment'] = investment;
    data['revenue'] = revenue;
    data['roi'] = roi;
    data['farmer_participation'] = farmerParticipation;
    data['loan'] = loan;
    data['repayment'] = repayment;
    data['repayment_start_date'] = repaymentStartDate;
    data['emi'] = emi;
    data['paid_emis'] = paidEmis;
    data['remaining_emi_value'] = remainingEmiValue;
    data['current_yield'] = currentYield;
    data['expected_yield'] = expectedYield;
    data['ideal_yield'] = idealYield;
    data['target_farm_production'] = targetFarmProduction;
    data['supplier_paid_amount'] = supplierPaidAmount;
    data['supplier_due_amount'] = supplierDueAmount;
    data['supplier_pending_amount'] = supplierPendingAmount;
    data['milk_supply_six_month'] = milkSupplySixMonth;
    data['milk_supply_two_week'] = milkSupplyTwoWeek;
    data['milk_supply_one_month'] = milkSupplyOneMonth;
    return data;
  }
}


class FarmerMaster {
  dynamic id;
  dynamic userId;
  String? name;
  String? email;
  String? fAddress;
  String? phone;
  dynamic mccId;
  dynamic ddeId;
  dynamic photos;
  dynamic kycStatus;
  dynamic landlineNo;
  dynamic dateOfBirth;
  dynamic gender;
  dynamic registrationDate;
  dynamic supplierId;
  dynamic farmSize;
  dynamic dairyArea;
  dynamic staffQuantity;
  dynamic farmingExperience;
  dynamic managerName;
  dynamic managerPhone;
  dynamic ragRating;
  dynamic leadType;
  dynamic idealYield;
  dynamic currentYield;
  dynamic status;
  dynamic createdBy;
  dynamic updatedBy;
  String? createdAt;
  dynamic photo;
  dynamic achievement;
  Address? address;
  FarmerDocuments? farmerDocuments;

  FarmerMaster(
      {this.id,
        this.userId,
        this.name,
        this.email,
        this.fAddress,
        this.phone,
        this.mccId,
        this.ddeId,
        this.photos,
        this.kycStatus,
        this.landlineNo,
        this.dateOfBirth,
        this.gender,
        this.registrationDate,
        this.supplierId,
        this.farmSize,
        this.dairyArea,
        this.staffQuantity,
        this.farmingExperience,
        this.managerName,
        this.managerPhone,
        this.ragRating,
        this.leadType,
        this.idealYield,
        this.currentYield,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.photo,
        this.achievement,
        this.address,
        this.farmerDocuments});

  FarmerMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    fAddress = json['f_address'];
    phone = json['phone'];
    mccId = json['mcc_id'];
    ddeId = json['dde_id'];
    photos = json['photos'];
    kycStatus = json['kyc_status'];
    landlineNo = json['landline_no'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    registrationDate = json['registration_date'];
    supplierId = json['supplier_id'];
    farmSize = json['farm_size'];
    dairyArea = json['dairy_area'];
    staffQuantity = json['staff_quantity'];
    farmingExperience = json['farming_experience'];
    managerName = json['manager_name'];
    managerPhone = json['manager_phone'];
    ragRating = json['rag_rating'];
    leadType = json['lead_type'];
    idealYield = json['ideal_yield'];
    currentYield = json['current_yield'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    photo = json['photo'];
    achievement = json['achievement'];
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
    farmerDocuments = json['farmer_documents'] != null
        ? FarmerDocuments.fromJson(json['farmer_documents'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['f_address'] = fAddress;
    data['phone'] = phone;
    data['mcc_id'] = mccId;
    data['dde_id'] = ddeId;
    data['photos'] = photos;
    data['kyc_status'] = kycStatus;
    data['landline_no'] = landlineNo;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['registration_date'] = registrationDate;
    data['supplier_id'] = supplierId;
    data['farm_size'] = farmSize;
    data['dairy_area'] = dairyArea;
    data['staff_quantity'] = staffQuantity;
    data['farming_experience'] = farmingExperience;
    data['manager_name'] = managerName;
    data['manager_phone'] = managerPhone;
    data['rag_rating'] = ragRating;
    data['lead_type'] = leadType;
    data['ideal_yield'] = idealYield;
    data['current_yield'] = currentYield;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['photo'] = photo;
    data['achievement'] = achievement;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    return data;
  }
}

class Address {
  dynamic id;
  dynamic addressableId;
  String? addressableType;
  String? name;
  String? mobile;
  dynamic dialCode;
  dynamic landlineNo;
  String? email;
  dynamic gstNumber;
  String? line1;
  dynamic line2;
  dynamic landmark;
  dynamic cityId;
  String? district;
  String? subCounty;
  dynamic centerName;
  dynamic village;
  dynamic parish;
  String? county;
  dynamic poBoxNumber;
  dynamic coordinates;
  dynamic latitude;
  dynamic longitude;
  dynamic stateId;
  dynamic country;
  dynamic countryId;
  String? region;
  String? postalCode;
  dynamic address;
  dynamic type;
  String? createdAt;
  String? updatedAt;
  String? fullAddress;

  Address(
      {this.id,
        this.addressableId,
        this.addressableType,
        this.name,
        this.mobile,
        this.dialCode,
        this.landlineNo,
        this.email,
        this.gstNumber,
        this.line1,
        this.line2,
        this.landmark,
        this.cityId,
        this.district,
        this.subCounty,
        this.centerName,
        this.village,
        this.parish,
        this.county,
        this.poBoxNumber,
        this.coordinates,
        this.latitude,
        this.longitude,
        this.stateId,
        this.country,
        this.countryId,
        this.region,
        this.postalCode,
        this.address,
        this.type,
        this.createdAt,
        this.updatedAt,
        this.fullAddress});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressableId = json['addressable_id'];
    addressableType = json['addressable_type'];
    name = json['name'];
    mobile = json['mobile'];
    dialCode = json['dial_code'];
    landlineNo = json['landline_no'];
    email = json['email'];
    gstNumber = json['gst_number'];
    line1 = json['line_1'];
    line2 = json['line_2'];
    landmark = json['landmark'];
    cityId = json['city_id'];
    district = json['district'];
    subCounty = json['sub_county'];
    centerName = json['center_name'];
    village = json['village'];
    parish = json['parish'];
    county = json['county'];
    poBoxNumber = json['po_box_number'];
    coordinates = json['coordinates'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    stateId = json['state_id'];
    country = json['country'];
    countryId = json['country_id'];
    region = json['region'];
    postalCode = json['postal_code'];
    address = json['address'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullAddress = json['full_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['addressable_id'] = addressableId;
    data['addressable_type'] = addressableType;
    data['name'] = name;
    data['mobile'] = mobile;
    data['dial_code'] = dialCode;
    data['landline_no'] = landlineNo;
    data['email'] = email;
    data['gst_number'] = gstNumber;
    data['line_1'] = line1;
    data['line_2'] = line2;
    data['landmark'] = landmark;
    data['city_id'] = cityId;
    data['district'] = district;
    data['sub_county'] = subCounty;
    data['center_name'] = centerName;
    data['village'] = village;
    data['parish'] = parish;
    data['county'] = county;
    data['po_box_number'] = poBoxNumber;
    data['coordinates'] = coordinates;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['state_id'] = stateId;
    data['country'] = country;
    data['country_id'] = countryId;
    data['region'] = region;
    data['postal_code'] = postalCode;
    data['address'] = address;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['full_address'] = fullAddress;
    return data;
  }
}

class FarmerProjectPaymentTerms {
  dynamic id;
  dynamic farmerId;
  dynamic farmerProjectId;
  dynamic farmerMilestoneId;
  dynamic paymentTerm;
  dynamic paymentPercentage;
  dynamic status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic createdAt;
  dynamic updatedAt;

  FarmerProjectPaymentTerms(
      {this.id,
        this.farmerId,
        this.farmerProjectId,
        this.farmerMilestoneId,
        this.paymentTerm,
        this.paymentPercentage,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt});

  FarmerProjectPaymentTerms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    farmerProjectId = json['farmer_project_id'];
    farmerMilestoneId = json['farmer_milestone_id'];
    paymentTerm = json['payment_term'];
    paymentPercentage = json['payment_percentage'];
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
    data['payment_term'] = paymentTerm;
    data['payment_percentage'] = paymentPercentage;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class FarmerProjectLog {
  dynamic id;
  dynamic farmerId;
  dynamic farmerProjectId;
  dynamic date;
  dynamic userId;
  String? userName;
  dynamic userRole;
  dynamic activityId;
  String? activityName;
  dynamic remarks;
  dynamic ddeVisitDate;
  dynamic projectStatus;
  dynamic ddeName;
  dynamic mccName;
  dynamic supplierName;
  dynamic status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;

  FarmerProjectLog(
      {this.id,
        this.farmerId,
        this.farmerProjectId,
        this.date,
        this.userId,
        this.userName,
        this.userRole,
        this.activityId,
        this.activityName,
        this.remarks,
        this.ddeVisitDate,
        this.projectStatus,
        this.ddeName,
        this.mccName,
        this.supplierName,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt});

  FarmerProjectLog.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    farmerProjectId = json['farmer_project_id'];
    date = json['date'];
    userId = json['user_id'];
    userName = json['user_name'];
    userRole = json['user_role'];
    activityId = json['activity_id'];
    activityName = json['activity_name'];
    remarks = json['remarks'];
    ddeVisitDate = json['dde_visit_date'];
    projectStatus = json['project_status'];
    ddeName = json['dde_name'];
    mccName = json['mcc_name'];
    supplierName = json['supplier_name'];
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
    data['date'] = date;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['user_role'] = userRole;
    data['activity_id'] = activityId;
    data['activity_name'] = activityName;
    data['remarks'] = remarks;
    data['dde_visit_date'] = ddeVisitDate;
    data['project_status'] = projectStatus;
    data['dde_name'] = ddeName;
    data['mcc_name'] = mccName;
    data['supplier_name'] = supplierName;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class FarmerProjectKycDocument {
  dynamic id;
  dynamic farmerId;
  dynamic farmerProjectId;
  dynamic addressDocumentName;
  dynamic addressDocumentNumber;
  dynamic addressExpiryDate;
  dynamic idDocumentName;
  dynamic idDocumentNumber;
  dynamic idExpiryDate;
  dynamic status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic createdAt;
  dynamic updatedAt;
  List<AddressDocumentFile>? addressDocumentFile;
  List<IdDocumentFile>? idDocumentFile;
  dynamic projectFarmerPhoto;
  List<Media>? media;

  FarmerProjectKycDocument(
      {this.id,
        this.farmerId,
        this.farmerProjectId,
        this.addressDocumentName,
        this.addressDocumentNumber,
        this.addressExpiryDate,
        this.idDocumentName,
        this.idDocumentNumber,
        this.idExpiryDate,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.addressDocumentFile,
        this.idDocumentFile,
        this.projectFarmerPhoto,
        this.media});

  FarmerProjectKycDocument.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    farmerProjectId = json['farmer_project_id'];
    addressDocumentName = json['address_document_name'];
    addressDocumentNumber = json['address_document_number'];
    addressExpiryDate = json['address_expiry_date'];
    idDocumentName = json['id_document_name'];
    idDocumentNumber = json['id_document_number'];
    idExpiryDate = json['id_expiry_date'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['address_document_file'] != null) {
      addressDocumentFile = <AddressDocumentFile>[];
      json['address_document_file'].forEach((v) {
        addressDocumentFile!.add(AddressDocumentFile.fromJson(v));
      });
    }
    if (json['id_document_file'] != null) {
      idDocumentFile = <IdDocumentFile>[];
      json['id_document_file'].forEach((v) {
        idDocumentFile!.add(IdDocumentFile.fromJson(v));
      });
    }
    projectFarmerPhoto = json['project_farmer_photo'];
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
    data['address_document_name'] = addressDocumentName;
    data['address_document_number'] = addressDocumentNumber;
    data['address_expiry_date'] = addressExpiryDate;
    data['id_document_name'] = idDocumentName;
    data['id_document_number'] = idDocumentNumber;
    data['id_expiry_date'] = idExpiryDate;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (addressDocumentFile != null) {
      data['address_document_file'] =
          addressDocumentFile!.map((v) => v.toJson()).toList();
    }
    if (idDocumentFile != null) {
      data['id_document_file'] =
          idDocumentFile!.map((v) => v.toJson()).toList();
    }
    data['project_farmer_photo'] = projectFarmerPhoto;
    if (media != null) {
      data['media'] = media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressDocumentFile {
  dynamic id;
  String? modelType;
  dynamic modelId;
  dynamic uuid;
  dynamic collectionName;
  String? name;
  String? fileName;
  String? mimeType;
  dynamic disk;
  dynamic conversionsDisk;
  dynamic size;
  dynamic manipulations;
  dynamic customProperties;
  dynamic generatedConversions;
  dynamic responsiveImages;
  dynamic orderColumn;
  String? createdAt;
  String? updatedAt;
  String? fullUrl;
  String? originalUrl;
  String? previewUrl;

  AddressDocumentFile(
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
        this.fullUrl,
        this.originalUrl,
        this.previewUrl});

  AddressDocumentFile.fromJson(Map<String, dynamic> json) {
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
    if (json['manipulations'] != null) {
      manipulations = <Null>[];
      json['manipulations'].forEach((v) {
        manipulations!.add(v);
      });
    }
    if (json['custom_properties'] != null) {
      customProperties = <Null>[];
      json['custom_properties'].forEach((v) {
        customProperties!.add(v);
      });
    }
    if (json['generated_conversions'] != null) {
      generatedConversions = <Null>[];
      json['generated_conversions'].forEach((v) {
        generatedConversions!.add(v);
      });
    }
    if (json['responsive_images'] != null) {
      responsiveImages = <Null>[];
      json['responsive_images'].forEach((v) {
        responsiveImages!.add(v);
      });
    }
    orderColumn = json['order_column'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullUrl = json['full_url'];
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
    if (manipulations != null) {
      data['manipulations'] =
          manipulations!.map((v) => v.toJson()).toList();
    }
    if (customProperties != null) {
      data['custom_properties'] =
          customProperties!.map((v) => v.toJson()).toList();
    }
    if (generatedConversions != null) {
      data['generated_conversions'] =
          generatedConversions!.map((v) => v.toJson()).toList();
    }
    if (responsiveImages != null) {
      data['responsive_images'] =
          responsiveImages!.map((v) => v.toJson()).toList();
    }
    data['order_column'] = orderColumn;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['full_url'] = fullUrl;
    data['original_url'] = originalUrl;
    data['preview_url'] = previewUrl;
    return data;
  }
}

class IdDocumentFile {
  dynamic id;
  String? modelType;
  dynamic modelId;
  dynamic uuid;
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
  String? fullUrl;
  String? originalUrl;
  String? previewUrl;

  IdDocumentFile(
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
        this.fullUrl,
        this.originalUrl,
        this.previewUrl});

  IdDocumentFile.fromJson(Map<String, dynamic> json) {
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
    if (json['manipulations'] != null) {
      manipulations = <Null>[];
      json['manipulations'].forEach((v) {
        manipulations!.add(v);
      });
    }
    if (json['custom_properties'] != null) {
      customProperties = <Null>[];
      json['custom_properties'].forEach((v) {
        customProperties!.add(v);
      });
    }
    if (json['generated_conversions'] != null) {
      generatedConversions = <Null>[];
      json['generated_conversions'].forEach((v) {
        generatedConversions!.add(v);
      });
    }
    if (json['responsive_images'] != null) {
      responsiveImages = <Null>[];
      json['responsive_images'].forEach((v) {
        responsiveImages!.add(v);
      });
    }
    orderColumn = json['order_column'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullUrl = json['full_url'];
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
    if (manipulations != null) {
      data['manipulations'] =
          manipulations!.map((v) => v.toJson()).toList();
    }
    if (customProperties != null) {
      data['custom_properties'] =
          customProperties!.map((v) => v.toJson()).toList();
    }
    if (generatedConversions != null) {
      data['generated_conversions'] =
          generatedConversions!.map((v) => v.toJson()).toList();
    }
    if (responsiveImages != null) {
      data['responsive_images'] =
          responsiveImages!.map((v) => v.toJson()).toList();
    }
    data['order_column'] = orderColumn;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['full_url'] = fullUrl;
    data['original_url'] = originalUrl;
    data['preview_url'] = previewUrl;
    return data;
  }
}

class Media {
  dynamic id;
  String? modelType;
  dynamic modelId;
  dynamic uuid;
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
  String? fullUrl;
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
        this.fullUrl,
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
    if (json['manipulations'] != null) {
      manipulations = <Null>[];
      json['manipulations'].forEach((v) {
        manipulations!.add(v);
      });
    }
    if (json['custom_properties'] != null) {
      customProperties = <Null>[];
      json['custom_properties'].forEach((v) {
        customProperties!.add(v);
      });
    }
    if (json['generated_conversions'] != null) {
      generatedConversions = <Null>[];
      json['generated_conversions'].forEach((v) {
        generatedConversions!.add(v);
      });
    }
    if (json['responsive_images'] != null) {
      responsiveImages = <Null>[];
      json['responsive_images'].forEach((v) {
        responsiveImages!.add(v);
      });
    }
    orderColumn = json['order_column'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullUrl = json['full_url'];
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
    if (manipulations != null) {
      data['manipulations'] =
          manipulations!.map((v) => v.toJson()).toList();
    }
    if (customProperties != null) {
      data['custom_properties'] =
          customProperties!.map((v) => v.toJson()).toList();
    }
    if (generatedConversions != null) {
      data['generated_conversions'] =
          generatedConversions!.map((v) => v.toJson()).toList();
    }
    if (responsiveImages != null) {
      data['responsive_images'] =
          responsiveImages!.map((v) => v.toJson()).toList();
    }
    data['order_column'] = orderColumn;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['full_url'] = fullUrl;
    data['original_url'] = originalUrl;
    data['preview_url'] = previewUrl;
    return data;
  }
}

class FarmerLoanDocument {
  dynamic id;
  dynamic farmerId;
  dynamic farmerProjectId;
  String? documentName;
  dynamic status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  dynamic addressDocumentFile;
  dynamic projectFarmerPhoto;
  dynamic idDocumentFile;
  List<LoanDocumentFile>? loanDocumentFile;
  List<Media>? media;

  FarmerLoanDocument(
      {this.id,
        this.farmerId,
        this.farmerProjectId,
        this.documentName,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.addressDocumentFile,
        this.projectFarmerPhoto,
        this.idDocumentFile,
        this.loanDocumentFile,
        this.media});

  FarmerLoanDocument.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    farmerProjectId = json['farmer_project_id'];
    documentName = json['document_name'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    addressDocumentFile = json['address_document_file'];
    projectFarmerPhoto = json['project_farmer_photo'];
    idDocumentFile = json['id_document_file'];
    if (json['loan_document_file'] != null) {
      loanDocumentFile = <LoanDocumentFile>[];
      json['loan_document_file'].forEach((v) {
        loanDocumentFile!.add(LoanDocumentFile.fromJson(v));
      });
    }
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
    data['document_name'] = documentName;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['address_document_file'] = addressDocumentFile;
    data['project_farmer_photo'] = projectFarmerPhoto;
    data['id_document_file'] = idDocumentFile;
    if (loanDocumentFile != null) {
      data['loan_document_file'] =
          loanDocumentFile!.map((v) => v.toJson()).toList();
    }
    if (media != null) {
      data['media'] = media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LoanDocumentFile {
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
  dynamic manipulations;
  dynamic customProperties;
  dynamic generatedConversions;
  dynamic responsiveImages;
  dynamic orderColumn;
  String? createdAt;
  String? updatedAt;
  String? fullUrl;
  String? originalUrl;
  String? previewUrl;

  LoanDocumentFile(
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
        this.fullUrl,
        this.originalUrl,
        this.previewUrl});

  LoanDocumentFile.fromJson(Map<String, dynamic> json) {
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
    if (json['manipulations'] != null) {
      manipulations = <Null>[];
      json['manipulations'].forEach((v) {
        manipulations!.add(v);
      });
    }
    if (json['custom_properties'] != null) {
      customProperties = <Null>[];
      json['custom_properties'].forEach((v) {
        customProperties!.add(v);
      });
    }
    if (json['generated_conversions'] != null) {
      generatedConversions = <Null>[];
      json['generated_conversions'].forEach((v) {
        generatedConversions!.add(v);
      });
    }
    if (json['responsive_images'] != null) {
      responsiveImages = <Null>[];
      json['responsive_images'].forEach((v) {
        responsiveImages!.add(v);
      });
    }
    orderColumn = json['order_column'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullUrl = json['full_url'];
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
    if (manipulations != null) {
      data['manipulations'] =
          manipulations!.map((v) => v.toJson()).toList();
    }
    if (customProperties != null) {
      data['custom_properties'] =
          customProperties!.map((v) => v.toJson()).toList();
    }
    if (generatedConversions != null) {
      data['generated_conversions'] =
          generatedConversions!.map((v) => v.toJson()).toList();
    }
    if (responsiveImages != null) {
      data['responsive_images'] =
          responsiveImages!.map((v) => v.toJson()).toList();
    }
    data['order_column'] = orderColumn;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['full_url'] = fullUrl;
    data['original_url'] = originalUrl;
    data['preview_url'] = previewUrl;
    return data;
  }
}

class FarmerProjectSurvey {
  dynamic id;
  dynamic farmerId;
  dynamic farmerProjectId;
  dynamic supplierCode;
  dynamic supplierId;
  String? projectSurveyDays;
  dynamic investmentAmount;
  String? surveySubmitDate;
  String? surveyCompletionDate;
  String? surveyStatus;
  String? surveyRemarks;
  dynamic status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;

  FarmerProjectSurvey(
      {this.id,
        this.farmerId,
        this.farmerProjectId,
        this.supplierCode,
        this.supplierId,
        this.projectSurveyDays,
        this.investmentAmount,
        this.surveySubmitDate,
        this.surveyCompletionDate,
        this.surveyStatus,
        this.surveyRemarks,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt});

  FarmerProjectSurvey.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    farmerProjectId = json['farmer_project_id'];
    supplierCode = json['supplier_code'];
    supplierId = json['supplier_id'];
    projectSurveyDays = json['project_survey_days'];
    investmentAmount = json['investment_amount'];
    surveySubmitDate = json['survey_submit_date'];
    surveyCompletionDate = json['survey_completion_date'];
    surveyStatus = json['survey_status'];
    surveyRemarks = json['survey_remarks'];
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
    data['supplier_code'] = supplierCode;
    data['supplier_id'] = supplierId;
    data['project_survey_days'] = projectSurveyDays;
    data['investment_amount'] = investmentAmount;
    data['survey_submit_date'] = surveySubmitDate;
    data['survey_completion_date'] = surveyCompletionDate;
    data['survey_status'] = surveyStatus;
    data['survey_remarks'] = surveyRemarks;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class ImprovementArea {
  dynamic id;
  String? name;
  dynamic gladCommissionPerc;
  dynamic ddeCommissionPerc;
  dynamic farmerPartPerc;
  dynamic minRepayMonths;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic createdAt;
  dynamic updatedAt;

  ImprovementArea(
      {this.id,
        this.name,
        this.gladCommissionPerc,
        this.ddeCommissionPerc,
        this.farmerPartPerc,
        this.minRepayMonths,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt});

  ImprovementArea.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gladCommissionPerc = json['glad_commission_perc'];
    ddeCommissionPerc = json['dde_commission_perc'];
    farmerPartPerc = json['farmer_part_perc'];
    minRepayMonths = json['min_repay_months'];
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
    data['name'] = name;
    data['glad_commission_perc'] = gladCommissionPerc;
    data['dde_commission_perc'] = ddeCommissionPerc;
    data['farmer_part_perc'] = farmerPartPerc;
    data['min_repay_months'] = minRepayMonths;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class SupplierDetail {
  dynamic id;
  dynamic name;
  dynamic userId;
  dynamic mccId;
  dynamic contactPerson;
  dynamic phone;
  String? email;
  dynamic status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  // dynamic image;
  dynamic photo;
  dynamic address;

  SupplierDetail(
      {this.id,
        this.name,
        this.userId,
        this.mccId,
        this.contactPerson,
        this.phone,
        this.email,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.photo,
        // this.image,
        this.address});

  SupplierDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['user_id'];
    mccId = json['mcc_id'];
    contactPerson = json['contact_person'];
    phone = json['phone'];
    email = json['email'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    photo = json['photo'];
    // image = json['image'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['user_id'] = userId;
    data['mcc_id'] = mccId;
    data['contact_person'] = contactPerson;
    data['phone'] = phone;
    data['email'] = email;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    // data['image'] = image;
    return data;
  }
}

class ProjectRating {
  dynamic rating;
  String? feedback;

  ProjectRating({this.rating, this.feedback});

  ProjectRating.fromJson(Map<String, dynamic> json) {
    rating = json['rating'];
    feedback = json['feedback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rating'] = rating;
    data['feedback'] = feedback;
    return data;
  }
}

class Seller {
  dynamic id;
  dynamic userId;
  dynamic name;
  dynamic email;
  dynamic fAddress;
  dynamic phone;
  dynamic mccId;
  dynamic ddeId;
  String? photos;
  String? kycStatus;
  String? landlineNo;
  String? dateOfBirth;
  String? gender;
  dynamic registrationDate;
  dynamic supplierId;
  dynamic farmSize;
  dynamic dairyArea;
  dynamic staffQuantity;
  dynamic farmingExperience;
  String? managerName;
  String? managerPhone;
  String? ragRating;
  String? leadType;
  dynamic idealYield;
  dynamic currentYield;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  String? createdAt;
  String? photo;
  dynamic achievement;
  dynamic farmerRating;
  dynamic framerRatingCount;
  Address? address;


  Seller(
      {this.id,
        this.userId,
        this.name,
        this.email,
        this.fAddress,
        this.phone,
        this.mccId,
        this.ddeId,
        this.photos,
        this.kycStatus,
        this.landlineNo,
        this.dateOfBirth,
        this.gender,
        this.registrationDate,
        this.supplierId,
        this.farmSize,
        this.dairyArea,
        this.staffQuantity,
        this.farmingExperience,
        this.managerName,
        this.managerPhone,
        this.ragRating,
        this.leadType,
        this.idealYield,
        this.currentYield,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.photo,
        this.achievement,
        this.farmerRating,
        this.framerRatingCount,
        this.address,});

  Seller.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    fAddress = json['f_address'];
    phone = json['phone'];
    mccId = json['mcc_id'];
    ddeId = json['dde_id'];
    photos = json['photos'];
    kycStatus = json['kyc_status'];
    landlineNo = json['landline_no'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    registrationDate = json['registration_date'];
    supplierId = json['supplier_id'];
    farmSize = json['farm_size'];
    dairyArea = json['dairy_area'];
    staffQuantity = json['staff_quantity'];
    farmingExperience = json['farming_experience'];
    managerName = json['manager_name'];
    managerPhone = json['manager_phone'];
    ragRating = json['rag_rating'];
    leadType = json['lead_type'];
    idealYield = json['ideal_yield'];
    currentYield = json['current_yield'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    photo = json['photo'];
    achievement = json['achievement'];
    farmerRating = json['farmer_rating'];
    framerRatingCount = json['framer_rating_count'];
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['f_address'] = fAddress;
    data['phone'] = phone;
    data['mcc_id'] = mccId;
    data['dde_id'] = ddeId;
    data['photos'] = photos;
    data['kyc_status'] = kycStatus;
    data['landline_no'] = landlineNo;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['registration_date'] = registrationDate;
    data['supplier_id'] = supplierId;
    data['farm_size'] = farmSize;
    data['dairy_area'] = dairyArea;
    data['staff_quantity'] = staffQuantity;
    data['farming_experience'] = farmingExperience;
    data['manager_name'] = managerName;
    data['manager_phone'] = managerPhone;
    data['rag_rating'] = ragRating;
    data['lead_type'] = leadType;
    data['ideal_yield'] = idealYield;
    data['current_yield'] = currentYield;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['photo'] = photo;
    data['achievement'] = achievement;
    data['farmer_rating'] = farmerRating;
    data['framer_rating_count'] = framerRatingCount;
    if (address != null) {
      data['address'] = address!.toJson();
    }

    return data;
  }
}

class DataLivestock {
  int? id;
  int? livestockId;
  int? userId;
  dynamic sellerId;
  dynamic cowQty;
  dynamic cowPrice;
  dynamic loanStatus;
  dynamic statusDate;
  dynamic remarks;
  dynamic farmerParticipation;
  dynamic loanAmount;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  List<LiveStockCartDetails>? liveStockCartDetails;

  DataLivestock(
      {this.id,
        this.livestockId,
        this.userId,
        this.sellerId,
        this.cowQty,
        this.cowPrice,
        this.loanStatus,
        this.statusDate,
        this.remarks,
        this.farmerParticipation,
        this.loanAmount,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.liveStockCartDetails});

  DataLivestock.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    livestockId = json['livestock_id'];
    userId = json['user_id'];
    sellerId = json['seller_id'];
    cowQty = json['cow_qty'];
    cowPrice = json['cow_price'];
    loanStatus = json['loan_status'];
    statusDate = json['status_date'];
    remarks = json['remarks'];
    farmerParticipation = json['farmer_participation'];
    loanAmount = json['loan_amount'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['live_stock_cart_details'] != null) {
      liveStockCartDetails = <LiveStockCartDetails>[];
      json['live_stock_cart_details'].forEach((v) {
        liveStockCartDetails!.add(LiveStockCartDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['livestock_id'] = livestockId;
    data['user_id'] = userId;
    data['seller_id'] = sellerId;
    data['cow_qty'] = cowQty;
    data['cow_price'] = cowPrice;
    data['loan_status'] = loanStatus;
    data['status_date'] = statusDate;
    data['remarks'] = remarks;
    data['farmer_participation'] = farmerParticipation;
    data['loan_amount'] = loanAmount;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (liveStockCartDetails != null) {
      data['live_stock_cart_details'] =
          liveStockCartDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LiveStockCartDetails {
  int? id;
  int? liveStockCartId;
  int? liveStockId;
  int? cowQty;
  dynamic cowPrice;
  String? deliveryStatus;
  dynamic remarks;
  dynamic deliveryDate;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  dynamic pictures;
  LiveStock? liveStock;
  List<MediaLivestock>? media;

  LiveStockCartDetails(
      {this.id,
        this.liveStockCartId,
        this.liveStockId,
        this.cowQty,
        this.cowPrice,
        this.deliveryStatus,
        this.remarks,
        this.deliveryDate,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.pictures,
        this.liveStock,
        this.media});

  LiveStockCartDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    liveStockCartId = json['live_stock_cart_id'];
    liveStockId = json['live_stock_id'];
    cowQty = json['cow_qty'];
    cowPrice = json['cow_price'];
    deliveryStatus = json['delivery_status'];
    remarks = json['remarks'];
    deliveryDate = json['delivery_date'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pictures = json['pictures'];
    liveStock = json['live_stock'] != null
        ? LiveStock.fromJson(json['live_stock'])
        : null;
    if (json['media'] != null) {
      media = <MediaLivestock>[];
      json['media'].forEach((v) {
        media!.add(MediaLivestock.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['live_stock_cart_id'] = liveStockCartId;
    data['live_stock_id'] = liveStockId;
    data['cow_qty'] = cowQty;
    data['cow_price'] = cowPrice;
    data['delivery_status'] = deliveryStatus;
    data['remarks'] = remarks;
    data['delivery_date'] = deliveryDate;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['pictures'] = pictures;
    if (liveStock != null) {
      data['live_stock'] = liveStock!.toJson();
    }
    if (media != null) {
      data['media'] = media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LiveStock {
  dynamic id;
  dynamic userId;
  String? advertisementNo;
  dynamic cowBreedId;
  dynamic userRole;
  String? userName;
  dynamic date;
  String? breedCode;
  String? breedName;
  dynamic cowQty;
  dynamic soldQty;
  dynamic loanAccepted;
  dynamic loanApproved;
  dynamic balanceCows;
  dynamic fileType;
  dynamic price;
  int? age;
  dynamic lactation;
  dynamic pregnant;
  String? yield;
  String? description;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  List<LiveStockDocumentFiles>? liveStockDocumentFiles;
  dynamic isInCart;
  CowBreed? cowBreed;
  User? user;

  LiveStock(
      {this.id,
        this.userId,
        this.advertisementNo,
        this.cowBreedId,
        this.userRole,
        this.userName,
        this.date,
        this.breedCode,
        this.breedName,
        this.cowQty,
        this.soldQty,
        this.loanAccepted,
        this.loanApproved,
        this.balanceCows,
        this.fileType,
        this.price,
        this.age,
        this.lactation,
        this.pregnant,
        this.yield,
        this.description,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.liveStockDocumentFiles,
        this.isInCart,
        this.cowBreed,
        this.user});

  LiveStock.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    advertisementNo = json['advertisement_no'];
    cowBreedId = json['cow_breed_id'];
    userRole = json['user_role'];
    userName = json['user_name'];
    date = json['date'];
    breedCode = json['breed_code'];
    breedName = json['breed_name'];
    cowQty = json['cow_qty'];
    soldQty = json['sold_qty'];
    loanAccepted = json['loan_accepted'];
    loanApproved = json['loan_approved'];
    balanceCows = json['balance_cows'];
    fileType = json['file_type'];
    price = json['price'];
    age = json['age'];
    lactation = json['lactation'];
    pregnant = json['pregnant'];
    yield = json['yield'];
    description = json['description'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['live_stock_document_files'] != null) {
      liveStockDocumentFiles = <LiveStockDocumentFiles>[];
      json['live_stock_document_files'].forEach((v) {
        liveStockDocumentFiles!.add(LiveStockDocumentFiles.fromJson(v));
      });
    }
    isInCart = json['is_in_cart'];
    cowBreed = json['cow_breed'] != null
        ? CowBreed.fromJson(json['cow_breed'])
        : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['advertisement_no'] = advertisementNo;
    data['cow_breed_id'] = cowBreedId;
    data['user_role'] = userRole;
    data['user_name'] = userName;
    data['date'] = date;
    data['breed_code'] = breedCode;
    data['breed_name'] = breedName;
    data['cow_qty'] = cowQty;
    data['sold_qty'] = soldQty;
    data['loan_accepted'] = loanAccepted;
    data['loan_approved'] = loanApproved;
    data['balance_cows'] = balanceCows;
    data['file_type'] = fileType;
    data['price'] = price;
    data['age'] = age;
    data['lactation'] = lactation;
    data['pregnant'] = pregnant;
    data['yield'] = yield;
    data['description'] = description;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (liveStockDocumentFiles != null) {
      data['live_stock_document_files'] =
          liveStockDocumentFiles!.map((v) => v.toJson()).toList();
    }
    data['is_in_cart'] = isInCart;
    if (cowBreed != null) {
      data['cow_breed'] = cowBreed!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class LiveStockDocumentFiles {
  int? id;
  String? modelType;
  int? modelId;
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
  int? orderColumn;
  String? createdAt;
  String? updatedAt;
  String? fullUrl;
  String? originalUrl;
  String? previewUrl;

  LiveStockDocumentFiles(
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
        this.fullUrl,
        this.originalUrl,
        this.previewUrl});

  LiveStockDocumentFiles.fromJson(Map<String, dynamic> json) {
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
    if (json['manipulations'] != null) {
      manipulations = <Null>[];
      json['manipulations'].forEach((v) {
        manipulations!.add(v);
      });
    }
    if (json['custom_properties'] != null) {
      customProperties = <Null>[];
      json['custom_properties'].forEach((v) {
        customProperties!.add(v);
      });
    }
    if (json['generated_conversions'] != null) {
      generatedConversions = <Null>[];
      json['generated_conversions'].forEach((v) {
        generatedConversions!.add(v);
      });
    }
    if (json['responsive_images'] != null) {
      responsiveImages = <Null>[];
      json['responsive_images'].forEach((v) {
        responsiveImages!.add(v);
      });
    }
    orderColumn = json['order_column'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullUrl = json['full_url'];
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
    if (manipulations != null) {
      data['manipulations'] =
          manipulations!.map((v) => v.toJson()).toList();
    }
    if (customProperties != null) {
      data['custom_properties'] =
          customProperties!.map((v) => v.toJson()).toList();
    }
    if (generatedConversions != null) {
      data['generated_conversions'] =
          generatedConversions!.map((v) => v.toJson()).toList();
    }
    if (responsiveImages != null) {
      data['responsive_images'] =
          responsiveImages!.map((v) => v.toJson()).toList();
    }
    data['order_column'] = orderColumn;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['full_url'] = fullUrl;
    data['original_url'] = originalUrl;
    data['preview_url'] = previewUrl;
    return data;
  }
}

class CowBreed {
  int? id;
  String? name;
  String? price;
  String? yield;
  String? address;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic createdAt;
  String? updatedAt;

  CowBreed(
      {this.id,
        this.name,
        this.price,
        this.yield,
        this.address,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt});

  CowBreed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    yield = json['yield'];
    address = json['address'];
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
    data['name'] = name;
    data['price'] = price;
    data['yield'] = yield;
    data['address'] = address;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class User {
  dynamic id;
  dynamic userType;
  dynamic userCode;
  dynamic hasPassword;
  String? mobile;
  dynamic isMobileVerified;
  dynamic dateOfBirth;
  dynamic gender;
  String? status;
  String? deviceToken;
  String? loginAt;
  dynamic logoutAt;
  String? name;
  String? email;
  String? supplierId;
  dynamic emailVerifiedAt;
  dynamic twoFactorConfirmedAt;
  dynamic currentTeamId;
  dynamic profilePhotoPath;
  String? createdAt;
  String? updatedAt;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic isFirst;
  String? profilePic;
  dynamic badge;
  dynamic kycStatus;
  dynamic kycRemarks;
  FarmerMaster? farmerMaster;

  User(
      {this.id,
        this.userType,
        this.userCode,
        this.hasPassword,
        this.mobile,
        this.isMobileVerified,
        this.dateOfBirth,
        this.gender,
        this.status,
        this.deviceToken,
        this.loginAt,
        this.logoutAt,
        this.name,
        this.email,
        this.supplierId,
        this.emailVerifiedAt,
        this.twoFactorConfirmedAt,
        this.currentTeamId,
        this.profilePhotoPath,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.isFirst,
        this.profilePic,
        this.badge,
        this.kycStatus,
        this.kycRemarks,
        this.farmerMaster});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    userCode = json['user_code'];
    hasPassword = json['has_password'];
    mobile = json['mobile'];
    isMobileVerified = json['is_mobile_verified'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    status = json['status'];
    deviceToken = json['device_token'];
    loginAt = json['login_at'];
    logoutAt = json['logout_at'];
    name = json['name'];
    email = json['email'];
    supplierId = json['supplier_id'];
    emailVerifiedAt = json['email_verified_at'];
    twoFactorConfirmedAt = json['two_factor_confirmed_at'];
    currentTeamId = json['current_team_id'];
    profilePhotoPath = json['profile_photo_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    isFirst = json['is_first'];
    profilePic = json['profile_pic'];
    badge = json['badge'];
    kycStatus = json['kyc_status'];
    kycRemarks = json['kyc_remarks'];
    farmerMaster = json['farmer_master'] != null
        ? FarmerMaster.fromJson(json['farmer_master'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_type'] = userType;
    data['user_code'] = userCode;
    data['has_password'] = hasPassword;
    data['mobile'] = mobile;
    data['is_mobile_verified'] = isMobileVerified;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['status'] = status;
    data['device_token'] = deviceToken;
    data['login_at'] = loginAt;
    data['logout_at'] = logoutAt;
    data['name'] = name;
    data['email'] = email;
    data['supplier_id'] = supplierId;
    data['email_verified_at'] = emailVerifiedAt;
    data['two_factor_confirmed_at'] = twoFactorConfirmedAt;
    data['current_team_id'] = currentTeamId;
    data['profile_photo_path'] = profilePhotoPath;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['is_first'] = isFirst;
    data['profile_pic'] = profilePic;
    data['badge'] = badge;
    data['kyc_status'] = kycStatus;
    data['kyc_remarks'] = kycRemarks;
    if (farmerMaster != null) {
      data['farmer_master'] = farmerMaster!.toJson();
    }
    return data;
  }
}

class MediaLivestock {
  dynamic id;
  dynamic modelType;
  dynamic modelId;
  dynamic uuid;
  String? collectionName;
  String? name;
  String? fileName;
  String? mimeType;
  String? disk;
  String? conversionsDisk;
  dynamic size;
  dynamic orderColumn;
  String? createdAt;
  String? updatedAt;
  String? fullUrl;
  String? originalUrl;
  String? previewUrl;

  MediaLivestock(
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
        this.orderColumn,
        this.createdAt,
        this.updatedAt,
        this.fullUrl,
        this.originalUrl,
        this.previewUrl});

  MediaLivestock.fromJson(Map<String, dynamic> json) {
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
    fullUrl = json['full_url'];
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
    data['full_url'] = fullUrl;
    data['original_url'] = originalUrl;
    data['preview_url'] = previewUrl;
    return data;
  }
}

