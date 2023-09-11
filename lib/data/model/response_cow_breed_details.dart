class ResponseCowBreedDetails {
  String? message;
  int? status;
  DataCowBreedDetails? data;

  ResponseCowBreedDetails({this.message, this.status, this.data});

  ResponseCowBreedDetails.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? DataCowBreedDetails.fromJson(json['data']) : null;
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

class DataCowBreedDetails {
  List<MonthWiseData>? monthWiseData;

  DataCowBreedDetails({this.monthWiseData});

  DataCowBreedDetails.fromJson(Map<String, dynamic> json) {
    if (json['month_wise_data'] != null) {
      monthWiseData = <MonthWiseData>[];
      json['month_wise_data'].forEach((v) {
        monthWiseData!.add(MonthWiseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (monthWiseData != null) {
      data['month_wise_data'] =
          monthWiseData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MonthWiseData {
  String? monthname;
  int? id;
  dynamic totalMilkProduction;
  dynamic milkingCow;
  dynamic yieldPerCow;
  dynamic suppliedToPdfl;
  dynamic suppliedToOthers;
  dynamic selfUse;
  dynamic year;
  dynamic month;
  List<DateWiseData>? dateWiseData;

  MonthWiseData(
      {this.monthname,
        this.totalMilkProduction,
        this.id,
        this.milkingCow,
        this.yieldPerCow,
        this.suppliedToPdfl,
        this.suppliedToOthers,
        this.selfUse,
        this.year,
        this.month,
        this.dateWiseData});

  MonthWiseData.fromJson(Map<String, dynamic> json) {
    monthname = json['monthname'];
    id = json['id'];
    totalMilkProduction = json['total_milk_production'];
    milkingCow = json['milking_cow'];
    yieldPerCow = json['yield_per_cow'];
    suppliedToPdfl = json['supplied_to_pdfl'];
    suppliedToOthers = json['supplied_to_others'];
    selfUse = json['self_use'];
    year = json['year'];
    month = json['month'];
    if (json['date_wise_data'] != null) {
      dateWiseData = <DateWiseData>[];
      json['date_wise_data'].forEach((v) {
        dateWiseData!.add(DateWiseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['monthname'] = monthname;
    data['id'] = id;
    data['total_milk_production'] = totalMilkProduction;
    data['milking_cow'] = milkingCow;
    data['yield_per_cow'] = yieldPerCow;
    data['supplied_to_pdfl'] = suppliedToPdfl;
    data['supplied_to_others'] = suppliedToOthers;
    data['self_use'] = selfUse;
    data['year'] = year;
    data['month'] = month;
    if (dateWiseData != null) {
      data['date_wise_data'] =
          dateWiseData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DateWiseData {
  dynamic id;
  dynamic farmerId;
  int? cowBreedId;
  String? year;
  String? month;
  String? breedName;
  dynamic heardSize;
  dynamic milkingCows;
  dynamic dryCows;
  dynamic heiferCows;
  dynamic i7to12mCows;
  dynamic i6mCows;
  dynamic bullCalfs;
  dynamic yieldPerCow;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;

  DateWiseData(
      {this.id,
        this.farmerId,
        this.cowBreedId,
        this.year,
        this.month,
        this.breedName,
        this.heardSize,
        this.milkingCows,
        this.dryCows,
        this.heiferCows,
        this.i7to12mCows,
        this.i6mCows,
        this.bullCalfs,
        this.yieldPerCow,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt});

  DateWiseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    cowBreedId = json['cow_breed_id'];
    year = json['year'];
    month = json['month'];
    breedName = json['breed_name'];
    heardSize = json['heard_size'];
    milkingCows = json['milking_cows'];
    dryCows = json['dry_cows'];
    heiferCows = json['heifer_cows'];
    i7to12mCows = json['7to12m_cows'];
    i6mCows = json['6m_cows'];
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
    data['breed_name'] = breedName;
    data['heard_size'] = heardSize;
    data['milking_cows'] = milkingCows;
    data['dry_cows'] = dryCows;
    data['heifer_cows'] = heiferCows;
    data['7to12m_cows'] = i7to12mCows;
    data['6m_cows'] = i6mCows;
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
