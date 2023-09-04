class FarmerDashboard {
  String? message;
  int? status;
  Data? data;

  FarmerDashboard({this.message, this.status, this.data});

  FarmerDashboard.fromJson(Map<String, dynamic> json) {
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
  FarmerMaster? farmerMaster;
  List<CowBreedDetails>? cowBreedDetails;
  Dde? dde;
  List<Testimonials>? testimonials;
  Mcc? mcc;
  List<FarmerProject>? farmerProject;
  List<FarmerMilkProduction>? farmerMilkProduction;
  List<TopPerformerFarmer>? topPerformerFarmer;

  Data(
      {this.farmerMaster,
        this.cowBreedDetails,
        this.dde,
        this.testimonials,
        this.mcc,
        this.farmerProject,
        this.farmerMilkProduction,
        this.topPerformerFarmer});

  Data.fromJson(Map<String, dynamic> json) {
    farmerMaster = json['farmerMaster'] != null
        ? new FarmerMaster.fromJson(json['farmerMaster'])
        : null;
    if (json['cowBreedDetails'] != null) {
      cowBreedDetails = <CowBreedDetails>[];
      json['cowBreedDetails'].forEach((v) {
        cowBreedDetails!.add(new CowBreedDetails.fromJson(v));
      });
    }
    dde = json['dde'] != null ? new Dde.fromJson(json['dde']) : null;
    if (json['testimonials'] != null) {
      testimonials = <Testimonials>[];
      json['testimonials'].forEach((v) {
        testimonials!.add(new Testimonials.fromJson(v));
      });
    }
    mcc = json['mcc'] != null ? new Mcc.fromJson(json['mcc']) : null;
    if (json['farmerProject'] != null) {
      farmerProject = <FarmerProject>[];
      json['farmerProject'].forEach((v) {
        farmerProject!.add(new FarmerProject.fromJson(v));
      });
    }
    if (json['farmerMilkProduction'] != null) {
      farmerMilkProduction = <FarmerMilkProduction>[];
      json['farmerMilkProduction'].forEach((v) {
        farmerMilkProduction!.add(new FarmerMilkProduction.fromJson(v));
      });
    }
    if (json['topPerformerFarmer'] != null) {
      topPerformerFarmer = <TopPerformerFarmer>[];
      json['topPerformerFarmer'].forEach((v) {
        topPerformerFarmer!.add(new TopPerformerFarmer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.farmerMaster != null) {
      data['farmerMaster'] = this.farmerMaster!.toJson();
    }
    if (this.cowBreedDetails != null) {
      data['cowBreedDetails'] =
          this.cowBreedDetails!.map((v) => v.toJson()).toList();
    }
    if (this.dde != null) {
      data['dde'] = this.dde!.toJson();
    }
    if (this.testimonials != null) {
      data['testimonials'] = this.testimonials!.map((v) => v.toJson()).toList();
    }
    if (this.mcc != null) {
      data['mcc'] = this.mcc!.toJson();
    }
    if (this.farmerProject != null) {
      data['farmerProject'] =
          this.farmerProject!.map((v) => v.toJson()).toList();
    }
    if (this.farmerMilkProduction != null) {
      data['farmerMilkProduction'] =
          this.farmerMilkProduction!.map((v) => v.toJson()).toList();
    }
    if (this.topPerformerFarmer != null) {
      data['topPerformerFarmer'] =
          this.topPerformerFarmer!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FarmerMaster {
  int? id;
  int? userId;
  String? name;
  String? email;
  Null? address;
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
  Null? phone;
  Null? image;

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

class Mcc {
  int? id;
  String? name;
  String? email;
  Null? phone;
  Null? address;
  Null? image;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['image'] = this.image;
    return data;
  }
}

class FarmerProject {
  int? id;
  String? name;
  String? description;
  String? projectStatus;
  int? initialYield;
  int? targetYield;
  int? investmentAmount;
  int? revenuePerYear;
  int? roiPerYear;
  int? category;
  Null? incrementalProduction;
  Null? photo;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['project_status'] = this.projectStatus;
    data['initial_yield'] = this.initialYield;
    data['target_yield'] = this.targetYield;
    data['investment_amount'] = this.investmentAmount;
    data['revenue_per_year'] = this.revenuePerYear;
    data['roi_per_year'] = this.roiPerYear;
    data['category'] = this.category;
    data['incremental_production'] = this.incrementalProduction;
    data['photo'] = this.photo;
    return data;
  }
}

class FarmerMilkProduction {
  int? id;
  int? userId;
  String? name;
  String? email;
  Null? address;
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
  Null? updatedBy;
  int? farmerId;
  String? date;
  int? totalMilkProduction;
  Null? milkingCow;
  int? suppliedToPdfl;
  int? suppliedToOthers;
  int? selfUse;
  double? yieldPerCow;
  int? cowBreedId;
  String? month;
  String? breedName;
  int? heardSize;
  int? milkingCows;
  int? dryCows;
  int? heiferCows;
  Null? n7to12mCows;
  Null? n6mCows;
  int? bullCalfs;

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
        this.n7to12mCows,
        this.n6mCows,
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
    n7to12mCows = json['7to12m_cows'];
    n6mCows = json['6m_cows'];
    bullCalfs = json['bull_calfs'];
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
    data['farmer_id'] = this.farmerId;
    data['date'] = this.date;
    data['total_milk_production'] = this.totalMilkProduction;
    data['milking_cow'] = this.milkingCow;
    data['supplied_to_pdfl'] = this.suppliedToPdfl;
    data['supplied_to_others'] = this.suppliedToOthers;
    data['self_use'] = this.selfUse;
    data['yield_per_cow'] = this.yieldPerCow;
    data['cow_breed_id'] = this.cowBreedId;
    data['month'] = this.month;
    data['breed_name'] = this.breedName;
    data['heard_size'] = this.heardSize;
    data['milking_cows'] = this.milkingCows;
    data['dry_cows'] = this.dryCows;
    data['heifer_cows'] = this.heiferCows;
    data['7to12m_cows'] = this.n7to12mCows;
    data['6m_cows'] = this.n6mCows;
    data['bull_calfs'] = this.bullCalfs;
    return data;
  }
}

class TopPerformerFarmer {
  int? id;
  String? name;
  Null? address;
  int? milkingCows;
  Null? photo;

  TopPerformerFarmer(
      {this.id, this.name, this.address, this.milkingCows, this.photo});

  TopPerformerFarmer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    milkingCows = json['milking_cows'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['milking_cows'] = this.milkingCows;
    data['photo'] = this.photo;
    return data;
  }
}
class Testimonials {
  dynamic id;
  String? name;
  String? description;
  String? attachment;
  String? type;
  String? status;

  Testimonials(
      {this.id,
        this.name,
        this.description,
        this.attachment,
        this.type,
        this.status});

  Testimonials.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    attachment = json['attachment'];
    type = json['type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['attachment'] = this.attachment;
    data['type'] = this.type;
    data['status'] = this.status;
    return data;
  }
}

