class UpdateRecordMonthBreedModel {

  int monthId;
  int farmerId;
  List<RequestData> requestData;

  UpdateRecordMonthBreedModel({
    required this.monthId,
    required this.farmerId,
    required this.requestData,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month_id'] = monthId;
    data['farmer_id'] = farmerId;
    data['requestData'] = requestData.map((v) => v).toList();

    return data;
  }

}

class RequestData {
  int id;
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

