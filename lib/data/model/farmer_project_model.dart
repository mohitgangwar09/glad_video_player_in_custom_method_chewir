class FarmerProjectModel {
  String? message;
  int? status;
  Data? data;

  FarmerProjectModel({this.message, this.status, this.data});

  FarmerProjectModel.fromJson(Map<String, dynamic> json) {
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
  List<ProjectList>? projectList;

  Data({this.projectList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['project_list'] != null) {
      projectList = <ProjectList>[];
      json['project_list'].forEach((v) {
        projectList!.add(ProjectList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (projectList != null) {
      data['project_list'] = projectList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProjectList {
  dynamic id;
  dynamic farmerId;
  dynamic projectId;
  String? name;
  dynamic category;
  String? description;
  String? projectStatus;
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
  dynamic photo;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  FarmerImprovementArea? farmerImprovementArea;

  ProjectList(
      {this.id,
        this.farmerId,
        this.projectId,
        this.name,
        this.category,
        this.description,
        this.projectStatus,
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
        this.farmerImprovementArea});

  ProjectList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    projectId = json['project_id'];
    name = json['name'];
    category = json['category'];
    description = json['description'];
    projectStatus = json['project_status'];
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
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    farmerImprovementArea = json['farmer_improvement_area'] != null
        ? FarmerImprovementArea.fromJson(json['farmer_improvement_area'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['farmer_id'] = farmerId;
    data['project_id'] = projectId;
    data['name'] = name;
    data['category'] = category;
    data['description'] = description;
    data['project_status'] = projectStatus;
    data['suggestion_rank'] = suggestionRank;
    data['initial_yield'] = initialYield;
    data['target_yield'] = targetYield;
    data['investment_amount'] = investmentAmount;
    data['credit_ratio'] = creditRatio;
    data['revenue_per_year'] = revenuePerYear;
    data['roi_per_year'] = roiPerYear;
    data['farmer_participation'] = farmerParticipation;
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
    if (farmerImprovementArea != null) {
      data['farmer_improvement_area'] = farmerImprovementArea!.toJson();
    }
    return data;
  }
}

class FarmerImprovementArea {
  dynamic id;
  dynamic improvementAreaId;
  dynamic farmerId;
  String? parameter;
  String? value;
  dynamic uom;
  dynamic inputType;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  ImprovementArea? improvementArea;

  FarmerImprovementArea(
      {this.id,
        this.improvementAreaId,
        this.farmerId,
        this.parameter,
        this.value,
        this.uom,
        this.inputType,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.improvementArea});

  FarmerImprovementArea.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    improvementAreaId = json['improvement_area_id'];
    farmerId = json['farmer_id'];
    parameter = json['parameter'];
    value = json['value'];
    uom = json['uom'];
    inputType = json['input_type'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    improvementArea = json['improvement_area'] != null
        ? ImprovementArea.fromJson(json['improvement_area'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['improvement_area_id'] = improvementAreaId;
    data['farmer_id'] = farmerId;
    data['parameter'] = parameter;
    data['value'] = value;
    data['uom'] = uom;
    data['input_type'] = inputType;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (improvementArea != null) {
      data['improvement_area'] = improvementArea!.toJson();
    }
    return data;
  }
}

class ImprovementArea {
  dynamic id;
  String? name;
  dynamic image;

  ImprovementArea({this.id, this.name, this.image});

  ImprovementArea.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}
