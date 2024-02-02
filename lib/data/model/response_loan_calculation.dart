class ResponseLoanCalculation {
  String? message;
  int? status;
  DataLoanCalculation? data;

  ResponseLoanCalculation({this.message, this.status, this.data});

  ResponseLoanCalculation.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? DataLoanCalculation.fromJson(json['data']) : null;
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

class DataLoanCalculation {
  dynamic rateOfInterest;
  dynamic totalRepayment;
  dynamic emiAmount;

  DataLoanCalculation({this.rateOfInterest, this.totalRepayment, this.emiAmount});

  DataLoanCalculation.fromJson(Map<String, dynamic> json) {
    rateOfInterest = json['rate_of_interest'];
    totalRepayment = json['total_repayment'];
    emiAmount = json['emi_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rate_of_interest'] = rateOfInterest;
    data['total_repayment'] = totalRepayment;
    data['emi_amount'] = emiAmount;
    return data;
  }
}
