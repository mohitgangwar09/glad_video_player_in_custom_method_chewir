class MilkProductionChart {
  String? message;
  int? status;
  Data? data;

  MilkProductionChart({this.message, this.status, this.data});

  MilkProductionChart.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  dynamic totalSixMonthMilkProduction;
  dynamic totalLastMonthMilkProduction;
  dynamic totalYesterdayMilkProduction;
  dynamic totalLastWeekMilkProduction;
  List<MonthWiseData>? monthWiseData;
  List<LastMonth>? lastMonth;
  List<PreviousDay>? previousDay;
  List<LastWeekData>? lastWeekData;

  Data(
      {this.totalSixMonthMilkProduction,
        this.totalLastMonthMilkProduction,
        this.totalYesterdayMilkProduction,
        this.totalLastWeekMilkProduction,
        this.monthWiseData,
        this.lastMonth,
        this.previousDay,
        this.lastWeekData});

  Data.fromJson(Map<String, dynamic> json) {
    totalSixMonthMilkProduction = json['total_six_month_milk_production'];
    totalLastMonthMilkProduction = json['total_last_month_milk_production'];
    totalYesterdayMilkProduction = json['total_yesterday_milk_production'];
    totalLastWeekMilkProduction = json['total_last_week_milk_production'];
    if (json['month_wise_data'] != null) {
      monthWiseData = <MonthWiseData>[];
      json['month_wise_data'].forEach((v) {
        monthWiseData!.add(MonthWiseData.fromJson(v));
      });
    }
    if (json['last_month'] != null) {
      lastMonth = <LastMonth>[];
      json['last_month'].forEach((v) {
        lastMonth!.add(LastMonth.fromJson(v));
      });
    }
    if (json['previous_day'] != null) {
      previousDay = <PreviousDay>[];
      json['previous_day'].forEach((v) {
        previousDay!.add(PreviousDay.fromJson(v));
      });
    }
    if (json['last_week_data'] != null) {
      lastWeekData = <LastWeekData>[];
      json['last_week_data'].forEach((v) {
        lastWeekData!.add(LastWeekData.fromJson(v));
      });
    }
  }
}

class MonthWiseData {
  String? monthname;
  dynamic totalMilkProduction;
  dynamic milkingCow;
  dynamic yieldPerCow;
  dynamic suppliedToPdfl;
  dynamic suppliedToOthers;
  dynamic selfUse;
  dynamic year;
  dynamic month;

  MonthWiseData(
      {this.monthname,
        this.totalMilkProduction,
        this.milkingCow,
        this.yieldPerCow,
        this.suppliedToPdfl,
        this.suppliedToOthers,
        this.selfUse,
        this.year,
        this.month});

  MonthWiseData.fromJson(Map<String, dynamic> json) {
    monthname = json['monthname'];
    totalMilkProduction = json['total_milk_production'];
    milkingCow = json['milking_cow'];
    yieldPerCow = json['yield_per_cow'];
    suppliedToPdfl = json['supplied_to_pdfl'];
    suppliedToOthers = json['supplied_to_others'];
    selfUse = json['self_use'];
    year = json['year'];
    month = json['month'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['monthname'] = monthname;
    data['total_milk_production'] = totalMilkProduction;
    data['milking_cow'] = milkingCow;
    data['yield_per_cow'] = yieldPerCow;
    data['supplied_to_pdfl'] = suppliedToPdfl;
    data['supplied_to_others'] = suppliedToOthers;
    data['self_use'] = selfUse;
    data['year'] = year;
    data['month'] = month;
    return data;
  }
}

class LastMonth {
  dynamic id;
  dynamic farmerId;
  String? date;
  dynamic totalMilkProduction;
  dynamic milkingCow;
  dynamic suppliedToPdfl;
  dynamic suppliedToOthers;
  dynamic selfUse;
  dynamic yieldPerCow;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  String? monthname;

  LastMonth(
      {this.id,
        this.farmerId,
        this.date,
        this.totalMilkProduction,
        this.milkingCow,
        this.suppliedToPdfl,
        this.suppliedToOthers,
        this.selfUse,
        this.yieldPerCow,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.monthname});

  LastMonth.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    date = json['date'];
    totalMilkProduction = json['total_milk_production'];
    milkingCow = json['milking_cow'];
    suppliedToPdfl = json['supplied_to_pdfl'];
    suppliedToOthers = json['supplied_to_others'];
    selfUse = json['self_use'];
    yieldPerCow = json['yield_per_cow'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    monthname = json['monthname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['farmer_id'] = farmerId;
    data['date'] = date;
    data['total_milk_production'] = totalMilkProduction;
    data['milking_cow'] = milkingCow;
    data['supplied_to_pdfl'] = suppliedToPdfl;
    data['supplied_to_others'] = suppliedToOthers;
    data['self_use'] = selfUse;
    data['yield_per_cow'] = yieldPerCow;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['monthname'] = monthname;
    return data;
  }
}

class LastWeekData {
  dynamic id;
  dynamic farmerId;
  String? date;
  dynamic totalMilkProduction;
  dynamic milkingCow;
  dynamic suppliedToPdfl;
  dynamic suppliedToOthers;
  dynamic selfUse;
  dynamic yieldPerCow;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;

  LastWeekData(
      {this.id,
        this.farmerId,
        this.date,
        this.totalMilkProduction,
        this.milkingCow,
        this.suppliedToPdfl,
        this.suppliedToOthers,
        this.selfUse,
        this.yieldPerCow,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt});

  LastWeekData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    date = json['date'];
    totalMilkProduction = json['total_milk_production'];
    milkingCow = json['milking_cow'];
    suppliedToPdfl = json['supplied_to_pdfl'];
    suppliedToOthers = json['supplied_to_others'];
    selfUse = json['self_use'];
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
    data['date'] = date;
    data['total_milk_production'] = totalMilkProduction;
    data['milking_cow'] = milkingCow;
    data['supplied_to_pdfl'] = suppliedToPdfl;
    data['supplied_to_others'] = suppliedToOthers;
    data['self_use'] = selfUse;
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

class PreviousDay {
  dynamic id;
  dynamic farmerId;
  String? date;
  String? month;
  dynamic totalMilkProduction;
  dynamic milkingCow;
  dynamic suppliedToPdfl;
  dynamic suppliedToOthers;
  dynamic selfUse;
  dynamic yieldPerCow;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;

  PreviousDay(
      {this.id,
        this.farmerId,
        this.date,
        this.month,
        this.totalMilkProduction,
        this.milkingCow,
        this.suppliedToPdfl,
        this.suppliedToOthers,
        this.selfUse,
        this.yieldPerCow,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt});

  PreviousDay.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    date = json['date'];
    month = json['month'];
    totalMilkProduction = json['total_milk_production'];
    milkingCow = json['milking_cow'];
    suppliedToPdfl = json['supplied_to_pdfl'];
    suppliedToOthers = json['supplied_to_others'];
    selfUse = json['self_use'];
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
    data['date'] = date;
    data['month'] = month;
    data['total_milk_production'] = totalMilkProduction;
    data['milking_cow'] = milkingCow;
    data['supplied_to_pdfl'] = suppliedToPdfl;
    data['supplied_to_others'] = suppliedToOthers;
    data['self_use'] = selfUse;
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
