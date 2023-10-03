class FarmerProfileModel {
  String? message;
  int? status;
  Data? data;

  FarmerProfileModel({this.message, this.status, this.data});

  FarmerProfileModel.fromJson(Map<String, dynamic> json) {
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
  Farmer? farmer;
  DairyDevelopMentExecutive? dairyDevelopMentExecutive;

  Data({this.farmer, this.dairyDevelopMentExecutive});

  Data.fromJson(Map<String, dynamic> json) {
    farmer =
    json['farmer'] != null ? Farmer.fromJson(json['farmer']) : null;
    dairyDevelopMentExecutive = json['dairy_develop_ment_executive'] != null
        ? DairyDevelopMentExecutive.fromJson(
        json['dairy_develop_ment_executive'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (farmer != null) {
      data['farmer'] = farmer!.toJson();
    }
    return data;
  }
}

class Farmer {
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
  dynamic farmSize;
  dynamic dairyArea;
  int? staffQuantity;
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
  dynamic achievement;
  Address? address;
  FarmerRagRating? farmerRagRating;
  List<CowBreedDetails>? cowBreedDetails;

  Farmer(
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
        this.achievement,
        this.address,
        this.farmerRagRating,
        this.cowBreedDetails});

  Farmer.fromJson(Map<String, dynamic> json) {
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
    achievement = json['achievement'];
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
    farmerRagRating = json['farmer_rag_rating'] != null
        ? FarmerRagRating.fromJson(json['farmer_rag_rating'])
        : null;
    if (json['cow_breed_details'] != null) {
      cowBreedDetails = <CowBreedDetails>[];
      json['cow_breed_details'].forEach((v) {
        cowBreedDetails!.add(CowBreedDetails.fromJson(v));
      });
    }
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
    data['achievement'] = achievement;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (farmerRagRating != null) {
      data['farmer_rag_rating'] = farmerRagRating!.toJson();
    }
    if (cowBreedDetails != null) {
      data['cow_breed_details'] =
          cowBreedDetails!.map((v) => v.toJson()).toList();
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
  dynamic email;
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
  double? lattitude;
  double? longitude;
  dynamic stateId;
  dynamic countryId;
  dynamic region;
  dynamic postalCode;
  String? address;
  dynamic type;
  dynamic createdAt;
  String? updatedAt;
  String? fullAddress;
  dynamic city;
  dynamic state;
  dynamic country;
  String? dialCode;

  Address(
      {this.id,
        this.addressableId,
        this.addressableType,
        this.name,
        this.mobile,
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
        this.lattitude,
        this.longitude,
        this.stateId,
        this.countryId,
        this.region,
        this.postalCode,
        this.address,
        this.type,
        this.createdAt,
        this.updatedAt,
        this.fullAddress,
        this.city,
        this.state,
        dialCode,
        this.country});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressableId = json['addressable_id'];
    addressableType = json['addressable_type'];
    name = json['name'];
    mobile = json['mobile'];
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
    lattitude = json['latitude'];
    longitude = json['longitude'];
    stateId = json['state_id'];
    countryId = json['country_id'];
    region = json['region'];
    postalCode = json['postal_code'];
    address = json['address'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullAddress = json['full_address'];
    city = json['city'];
    state = json['state'];
    dialCode = json['dial_code;'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['addressable_id'] = addressableId;
    data['addressable_type'] = addressableType;
    data['name'] = name;
    data['mobile'] = mobile;
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
    data['dial_code'] = dialCode;
    data['po_box_number'] = poBoxNumber;
    data['coordinates'] = coordinates;
    data['latitude'] = lattitude;
    data['longitude'] = longitude;
    data['state_id'] = stateId;
    data['country_id'] = countryId;
    data['region'] = region;
    data['postal_code'] = postalCode;
    data['address'] = address;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['full_address'] = fullAddress;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
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

class CowBreedDetails {
  int? id;
  dynamic cowBreedId;
  String? breedName;
  dynamic herdSize;
  dynamic milkingCows;
  dynamic dryCows;
  dynamic yieldPerCow;
  dynamic bullCalfs;
  dynamic heiferCows;
  dynamic sixMonthCow;
  dynamic sevenToTwelveMonthCows;

  CowBreedDetails(
      {this.id,
        this.cowBreedId,
        this.breedName,
        this.herdSize,
        this.milkingCows,
        this.dryCows,
        this.yieldPerCow,
        this.bullCalfs,
        this.heiferCows,
        this.sixMonthCow,
        this.sevenToTwelveMonthCows});

  CowBreedDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cowBreedId = json['cow_breed_id'];
    breedName = json['breed_name'];
    herdSize = json['herd_size'];
    milkingCows = json['milking_cows'];
    dryCows = json['dry_cows'];
    yieldPerCow = json['yield_per_cow'];
    bullCalfs = json['bull_calfs'];
    heiferCows = json['heifer_cows'];
    sixMonthCow = json['six_month_cow'];
    sevenToTwelveMonthCows = json['seven_to_twelve_month_cows'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cow_breed_id'] = cowBreedId;
    data['breed_name'] = breedName;
    data['herd_size'] = herdSize;
    data['milking_cows'] = milkingCows;
    data['dry_cows'] = dryCows;
    data['yield_per_cow'] = yieldPerCow;
    data['bull_calfs'] = bullCalfs;
    data['heifer_cows'] = heiferCows;
    data['six_month_cow'] = sixMonthCow;
    data['seven_to_twelve_month_cows'] = sevenToTwelveMonthCows;
    return data;
  }
}

class DairyDevelopMentExecutive {
  int? id;
  int? userId;
  String? name;
  dynamic phone;
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
