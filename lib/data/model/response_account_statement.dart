class ResponseAccountStatement {
  String? message;
  int? status;
  DataAccountStatement? data;

  ResponseAccountStatement({this.message, this.status, this.data});

  ResponseAccountStatement.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? DataAccountStatement.fromJson(json['data']) : null;
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

class DataAccountStatement {
  Summary? summary;
  List<FarmerProjectFinancial>? farmerProjectFinancial;

  DataAccountStatement({this.summary, this.farmerProjectFinancial});

  DataAccountStatement.fromJson(Map<String, dynamic> json) {
    summary =
    json['summary'] != null ? Summary.fromJson(json['summary']) : null;
    if (json['farmerProjectFinancial'] != null) {
      farmerProjectFinancial = <FarmerProjectFinancial>[];
      json['farmerProjectFinancial'].forEach((v) {
        farmerProjectFinancial!.add(FarmerProjectFinancial.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (summary != null) {
      data['summary'] = summary!.toJson();
    }
    if (farmerProjectFinancial != null) {
      data['farmerProjectFinancial'] =
          farmerProjectFinancial!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Summary {
  dynamic paidAmount;
  dynamic dueAmount;
  dynamic pendingAmount;
  dynamic totalAmount;

  Summary(
      {this.paidAmount, this.dueAmount, this.pendingAmount, this.totalAmount});

  Summary.fromJson(Map<String, dynamic> json) {
    paidAmount = json['paidAmount'];
    dueAmount = json['dueAmount'];
    pendingAmount = json['pendingAmount'];
    totalAmount = json['totalAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paidAmount'] = paidAmount;
    data['dueAmount'] = dueAmount;
    data['pendingAmount'] = pendingAmount;
    data['totalAmount'] = totalAmount;
    return data;
  }
}

class FarmerProjectFinancial {
  dynamic id;
  dynamic farmerId;
  dynamic farmerProjectId;
  dynamic supplierId;
  dynamic ddeId;
  dynamic farmerMilestoneId;
  dynamic farmerPaymentTermId;
  dynamic partyType;
  dynamic partyName;
  String? particulars;
  dynamic payableAmount;
  dynamic receivableAmount;
  dynamic dueDate;
  dynamic paymentStatus;
  dynamic paymentDate;
  dynamic remarks;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  FarmerProject? farmerProject;
  FarmerMaster? farmerMaster;
  Dde? dde;
  Supplier? supplier;

  FarmerProjectFinancial(
      {this.id,
        this.farmerId,
        this.farmerProjectId,
        this.supplierId,
        this.ddeId,
        this.farmerMilestoneId,
        this.farmerPaymentTermId,
        this.partyType,
        this.partyName,
        this.particulars,
        this.payableAmount,
        this.receivableAmount,
        this.dueDate,
        this.paymentStatus,
        this.paymentDate,
        this.remarks,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.farmerProject,
        this.farmerMaster,
        this.dde,
        this.supplier});

  FarmerProjectFinancial.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    farmerProjectId = json['farmer_project_id'];
    supplierId = json['supplier_id'];
    ddeId = json['dde_id'];
    farmerMilestoneId = json['farmer_milestone_id'];
    farmerPaymentTermId = json['farmer_payment_term_id'];
    partyType = json['party_type'];
    partyName = json['party_name'];
    particulars = json['particulars'];
    payableAmount = json['payable_amount'];
    receivableAmount = json['receivable_amount'];
    dueDate = json['due_date'];
    paymentStatus = json['payment_status'];
    paymentDate = json['payment_date'];
    remarks = json['remarks'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    farmerProject = json['farmer_project'] != null
        ? FarmerProject.fromJson(json['farmer_project'])
        : null;
    farmerMaster = json['farmer_master'] != null
        ? FarmerMaster.fromJson(json['farmer_master'])
        : null;
    dde = json['dde'] != null ? Dde.fromJson(json['dde']) : null;
    supplier = json['supplier'] != null
        ? Supplier.fromJson(json['supplier'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['farmer_id'] = farmerId;
    data['farmer_project_id'] = farmerProjectId;
    data['supplier_id'] = supplierId;
    data['dde_id'] = ddeId;
    data['farmer_milestone_id'] = farmerMilestoneId;
    data['farmer_payment_term_id'] = farmerPaymentTermId;
    data['party_type'] = partyType;
    data['party_name'] = partyName;
    data['particulars'] = particulars;
    data['payable_amount'] = payableAmount;
    data['receivable_amount'] = receivableAmount;
    data['due_date'] = dueDate;
    data['payment_status'] = paymentStatus;
    data['payment_date'] = paymentDate;
    data['remarks'] = remarks;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (farmerProject != null) {
      data['farmer_project'] = farmerProject!.toJson();
    }
    if (farmerMaster != null) {
      data['farmer_master'] = farmerMaster!.toJson();
    }
    if (dde != null) {
      data['dde'] = dde!.toJson();
    }
    if (supplier != null) {
      data['supplier'] = supplier!.toJson();
    }
    return data;
  }
}

class FarmerProject {
  dynamic id;
  dynamic ddeId;
  dynamic mccId;
  dynamic farmerId;
  dynamic projectId;
  String? name;
  dynamic category;
  String? description;
  String? projectStatus;
  String? projectStatusDate;
  String? projectStatusRemarks;
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
  String? repaymentFactor;
  dynamic repaymentStartDays;
  String? repaymentStartDate;
  dynamic photo;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  String? projectFilter;

  FarmerProject(
      {this.id,
        this.ddeId,
        this.mccId,
        this.farmerId,
        this.projectId,
        this.name,
        this.category,
        this.description,
        this.projectStatus,
        this.projectStatusDate,
        this.projectStatusRemarks,
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
        this.repaymentFactor,
        this.repaymentStartDays,
        this.repaymentStartDate,
        this.photo,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.projectFilter});

  FarmerProject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ddeId = json['dde_id'];
    mccId = json['mcc_id'];
    farmerId = json['farmer_id'];
    projectId = json['project_id'];
    name = json['name'];
    category = json['category'];
    description = json['description'];
    projectStatus = json['project_status'];
    projectStatusDate = json['project_status_date'];
    projectStatusRemarks = json['project_status_remarks'];
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
    repaymentFactor = json['repayment_factor'];
    repaymentStartDays = json['repayment_start_days'];
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
    data['mcc_id'] = mccId;
    data['farmer_id'] = farmerId;
    data['project_id'] = projectId;
    data['name'] = name;
    data['category'] = category;
    data['description'] = description;
    data['project_status'] = projectStatus;
    data['project_status_date'] = projectStatusDate;
    data['project_status_remarks'] = projectStatusRemarks;
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
    data['repayment_factor'] = repaymentFactor;
    data['repayment_start_days'] = repaymentStartDays;
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
  dynamic supplierId;
  dynamic farmSize;
  dynamic dairyArea;
  dynamic staffQuantity;
  dynamic farmingExperience;
  String? managerName;
  String? managerPhone;
  dynamic ragRating;
  String? leadType;
  dynamic idealYield;
  dynamic currentYield;
  dynamic status;
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
  int? id;
  int? addressableId;
  String? addressableType;
  String? name;
  String? mobile;
  String? dialCode;
  Null? landlineNo;
  String? email;
  Null? gstNumber;
  String? line1;
  Null? line2;
  Null? landmark;
  int? cityId;
  String? district;
  String? subCounty;
  String? centerName;
  String? village;
  String? parish;
  String? county;
  Null? poBoxNumber;
  Null? coordinates;
  double? latitude;
  double? longitude;
  int? stateId;
  String? country;
  int? countryId;
  String? region;
  int? subCountyId;
  int? countyId;
  int? districtId;
  int? regionId;
  String? postalCode;
  String? address;
  Null? type;
  Null? createdAt;
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

class Dde {
  dynamic id;
  String? name;
  dynamic userId;
  dynamic mccId;
  dynamic latitude;
  dynamic longitude;
  String? phone;
  String? email;
  String? gender;
  String? dob;
  dynamic memberSince;
  dynamic status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  String? photo;

  Dde(
      {this.id,
        this.name,
        this.userId,
        this.mccId,
        this.latitude,
        this.longitude,
        this.phone,
        this.email,
        this.gender,
        this.dob,
        this.memberSince,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.photo});

  Dde.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['user_id'];
    mccId = json['mcc_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    phone = json['phone'];
    email = json['email'];
    gender = json['gender'];
    dob = json['dob'];
    memberSince = json['member_since'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['user_id'] = userId;
    data['mcc_id'] = mccId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['phone'] = phone;
    data['email'] = email;
    data['gender'] = gender;
    data['dob'] = dob;
    data['member_since'] = memberSince;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['photo'] = photo;
    return data;
  }
}

class Supplier {
  dynamic id;
  String? name;
  dynamic userId;
  dynamic mccId;
  String? contactPerson;
  String? phone;
  String? email;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  String? photo;

  Supplier(
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
        this.photo});

  Supplier.fromJson(Map<String, dynamic> json) {
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
    data['photo'] = photo;
    return data;
  }
}
