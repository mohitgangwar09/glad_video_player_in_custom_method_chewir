class ModelTotalProduction {

  String suppliedToPdfl;
  String suppliedToOther;
  String selfUseController;
  double totalMilkProduction;

  ModelTotalProduction({
    required this.suppliedToPdfl,
    required this.suppliedToOther,
    required this.selfUseController,
    required this.totalMilkProduction,
  });

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['month_id'] = monthId;
  //   data['farmer_id'] = farmerId;
  //   data['requestData'] = requestData.map((v) => v).toList();
  //
  //   return data;
  // }

}