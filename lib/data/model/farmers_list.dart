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
  int? id;
  int? userId;
  String? name;
  String? email;
  dynamic fAddress;
  String? phone;
  int? mccId;
  int? ddeId;
  String? photo;
  String? kycStatus;
  String? landlineNo;
  String? dateOfBirth;
  String? gender;
  String? registrationDate;
  String? supplierCode;
  int? farmSize;
  int? dairyArea;
  int? staffQuantity;
  dynamic farmingExperience;
  String? managerName;
  String? managerPhone;
  String? ragRating;
  String? leadType;
  int? idealYield;
  int? currentYield;
  String? status;
  int? createdBy;
  int? updatedBy;
  String? projectName;
  String? description;
  String? projectStatus;
  int? investmentAmount;
  int? revenuePerYear;
  int? roiPerYear;
  String? breedName;
  int? herdSize;
  int? milkingCows;
  int? dryCows;
  int? heiferCows;
  int? bullCalfs;
  int? yieldPerCow;
  int? achievement;
  FarmerRagRating? farmerRagRating;

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
        this.projectName,
        this.description,
        this.projectStatus,
        this.investmentAmount,
        this.revenuePerYear,
        this.roiPerYear,
        this.breedName,
        this.herdSize,
        this.milkingCows,
        this.dryCows,
        this.heiferCows,
        this.bullCalfs,
        this.yieldPerCow,
        this.achievement,
        this.farmerRagRating});

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
    projectName = json['project_name'];
    description = json['description'];
    projectStatus = json['project_status'];
    investmentAmount = json['investment_amount'];
    revenuePerYear = json['revenue_per_year'];
    roiPerYear = json['roi_per_year'];
    breedName = json['breed_name'];
    herdSize = json['herd_size'];
    milkingCows = json['milking_cows'];
    dryCows = json['dry_cows'];
    heiferCows = json['heifer_cows'];
    bullCalfs = json['bull_calfs'];
    yieldPerCow = json['yield_per_cow'];
    achievement = json['achievement'];
    farmerRagRating = json['farmer_rag_rating'] != null
        ? FarmerRagRating.fromJson(json['farmer_rag_rating'])
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
    data['project_name'] = projectName;
    data['description'] = description;
    data['project_status'] = projectStatus;
    data['investment_amount'] = investmentAmount;
    data['revenue_per_year'] = revenuePerYear;
    data['roi_per_year'] = roiPerYear;
    data['breed_name'] = breedName;
    data['herd_size'] = herdSize;
    data['milking_cows'] = milkingCows;
    data['dry_cows'] = dryCows;
    data['heifer_cows'] = heiferCows;
    data['bull_calfs'] = bullCalfs;
    data['yield_per_cow'] = yieldPerCow;
    data['achievement'] = achievement;
    if (farmerRagRating != null) {
      data['farmer_rag_rating'] = farmerRagRating!.toJson();
    }
    return data;
  }
}

class FarmerRagRating {
  int? id;
  int? farmerMasterId;
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

class RagRatingCount {
  int? critical;
  int? average;
  int? satisfactory;
  int? mature;

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
