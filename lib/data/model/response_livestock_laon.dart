class ResponseLivestockLoan {
  String? message;
  int? status;
  DataLivestockLoan? data;

  ResponseLivestockLoan({this.message, this.status, this.data});

  ResponseLivestockLoan.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? DataLivestockLoan.fromJson(json['data']) : null;
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

class DataLivestockLoan {
  dynamic farmerId;
  dynamic ddeId;
  dynamic mccId;
  dynamic liveStockCartId;
  String? name;
  dynamic category;
  String? description;
  String? projectStatus;
  String? projectStatusRemarks;
  dynamic projectStatusDate;
  dynamic milkPrice;
  dynamic milkSupply6months;
  dynamic milkSupply6monthsValue;
  dynamic targetYield;
  dynamic revenuePerMonth;
  dynamic revenuePerYear;
  dynamic farmerParticipationPercentage;
  dynamic gladCommisionPercentage;
  dynamic ddeCommisionPercentage;
  dynamic maxRepaymentMonths;
  dynamic incrementalProduction;
  dynamic investmentAmount;
  dynamic farmerParticipation;
  dynamic createdBy;
  String? updatedAt;
  String? createdAt;
  dynamic id;
  dynamic projectBalance;
  dynamic paymentStatus;

  DataLivestockLoan(
      {this.farmerId,
        this.ddeId,
        this.mccId,
        this.liveStockCartId,
        this.name,
        this.category,
        this.description,
        this.projectStatus,
        this.projectStatusRemarks,
        this.projectStatusDate,
        this.milkPrice,
        this.milkSupply6months,
        this.milkSupply6monthsValue,
        this.targetYield,
        this.revenuePerMonth,
        this.revenuePerYear,
        this.farmerParticipationPercentage,
        this.gladCommisionPercentage,
        this.ddeCommisionPercentage,
        this.maxRepaymentMonths,
        this.incrementalProduction,
        this.investmentAmount,
        this.farmerParticipation,
        this.createdBy,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.projectBalance,
        this.paymentStatus});

  DataLivestockLoan.fromJson(Map<String, dynamic> json) {
    farmerId = json['farmer_id'];
    ddeId = json['dde_id'];
    mccId = json['mcc_id'];
    liveStockCartId = json['live_stock_cart_id'];
    name = json['name'];
    category = json['category'];
    description = json['description'];
    projectStatus = json['project_status'];
    projectStatusRemarks = json['project_status_remarks'];
    projectStatusDate = json['project_status_date'];
    milkPrice = json['milk_price'];
    milkSupply6months = json['milk_supply_6months'];
    milkSupply6monthsValue = json['milk_supply_6months_value'];
    targetYield = json['target_yield'];
    revenuePerMonth = json['revenue_per_month'];
    revenuePerYear = json['revenue_per_year'];
    farmerParticipationPercentage = json['farmer_participation_percentage'];
    gladCommisionPercentage = json['glad_commision_percentage'];
    ddeCommisionPercentage = json['dde_commision_percentage'];
    maxRepaymentMonths = json['max_repayment_months'];
    incrementalProduction = json['incremental_production'];
    investmentAmount = json['investment_amount'];
    farmerParticipation = json['farmer_participation'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    projectBalance = json['project_balance'];
    paymentStatus = json['payment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['farmer_id'] = farmerId;
    data['dde_id'] = ddeId;
    data['mcc_id'] = mccId;
    data['live_stock_cart_id'] = liveStockCartId;
    data['name'] = name;
    data['category'] = category;
    data['description'] = description;
    data['project_status'] = projectStatus;
    data['project_status_remarks'] = projectStatusRemarks;
    data['project_status_date'] = projectStatusDate;
    data['milk_price'] = milkPrice;
    data['milk_supply_6months'] = milkSupply6months;
    data['milk_supply_6months_value'] = milkSupply6monthsValue;
    data['target_yield'] = targetYield;
    data['revenue_per_month'] = revenuePerMonth;
    data['revenue_per_year'] = revenuePerYear;
    data['farmer_participation_percentage'] =
        farmerParticipationPercentage;
    data['glad_commision_percentage'] = gladCommisionPercentage;
    data['dde_commision_percentage'] = ddeCommisionPercentage;
    data['max_repayment_months'] = maxRepaymentMonths;
    data['incremental_production'] = incrementalProduction;
    data['investment_amount'] = investmentAmount;
    data['farmer_participation'] = farmerParticipation;
    data['created_by'] = createdBy;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['project_balance'] = projectBalance;
    data['payment_status'] = paymentStatus;
    return data;
  }
}
