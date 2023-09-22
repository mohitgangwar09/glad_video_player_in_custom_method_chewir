class ImprovementAreaListModel {
  String? message;
  int? status;
  Data? data;

  ImprovementAreaListModel({this.message, this.status, this.data});

  ImprovementAreaListModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  List<ImprovementAreaList>? improvementAreaList;

  Data({this.improvementAreaList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['improvement_area_list'] != null) {
      improvementAreaList = <ImprovementAreaList>[];
      json['improvement_area_list'].forEach((v) {
        improvementAreaList!.add(ImprovementAreaList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (improvementAreaList != null) {
      data['improvement_area_list'] =
          improvementAreaList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImprovementAreaList {
  dynamic id;
  String? name;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic image;
  List<FarmerImprovementArea>? farmerImprovementArea;
  Results? results;

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
        this.farmerImprovementArea,
        this.results});

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
        farmerImprovementArea!.add(FarmerImprovementArea.fromJson(v));
      });
    }
    results =
    json['results'] != null ? Results.fromJson(json['results']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['image'] = image;
    if (farmerImprovementArea != null) {
      data['farmer_improvement_area'] =
          farmerImprovementArea!.map((v) => v.toJson()).toList();
    }
    if (results != null) {
      data['results'] = results!.toJson();
    }
    return data;
  }
}

class FarmerImprovementArea {
  dynamic id;
  dynamic improvementAreaId;
  dynamic farmerId;
  String? parameter;
  String? value;
  String? uom;

  FarmerImprovementArea(
      {this.id,
        this.improvementAreaId,
        this.farmerId,
        this.parameter,
        this.value,
        this.uom});

  FarmerImprovementArea.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    improvementAreaId = json['improvement_area_id'];
    farmerId = json['farmer_id'];
    parameter = json['parameter'];
    value = json['value'];
    uom = json['uom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['improvement_area_id'] = improvementAreaId;
    data['farmer_id'] = farmerId;
    data['parameter'] = parameter;
    data['value'] = value;
    data['uom'] = uom;
    return data;
  }
}

class Results {
  dynamic lossOfMilkPerCow;
  dynamic expectedYieldPerCow;
  dynamic incrementalProduction;
  dynamic incrementalEarning;

  Results(
      {this.lossOfMilkPerCow,
        this.expectedYieldPerCow,
        this.incrementalProduction,
        this.incrementalEarning});

  Results.fromJson(Map<String, dynamic> json) {
    lossOfMilkPerCow = json['lossOfMilkPerCow'];
    expectedYieldPerCow = json['expectedYieldPerCow'];
    incrementalProduction = json['incrementalProduction'];
    incrementalEarning = json['incrementalEarning'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lossOfMilkPerCow'] = lossOfMilkPerCow;
    data['expectedYieldPerCow'] = expectedYieldPerCow;
    data['incrementalProduction'] = incrementalProduction;
    data['incrementalEarning'] = incrementalEarning;
    return data;
  }
}

