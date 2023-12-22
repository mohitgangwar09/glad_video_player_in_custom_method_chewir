class SupplierProjectModel {
  String? message;
  int? status;
  Data? data;

  SupplierProjectModel({this.message, this.status, this.data});

  SupplierProjectModel.fromJson(Map<String, dynamic> json) {
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
  dynamic ddeId;
  dynamic mccId;
  dynamic farmerId;
  dynamic projectId;
  String? name;
  dynamic category;
  String? description;
  String? projectStatus;
  dynamic rejectStatus;
  String? rejectRemarks;
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
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  String? projectFilter;
  Project? project;
  FarmerMaster? farmerMaster;
  ImprovementArea? improvementArea;
  List<FarmerProjectSurvey>? farmerProjectSurvey;
  List<FarmerProjectMilestones>? farmerProjectMilestones;

  ProjectList(
      {this.id,
        this.ddeId,
        this.mccId,
        this.farmerId,
        this.projectId,
        this.name,
        this.category,
        this.description,
        this.projectStatus,
        this.rejectStatus,
        this.rejectRemarks,
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
        this.projectFilter,
        this.project,
        this.farmerMaster,
        this.improvementArea,
        this.farmerProjectSurvey,
        this.farmerProjectMilestones});

  ProjectList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ddeId = json['dde_id'];
    mccId = json['mcc_id'];
    farmerId = json['farmer_id'];
    projectId = json['project_id'];
    name = json['name'];
    category = json['category'];
    description = json['description'];
    projectStatus = json['project_status'];
    rejectStatus = json['reject_status'];
    rejectRemarks = json['reject_remarks'];
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
    if (json['farmer_project_milestones'] != null) {
      farmerProjectMilestones = <FarmerProjectMilestones>[];
      json['farmer_project_milestones'].forEach((v) {
        farmerProjectMilestones!.add(new FarmerProjectMilestones.fromJson(v));
      });
    }
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    projectFilter = json['project_filter'];
    project =
    json['project'] != null ? Project.fromJson(json['project']) : null;
    farmerMaster = json['farmer_master'] != null
        ? FarmerMaster.fromJson(json['farmer_master'])
        : null;
    improvementArea = json['improvement_area'] != null
        ? ImprovementArea.fromJson(json['improvement_area'])
        : null;
    if (json['farmer_project_survey'] != null) {
      farmerProjectSurvey = <FarmerProjectSurvey>[];
      json['farmer_project_survey'].forEach((v) {
        farmerProjectSurvey!.add(FarmerProjectSurvey.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['dde_id'] = ddeId;
    data['mcc_id'] = mccId;
    data['farmer_id'] = farmerId;
    data['project_id'] = projectId;
    data['name'] = name;
    data['category'] = category;
    data['description'] = description;
    data['project_status'] = projectStatus;
    data['reject_status'] = rejectStatus;
    data['reject_remarks'] = rejectRemarks;
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
    if (project != null) {
      data['project'] = project!.toJson();
    }
    if (farmerMaster != null) {
      data['farmer_master'] = farmerMaster!.toJson();
    }
    if (farmerProjectSurvey != null) {
      data['farmer_project_survey'] =
          farmerProjectSurvey!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FarmerProjectMilestones {
  dynamic id;
  dynamic farmerId;
  dynamic farmerProjectId;
  dynamic projectId;
  dynamic projectMilestoneId;
  String? milestoneTitle;
  String? milestoneDescription;
  dynamic milestoneDuration;
  dynamic milestoneValue;
  String? milestoneStatus;
  dynamic milestoneDueDate;
  dynamic approvalDate;
  dynamic approvalRemarks;
  String? status;
  dynamic notRequired;
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
        this.projectId,
        this.projectMilestoneId,
        this.milestoneTitle,
        this.milestoneDescription,
        this.milestoneDuration,
        this.milestoneValue,
        this.milestoneStatus,
        this.milestoneDueDate,
        this.approvalDate,
        this.approvalRemarks,
        this.status,
        this.notRequired,
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
    projectId = json['project_id'];
    projectMilestoneId = json['project_milestone_id'];
    milestoneTitle = json['milestone_title'];
    milestoneDescription = json['milestone_description'];
    milestoneDuration = json['milestone_duration'];
    milestoneValue = json['milestone_value'];
    milestoneStatus = json['milestone_status'];
    milestoneDueDate = json['milestone_due_date'];
    approvalDate = json['approval_date'];
    approvalRemarks = json['approval_remarks'];
    status = json['status'];
    notRequired = json['not_required'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    farmerProjectTaskCount = json['farmer_project_task_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['farmer_id'] = this.farmerId;
    data['farmer_project_id'] = this.farmerProjectId;
    data['project_id'] = this.projectId;
    data['project_milestone_id'] = this.projectMilestoneId;
    data['milestone_title'] = this.milestoneTitle;
    data['milestone_description'] = this.milestoneDescription;
    data['milestone_duration'] = this.milestoneDuration;
    data['milestone_value'] = this.milestoneValue;
    data['milestone_status'] = this.milestoneStatus;
    data['milestone_due_date'] = this.milestoneDueDate;
    data['approval_date'] = this.approvalDate;
    data['approval_remarks'] = this.approvalRemarks;
    data['status'] = this.status;
    data['not_required'] = this.notRequired;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_by'] = this.deletedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['farmer_project_task_count'] = this.farmerProjectTaskCount;
    return data;
  }
}


class Project {
  dynamic id;
  dynamic projectUomId;
  String? name;
  dynamic photo;
  String? description;
  String? categoryId;
  String? surveyDays;
  dynamic repaymentStartDate;
  String? advancePayment;
  String? mode;
  String? status;
  String? type;
  String? perUnitOf;
  String? factor;
  String? projectSize;
  String? gladCommissionPerc;
  String? ddeCommissionPerc;
  String? farmerPartPerc;
  dynamic minRepayMonths;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  String? image;

  Project(
      {this.id,
        this.projectUomId,
        this.name,
        this.photo,
        this.description,
        this.categoryId,
        this.surveyDays,
        this.repaymentStartDate,
        this.advancePayment,
        this.mode,
        this.status,
        this.type,
        this.perUnitOf,
        this.factor,
        this.projectSize,
        this.gladCommissionPerc,
        this.ddeCommissionPerc,
        this.farmerPartPerc,
        this.minRepayMonths,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.image});

  Project.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectUomId = json['project_uom_id'];
    name = json['name'];
    photo = json['photo'];
    description = json['description'];
    categoryId = json['category_id'];
    surveyDays = json['survey_days'];
    repaymentStartDate = json['repayment_start_date'];
    advancePayment = json['advance_payment'];
    mode = json['mode'];
    status = json['status'];
    type = json['type'];
    perUnitOf = json['per_unit_of'];
    factor = json['factor'];
    projectSize = json['project_size'];
    gladCommissionPerc = json['glad_commission_perc'];
    ddeCommissionPerc = json['dde_commission_perc'];
    farmerPartPerc = json['farmer_part_perc'];
    minRepayMonths = json['min_repay_months'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['project_uom_id'] = projectUomId;
    data['name'] = name;
    data['photo'] = photo;
    data['description'] = description;
    data['category_id'] = categoryId;
    data['survey_days'] = surveyDays;
    data['repayment_start_date'] = repaymentStartDate;
    data['advance_payment'] = advancePayment;
    data['mode'] = mode;
    data['status'] = status;
    data['type'] = type;
    data['per_unit_of'] = perUnitOf;
    data['factor'] = factor;
    data['project_size'] = projectSize;
    data['glad_commission_perc'] = gladCommissionPerc;
    data['dde_commission_perc'] = ddeCommissionPerc;
    data['farmer_part_perc'] = farmerPartPerc;
    data['min_repay_months'] = minRepayMonths;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['image'] = image;
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
  String? photos;
  String? kycStatus;
  String? landlineNo;
  String? dateOfBirth;
  String? gender;
  String? registrationDate;
  String? supplierId;
  dynamic farmSize;
  dynamic dairyArea;
  dynamic staffQuantity;
  String? farmingExperience;
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
  Address? address;

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
        this.address});

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
  String? dialCode;
  dynamic landlineNo;
  String? email;
  dynamic gstNumber;
  String? line1;
  dynamic line2;
  dynamic landmark;
  dynamic cityId;
  String? district;
  String? subCounty;
  String? centerName;
  String? village;
  String? parish;
  String? county;
  dynamic poBoxNumber;
  dynamic coordinates;
  dynamic latitude;
  dynamic longitude;
  dynamic stateId;
  String? country;
  dynamic countryId;
  String? region;
  dynamic subCountyId;
  dynamic countyId;
  dynamic districtId;
  dynamic regionId;
  String? postalCode;
  String? address;
  dynamic type;
  dynamic createdAt;
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
        this.subCountyId,
        this.countyId,
        this.districtId,
        this.regionId,
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
    subCountyId = json['sub_county_id'];
    countyId = json['county_id'];
    districtId = json['district_id'];
    regionId = json['region_id'];
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
    data['sub_county_id'] = subCountyId;
    data['county_id'] = countyId;
    data['district_id'] = districtId;
    data['region_id'] = regionId;
    data['postal_code'] = postalCode;
    data['address'] = address;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['full_address'] = fullAddress;
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

class FarmerProjectSurvey {
  dynamic id;
  dynamic farmerId;
  dynamic farmerProjectId;
  dynamic supplierId;
  String? projectSurveyDays;
  dynamic investmentAmount;
  String? surveySubmitDate;
  String? surveyCompletionDate;
  String? surveyStatus;
  String? surveyRemarks;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;

  FarmerProjectSurvey(
      {this.id,
        this.farmerId,
        this.farmerProjectId,
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
