class ResponseCowBreedDetails {
  String? message;
  int? status;
  DataCowBreedDetail? data;

  ResponseCowBreedDetails({this.message, this.status, this.data});

  ResponseCowBreedDetails.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? DataCowBreedDetail.fromJson(json['data']) : null;
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

class DataCowBreedDetail {
  List<MonthWiseData>? monthWiseData;

  DataCowBreedDetail({this.monthWiseData});

  DataCowBreedDetail.fromJson(Map<String, dynamic> json) {
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
  dynamic id;
  dynamic farmerId;
  String? monthname;
  dynamic totalMilkProduction;
  dynamic totalHerdSize;
  dynamic milkingCow;
  dynamic yieldPerCow;
  dynamic suppliedToPdfl;
  dynamic suppliedToOthers;
  dynamic selfUse;
  dynamic year;
  dynamic month;
  List<DateWiseData>? dateWiseData;

  MonthWiseData(
      {this.id,
        this.farmerId,
        this.monthname,
        this.totalMilkProduction,
        this.milkingCow,
        this.yieldPerCow,
        this.suppliedToPdfl,
        this.suppliedToOthers,
        this.selfUse,
        this.year,
        this.month,
        this.totalHerdSize,
        this.dateWiseData});

  MonthWiseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    monthname = json['monthname'];
    totalMilkProduction = json['total_milk_production'];
    milkingCow = json['milking_cow'];
    yieldPerCow = json['yield_per_cow'];
    suppliedToPdfl = json['supplied_to_pdfl'];
    suppliedToOthers = json['supplied_to_others'];
    selfUse = json['self_use'];
    year = json['year'];
    totalHerdSize = json['total_herd_size'];
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
    data['id'] = id;
    data['total_herd_size'] = totalHerdSize;
    data['farmer_id'] = farmerId;
    data['monthname'] = monthname;
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
  dynamic cowBreedId;
  String? month;
  String? year;
  String? breedName;
  dynamic heardSize;
  dynamic milkingCows;
  dynamic dryCows;
  dynamic heiferCows;
  dynamic sevenToTwelveMonthCows;
  dynamic sixMonthCow;
  dynamic yieldPerCow;
  dynamic bullCalfs;

  DateWiseData(
      {this.id,
        this.farmerId,
        this.cowBreedId,
        this.month,
        this.year,
        this.breedName,
        this.heardSize,
        this.milkingCows,
        this.dryCows,
        this.heiferCows,
        this.sevenToTwelveMonthCows,
        this.sixMonthCow,
        this.bullCalfs,
        this.yieldPerCow});

  DateWiseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    cowBreedId = json['cow_breed_id'];
    month = json['month'];
    year = json['year'];
    breedName = json['breed_name'];
    heardSize = json['herd_size'];
    milkingCows = json['milking_cows'];
    dryCows = json['dry_cows'];
    heiferCows = json['heifer_cows'];
    sevenToTwelveMonthCows = json['seven_to_twelve_month_cows'];
    sixMonthCow = json['six_month_cow'];
    yieldPerCow = json['yield_per_cow'];
    bullCalfs = json['bull_calfs'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['farmer_id'] = farmerId;
    data['cow_breed_id'] = cowBreedId;
    data['month'] = month;
    data['year'] = year;
    data['breed_name'] = breedName;
    data['herd_size'] = heardSize;
    data['milking_cows'] = milkingCows;
    data['dry_cows'] = dryCows;
    data['heifer_cows'] = heiferCows;
    data['seven_to_twelve_month_cows'] = sevenToTwelveMonthCows;
    data['six_month_cow'] = sixMonthCow;
    data['yield_per_cow'] = yieldPerCow;
    data['bull_calfs'] = bullCalfs;
    return data;
  }
}
