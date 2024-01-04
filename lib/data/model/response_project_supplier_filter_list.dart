class ResponseProjectSupplierFilterDropdownList {
  String? message;
  int? status;
  List<DataSupplierFilter>? data;

  ResponseProjectSupplierFilterDropdownList({this.message, this.status, this.data});

  ResponseProjectSupplierFilterDropdownList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataSupplierFilter>[];
      json['data'].forEach((v) {
        data!.add(DataSupplierFilter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataSupplierFilter {
  String? name;
  int? projectBalance;
  String? paymentStatus;

  DataSupplierFilter({this.name, this.projectBalance, this.paymentStatus});

  DataSupplierFilter.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    projectBalance = json['project_balance'];
    paymentStatus = json['payment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['project_balance'] = projectBalance;
    data['payment_status'] = paymentStatus;
    return data;
  }
}
