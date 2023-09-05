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
  FarmerMaster? farmerMaster;
  List<Testimonials>? testimonials;
  List<FarmerProject>? farmerProject;
  CowBreedDetails? cowBreedDetails;
  List<FarmerMilkProduction>? farmerMilkProduction;
  List<TopPerformerFarmer>? topPerformerFarmer;

  Data(
      {this.dde,
        this.mcc,
        this.farmerMaster,
        this.testimonials,
        this.farmerProject,
        this.cowBreedDetails,
        this.farmerMilkProduction,
        this.topPerformerFarmer});

  Data.fromJson(Map<String, dynamic> json) {
    dde = json['dde'] != null ? Dde.fromJson(json['dde']) : null;
    mcc = json['mcc'] != null ? Mcc.fromJson(json['mcc']) : null;
    farmerMaster = json['farmerMaster'] != null
        ? FarmerMaster.fromJson(json['farmerMaster'])
        : null;
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
    if (json['topPerformerFarmer'] != null) {
      topPerformerFarmer = <TopPerformerFarmer>[];
      json['topPerformerFarmer'].forEach((v) {
        topPerformerFarmer!.add(TopPerformerFarmer.fromJson(v));
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
    if (farmerMaster != null) {
      data['farmerMaster'] = farmerMaster!.toJson();
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
    if (topPerformerFarmer != null) {
      data['topPerformerFarmer'] =
          topPerformerFarmer!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dde {
  dynamic id;
  String? name;
  dynamic phone;
  dynamic image;

  Dde({this.id, this.name, this.phone, this.image});

  Dde.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['image'] = image;
    return data;
  }
}

class Mcc {
  dynamic id;
  String? name;
  String? email;
  dynamic phone;
  dynamic address;
  dynamic image;

  Mcc({this.id, this.name, this.email, this.phone, this.address, this.image});

  Mcc.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['image'] = image;
    return data;
  }
}

class FarmerMaster {
  dynamic id;
  dynamic userId;
  String? name;
  String? email;
  dynamic address;
  String? phone;
  dynamic mccId;
  dynamic ddeId;
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
  dynamic createdBy;
  dynamic updatedBy;

  FarmerMaster(
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
        this.updatedBy});

  FarmerMaster.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class Testimonials {
  dynamic id;
  String? description;
  String? attachment;
  String? type;
  String? status;

  Testimonials(
      {this.id, this.description, this.attachment, this.type, this.status});

  Testimonials.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    attachment = json['attachment'];
    type = json['type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['attachment'] = attachment;
    data['type'] = type;
    data['status'] = status;
    return data;
  }
}

class FarmerProject {
  dynamic id;
  String? name;
  String? description;
  String? projectStatus;
  dynamic initialYield;
  dynamic targetYield;
  dynamic investmentAmount;
  dynamic revenuePerYear;
  dynamic roiPerYear;
  dynamic category;
  dynamic incrementalProduction;
  dynamic photo;

  FarmerProject(
      {this.id,
        this.name,
        this.description,
        this.projectStatus,
        this.initialYield,
        this.targetYield,
        this.investmentAmount,
        this.revenuePerYear,
        this.roiPerYear,
        this.category,
        this.incrementalProduction,
        this.photo});

  FarmerProject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    projectStatus = json['project_status'];
    initialYield = json['initial_yield'];
    targetYield = json['target_yield'];
    investmentAmount = json['investment_amount'];
    revenuePerYear = json['revenue_per_year'];
    roiPerYear = json['roi_per_year'];
    category = json['category'];
    incrementalProduction = json['incremental_production'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['project_status'] = projectStatus;
    data['initial_yield'] = initialYield;
    data['target_yield'] = targetYield;
    data['investment_amount'] = investmentAmount;
    data['revenue_per_year'] = revenuePerYear;
    data['roi_per_year'] = roiPerYear;
    data['category'] = category;
    data['incremental_production'] = incrementalProduction;
    data['photo'] = photo;
    return data;
  }
}

class CowBreedDetails {
  dynamic id;
  String? breedName;
  dynamic heardSize;
  dynamic milkingCows;
  dynamic dryCows;
  dynamic yieldPerCow;
  dynamic bullCalfs;
  dynamic heiferCows;
  dynamic i7to12mCows;
  dynamic i6mCows;

  CowBreedDetails(
      {this.id,
        this.breedName,
        this.heardSize,
        this.milkingCows,
        this.dryCows,
        this.yieldPerCow,
        this.bullCalfs,
        this.heiferCows,
        this.i7to12mCows,
        this.i6mCows});

  CowBreedDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    breedName = json['breed_name'];
    heardSize = json['heard_size'];
    milkingCows = json['milking_cows'];
    dryCows = json['dry_cows'];
    yieldPerCow = json['yield_per_cow'];
    bullCalfs = json['bull_calfs'];
    heiferCows = json['heifer_cows'];
    i7to12mCows = json['7to12m_cows'];
    i6mCows = json['6m_cows'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['breed_name'] = breedName;
    data['heard_size'] = heardSize;
    data['milking_cows'] = milkingCows;
    data['dry_cows'] = dryCows;
    data['yield_per_cow'] = yieldPerCow;
    data['bull_calfs'] = bullCalfs;
    data['heifer_cows'] = heiferCows;
    data['7to12m_cows'] = i7to12mCows;
    data['6m_cows'] = i6mCows;
    return data;
  }
}

class FarmerMilkProduction {
  dynamic id;
  dynamic userId;
  String? name;
  String? email;
  dynamic address;
  String? phone;
  dynamic mccId;
  dynamic ddeId;
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
  dynamic createdBy;
  dynamic updatedBy;
  dynamic farmerId;
  String? date;
  dynamic totalMilkProduction;
  dynamic milkingCow;
  dynamic suppliedToPdfl;
  dynamic suppliedToOthers;
  dynamic selfUse;
  dynamic yieldPerCow;
  dynamic cowBreedId;
  String? month;
  String? breedName;
  dynamic heardSize;
  dynamic milkingCows;
  dynamic dryCows;
  dynamic heiferCows;
  dynamic i7to12mCows;
  dynamic i6mCows;
  dynamic bullCalfs;

  FarmerMilkProduction(
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
        this.farmerId,
        this.date,
        this.totalMilkProduction,
        this.milkingCow,
        this.suppliedToPdfl,
        this.suppliedToOthers,
        this.selfUse,
        this.yieldPerCow,
        this.cowBreedId,
        this.month,
        this.breedName,
        this.heardSize,
        this.milkingCows,
        this.dryCows,
        this.heiferCows,
        this.i7to12mCows,
        this.i6mCows,
        this.bullCalfs});

  FarmerMilkProduction.fromJson(Map<String, dynamic> json) {
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
    farmerId = json['farmer_id'];
    date = json['date'];
    totalMilkProduction = json['total_milk_production'];
    milkingCow = json['milking_cow'];
    suppliedToPdfl = json['supplied_to_pdfl'];
    suppliedToOthers = json['supplied_to_others'];
    selfUse = json['self_use'];
    yieldPerCow = json['yield_per_cow'];
    cowBreedId = json['cow_breed_id'];
    month = json['month'];
    breedName = json['breed_name'];
    heardSize = json['heard_size'];
    milkingCows = json['milking_cows'];
    dryCows = json['dry_cows'];
    heiferCows = json['heifer_cows'];
    i7to12mCows = json['7to12m_cows'];
    i6mCows = json['6m_cows'];
    bullCalfs = json['bull_calfs'];
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
    data['farmer_id'] = farmerId;
    data['date'] = date;
    data['total_milk_production'] = totalMilkProduction;
    data['milking_cow'] = milkingCow;
    data['supplied_to_pdfl'] = suppliedToPdfl;
    data['supplied_to_others'] = suppliedToOthers;
    data['self_use'] = selfUse;
    data['yield_per_cow'] = yieldPerCow;
    data['cow_breed_id'] = cowBreedId;
    data['month'] = month;
    data['breed_name'] = breedName;
    data['heard_size'] = heardSize;
    data['milking_cows'] = milkingCows;
    data['dry_cows'] = dryCows;
    data['heifer_cows'] = heiferCows;
    data['7to12m_cows'] = i7to12mCows;
    data['6m_cows'] = i6mCows;
    data['bull_calfs'] = bullCalfs;
    return data;
  }
}

class TopPerformerFarmer {
  dynamic id;
  String? name;
  dynamic address;
  dynamic milkingCows;
  dynamic photo;
  dynamic yieldPerCow;

  TopPerformerFarmer(
      {this.id,
        this.name,
        this.address,
        this.milkingCows,
        this.photo,
        this.yieldPerCow});

  TopPerformerFarmer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    milkingCows = json['milking_cows'];
    photo = json['photo'];
    yieldPerCow = json['yield_per_cow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['address'] = address;
    data['milking_cows'] = milkingCows;
    data['photo'] = photo;
    data['yield_per_cow'] = yieldPerCow;
    return data;
  }
}
