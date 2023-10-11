class FarmerProjectDetailModel {
  String? message;
  int? status;
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

  Data({this.farmerProject});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['farmer-project'] != null) {
      farmerProject = <FarmerProject>[];
      json['farmer-project'].forEach((v) {
        farmerProject!.add(FarmerProject.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (farmerProject != null) {
      data['farmer-project'] =
          farmerProject!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FarmerProject {
  dynamic id;
  dynamic ddeId;
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
  List<FarmerProjectMilestones>? farmerProjectMilestones;
  DairyDevelopMentExecutive? dairyDevelopMentExecutive;
  Kpi? kpi;

  FarmerProject(
      {this.id,
        this.ddeId,
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
        this.farmerProjectMilestones,
        this.dairyDevelopMentExecutive,
        this.kpi,
      });

  FarmerProject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ddeId = json['dde_id'];
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
    kpi = json['kpi'] != null ? Kpi.fromJson(json['kpi']) : null;
    if (json['farmer_project_milestones'] != null) {
      farmerProjectMilestones = <FarmerProjectMilestones>[];
      json['farmer_project_milestones'].forEach((v) {
        farmerProjectMilestones!.add(FarmerProjectMilestones.fromJson(v));
      });
    }
    dairyDevelopMentExecutive = json['dairy_develop_ment_executive'] != null
        ? DairyDevelopMentExecutive.fromJson(
        json['dairy_develop_ment_executive'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['dde_id'] = ddeId;
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
  dynamic completionDate;
  dynamic approvalDate;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  dynamic farmerProjectTaskCount;

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
        this.farmerProjectTaskCount});

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
    farmerProjectTaskCount = json['farmer_project_task_count'];
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

class DairyDevelopMentExecutive {
  dynamic id;
  dynamic userId;
  String? name;
  String? phone;
  dynamic image;
  dynamic address;

  DairyDevelopMentExecutive(
      {this.id, this.userId, this.name, this.phone, this.image, this.address});

  DairyDevelopMentExecutive.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    phone = json['phone'];
    image = json['image'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['phone'] = phone;
    data['image'] = image;
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
  dynamic emi;
  dynamic currentYield;
  dynamic expectedYield;
  dynamic idealYield;
  dynamic targetFarmProduction;

  Kpi(
      {this.investment,
        this.revenue,
        this.roi,
        this.farmerParticipation,
        this.loan,
        this.repayment,
        this.emi,
        this.currentYield,
        this.expectedYield,
        this.idealYield,
        this.targetFarmProduction});

  Kpi.fromJson(Map<String, dynamic> json) {
    investment = json['investment'];
    revenue = json['revenue'];
    roi = json['roi'];
    farmerParticipation = json['farmer_participation'];
    loan = json['loan'];
    repayment = json['repayment'];
    emi = json['emi'];
    currentYield = json['current_yield'];
    expectedYield = json['expected_yield'];
    idealYield = json['ideal_yield'];
    targetFarmProduction = json['target_farm_production'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['investment'] = investment;
    data['revenue'] = revenue;
    data['roi'] = roi;
    data['farmer_participation'] = farmerParticipation;
    data['loan'] = loan;
    data['repayment'] = repayment;
    data['emi'] = emi;
    data['current_yield'] = currentYield;
    data['expected_yield'] = expectedYield;
    data['ideal_yield'] = idealYield;
    data['target_farm_production'] = targetFarmProduction;
    return data;
  }
}
