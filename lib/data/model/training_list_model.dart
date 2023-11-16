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
  Youtube? youtube;
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
        this.youtube,
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
    youtube =
    json['youtube'] != null ? new Youtube.fromJson(json['youtube']) : null;
    image = json['image'];
    categories = json['categories'] != null
        ? new Categories.fromJson(json['categories'])
        : null;
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
    data['category_name'] = this.categoryName;
    if (this.youtube != null) {
      data['youtube'] = this.youtube!.toJson();
    }
    data['image'] = this.image;
    if (this.categories != null) {
      data['categories'] = this.categories!.toJson();
    }
    return data;
  }
}

class Youtube {
  String? viewCount;
  String? likeCount;
  String? favoriteCount;
  String? commentCount;

  Youtube(
      {this.viewCount, this.likeCount, this.favoriteCount, this.commentCount});

  Youtube.fromJson(Map<String, dynamic> json) {
    viewCount = json['viewCount'];
    likeCount = json['likeCount'];
    favoriteCount = json['favoriteCount'];
    commentCount = json['commentCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['viewCount'] = this.viewCount;
    data['likeCount'] = this.likeCount;
    data['favoriteCount'] = this.favoriteCount;
    data['commentCount'] = this.commentCount;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_by'] = this.deletedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

