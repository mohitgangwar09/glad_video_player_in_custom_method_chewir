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
  List<FarmerProject>? farmerProject;
  List<FarmerMaster>? farmerMaster;

  Data({this.farmerProject, this.farmerMaster});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['farmerProject'] != null) {
      farmerProject = <FarmerProject>[];
      json['farmerProject'].forEach((v) {
        farmerProject!.add(new FarmerProject.fromJson(v));
      });
    }
    if (json['farmerMaster'] != null) {
      farmerMaster = <FarmerMaster>[];
      json['farmerMaster'].forEach((v) {
        farmerMaster!.add(new FarmerMaster.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.farmerProject != null) {
      data['farmerProject'] =
          this.farmerProject!.map((v) => v.toJson()).toList();
    }
    if (this.farmerMaster != null) {
      data['farmerMaster'] = this.farmerMaster!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FarmerProject {
  int? id;
  int? farmerId;
  int? projectId;
  String? name;
  int? category;
  String? description;
  String? projectStatus;
  int? suggestionRank;
  int? initialYield;
  int? targetYield;
  int? investmentAmount;
  int? creditRatio;
  int? revenuePerYear;
  int? roiPerYear;
  Null? farmerParticipation;
  Null? gladCommisionPercentage;
  Null? gladCommisionAmount;
  Null? ddeCommisionPercentage;
  Null? ddeCommisionAmount;
  int? loanAmount;
  int? repaymentMonths;
  int? emiAmount;
  String? repaymentStartDate;
  String? status;
  int? createdBy;
  Null? updatedBy;
  Null? deletedBy;
  String? createdAt;
  String? updatedAt;

  FarmerProject(
      {this.id,
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
        this.repaymentStartDate,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt});

  FarmerProject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    repaymentStartDate = json['repayment_start_date'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['farmer_id'] = this.farmerId;
    data['project_id'] = this.projectId;
    data['name'] = this.name;
    data['category'] = this.category;
    data['description'] = this.description;
    data['project_status'] = this.projectStatus;
    data['suggestion_rank'] = this.suggestionRank;
    data['initial_yield'] = this.initialYield;
    data['target_yield'] = this.targetYield;
    data['investment_amount'] = this.investmentAmount;
    data['credit_ratio'] = this.creditRatio;
    data['revenue_per_year'] = this.revenuePerYear;
    data['roi_per_year'] = this.roiPerYear;
    data['farmer_participation'] = this.farmerParticipation;
    data['glad_commision_percentage'] = this.gladCommisionPercentage;
    data['glad_commision_amount'] = this.gladCommisionAmount;
    data['dde_commision_percentage'] = this.ddeCommisionPercentage;
    data['dde_commision_amount'] = this.ddeCommisionAmount;
    data['loan_amount'] = this.loanAmount;
    data['repayment_months'] = this.repaymentMonths;
    data['emi_amount'] = this.emiAmount;
    data['repayment_start_date'] = this.repaymentStartDate;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_by'] = this.deletedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class FarmerMaster {
  int? id;
  int? userId;
  String? name;
  String? email;
  String? phone;
  int? mccId;
  int? ddeId;
  dynamic? photo;
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
  Null? deletedBy;
  String? createdAt;
  String? updatedAt;

  FarmerMaster(
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
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt});

  FarmerMaster.fromJson(Map<String, dynamic> json) {
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
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['deleted_by'] = this.deletedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}