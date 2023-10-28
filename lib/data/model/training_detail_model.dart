class TrainingDetailModel {
  String? message;
  int? status;
  Data? data;

  TrainingDetailModel({this.message, this.status, this.data});

  TrainingDetailModel.fromJson(Map<String, dynamic> json) {
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
  dynamic id;
  String? title;
  String? videoUrl;
  List<String>? applicableFor;
  String? validFrom;
  String? validTo;
  dynamic categoryId;
  String? image;
  Categories? categories;

  Data(
      {this.id,
        this.title,
        this.videoUrl,
        this.applicableFor,
        this.validFrom,
        this.validTo,
        this.categoryId,
        this.image,
        this.categories});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    videoUrl = json['video_url'];
    applicableFor = json['applicable_for'].cast<String>();
    validFrom = json['valid_from'];
    validTo = json['valid_to'];
    categoryId = json['category_id'];
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
    data['category_id'] = this.categoryId;
    data['image'] = this.image;
    if (this.categories != null) {
      data['categories'] = this.categories!.toJson();
    }
    return data;
  }
}

class Categories {
  dynamic id;
  String? type;
  String? name;

  Categories({this.id, this.type, this.name});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;
    return data;
  }
}
