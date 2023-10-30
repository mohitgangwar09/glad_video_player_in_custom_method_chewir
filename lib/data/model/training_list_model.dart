class TrainingListModel {
  String? message;
  int? status;
  List<Data>? data;

  TrainingListModel({this.message, this.status, this.data});

  TrainingListModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
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
  String? categoryName;
  String? image;
  Categories? categories;

  Data(
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
        this.categoryName,
        this.image,
        this.categories});

  Data.fromJson(Map<String, dynamic> json) {
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
    categoryName = json['category_name'];
    image = json['image'];
    categories = json['categories'] != null
        ? Categories.fromJson(json['categories'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['video_url'] = videoUrl;
    data['applicable_for'] = applicableFor;
    data['valid_from'] = validFrom;
    data['valid_to'] = validTo;
    data['status'] = status;
    data['category_id'] = categoryId;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['category_name'] = categoryName;
    data['image'] = image;
    if (categories != null) {
      data['categories'] = categories!.toJson();
    }
    return data;
  }
}

class Categories {
  dynamic id;
  String? type;
  String? name;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;

  Categories(
      {this.id,
        this.type,
        this.name,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['name'] = name;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
