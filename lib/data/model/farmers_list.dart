class FarmersList {
  String? message;
  dynamic status;
  Data? data;

  FarmersList({this.message, this.status, this.data});

  FarmersList.fromJson(Map<String, dynamic> json) {
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
  List<FarmerMAster>? farmerMAster;
  RagRatingCount? ragRatingCount;

  Data({this.farmerMAster, this.ragRatingCount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['farmerMAster'] != null) {
      farmerMAster = <FarmerMAster>[];
      json['farmerMAster'].forEach((v) {
        farmerMAster!.add(new FarmerMAster.fromJson(v));
      });
    }
    ragRatingCount = json['rag_rating_count'] != null
        ? new RagRatingCount.fromJson(json['rag_rating_count'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.farmerMAster != null) {
      data['farmerMAster'] = this.farmerMAster!.map((v) => v.toJson()).toList();
    }
    if (this.ragRatingCount != null) {
      data['rag_rating_count'] = this.ragRatingCount!.toJson();
    }
    return data;
  }
}

class FarmerMAster {
  dynamic id;
  dynamic userId;
  String? name;
  String? email;
  dynamic fAddress;
  String? phone;
  dynamic mccId;
  dynamic ddeId;
  String? photo;
  String? kycStatus;
  String? landlineNo;
  String? dateOfBirth;
  String? gender;
  String? registrationDate;
  String? supplierCode;
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
  String? breedName;
  dynamic herdSize;
  dynamic milkingCows;
  dynamic dryCows;
  dynamic heiferCows;
  dynamic bullCalfs;
  dynamic yieldPerCow;
  dynamic achievement;
  FarmerRagRating? farmerRagRating;
  List<FarmerProject>? farmerProject;
  FarmerImprovementArea? farmerImprovementArea;

  FarmerMAster(
      {this.id,
        this.userId,
        this.name,
        this.email,
        this.fAddress,
        this.phone,
        this.mccId,
        this.ddeId,
        this.photo,
        this.kycStatus,
        this.landlineNo,
        this.dateOfBirth,
        this.gender,
        this.registrationDate,
        this.supplierCode,
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
        this.breedName,
        this.herdSize,
        this.milkingCows,
        this.dryCows,
        this.heiferCows,
        this.bullCalfs,
        this.yieldPerCow,
        this.achievement,
        this.farmerRagRating,
        this.farmerProject,
        this.farmerImprovementArea});

  FarmerMAster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    fAddress = json['f_address'];
    phone = json['phone'];
    mccId = json['mcc_id'];
    ddeId = json['dde_id'];
    photo = json['photo'];
    kycStatus = json['kyc_status'];
    landlineNo = json['landline_no'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    registrationDate = json['registration_date'];
    supplierCode = json['supplier_code'];
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
    breedName = json['breed_name'];
    herdSize = json['herd_size'];
    milkingCows = json['milking_cows'];
    dryCows = json['dry_cows'];
    heiferCows = json['heifer_cows'];
    bullCalfs = json['bull_calfs'];
    yieldPerCow = json['yield_per_cow'];
    achievement = json['achievement'];
    farmerRagRating = json['farmer_rag_rating'] != null
        ? new FarmerRagRating.fromJson(json['farmer_rag_rating'])
        : null;
    if (json['farmer_project'] != null) {
      farmerProject = <FarmerProject>[];
      json['farmer_project'].forEach((v) {
        farmerProject!.add(new FarmerProject.fromJson(v));
      });
    }
    farmerImprovementArea = json['farmer_improvement_area'] != null
        ? new FarmerImprovementArea.fromJson(json['farmer_improvement_area'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['f_address'] = this.fAddress;
    data['phone'] = this.phone;
    data['mcc_id'] = this.mccId;
    data['dde_id'] = this.ddeId;
    data['photo'] = this.photo;
    data['kyc_status'] = this.kycStatus;
    data['landline_no'] = this.landlineNo;
    data['date_of_birth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['registration_date'] = this.registrationDate;
    data['supplier_code'] = this.supplierCode;
    data['farm_size'] = this.farmSize;
    data['dairy_area'] = this.dairyArea;
    data['staff_quantity'] = this.staffQuantity;
    data['farming_experience'] = this.farmingExperience;
    data['manager_name'] = this.managerName;
    data['manager_phone'] = this.managerPhone;
    data['rag_rating'] = this.ragRating;
    data['lead_type'] = this.leadType;
    data['ideal_yield'] = this.idealYield;
    data['current_yield'] = this.currentYield;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['breed_name'] = this.breedName;
    data['herd_size'] = this.herdSize;
    data['milking_cows'] = this.milkingCows;
    data['dry_cows'] = this.dryCows;
    data['heifer_cows'] = this.heiferCows;
    data['bull_calfs'] = this.bullCalfs;
    data['yield_per_cow'] = this.yieldPerCow;
    data['achievement'] = this.achievement;
    if (this.farmerRagRating != null) {
      data['farmer_rag_rating'] = this.farmerRagRating!.toJson();
    }
    if (this.farmerProject != null) {
      data['farmer_project'] =
          this.farmerProject!.map((v) => v.toJson()).toList();
    }
    if (this.farmerImprovementArea != null) {
      data['farmer_improvement_area'] = this.farmerImprovementArea!.toJson();
    }
    return data;
  }
}

class FarmerRagRating {
  dynamic id;
  dynamic farmerMasterId;
  String? ragRating;
  String? ratio;
  String? achievement;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  dynamic updatedAt;

  FarmerRagRating(
      {this.id,
        this.farmerMasterId,
        this.ragRating,
        this.ratio,
        this.achievement,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt});

  FarmerRagRating.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerMasterId = json['farmer_master_id'];
    ragRating = json['rag_rating'];
    ratio = json['ratio'];
    achievement = json['achievement'];
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
    data['farmer_master_id'] = this.farmerMasterId;
    data['rag_rating'] = this.ragRating;
    data['ratio'] = this.ratio;
    data['achievement'] = this.achievement;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_by'] = this.deletedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class FarmerProject {
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

  FarmerProject(
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
        this.updatedAt});

  FarmerProject.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['farmer_id'] = this.farmerId;
    data['project_id'] = this.projectId;
    data['name'] = this.name;
    data['category'] = this.category;
    data['description'] = this.description;
    data['project_status'] = this.projectStatus;
    data['suggestion_rank'] = this.suggestionRank;
    data['initial_yield'] = this.initialYield;
    data['target_yield'] = this.targetYield;
    data['investment_amount'] = this.investmentAmount;
    data['credit_ratio'] = this.creditRatio;
    data['revenue_per_year'] = this.revenuePerYear;
    data['roi_per_year'] = this.roiPerYear;
    data['farmer_participation'] = this.farmerParticipation;
    data['glad_commision_percentage'] = this.gladCommisionPercentage;
    data['glad_commision_amount'] = this.gladCommisionAmount;
    data['dde_commision_percentage'] = this.ddeCommisionPercentage;
    data['dde_commision_amount'] = this.ddeCommisionAmount;
    data['loan_amount'] = this.loanAmount;
    data['repayment_months'] = this.repaymentMonths;
    data['emi_amount'] = this.emiAmount;
    data['incremental_production'] = this.incrementalProduction;
    data['repayment_start_date'] = this.repaymentStartDate;
    data['photo'] = this.photo;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_by'] = this.deletedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
        this.updatedAt});

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['improvement_area_id'] = this.improvementAreaId;
    data['farmer_id'] = this.farmerId;
    data['parameter'] = this.parameter;
    data['value'] = this.value;
    data['uom'] = this.uom;
    data['input_type'] = this.inputType;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_by'] = this.deletedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class RagRatingCount {
  dynamic critical;
  dynamic average;
  dynamic satisfactory;
  dynamic mature;

  RagRatingCount({this.critical, this.average, this.satisfactory, this.mature});

  RagRatingCount.fromJson(Map<String, dynamic> json) {
    critical = json['critical'];
    average = json['average'];
    satisfactory = json['satisfactory'];
    mature = json['mature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['critical'] = this.critical;
    data['average'] = this.average;
    data['satisfactory'] = this.satisfactory;
    data['mature'] = this.mature;
    return data;
  }
}
