class ImprovementAreaListModel {
  String? message;
  int? status;
  Data? data;

  ImprovementAreaListModel({this.message, this.status, this.data});

  ImprovementAreaListModel.fromJson(Map<String, dynamic> json) {
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
  List<ImprovementAreaList>? improvementAreaList;

  Data({this.improvementAreaList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['improvement_area_list'] != null) {
      improvementAreaList = <ImprovementAreaList>[];
      json['improvement_area_list'].forEach((v) {
        improvementAreaList!.add(ImprovementAreaList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (improvementAreaList != null) {
      data['improvement_area_list'] =
          improvementAreaList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImprovementAreaList {
  int? id;
  String? name;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic image;
  List<FarmerImprovementArea>? farmerImprovementArea;
  Results? results;
  List<Projects>? projects;

  ImprovementAreaList(
      {this.id,
        this.name,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.image,
        this.farmerImprovementArea,
        this.results,
        this.projects});

  ImprovementAreaList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    if (json['farmer_improvement_area'] != null) {
      farmerImprovementArea = <FarmerImprovementArea>[];
      json['farmer_improvement_area'].forEach((v) {
        farmerImprovementArea!.add(FarmerImprovementArea.fromJson(v));
      });
    }
    results =
    json['results'] != null ? Results.fromJson(json['results']) : null;
    if (json['projects'] != null) {
      projects = <Projects>[];
      json['projects'].forEach((v) {
        projects!.add(Projects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['image'] = image;
    if (farmerImprovementArea != null) {
      data['farmer_improvement_area'] =
          farmerImprovementArea!.map((v) => v.toJson()).toList();
    }
    if (results != null) {
      data['results'] = results!.toJson();
    }
    if (projects != null) {
      data['projects'] = projects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FarmerImprovementArea {
  int? id;
  int? improvementAreaId;
  int? farmerId;
  dynamic parameter;
  dynamic value;
  dynamic uom;
  String? inputType;
  dynamic impAreaParamId;
  List<String>? dropdownValues;

  FarmerImprovementArea(
      {this.id,
        this.improvementAreaId,
        this.farmerId,
        this.parameter,
        this.value,
        this.uom,
        this.inputType,
        this.impAreaParamId,
        this.dropdownValues,
      });

  FarmerImprovementArea.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    improvementAreaId = json['improvement_area_id'];
    farmerId = json['farmer_id'];
    parameter = json['parameter'];
    value = json['value'];
    uom = json['uom'];
    inputType = json['input_type'];
    impAreaParamId = json['imp_area_param_id'];
    dropdownValues = json['dropdown_values'].cast<String>();
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
    data['imp_area_param_id'] = impAreaParamId;
    data['dropdown_values'] = dropdownValues;
    return data;
  }
}

class Results {
  dynamic lossOfMilkPerCow;
  dynamic totalDistanceTravelled;
  dynamic suggestedPastureArea;
  dynamic expectedYieldPerCow;
  dynamic incrementalProduction;
  dynamic incrementalEarning;

  Results(
      {this.lossOfMilkPerCow,
        this.totalDistanceTravelled,
        this.suggestedPastureArea,
        this.expectedYieldPerCow,
        this.incrementalProduction,
        this.incrementalEarning});

  Results.fromJson(Map<String, dynamic> json) {
    lossOfMilkPerCow = json['lossOfMilkPerCow'];
    totalDistanceTravelled = json['totalDistanceTravelled'];
    suggestedPastureArea = json['suggestedPastureArea'];
    expectedYieldPerCow = json['expectedYieldPerCow'];
    incrementalProduction = json['incrementalProduction'];
    incrementalEarning = json['incrementalEarning'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lossOfMilkPerCow'] = lossOfMilkPerCow;
    data['totalDistanceTravelled'] = totalDistanceTravelled;
    data['suggestedPastureArea'] = suggestedPastureArea;
    data['expectedYieldPerCow'] = expectedYieldPerCow;
    data['incrementalProduction'] = incrementalProduction;
    data['incrementalEarning'] = incrementalEarning;
    return data;
  }
}

class Projects {
  int? id;
  int? ddeId;
  int? farmerId;
  int? projectId;
  String? name;
  dynamic category;
  String? description;
  dynamic projectStatus;
  dynamic suggestionRank;
  dynamic milkPrice;
  dynamic milkSupply6months;
  dynamic milkSupply6monthsValue;
  dynamic initialYield;
  dynamic targetYield;
  dynamic investmentAmount;
  dynamic creditRatio;
  dynamic revenuePerMonth;
  dynamic revenuePerYear;
  dynamic roiPerYear;
  dynamic farmerParticipationPercentage;
  dynamic farmerParticipation;
  dynamic gladCommisionPercentage;
  dynamic gladCommisionAmount;
  dynamic ddeCommisionPercentage;
  dynamic ddeCommisionAmount;
  dynamic loanAmount;
  dynamic maxRepaymentMonths;
  dynamic repaymentMonths;
  dynamic emiAmount;
  dynamic incrementalProduction;
  dynamic repaymentStartDate;
  dynamic photo;
  dynamic status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  String? projectFilter;

  Projects(
      {this.id,
        this.ddeId,
        this.farmerId,
        this.projectId,
        this.name,
        this.category,
        this.description,
        this.projectStatus,
        this.suggestionRank,
        this.milkPrice,
        this.milkSupply6months,
        this.milkSupply6monthsValue,
        this.initialYield,
        this.targetYield,
        this.investmentAmount,
        this.creditRatio,
        this.revenuePerMonth,
        this.revenuePerYear,
        this.roiPerYear,
        this.farmerParticipationPercentage,
        this.farmerParticipation,
        this.gladCommisionPercentage,
        this.gladCommisionAmount,
        this.ddeCommisionPercentage,
        this.ddeCommisionAmount,
        this.loanAmount,
        this.maxRepaymentMonths,
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
        this.projectFilter});

  Projects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ddeId = json['dde_id'];
    farmerId = json['farmer_id'];
    projectId = json['project_id'];
    name = json['name'];
    category = json['category'];
    description = json['description'];
    projectStatus = json['project_status'];
    suggestionRank = json['suggestion_rank'];
    milkPrice = json['milk_price'];
    milkSupply6months = json['milk_supply_6months'];
    milkSupply6monthsValue = json['milk_supply_6months_value'];
    initialYield = json['initial_yield'];
    targetYield = json['target_yield'];
    investmentAmount = json['investment_amount'];
    creditRatio = json['credit_ratio'];
    revenuePerMonth = json['revenue_per_month'];
    revenuePerYear = json['revenue_per_year'];
    roiPerYear = json['roi_per_year'];
    farmerParticipationPercentage = json['farmer_participation_percentage'];
    farmerParticipation = json['farmer_participation'];
    gladCommisionPercentage = json['glad_commision_percentage'];
    gladCommisionAmount = json['glad_commision_amount'];
    ddeCommisionPercentage = json['dde_commision_percentage'];
    ddeCommisionAmount = json['dde_commision_amount'];
    loanAmount = json['loan_amount'];
    maxRepaymentMonths = json['max_repayment_months'];
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
    projectFilter = json['project_filter'];
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
    data['milk_price'] = milkPrice;
    data['milk_supply_6months'] = milkSupply6months;
    data['milk_supply_6months_value'] = milkSupply6monthsValue;
    data['initial_yield'] = initialYield;
    data['target_yield'] = targetYield;
    data['investment_amount'] = investmentAmount;
    data['credit_ratio'] = creditRatio;
    data['revenue_per_month'] = revenuePerMonth;
    data['revenue_per_year'] = revenuePerYear;
    data['roi_per_year'] = roiPerYear;
    data['farmer_participation_percentage'] =
        farmerParticipationPercentage;
    data['farmer_participation'] = farmerParticipation;
    data['glad_commision_percentage'] = gladCommisionPercentage;
    data['glad_commision_amount'] = gladCommisionAmount;
    data['dde_commision_percentage'] = ddeCommisionPercentage;
    data['dde_commision_amount'] = ddeCommisionAmount;
    data['loan_amount'] = loanAmount;
    data['max_repayment_months'] = maxRepaymentMonths;
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
    data['project_filter'] = projectFilter;
    return data;
  }
}
