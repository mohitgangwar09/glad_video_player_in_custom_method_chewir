class FarmerProfileModel {
  String? message;
  int? status;
  Data? data;

  FarmerProfileModel({this.message, this.status, this.data});

  FarmerProfileModel.fromJson(Map<String, dynamic> json) {
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
  Farmer? farmer;
  List<CowBreedDetails>? cowBreedDetails;
  Dde? dde;

  Data({this.farmer, this.cowBreedDetails, this.dde});

  Data.fromJson(Map<String, dynamic> json) {
    farmer =
    json['farmer'] != null ? new Farmer.fromJson(json['farmer']) : null;
    if (json['cowBreedDetails'] != null) {
      cowBreedDetails = <CowBreedDetails>[];
      json['cowBreedDetails'].forEach((v) {
        cowBreedDetails!.add(new CowBreedDetails.fromJson(v));
      });
    }
    dde = json['dde'] != null ? new Dde.fromJson(json['dde']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.farmer != null) {
      data['farmer'] = this.farmer!.toJson();
    }
    if (this.cowBreedDetails != null) {
      data['cowBreedDetails'] =
          this.cowBreedDetails!.map((v) => v.toJson()).toList();
    }
    if (this.dde != null) {
      data['dde'] = this.dde!.toJson();
    }
    return data;
  }
}

class Farmer {
  int? id;
  int? userId;
  String? name;
  String? email;
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

  Farmer(
      {this.id,
        this.userId,
        this.name,
        this.email,
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
        this.updatedBy});

  Farmer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
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
    return data;
  }
}

class CowBreedDetails {
  int? id;
  String? breedName;
  int? heardSize;
  int? milkingCows;
  int? dryCows;
  double? yieldPerCow;
  int? bullCalfs;

  CowBreedDetails(
      {this.id,
        this.breedName,
        this.heardSize,
        this.milkingCows,
        this.dryCows,
        this.yieldPerCow,
        this.bullCalfs});

  CowBreedDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    breedName = json['breed_name'];
    heardSize = json['heard_size'];
    milkingCows = json['milking_cows'];
    dryCows = json['dry_cows'];
    yieldPerCow = json['yield_per_cow'];
    bullCalfs = json['bull_calfs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['breed_name'] = this.breedName;
    data['heard_size'] = this.heardSize;
    data['milking_cows'] = this.milkingCows;
    data['dry_cows'] = this.dryCows;
    data['yield_per_cow'] = this.yieldPerCow;
    data['bull_calfs'] = this.bullCalfs;
    return data;
  }
}

class Dde {
  String? name;
  String? phone;
  String? image;

  Dde({this.name, this.phone, this.image});

  Dde.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['image'] = this.image;
    return data;
  }
}