// class ImprovementAreaListModel {
//   String? message;
//   int? status;
//   Data? data;
//
//   ImprovementAreaListModel({this.message, this.status, this.data});
//
//   ImprovementAreaListModel.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     status = json['status'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message;
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   List<ImprovementAreaList>? improvementAreaList;
//
//   Data({this.improvementAreaList});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['improvement_area_list'] != null) {
//       improvementAreaList = <ImprovementAreaList>[];
//       json['improvement_area_list'].forEach((v) {
//         improvementAreaList!.add(new ImprovementAreaList.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.improvementAreaList != null) {
//       data['improvement_area_list'] =
//           this.improvementAreaList!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class ImprovementAreaList {
//   int? id;
//   String? name;
//   String? status;
//   dynamic createdBy;
//   dynamic updatedBy;
//   dynamic deletedBy;
//   dynamic createdAt;
//   dynamic updatedAt;
//   dynamic image;
//   List<FarmerImprovementArea>? farmerImprovementArea;
//
//   ImprovementAreaList(
//       {this.id,
//         this.name,
//         this.status,
//         this.createdBy,
//         this.updatedBy,
//         this.deletedBy,
//         this.createdAt,
//         this.updatedAt,
//         this.image,
//         this.farmerImprovementArea});
//
//   ImprovementAreaList.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     status = json['status'];
//     createdBy = json['created_by'];
//     updatedBy = json['updated_by'];
//     deletedBy = json['deleted_by'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     image = json['image'];
//     if (json['farmer_improvement_area'] != null) {
//       farmerImprovementArea = <FarmerImprovementArea>[];
//       json['farmer_improvement_area'].forEach((v) {
//         farmerImprovementArea!.add(new FarmerImprovementArea.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['status'] = this.status;
//     data['created_by'] = this.createdBy;
//     data['updated_by'] = this.updatedBy;
//     data['deleted_by'] = this.deletedBy;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['image'] = this.image;
//     if (this.farmerImprovementArea != null) {
//       data['farmer_improvement_area'] =
//           this.farmerImprovementArea!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class FarmerImprovementArea {
//   int? id;
//   int? improvementAreaId;
//   int? farmerId;
//   String? parameter;
//   String? value;
//
//   FarmerImprovementArea(
//       {this.id,
//         this.improvementAreaId,
//         this.farmerId,
//         this.parameter,
//         this.value});
//
//   FarmerImprovementArea.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     improvementAreaId = json['improvement_area_id'];
//     farmerId = json['farmer_id'];
//     parameter = json['parameter'];
//     value = json['value'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['improvement_area_id'] = this.improvementAreaId;
//     data['farmer_id'] = this.farmerId;
//     data['parameter'] = this.parameter;
//     data['value'] = this.value;
//     return data;
//   }
// }

class ImprovementAreaListModel {
  String? message;
  int? status;
  Data? data;

  ImprovementAreaListModel({this.message, this.status, this.data});

  ImprovementAreaListModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<ImprovementAreaList>? improvementAreaList;

  Data({this.improvementAreaList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['improvement_area_list'] != null) {
      improvementAreaList = <ImprovementAreaList>[];
      json['improvement_area_list'].forEach((v) {
        improvementAreaList!.add(new ImprovementAreaList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.improvementAreaList != null) {
      data['improvement_area_list'] =
          this.improvementAreaList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImprovementAreaList {
  int? id;
  String? name;
  String? status;
  Null? createdBy;
  Null? updatedBy;
  Null? deletedBy;
  Null? createdAt;
  Null? updatedAt;
  Null? image;
  List<FarmerImprovementArea>? farmerImprovementArea;

  ImprovementAreaList(
      {this.id,
        this.name,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.image,
        this.farmerImprovementArea});

  ImprovementAreaList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    if (json['farmer_improvement_area'] != null) {
      farmerImprovementArea = <FarmerImprovementArea>[];
      json['farmer_improvement_area'].forEach((v) {
        farmerImprovementArea!.add(new FarmerImprovementArea.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_by'] = this.deletedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    if (this.farmerImprovementArea != null) {
      data['farmer_improvement_area'] =
          this.farmerImprovementArea!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FarmerImprovementArea {
  int? id;
  int? improvementAreaId;
  int? farmerId;
  String? parameter;
  String? value;
  dynamic expectedIncrementalProduction;
  dynamic expectedIncrementalEarning;

  FarmerImprovementArea(
      {this.id,
        this.improvementAreaId,
        this.farmerId,
        this.parameter,
        this.value,
        this.expectedIncrementalProduction,
        this.expectedIncrementalEarning});

  FarmerImprovementArea.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    improvementAreaId = json['improvement_area_id'];
    farmerId = json['farmer_id'];
    parameter = json['parameter'];
    value = json['value'];
    expectedIncrementalProduction =
    json['Expected Incremental Production'] != null
        ? new ExpectedIncrementalProduction.fromJson(
        json['Expected Incremental Production'])
        : null;
    expectedIncrementalEarning = json['Expected Incremental earning'] != null
        ? new ExpectedIncrementalProduction.fromJson(
        json['Expected Incremental earning'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['improvement_area_id'] = this.improvementAreaId;
    data['farmer_id'] = this.farmerId;
    data['parameter'] = this.parameter;
    data['value'] = this.value;
    if (this.expectedIncrementalProduction != null) {
      data['Expected Incremental Production'] =
          this.expectedIncrementalProduction!.toJson();
    }
    if (this.expectedIncrementalEarning != null) {
      data['Expected Incremental earning'] =
          this.expectedIncrementalEarning!.toJson();
    }
    return data;
  }
}

class ExpectedIncrementalProduction {
  int? perDay;
  int? permonth;
  int? perYear;

  ExpectedIncrementalProduction({this.perDay, this.permonth, this.perYear});

  ExpectedIncrementalProduction.fromJson(Map<String, dynamic> json) {
    perDay = json['perDay'];
    permonth = json['permonth'];
    perYear = json['perYear'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['perDay'] = this.perDay;
    data['permonth'] = this.permonth;
    data['perYear'] = this.perYear;
    return data;
  }
}
