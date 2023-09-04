class FarmersList {
  String? message;
  int? status;
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

  Data({this.farmerMAster});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['farmerMAster'] != null) {
      farmerMAster = <FarmerMAster>[];
      json['farmerMAster'].forEach((v) {
        farmerMAster!.add(new FarmerMAster.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.farmerMAster != null) {
      data['farmerMAster'] = this.farmerMAster!.map((v) => v.toJson()).toList();
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
  int? farmSize;
  int? dairyArea;
  int? staffQuantity;
  String? farmingExperience;
  String? managerName;
  String? managerPhone;
  Null? ragRating;
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
  int? heardSize;
  int? milkingCows;
  int? dryCows;
  int? heiferCows;
  int? bullCalfs;
  double? yieldPerCow;

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
    yieldPerCow = json['yield_per_cow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['mcc_id'] = this.mccId;
    data['dde_id'] = this.ddeId;
    data['photo'] = this.photo;
    data['kyc_status'] = this.kycStatus;
    data['landline_no'] = this.landlineNo;
    data['date_of_birth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['registration_date'] = this.registrationDate;
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
    data['project_name'] = this.projectName;
    data['description'] = this.description;
    data['project_status'] = this.projectStatus;
    data['investment_amount'] = this.investmentAmount;
    data['revenue_per_year'] = this.revenuePerYear;
    data['roi_per_year'] = this.roiPerYear;
    data['breed_name'] = this.breedName;
    data['heard_size'] = this.heardSize;
    data['milking_cows'] = this.milkingCows;
    data['dry_cows'] = this.dryCows;
    data['heifer_cows'] = this.heiferCows;
    data['bull_calfs'] = this.bullCalfs;
    data['yield_per_cow'] = this.yieldPerCow;
    return data;
  }
}