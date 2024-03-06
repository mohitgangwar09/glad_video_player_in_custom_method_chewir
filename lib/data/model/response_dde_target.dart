
class ResponseDdeTarget {
  String? message;
  int? status;
  DdeData? data;

  ResponseDdeTarget({this.message, this.status, this.data});

  ResponseDdeTarget.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? DdeData.fromJson(json['data']) : null;
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

class DdeData {
  List<DdeCommissionSlab>? ddeCommissionSlab;
  String? assignedBadge;

  DdeData({this.ddeCommissionSlab, this.assignedBadge});

  DdeData.fromJson(Map<String, dynamic> json) {
    if (json['DdeCommissionSlab'] != null) {
      ddeCommissionSlab = <DdeCommissionSlab>[];
      json['DdeCommissionSlab'].forEach((v) {
        ddeCommissionSlab!.add(DdeCommissionSlab.fromJson(v));
      });
    }
    assignedBadge = json['assignedBadge'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ddeCommissionSlab != null) {
      data['DdeCommissionSlab'] =
          ddeCommissionSlab!.map((v) => v.toJson()).toList();
    }
    data['assignedBadge'] = assignedBadge;
    return data;
  }
}

class DdeCommissionSlab {
  dynamic id;
  dynamic ddeId;
  dynamic loanClosureFrom;
  dynamic loanClosureUpto;
  dynamic commissionPercent;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  String? targetStatus;

  DdeCommissionSlab(
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

  DdeCommissionSlab.fromJson(Map<String, dynamic> json) {
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
