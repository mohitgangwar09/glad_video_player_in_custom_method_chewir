class UpdateRecordMonthBreedModel {

  int monthId;
  int farmerId;
  int selfUse;
  int suppliedToOtherPdf;
  int suppliedToPdf;
  int totalProduction;
  double yieldPerCow;
  List<RequestData> requestData;

  UpdateRecordMonthBreedModel({
    required this.monthId,
    required this.farmerId,
    required this.selfUse,
    required this.suppliedToOtherPdf,
    required this.suppliedToPdf,
    required this.totalProduction,
    required this.yieldPerCow,
    required this.requestData,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month_id'] = monthId;
    data['farmer_id'] = farmerId;
    data['supplied_to_pdfl'] = suppliedToPdf;
    data['self_use'] = selfUse;
    data['supplied_to_others'] = suppliedToOtherPdf;
    data['total_milk_production'] = totalProduction;
    data['yield_per_cow'] = yieldPerCow;
    data['requestData'] = requestData.map((v) => v).toList();

    return data;
  }

}

class RequestData {
  dynamic id;
  double? cowSum;
  dynamic heardSize;
  dynamic milkingCows;
  dynamic dryCows;
  dynamic heiferCows;
  dynamic sevenToTwelveMonthCows;
  dynamic sixMonthCow;
  dynamic bullCalfs;
  dynamic yieldPerCow;
  dynamic cowBreedId;

  RequestData({
    required this.id,
    this.heardSize,
    this.cowSum,
    this.milkingCows,
    this.dryCows,
    this.heiferCows,
    this.sevenToTwelveMonthCows,
    this.sixMonthCow,
    this.bullCalfs,
    this.yieldPerCow,
    this.cowBreedId
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cow_breed_id'] = cowBreedId;
    data['heard_size'] = heardSize;
    data['milking_cows'] = milkingCows;
    data['dry_cows'] = dryCows;
    data['bull_calfs'] = bullCalfs;
    data['heifer_cows'] = heiferCows;
    data['seven_to_twelve_month_cows'] = sevenToTwelveMonthCows;
    data['six_month_cow'] = sixMonthCow;
    data['yield_per_cow'] = yieldPerCow;
    return data;
  }
}

