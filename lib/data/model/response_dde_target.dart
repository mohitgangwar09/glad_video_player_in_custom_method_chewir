class ResponseDdeTarget {
  String? message;
  int? status;
  List<DataTarget>? data;

  ResponseDdeTarget({this.message, this.status, this.data});

  ResponseDdeTarget.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataTarget>[];
      json['data'].forEach((v) {
        data!.add(DataTarget.fromJson(v));
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

class DataTarget {
  dynamic id;
  dynamic ddeId;
  dynamic loanClosureFrom;
  dynamic loanClosureUpto;
  dynamic commissionPercent;
  dynamic status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic targetStatus;

  DataTarget(
      {this.id,
        this.ddeId,
        this.loanClosureFrom,
        this.loanClosureUpto,
        this.commissionPercent,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.targetStatus});

  DataTarget.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ddeId = json['dde_id'];
    loanClosureFrom = json['loan_closure_from'];
    loanClosureUpto = json['loan_closure_upto'];
    commissionPercent = json['commission_percent'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    targetStatus = json['target_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['dde_id'] = ddeId;
    data['loan_closure_from'] = loanClosureFrom;
    data['loan_closure_upto'] = loanClosureUpto;
    data['commission_percent'] = commissionPercent;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['target_status'] = targetStatus;
    return data;
  }
}
