class SupplierDashboardModel {
  String? message;
  int? status;
  Data? data;

  SupplierDashboardModel({this.message, this.status, this.data});

  SupplierDashboardModel.fromJson(Map<String, dynamic> json) {
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
  List<FarmerProjetSurvey>? farmerProjetSurvey;
  List<Null>? farmerProjet;
  List<NewsEvent>? newsEvent;
  List<Null>? community;
  List<TrainingList>? trainingList;

  Data(
      {this.farmerProjetSurvey,
        this.farmerProjet,
        this.newsEvent,
        this.community,
        this.trainingList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['farmerProjetSurvey'] != null) {
      farmerProjetSurvey = <FarmerProjetSurvey>[];
      json['farmerProjetSurvey'].forEach((v) {
        farmerProjetSurvey!.add(new FarmerProjetSurvey.fromJson(v));
      });
    }
    // if (json['farmerProjet'] != null) {
    //   farmerProjet = <Null>[];
    //   json['farmerProjet'].forEach((v) {
    //     farmerProjet!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['newsEvent'] != null) {
      newsEvent = <NewsEvent>[];
      json['newsEvent'].forEach((v) {
        newsEvent!.add(new NewsEvent.fromJson(v));
      });
    }
    // if (json['community'] != null) {
    //   community = <Null>[];
    //   json['community'].forEach((v) {
    //     community!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['trainingList'] != null) {
      trainingList = <TrainingList>[];
      json['trainingList'].forEach((v) {
        trainingList!.add(new TrainingList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.farmerProjetSurvey != null) {
      data['farmerProjetSurvey'] =
          this.farmerProjetSurvey!.map((v) => v.toJson()).toList();
    }
    // if (this.farmerProjet != null) {
    //   data['farmerProjet'] = this.farmerProjet!.map((v) => v.toJson()).toList();
    // }
    if (this.newsEvent != null) {
      data['newsEvent'] = this.newsEvent!.map((v) => v.toJson()).toList();
    }
    // if (this.community != null) {
    //   data['community'] = this.community!.map((v) => v.toJson()).toList();
    // }
    if (this.trainingList != null) {
      data['trainingList'] = this.trainingList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FarmerProjetSurvey {
  String? surveyStatus;
  dynamic count;

  FarmerProjetSurvey({this.surveyStatus, this.count});

  FarmerProjetSurvey.fromJson(Map<String, dynamic> json) {
    surveyStatus = json['survey_status'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['survey_status'] = this.surveyStatus;
    data['count'] = this.count;
    return data;
  }
}

class NewsEvent {
  dynamic id;
  String? title;
  String? webUrl;
  String? description;
  String? validFrom;
  String? validTo;
  String? status;
  dynamic categoryId;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  String? image;
  Resource? resource;

  NewsEvent(
      {this.id,
        this.title,
        this.webUrl,
        this.description,
        this.validFrom,
        this.validTo,
        this.status,
        this.categoryId,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.image,
        this.resource});

  NewsEvent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    webUrl = json['web_url'];
    description = json['description'];
    validFrom = json['valid_from'];
    validTo = json['valid_to'];
    status = json['status'];
    categoryId = json['category_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    resource = json['resource'] != null
        ? new Resource.fromJson(json['resource'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['web_url'] = this.webUrl;
    data['description'] = this.description;
    data['valid_from'] = this.validFrom;
    data['valid_to'] = this.validTo;
    data['status'] = this.status;
    data['category_id'] = this.categoryId;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_by'] = this.deletedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    if (this.resource != null) {
      data['resource'] = this.resource!.toJson();
    }
    return data;
  }
}

class Resource {
  dynamic id;
  String? modelType;
  dynamic modelId;
  String? uuid;
  String? collectionName;
  String? name;
  String? fileName;
  String? mimeType;
  String? disk;
  String? conversionsDisk;
  dynamic size;
  dynamic orderColumn;
  String? createdAt;
  String? updatedAt;
  String? originalUrl;
  String? previewUrl;

  Resource(
      {this.id,
        this.modelType,
        this.modelId,
        this.uuid,
        this.collectionName,
        this.name,
        this.fileName,
        this.mimeType,
        this.disk,
        this.conversionsDisk,
        this.size,
        this.orderColumn,
        this.createdAt,
        this.updatedAt,
        this.originalUrl,
        this.previewUrl});

  Resource.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelType = json['model_type'];
    modelId = json['model_id'];
    uuid = json['uuid'];
    collectionName = json['collection_name'];
    name = json['name'];
    fileName = json['file_name'];
    mimeType = json['mime_type'];
    disk = json['disk'];
    conversionsDisk = json['conversions_disk'];
    size = json['size'];
    orderColumn = json['order_column'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    originalUrl = json['original_url'];
    previewUrl = json['preview_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['model_type'] = this.modelType;
    data['model_id'] = this.modelId;
    data['uuid'] = this.uuid;
    data['collection_name'] = this.collectionName;
    data['name'] = this.name;
    data['file_name'] = this.fileName;
    data['mime_type'] = this.mimeType;
    data['disk'] = this.disk;
    data['conversions_disk'] = this.conversionsDisk;
    data['size'] = this.size;
    data['order_column'] = this.orderColumn;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['original_url'] = this.originalUrl;
    data['preview_url'] = this.previewUrl;
    return data;
  }
}

class TrainingList {
  dynamic id;
  String? title;
  String? videoUrl;
  List<String>? applicableFor;
  String? validFrom;
  String? validTo;
  String? status;
  dynamic categoryId;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  String? image;

  TrainingList(
      {this.id,
        this.title,
        this.videoUrl,
        this.applicableFor,
        this.validFrom,
        this.validTo,
        this.status,
        this.categoryId,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.image});

  TrainingList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    videoUrl = json['video_url'];
    applicableFor = json['applicable_for'].cast<String>();
    validFrom = json['valid_from'];
    validTo = json['valid_to'];
    status = json['status'];
    categoryId = json['category_id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['video_url'] = this.videoUrl;
    data['applicable_for'] = this.applicableFor;
    data['valid_from'] = this.validFrom;
    data['valid_to'] = this.validTo;
    data['status'] = this.status;
    data['category_id'] = this.categoryId;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_by'] = this.deletedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    return data;
  }
}
