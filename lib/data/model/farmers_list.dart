class FarmersList {
  String? message;
  int? status;
  Data? data;

  FarmersList({this.message, this.status, this.data});

  FarmersList.fromJson(Map<String, dynamic> json) {
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
  List<FarmerMAster>? farmerMAster;
  RagRatingCount? ragRatingCount;

  Data({this.farmerMAster, this.ragRatingCount});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['farmerMAster'] != null) {
      farmerMAster = <FarmerMAster>[];
      json['farmerMAster'].forEach((v) {
        farmerMAster!.add(FarmerMAster.fromJson(v));
      });
    }
    ragRatingCount = json['rag_rating_count'] != null
        ? RagRatingCount.fromJson(json['rag_rating_count'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (farmerMAster != null) {
      data['farmerMAster'] = farmerMAster!.map((v) => v.toJson()).toList();
    }
    if (ragRatingCount != null) {
      data['rag_rating_count'] = ragRatingCount!.toJson();
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
  String? farmingExperience;
  String? managerName;
  String? managerPhone;
  String? ragRating;
  String? leadType;
  dynamic idealYield;
  dynamic currentYield;
  dynamic farmerRating;
  dynamic farmerRatingCount;
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
  Address? address;
  List<FarmerMilkProduction>? farmerMilkProduction;
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
        this.farmerMilkProduction,
        this.farmerRagRating,
        this.farmerProject,
        this.address,
        this.farmerRating,
        this.farmerRatingCount,
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
    farmerRating = json['farmer_rating'];
    farmerRatingCount = json['framer_rating_count'];
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
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
    if (json['farmer_milk_production'] != null) {
      farmerMilkProduction = <FarmerMilkProduction>[];
      json['farmer_milk_production'].forEach((v) {
        farmerMilkProduction!.add(FarmerMilkProduction.fromJson(v));
      });
    }
    farmerRagRating = json['farmer_rag_rating'] != null
        ? FarmerRagRating.fromJson(json['farmer_rag_rating'])
        : null;
    if (json['farmer_project'] != null) {
      farmerProject = <FarmerProject>[];
      json['farmer_project'].forEach((v) {
        farmerProject!.add(FarmerProject.fromJson(v));
      });
    }
    farmerImprovementArea = json['farmer_improvement_area'] != null
        ? FarmerImprovementArea.fromJson(json['farmer_improvement_area'])
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
    data['photo'] = photo;
    data['kyc_status'] = kycStatus;
    data['landline_no'] = landlineNo;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['registration_date'] = registrationDate;
    data['supplier_code'] = supplierCode;
    data['farm_size'] = farmSize;
    data['framer_rating_count'] = farmerRatingCount;
    data['framer_rating'] = farmerRating;
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
    data['breed_name'] = breedName;
    data['herd_size'] = herdSize;
    data['milking_cows'] = milkingCows;
    data['dry_cows'] = dryCows;
    data['heifer_cows'] = heiferCows;
    data['bull_calfs'] = bullCalfs;
    data['yield_per_cow'] = yieldPerCow;
    data['achievement'] = achievement;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (farmerMilkProduction != null) {
      data['farmer_milk_production'] =
          farmerMilkProduction!.map((v) => v.toJson()).toList();
    }
    if (farmerRagRating != null) {
      data['farmer_rag_rating'] = farmerRagRating!.toJson();
    }
    if (farmerProject != null) {
      data['farmer_project'] =
          farmerProject!.map((v) => v.toJson()).toList();
    }
    if (farmerImprovementArea != null) {
      data['farmer_improvement_area'] = farmerImprovementArea!.toJson();
    }
    return data;
  }
}

class FarmerMilkProduction {
  dynamic id;
  dynamic farmerId;
  String? date;
  String? month;
  dynamic totalMilkProduction;
  dynamic milkingCow;
  dynamic suppliedToPdfl;
  dynamic suppliedToOthers;
  dynamic selfUse;
  dynamic yieldPerCow;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;

  FarmerMilkProduction(
      {this.id,
        this.farmerId,
        this.date,
        this.month,
        this.totalMilkProduction,
        this.milkingCow,
        this.suppliedToPdfl,
        this.suppliedToOthers,
        this.selfUse,
        this.yieldPerCow,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt});

  FarmerMilkProduction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    date = json['date'];
    month = json['month'];
    totalMilkProduction = json['total_milk_production'];
    milkingCow = json['milking_cow'];
    suppliedToPdfl = json['supplied_to_pdfl'];
    suppliedToOthers = json['supplied_to_others'];
    selfUse = json['self_use'];
    yieldPerCow = json['yield_per_cow'];
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
    data['date'] = date;
    data['month'] = month;
    data['total_milk_production'] = totalMilkProduction;
    data['milking_cow'] = milkingCow;
    data['supplied_to_pdfl'] = suppliedToPdfl;
    data['supplied_to_others'] = suppliedToOthers;
    data['self_use'] = selfUse;
    data['yield_per_cow'] = yieldPerCow;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['farmer_master_id'] = farmerMasterId;
    data['rag_rating'] = ragRating;
    data['ratio'] = ratio;
    data['achievement'] = achievement;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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
        this.updatedAt});

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['critical'] = critical;
    data['average'] = average;
    data['satisfactory'] = satisfactory;
    data['mature'] = mature;
    return data;
  }
}
