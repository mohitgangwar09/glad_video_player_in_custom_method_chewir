class DDEVisitorDetails {
  dynamic id;
  dynamic userId;
  String? name;
  String? email;
  String? fAddress;
  String? phone;
  dynamic mccId;
  dynamic ddeId;
  dynamic photo;
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
  String? date;
  dynamic achievement;
  List<FarmerProject>? farmerProject;

  DDEVisitorDetails(
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
        this.date,
        this.achievement,
        this.farmerProject});

  DDEVisitorDetails.fromJson(Map<String, dynamic> json) {
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
    date = json['date'];
    achievement = json['achievement'];
    if (json['farmer_project'] != null) {
      farmerProject = <FarmerProject>[];
      json['farmer_project'].forEach((v) {
        farmerProject!.add(new FarmerProject.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['f_address'] = this.fAddress;
    data['phone'] = this.phone;
    data['mcc_id'] = this.mccId;
    data['dde_id'] = this.ddeId;
    data['photo'] = this.photo;
    data['kyc_status'] = this.kycStatus;
    data['landline_no'] = this.landlineNo;
    data['date_of_birth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['registration_date'] = this.registrationDate;
    data['supplier_id'] = this.supplierId;
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
    data['created_at'] = this.createdAt;
    data['date'] = this.date;
    data['achievement'] = this.achievement;
    if (this.farmerProject != null) {
      data['farmer_project'] =
          this.farmerProject!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FarmerProject {
  dynamic id;
  dynamic ddeId;
  dynamic farmerId;
  dynamic projectId;
  String? name;
  dynamic category;
  String? description;
  String? projectStatus;
  dynamic projectSubStatus;
  dynamic suggestionRank;
  dynamic initialYield;
  dynamic targetYield;
  dynamic investmentAmount;
  dynamic creditRatio;
  dynamic revenuePerYear;
  dynamic roiPerYear;
  dynamic farmerParticipation;
  dynamic gladCommisionPercentage;
  dynamic gladCommisionAmount;
  dynamic ddeCommisionPercentage;
  dynamic ddeCommisionAmount;
  dynamic loanAmount;
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
  String? projectFilter;

  FarmerProject(
      {this.id,
        this.ddeId,
        this.farmerId,
        this.projectId,
        this.name,
        this.category,
        this.description,
        this.projectStatus,
        this.projectSubStatus,
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
        this.incrementalProduction,
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
    farmerId = json['farmer_id'];
    projectId = json['project_id'];
    name = json['name'];
    category = json['category'];
    description = json['description'];
    projectStatus = json['project_status'];
    projectSubStatus = json['project_sub_status'];
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
    incrementalProduction = json['incremental_production'];
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dde_id'] = this.ddeId;
    data['farmer_id'] = this.farmerId;
    data['project_id'] = this.projectId;
    data['name'] = this.name;
    data['category'] = this.category;
    data['description'] = this.description;
    data['project_status'] = this.projectStatus;
    data['project_sub_status'] = this.projectSubStatus;
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
    data['incremental_production'] = this.incrementalProduction;
    data['repayment_start_date'] = this.repaymentStartDate;
    data['photo'] = this.photo;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_by'] = this.deletedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['project_filter'] = this.projectFilter;
    return data;
  }
}
