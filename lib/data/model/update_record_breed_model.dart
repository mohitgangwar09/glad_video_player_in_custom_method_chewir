class UpdateRecordMonthBreedModel {

  int monthId;
  int farmerId;
  List<RequestData> requestData;

  UpdateRecordMonthBreedModel({
    required this.monthId,
    required this.farmerId,
    required this.requestData,
  });

/*  factory UpdateRecordMonthBreedModel.fromJson(dynamic json) {
    return UpdateRecordMonthBreedModel(json['month_id'] as int);
  }

  @override
  String toString() {
    return '{ ${this.monthId}, ${this.description}, ${this.author} }';
  }*/

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
  dynamic yieldPeCow;
  dynamic cowBreedId;

  RequestData(
  this.id,
  this.heardSize,
  this.milkingCows,
  this.dryCows,
  this.heiferCows,
  this.sevenToTwelveMonthCows,
  this.sixMonthCow,
  this.bullCalfs,
  this.yieldPeCow,
  this.cowBreedId);
}

