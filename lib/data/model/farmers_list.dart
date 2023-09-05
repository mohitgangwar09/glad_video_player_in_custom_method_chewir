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

  Data({this.farmerMAster});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['farmerMAster'] != null) {
      farmerMAster = <FarmerMAster>[];
      json['farmerMAster'].forEach((v) {
        farmerMAster!.add(FarmerMAster.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (farmerMAster != null) {
      data['farmerMAster'] = farmerMAster!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FarmerMAster {
  int? id;
  int? userId;
  String? name;
  String? email;
  String? address;
  String? phone;
  int? mccId;
  int? ddeId;
  String? photo;
  String? kycStatus;
  String? landlineNo;
  String? dateOfBirth;
  String? gender;
  String? registrationDate;
  dynamic farmSize;
  dynamic dairyArea;
  dynamic staffQuantity;
  String? farmingExperience;
  String? managerName;
  String? managerPhone;
  dynamic ragRating;
  String? leadType;
  dynamic idealYield;
  dynamic currentYield;
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
  dynamic heardSize;
  dynamic milkingCows;
  dynamic dryCows;
  dynamic heiferCows;
  dynamic bullCalfs;
  dynamic yieldPerCow;

  FarmerMAster(
      {this.id,
        this.userId,
        this.name,
        this.email,
        this.address,
        this.phone,
        this.mccId,
        this.ddeId,
        this.photo,
        this.kycStatus,
        this.landlineNo,
        this.dateOfBirth,
        this.gender,
        this.registrationDate,
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
        this.heardSize,
        this.milkingCows,
        this.dryCows,
        this.heiferCows,
        this.bullCalfs,
        this.yieldPerCow});

  FarmerMAster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    phone = json['phone'];
    mccId = json['mcc_id'];
    ddeId = json['dde_id'];
    photo = json['photo'];
    kycStatus = json['kyc_status'];
    landlineNo = json['landline_no'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    registrationDate = json['registration_date'];
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
    heardSize = json['heard_size'];
    milkingCows = json['milking_cows'];
    dryCows = json['dry_cows'];
    heiferCows = json['heifer_cows'];
    bullCalfs = json['bull_calfs'];
    yieldPerCow = double.parse(json['yield_per_cow'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['address'] = address;
    data['phone'] = phone;
    data['mcc_id'] = mccId;
    data['dde_id'] = ddeId;
    data['photo'] = photo;
    data['kyc_status'] = kycStatus;
    data['landline_no'] = landlineNo;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['registration_date'] = registrationDate;
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
    data['heard_size'] = heardSize;
    data['milking_cows'] = milkingCows;
    data['dry_cows'] = dryCows;
    data['heifer_cows'] = heiferCows;
    data['bull_calfs'] = bullCalfs;
    data['yield_per_cow'] = yieldPerCow;
    return data;
  }
}