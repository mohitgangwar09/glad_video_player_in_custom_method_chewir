import 'package:glad/data/model/dashboard_community.dart';
import 'package:glad/data/model/dashboard_news_event.dart';
import 'package:glad/data/model/dashboard_training.dart';

class FarmerDashboard {
  String? message;
  int? status;
  Data? data;

  FarmerDashboard({this.message, this.status, this.data});

  FarmerDashboard.fromJson(Map<String, dynamic> json) {
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
  Dde? dde;
  Mcc? mcc;
  User? user;
  List<Testimonials>? testimonials;
  List<FarmerProject>? farmerProject;
  CowBreedDetails? cowBreedDetails;
  List<FarmerMilkProduction>? farmerMilkProduction;
  FarmerCowDetail? farmerCowDetail;
  List<TopPerformerFarmer>? topPerformerFarmer;
  List<NewsEvent>? newsEvent;
  List<TrainingList>? trainingList;
  List<Community>? community;
  TodayMilkPrice? todayMilkPrice;


  Data(
      {this.dde,
        this.mcc,
        this.user,
        this.testimonials,
        this.farmerProject,
        this.cowBreedDetails,
        this.farmerMilkProduction,
        this.farmerCowDetail,
        this.topPerformerFarmer,
        this.newsEvent,
        this.trainingList,
        this.community,
        this.todayMilkPrice,
      });

  Data.fromJson(Map<String, dynamic> json) {
    dde = json['dde'] != null ? Dde.fromJson(json['dde']) : null;
    mcc = json['mcc'] != null ? Mcc.fromJson(json['mcc']) : null;
    todayMilkPrice = json['today_milk_price'] != null ? TodayMilkPrice.fromJson(json['today_milk_price']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['testimonials'] != null) {
      testimonials = <Testimonials>[];
      json['testimonials'].forEach((v) {
        testimonials!.add(Testimonials.fromJson(v));
      });
    }
    if (json['farmerProject'] != null) {
      farmerProject = <FarmerProject>[];
      json['farmerProject'].forEach((v) {
        farmerProject!.add(FarmerProject.fromJson(v));
      });
    }
    cowBreedDetails = json['cowBreedDetails'] != null
        ? CowBreedDetails.fromJson(json['cowBreedDetails'])
        : null;
    if (json['farmerMilkProduction'] != null) {
      farmerMilkProduction = <FarmerMilkProduction>[];
      json['farmerMilkProduction'].forEach((v) {
        farmerMilkProduction!.add(FarmerMilkProduction.fromJson(v));
      });
    }
    farmerCowDetail = json['farmerCowDetail'] != null
        ? FarmerCowDetail.fromJson(json['farmerCowDetail'])
        : null;
    if (json['topPerformerFarmer'] != null) {
      topPerformerFarmer = <TopPerformerFarmer>[];
      json['topPerformerFarmer'].forEach((v) {
        topPerformerFarmer!.add(TopPerformerFarmer.fromJson(v));
      });
    }
    if (json['newsEvent'] != null) {
      newsEvent = <NewsEvent>[];
      json['newsEvent'].forEach((v) {
        newsEvent!.add(NewsEvent.fromJson(v));
      });
    }
    if (json['trainingList'] != null) {
      trainingList = <TrainingList>[];
      json['trainingList'].forEach((v) {
        trainingList!.add(TrainingList.fromJson(v));
      });
    }
    if (json['community'] != null) {
      community = <Community>[];
      json['community'].forEach((v) {
        community!.add(Community.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dde != null) {
      data['dde'] = dde!.toJson();
    }
    if (mcc != null) {
      data['mcc'] = mcc!.toJson();
    }
    if (todayMilkPrice != null) {
      data['today_milk_price'] = todayMilkPrice!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (testimonials != null) {
      data['testimonials'] = testimonials!.map((v) => v.toJson()).toList();
    }
    if (farmerProject != null) {
      data['farmerProject'] =
          farmerProject!.map((v) => v.toJson()).toList();
    }
    if (cowBreedDetails != null) {
      data['cowBreedDetails'] = cowBreedDetails!.toJson();
    }
    if (farmerMilkProduction != null) {
      data['farmerMilkProduction'] =
          farmerMilkProduction!.map((v) => v.toJson()).toList();
    }
    if (farmerCowDetail != null) {
      data['farmerCowDetail'] = farmerCowDetail!.toJson();
    }
    if (topPerformerFarmer != null) {
      data['topPerformerFarmer'] =
          topPerformerFarmer!.map((v) => v.toJson()).toList();
    }
    if (newsEvent != null) {
      data['newsEvent'] = newsEvent!.map((v) => v.toJson()).toList();
    }
    if (trainingList != null) {
      data['trainingList'] = trainingList!.map((v) => v.toJson()).toList();
    }
    if (community != null) {
      data['community'] = community!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dde {
  dynamic id;
  dynamic userId;
  String? name;
  String? phone;
  String? photo;

  Dde({this.id, this.userId, this.name, this.phone, this.photo});

  Dde.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    phone = json['phone'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['phone'] = phone;
    data['photo'] = photo;
    return data;
  }
}

class Mcc {
  dynamic id;
  String? name;
  dynamic userId;
  String? contactPerson;
  String? phone;
  String? landlineNo;
  String? email;
  String? type;
  dynamic serviceRadius;
  String? status;
  String? createdAt;
  String? updatedAt;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? image;
  Address? address;

  Mcc(
      {this.id,
        this.name,
        this.userId,
        this.contactPerson,
        this.phone,
        this.landlineNo,
        this.email,
        this.type,
        this.serviceRadius,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.image,
        this.address});

  Mcc.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['user_id'];
    contactPerson = json['contact_person'];
    phone = json['phone'];
    landlineNo = json['landline_no'];
    email = json['email'];
    type = json['type'];
    serviceRadius = json['service_radius'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    image = json['image'];
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['user_id'] = userId;
    data['contact_person'] = contactPerson;
    data['phone'] = phone;
    data['landline_no'] = landlineNo;
    data['email'] = email;
    data['type'] = type;
    data['service_radius'] = serviceRadius;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['image'] = image;
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
  dynamic dialCode;
  dynamic landlineNo;
  String? email;
  dynamic gstNumber;
  String? line1;
  dynamic line2;
  dynamic landmark;
  dynamic cityId;
  String? district;
  String? subCounty;
  dynamic centerName;
  dynamic village;
  dynamic parish;
  String? county;
  dynamic poBoxNumber;
  dynamic coordinates;
  dynamic latitude;
  dynamic longitude;
  dynamic stateId;
  dynamic country;
  dynamic countryId;
  String? region;
  String? postalCode;
  String? address;
  dynamic type;
  String? createdAt;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['addressable_id'] = this.addressableId;
    data['addressable_type'] = this.addressableType;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['dial_code'] = this.dialCode;
    data['landline_no'] = this.landlineNo;
    data['email'] = this.email;
    data['gst_number'] = this.gstNumber;
    data['line_1'] = this.line1;
    data['line_2'] = this.line2;
    data['landmark'] = this.landmark;
    data['city_id'] = this.cityId;
    data['district'] = this.district;
    data['sub_county'] = this.subCounty;
    data['center_name'] = this.centerName;
    data['village'] = this.village;
    data['parish'] = this.parish;
    data['county'] = this.county;
    data['po_box_number'] = this.poBoxNumber;
    data['coordinates'] = this.coordinates;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['state_id'] = this.stateId;
    data['country'] = this.country;
    data['country_id'] = this.countryId;
    data['region'] = this.region;
    data['postal_code'] = this.postalCode;
    data['address'] = this.address;
    data['type'] = this.type;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['full_address'] = this.fullAddress;
    return data;
  }
}


class User {
  dynamic id;
  String? userType;
  dynamic userCode;
  dynamic hasPassword;
  String? mobile;
  dynamic isMobileVerified;
  dynamic dateOfBirth;
  dynamic gender;
  String? status;
  String? deviceToken;
  dynamic loginAt;
  dynamic logoutAt;
  String? name;
  String? email;
  String? supplierId;
  dynamic emailVerifiedAt;
  dynamic twoFactorConfirmedAt;
  dynamic currentTeamId;
  dynamic profilePhotoPath;
  String? createdAt;
  String? updatedAt;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic isFirst;
  String? profilePic;
  FarmerMaster? farmerMaster;

  User(
      {this.id,
        this.userType,
        this.userCode,
        this.hasPassword,
        this.mobile,
        this.isMobileVerified,
        this.dateOfBirth,
        this.gender,
        this.status,
        this.deviceToken,
        this.loginAt,
        this.logoutAt,
        this.name,
        this.email,
        this.supplierId,
        this.emailVerifiedAt,
        this.twoFactorConfirmedAt,
        this.currentTeamId,
        this.profilePhotoPath,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.isFirst,
        this.profilePic,
        this.farmerMaster});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    userCode = json['user_code'];
    hasPassword = json['has_password'];
    mobile = json['mobile'];
    isMobileVerified = json['is_mobile_verified'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    status = json['status'];
    deviceToken = json['device_token'];
    loginAt = json['login_at'];
    logoutAt = json['logout_at'];
    name = json['name'];
    email = json['email'];
    supplierId = json['supplier_id'];
    emailVerifiedAt = json['email_verified_at'];
    twoFactorConfirmedAt = json['two_factor_confirmed_at'];
    currentTeamId = json['current_team_id'];
    profilePhotoPath = json['profile_photo_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    isFirst = json['is_first'];
    profilePic = json['profile_pic'];
    farmerMaster = json['farmer_master'] != null
        ? FarmerMaster.fromJson(json['farmer_master'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_type'] = userType;
    data['user_code'] = userCode;
    data['has_password'] = hasPassword;
    data['mobile'] = mobile;
    data['is_mobile_verified'] = isMobileVerified;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['status'] = status;
    data['device_token'] = deviceToken;
    data['login_at'] = loginAt;
    data['logout_at'] = logoutAt;
    data['name'] = name;
    data['email'] = email;
    data['supplier_id'] = supplierId;
    data['email_verified_at'] = emailVerifiedAt;
    data['two_factor_confirmed_at'] = twoFactorConfirmedAt;
    data['current_team_id'] = currentTeamId;
    data['profile_photo_path'] = profilePhotoPath;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['is_first'] = isFirst;
    data['profile_pic'] = profilePic;
    if (farmerMaster != null) {
      data['farmer_master'] = farmerMaster!.toJson();
    }
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
        this.achievement});

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
    return data;
  }
}

class Testimonials {
  dynamic id;
  dynamic userId;
  String? description;
  String? attachment;
  String? type;
  String? status;
  dynamic featured;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  String? name;

  Testimonials(
      {this.id,
        this.userId,
        this.description,
        this.attachment,
        this.type,
        this.status,
        this.featured,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.name});

  Testimonials.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    description = json['description'];
    attachment = json['attachment'];
    type = json['type'];
    status = json['status'];
    featured = json['featured'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['description'] = description;
    data['attachment'] = attachment;
    data['type'] = type;
    data['status'] = status;
    data['featured'] = featured;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['name'] = name;
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
  String? projectSubStatus;
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
  String? repaymentStartDate;
  dynamic photo;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  String? categoeryName;
  String? projectFilter;
  FarmerImprovementArea? farmerImprovementArea;
  dynamic project;

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
        this.projectSubStatus,
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
        this.categoeryName,
        this.projectFilter,
        this.farmerImprovementArea,
        this.project});

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
    projectSubStatus = json['project_sub_status'];
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
    categoeryName = json['categoery_name'];
    projectFilter = json['project_filter'];
    project = json["project"];
    farmerImprovementArea = json['farmer_improvement_area'] != null
        ? FarmerImprovementArea.fromJson(json['farmer_improvement_area'])
        : null;
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
    data['project_sub_status'] = projectSubStatus;
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
    data['categoery_name'] = categoeryName;
    data['project_filter'] = projectFilter;
    return data;
  }
}

class CowBreedDetails {
  dynamic id;
  dynamic farmerId;
  dynamic cowBreedId;
  String? year;
  String? month;
  String? date;
  String? breedName;
  dynamic herdSize;
  dynamic milkingCows;
  dynamic dryCows;
  dynamic heiferCows;
  dynamic sevenToTwelveMonthCows;
  dynamic sixMonthCow;
  dynamic bullCalfs;
  dynamic yieldPerCow;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;

  CowBreedDetails(
      {this.id,
        this.farmerId,
        this.cowBreedId,
        this.year,
        this.month,
        this.date,
        this.breedName,
        this.herdSize,
        this.milkingCows,
        this.dryCows,
        this.heiferCows,
        this.sevenToTwelveMonthCows,
        this.sixMonthCow,
        this.bullCalfs,
        this.yieldPerCow,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt});

  CowBreedDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    cowBreedId = json['cow_breed_id'];
    year = json['year'];
    month = json['month'];
    date = json['date'];
    breedName = json['breed_name'];
    herdSize = json['herd_size'];
    milkingCows = json['milking_cows'];
    dryCows = json['dry_cows'];
    heiferCows = json['heifer_cows'];
    sevenToTwelveMonthCows = json['seven_to_twelve_month_cows'];
    sixMonthCow = json['six_month_cow'];
    bullCalfs = json['bull_calfs'];
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
    data['cow_breed_id'] = cowBreedId;
    data['year'] = year;
    data['month'] = month;
    data['date'] = date;
    data['breed_name'] = breedName;
    data['herd_size'] = herdSize;
    data['milking_cows'] = milkingCows;
    data['dry_cows'] = dryCows;
    data['heifer_cows'] = heiferCows;
    data['seven_to_twelve_month_cows'] = sevenToTwelveMonthCows;
    data['six_month_cow'] = sixMonthCow;
    data['bull_calfs'] = bullCalfs;
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

class FarmerMilkProduction {
  dynamic totalMilkProduction;
  dynamic suppliedToPdfl;
  dynamic suppliedToOthers;
  dynamic selfUse;

  FarmerMilkProduction(
      {this.totalMilkProduction,
        this.suppliedToPdfl,
        this.suppliedToOthers,
        this.selfUse});

  FarmerMilkProduction.fromJson(Map<String, dynamic> json) {
    totalMilkProduction = json['total_milk_production'];
    suppliedToPdfl = json['supplied_to_pdfl'];
    suppliedToOthers = json['supplied_to_others'];
    selfUse = json['self_use'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_milk_production'] = totalMilkProduction;
    data['supplied_to_pdfl'] = suppliedToPdfl;
    data['supplied_to_others'] = suppliedToOthers;
    data['self_use'] = selfUse;
    return data;
  }
}

class FarmerCowDetail {
  dynamic milkingCow;
  dynamic yieldPerCow;

  FarmerCowDetail({this.milkingCow, this.yieldPerCow});

  FarmerCowDetail.fromJson(Map<String, dynamic> json) {
    milkingCow = json['milking_cow'];
    yieldPerCow = json['yield_per_cow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['milking_cow'] = milkingCow;
    data['yield_per_cow'] = yieldPerCow;
    return data;
  }
}

class TopPerformerFarmer {
  dynamic id;
  dynamic userId;
  String? name;
  String? email;
  String? fAddress;
  String? phone;
  dynamic mccId;
  dynamic ddeId;
  dynamic photos;
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
  List<CowBreedDetails>? cowBreedDetails;
  FarmerImprovementArea? farmerImprovementArea;

  TopPerformerFarmer(
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
        this.cowBreedDetails,
        this.farmerImprovementArea});

  TopPerformerFarmer.fromJson(Map<String, dynamic> json) {
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
    if (json['cow_breed_details'] != null) {
      cowBreedDetails = <CowBreedDetails>[];
      json['cow_breed_details'].forEach((v) {
        cowBreedDetails!.add(CowBreedDetails.fromJson(v));
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
    if (cowBreedDetails != null) {
      data['cow_breed_details'] =
          cowBreedDetails!.map((v) => v.toJson()).toList();
    }
    if (farmerImprovementArea != null) {
      data['farmer_improvement_area'] = farmerImprovementArea!.toJson();
    }
    return data;
  }
}

class FarmerImprovementArea {
  dynamic id;
  dynamic improvementAreaId;
  dynamic impAreaParamId;
  dynamic farmerId;
  String? parameter;
  String? value;
  dynamic uom;
  String? inputType;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  List<Null>? dropdownValues;
  ImprovementArea? improvementArea;

  FarmerImprovementArea(
      {this.id,
        this.improvementAreaId,
        this.impAreaParamId,
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
        this.updatedAt,
        this.dropdownValues,
        this.improvementArea});

  FarmerImprovementArea.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    improvementAreaId = json['improvement_area_id'];
    impAreaParamId = json['imp_area_param_id'];
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
    // if (json['dropdown_values'] != null) {
    //   dropdownValues = <Null>[];
    //   json['dropdown_values'].forEach((v) {
    //     dropdownValues!.add(new Null.fromJson(v));
    //   });
    // }
    improvementArea = json['improvement_area'] != null
        ? ImprovementArea.fromJson(json['improvement_area'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['improvement_area_id'] = improvementAreaId;
    data['imp_area_param_id'] = impAreaParamId;
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
    // if (this.dropdownValues != null) {
    //   data['dropdown_values'] =
    //       this.dropdownValues!.map((v) => v.toJson()).toList();
    // }
    if (improvementArea != null) {
      data['improvement_area'] = improvementArea!.toJson();
    }
    return data;
  }
}

class ImprovementArea {
  dynamic id;
  String? name;
  dynamic image;

  ImprovementArea({this.id, this.name, this.image});

  ImprovementArea.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}

class TodayMilkPrice {
  int? id;
  String? date;
  dynamic countryId;
  dynamic regionId;
  dynamic milkPrice;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic createdAt;
  dynamic updatedAt;

  TodayMilkPrice(
      {this.id,
        this.date,
        this.countryId,
        this.regionId,
        this.milkPrice,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt});

  TodayMilkPrice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    countryId = json['country_id'];
    regionId = json['region_id'];
    milkPrice = json['milk_price'];
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
    data['date'] = date;
    data['country_id'] = countryId;
    data['region_id'] = regionId;
    data['milk_price'] = milkPrice;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

// class FarmerDashboard {
//   String? message;
//   dynamic status;
//   Data? data;
//
//   FarmerDashboard({this.message, this.status, this.data});
//
//   FarmerDashboard.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     status = json['status'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['message'] = message;
//     data['status'] = status;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   Dde? dde;
//   Mcc? mcc;
//   User? user;
//   List<Testimonials>? testimonials;
//   List<FarmerProject>? farmerProject;
//   List<CowBreedDetails>? cowBreedDetails;
//   List<FarmerMilkProduction>? farmerMilkProduction;
//   List<TopPerformerFarmer>? topPerformerFarmer;
//
//   Data(
//       {this.dde,
//         this.mcc,
//         this.user,
//         this.testimonials,
//         this.farmerProject,
//         this.cowBreedDetails,
//         this.farmerMilkProduction,
//         this.topPerformerFarmer});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     dde = json['dde'] != null ? Dde.fromJson(json['dde']) : null;
//     mcc = json['mcc'] != null ? Mcc.fromJson(json['mcc']) : null;
//     user = json['user'] != null
//         ? User.fromJson(json['user'])
//         : null;
//     if (json['testimonials'] != null) {
//       testimonials = <Testimonials>[];
//       json['testimonials'].forEach((v) {
//         testimonials!.add(Testimonials.fromJson(v));
//       });
//     }
//     if (json['farmerProject'] != null) {
//       farmerProject = <FarmerProject>[];
//       json['farmerProject'].forEach((v) {
//         farmerProject!.add(FarmerProject.fromJson(v));
//       });
//     }
//     if (json['cow_breed_details'] != null) {
//       cowBreedDetails = <CowBreedDetails>[];
//       json['cow_breed_details'].forEach((v) {
//         cowBreedDetails!.add(CowBreedDetails.fromJson(v));
//       });
//     }
//     if (json['farmerMilkProduction'] != null) {
//       farmerMilkProduction = <FarmerMilkProduction>[];
//       json['farmerMilkProduction'].forEach((v) {
//         farmerMilkProduction!.add(FarmerMilkProduction.fromJson(v));
//       });
//     }
//     if (json['topPerformerFarmer'] != null) {
//       topPerformerFarmer = <TopPerformerFarmer>[];
//       json['topPerformerFarmer'].forEach((v) {
//         topPerformerFarmer!.add(TopPerformerFarmer.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (dde != null) {
//       data['dde'] = dde!.toJson();
//     }
//     if (mcc != null) {
//       data['mcc'] = mcc!.toJson();
//     }
//     if (user != null) {
//       data['user'] = user!.toJson();
//     }
//     if (testimonials != null) {
//       data['testimonials'] = testimonials!.map((v) => v.toJson()).toList();
//     }
//     if (farmerProject != null) {
//       data['farmerProject'] =
//           farmerProject!.map((v) => v.toJson()).toList();
//     }
//     if (farmerMilkProduction != null) {
//       data['farmerMilkProduction'] =
//           farmerMilkProduction!.map((v) => v.toJson()).toList();
//     }
//     if (topPerformerFarmer != null) {
//       data['topPerformerFarmer'] =
//           topPerformerFarmer!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Dde {
//   dynamic id;
//   dynamic userId;
//   String? name;
//   dynamic phone;
//   dynamic image;
//
//   Dde({this.id, this.userId, this.name, this.phone, this.image});
//
//   Dde.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     name = json['name'];
//     phone = json['phone'];
//     image = json['image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['user_id'] = userId;
//     data['name'] = name;
//     data['phone'] = phone;
//     data['image'] = image;
//     return data;
//   }
// }
//
// class Mcc {
//   dynamic id;
//   String? name;
//   String? email;
//   dynamic phone;
//   dynamic address;
//   dynamic image;
//
//   Mcc({this.id, this.name, this.email, this.phone, this.address, this.image});
//
//   Mcc.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     phone = json['phone'];
//     address = json['address'];
//     image = json['image'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['email'] = email;
//     data['phone'] = phone;
//     data['address'] = address;
//     data['image'] = image;
//     return data;
//   }
// }
//
// class User {
//   dynamic id;
//   dynamic userId;
//   String? name;
//   String? email;
//   dynamic fAddress;
//   String? phone;
//   dynamic mccId;
//   dynamic ddeId;
//   String? photo;
//   String? profilePic;
//   String? kycStatus;
//   String? landlineNo;
//   String? dateOfBirth;
//   String? gender;
//   String? registrationDate;
//   dynamic farmSize;
//   dynamic dairyArea;
//   dynamic staffQuantity;
//   String? farmingExperience;
//   String? managerName;
//   String? managerPhone;
//   dynamic ragRating;
//   String? leadType;
//   dynamic idealYield;
//   dynamic currentYield;
//   String? status;
//   dynamic createdBy;
//   dynamic updatedBy;
//   dynamic supplierCode;
//
//   User(
//       {this.id,
//         this.userId,
//         this.name,
//         this.email,
//         this.fAddress,
//         this.phone,
//         this.mccId,
//         this.ddeId,
//         this.photo,
//         this.profilePic,
//         this.kycStatus,
//         this.landlineNo,
//         this.dateOfBirth,
//         this.gender,
//         this.registrationDate,
//         this.farmSize,
//         this.dairyArea,
//         this.staffQuantity,
//         this.farmingExperience,
//         this.managerName,
//         this.managerPhone,
//         this.ragRating,
//         this.leadType,
//         this.idealYield,
//         this.currentYield,
//         this.status,
//         this.createdBy,
//         this.updatedBy,
//       this.supplierCode});
//
//   User.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     name = json['name'];
//     email = json['email'];
//     fAddress = json['f_address'];
//     phone = json['phone'];
//     mccId = json['mcc_id'];
//     ddeId = json['dde_id'];
//     photo = json['photo'];
//     profilePic = json['profile_pic'];
//     kycStatus = json['kyc_status'];
//     landlineNo = json['landline_no'];
//     dateOfBirth = json['date_of_birth'];
//     gender = json['gender'];
//     registrationDate = json['registration_date'];
//     farmSize = json['farm_size'];
//     dairyArea = json['dairy_area'];
//     staffQuantity = json['staff_quantity'];
//     farmingExperience = json['farming_experience'];
//     managerName = json['manager_name'];
//     managerPhone = json['manager_phone'];
//     ragRating = json['rag_rating'];
//     leadType = json['lead_type'];
//     idealYield = json['ideal_yield'];
//     currentYield = json['current_yield'];
//     status = json['status'];
//     createdBy = json['created_by'];
//     updatedBy = json['updated_by'];
//     supplierCode = json['supplier_code'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['user_id'] = userId;
//     data['name'] = name;
//     data['email'] = email;
//     data['f_address'] = fAddress;
//     data['phone'] = phone;
//     data['mcc_id'] = mccId;
//     data['dde_id'] = ddeId;
//     data['photo'] = photo;
//     data['profile_pic'] = profilePic;
//     data['kyc_status'] = kycStatus;
//     data['landline_no'] = landlineNo;
//     data['date_of_birth'] = dateOfBirth;
//     data['gender'] = gender;
//     data['registration_date'] = registrationDate;
//     data['farm_size'] = farmSize;
//     data['dairy_area'] = dairyArea;
//     data['staff_quantity'] = staffQuantity;
//     data['farming_experience'] = farmingExperience;
//     data['manager_name'] = managerName;
//     data['manager_phone'] = managerPhone;
//     data['rag_rating'] = ragRating;
//     data['lead_type'] = leadType;
//     data['ideal_yield'] = idealYield;
//     data['current_yield'] = currentYield;
//     data['status'] = status;
//     data['created_by'] = createdBy;
//     data['updated_by'] = updatedBy;
//     return data;
//   }
// }
//
// class Testimonials {
//   dynamic id;
//   dynamic userId;
//   String? description;
//   String? attachment;
//   String? type;
//   String? status;
//   dynamic featured;
//   dynamic createdBy;
//   dynamic updatedBy;
//   dynamic deletedBy;
//   String? createdAt;
//   String? updatedAt;
//   String? name;
//
//   Testimonials(
//       {this.id,
//         this.userId,
//         this.description,
//         this.attachment,
//         this.type,
//         this.status,
//         this.featured,
//         this.createdBy,
//         this.updatedBy,
//         this.deletedBy,
//         this.createdAt,
//         this.updatedAt,
//         this.name});
//
//   Testimonials.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     description = json['description'];
//     attachment = json['attachment'];
//     type = json['type'];
//     status = json['status'];
//     featured = json['featured'];
//     createdBy = json['created_by'];
//     updatedBy = json['updated_by'];
//     deletedBy = json['deleted_by'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     name = json['name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['user_id'] = userId;
//     data['description'] = description;
//     data['attachment'] = attachment;
//     data['type'] = type;
//     data['status'] = status;
//     data['featured'] = featured;
//     data['created_by'] = createdBy;
//     data['updated_by'] = updatedBy;
//     data['deleted_by'] = deletedBy;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     data['name'] = name;
//     return data;
//   }
// }
//
// class FarmerProject {
//   dynamic id;
//   String? name;
//   String? description;
//   String? projectStatus;
//   dynamic initialYield;
//   dynamic targetYield;
//   dynamic investmentAmount;
//   dynamic revenuePerYear;
//   dynamic roiPerYear;
//   dynamic category;
//   dynamic incrementalProduction;
//   dynamic photo;
//   String? categoeryName;
//
//   FarmerProject(
//       {this.id,
//         this.name,
//         this.description,
//         this.projectStatus,
//         this.initialYield,
//         this.targetYield,
//         this.investmentAmount,
//         this.revenuePerYear,
//         this.roiPerYear,
//         this.category,
//         this.incrementalProduction,
//         this.photo,
//         this.categoeryName});
//
//   FarmerProject.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     description = json['description'];
//     projectStatus = json['project_status'];
//     initialYield = json['initial_yield'];
//     targetYield = json['target_yield'];
//     investmentAmount = json['investment_amount'];
//     revenuePerYear = json['revenue_per_year'];
//     roiPerYear = json['roi_per_year'];
//     category = json['category'];
//     incrementalProduction = json['incremental_production'];
//     photo = json['photo'];
//     categoeryName = json['categoery_name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['description'] = description;
//     data['project_status'] = projectStatus;
//     data['initial_yield'] = initialYield;
//     data['target_yield'] = targetYield;
//     data['investment_amount'] = investmentAmount;
//     data['revenue_per_year'] = revenuePerYear;
//     data['roi_per_year'] = roiPerYear;
//     data['category'] = category;
//     data['incremental_production'] = incrementalProduction;
//     data['photo'] = photo;
//     data['categoery_name'] = categoeryName;
//     return data;
//   }
// }
//
// class CowBreedDetails {
//   dynamic id;
//   dynamic cowBreedId;
//   String? breedName;
//   dynamic herdSize;
//   dynamic milkingCows;
//   dynamic dryCows;
//   dynamic yieldPerCow;
//   dynamic bullCalfs;
//   dynamic heiferCows;
//   dynamic sixMonthCow;
//   dynamic sevenToTwelveMonthCows;
//
//   CowBreedDetails(
//       {this.id,
//         this.cowBreedId,
//         this.breedName,
//         this.herdSize,
//         this.milkingCows,
//         this.dryCows,
//         this.yieldPerCow,
//         this.bullCalfs,
//         this.heiferCows,
//         this.sixMonthCow,
//         this.sevenToTwelveMonthCows});
//
//   CowBreedDetails.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     cowBreedId = json['cow_breed_id'];
//     breedName = json['breed_name'];
//     herdSize = json['herd_size'];
//     milkingCows = json['milking_cows'];
//     dryCows = json['dry_cows'];
//     yieldPerCow = json['yield_per_cow'];
//     bullCalfs = json['bull_calfs'];
//     heiferCows = json['heifer_cows'];
//     sixMonthCow = json['six_month_cow'];
//     sevenToTwelveMonthCows = json['seven_to_twelve_month_cows'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['cow_breed_id'] = cowBreedId;
//     data['breed_name'] = breedName;
//     data['herd_size'] = herdSize;
//     data['milking_cows'] = milkingCows;
//     data['dry_cows'] = dryCows;
//     data['yield_per_cow'] = yieldPerCow;
//     data['bull_calfs'] = bullCalfs;
//     data['heifer_cows'] = heiferCows;
//     data['six_month_cow'] = sixMonthCow;
//     data['seven_to_twelve_month_cows'] = sevenToTwelveMonthCows;
//     return data;
//   }
// }
//
// class FarmerMilkProduction {
//   dynamic id;
//   dynamic userId;
//   String? name;
//   String? email;
//   dynamic fAddress;
//   String? phone;
//   dynamic mccId;
//   dynamic ddeId;
//   String? photo;
//   String? kycStatus;
//   String? landlineNo;
//   String? dateOfBirth;
//   String? gender;
//   String? registrationDate;
//   dynamic farmSize;
//   dynamic dairyArea;
//   dynamic staffQuantity;
//   String? farmingExperience;
//   String? managerName;
//   String? managerPhone;
//   dynamic ragRating;
//   String? leadType;
//   dynamic idealYield;
//   dynamic currentYield;
//   String? status;
//   dynamic createdBy;
//   dynamic updatedBy;
//   dynamic farmerId;
//   String? date;
//   dynamic totalMilkProduction;
//   dynamic milkingCow;
//   dynamic suppliedToPdfl;
//   dynamic suppliedToOthers;
//   dynamic selfUse;
//   dynamic yieldPerCow;
//   dynamic cowBreedId;
//   String? year;
//   String? month;
//   String? breedName;
//   dynamic heardSize;
//   dynamic milkingCows;
//   dynamic dryCows;
//   dynamic heiferCows;
//   dynamic sevenToTwelveMonthCows;
//   dynamic sixMonthCow;
//   dynamic bullCalfs;
//
//   FarmerMilkProduction(
//       {this.id,
//         this.userId,
//         this.name,
//         this.email,
//         this.fAddress,
//         this.phone,
//         this.mccId,
//         this.ddeId,
//         this.photo,
//         this.kycStatus,
//         this.landlineNo,
//         this.dateOfBirth,
//         this.gender,
//         this.registrationDate,
//         this.farmSize,
//         this.dairyArea,
//         this.staffQuantity,
//         this.farmingExperience,
//         this.managerName,
//         this.managerPhone,
//         this.ragRating,
//         this.leadType,
//         this.idealYield,
//         this.currentYield,
//         this.status,
//         this.createdBy,
//         this.updatedBy,
//         this.farmerId,
//         this.date,
//         this.totalMilkProduction,
//         this.milkingCow,
//         this.suppliedToPdfl,
//         this.suppliedToOthers,
//         this.selfUse,
//         this.yieldPerCow,
//         this.cowBreedId,
//         this.year,
//         this.month,
//         this.breedName,
//         this.heardSize,
//         this.milkingCows,
//         this.dryCows,
//         this.heiferCows,
//         this.sevenToTwelveMonthCows,
//         this.sixMonthCow,
//         this.bullCalfs});
//
//   FarmerMilkProduction.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     name = json['name'];
//     email = json['email'];
//     fAddress = json['f_address'];
//     phone = json['phone'];
//     mccId = json['mcc_id'];
//     ddeId = json['dde_id'];
//     photo = json['photo'];
//     kycStatus = json['kyc_status'];
//     landlineNo = json['landline_no'];
//     dateOfBirth = json['date_of_birth'];
//     gender = json['gender'];
//     registrationDate = json['registration_date'];
//     farmSize = json['farm_size'];
//     dairyArea = json['dairy_area'];
//     staffQuantity = json['staff_quantity'];
//     farmingExperience = json['farming_experience'];
//     managerName = json['manager_name'];
//     managerPhone = json['manager_phone'];
//     ragRating = json['rag_rating'];
//     leadType = json['lead_type'];
//     idealYield = json['ideal_yield'];
//     currentYield = json['current_yield'];
//     status = json['status'];
//     createdBy = json['created_by'];
//     updatedBy = json['updated_by'];
//     farmerId = json['farmer_id'];
//     date = json['date'];
//     totalMilkProduction = json['total_milk_production'];
//     milkingCow = json['milking_cow'];
//     suppliedToPdfl = json['supplied_to_pdfl'];
//     suppliedToOthers = json['supplied_to_others'];
//     selfUse = json['self_use'];
//     yieldPerCow = json['yield_per_cow'];
//     cowBreedId = json['cow_breed_id'];
//     year = json['year'];
//     month = json['month'];
//     breedName = json['breed_name'];
//     heardSize = json['heard_size'];
//     milkingCows = json['milking_cows'];
//     dryCows = json['dry_cows'];
//     heiferCows = json['heifer_cows'];
//     sevenToTwelveMonthCows = json['seven_to_twelve_month_cows'];
//     sixMonthCow = json['six_month_cow'];
//     bullCalfs = json['bull_calfs'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['user_id'] = userId;
//     data['name'] = name;
//     data['email'] = email;
//     data['f_address'] = fAddress;
//     data['phone'] = phone;
//     data['mcc_id'] = mccId;
//     data['dde_id'] = ddeId;
//     data['photo'] = photo;
//     data['kyc_status'] = kycStatus;
//     data['landline_no'] = landlineNo;
//     data['date_of_birth'] = dateOfBirth;
//     data['gender'] = gender;
//     data['registration_date'] = registrationDate;
//     data['farm_size'] = farmSize;
//     data['dairy_area'] = dairyArea;
//     data['staff_quantity'] = staffQuantity;
//     data['farming_experience'] = farmingExperience;
//     data['manager_name'] = managerName;
//     data['manager_phone'] = managerPhone;
//     data['rag_rating'] = ragRating;
//     data['lead_type'] = leadType;
//     data['ideal_yield'] = idealYield;
//     data['current_yield'] = currentYield;
//     data['status'] = status;
//     data['created_by'] = createdBy;
//     data['updated_by'] = updatedBy;
//     data['farmer_id'] = farmerId;
//     data['date'] = date;
//     data['total_milk_production'] = totalMilkProduction;
//     data['milking_cow'] = milkingCow;
//     data['supplied_to_pdfl'] = suppliedToPdfl;
//     data['supplied_to_others'] = suppliedToOthers;
//     data['self_use'] = selfUse;
//     data['yield_per_cow'] = yieldPerCow;
//     data['cow_breed_id'] = cowBreedId;
//     data['year'] = year;
//     data['month'] = month;
//     data['breed_name'] = breedName;
//     data['heard_size'] = heardSize;
//     data['milking_cows'] = milkingCows;
//     data['dry_cows'] = dryCows;
//     data['heifer_cows'] = heiferCows;
//     data['seven_to_twelve_month_cows'] = sevenToTwelveMonthCows;
//     data['six_month_cow'] = sixMonthCow;
//     data['bull_calfs'] = bullCalfs;
//     return data;
//   }
// }
//
// class TopPerformerFarmer {
//   dynamic id;
//   String? name;
//   dynamic fAddress;
//   dynamic milkingCows;
//   dynamic photo;
//   dynamic yieldPerCow;
//
//   TopPerformerFarmer(
//       {this.id,
//         this.name,
//         this.fAddress,
//         this.milkingCows,
//         this.photo,
//         this.yieldPerCow});
//
//   TopPerformerFarmer.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     fAddress = json['f_address'];
//     milkingCows = json['milking_cows'];
//     photo = json['photo'];
//     yieldPerCow = json['yield_per_cow'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['f_address'] = fAddress;
//     data['milking_cows'] = milkingCows;
//     data['photo'] = photo;
//     data['yield_per_cow'] = yieldPerCow;
//     return data;
//   }
// }