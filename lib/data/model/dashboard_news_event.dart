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
        ? Resource.fromJson(json['resource'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['web_url'] = webUrl;
    data['description'] = description;
    data['valid_from'] = validFrom;
    data['valid_to'] = validTo;
    data['status'] = status;
    data['category_id'] = categoryId;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['image'] = image;
    if (resource != null) {
      data['resource'] = resource!.toJson();
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
  List<dynamic>? manipulations;
  List<dynamic>? customProperties;
  List<dynamic>? generatedConversions;
  List<dynamic>? responsiveImages;
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
        this.manipulations,
        this.customProperties,
        this.generatedConversions,
        this.responsiveImages,
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['model_type'] = modelType;
    data['model_id'] = modelId;
    data['uuid'] = uuid;
    data['collection_name'] = collectionName;
    data['name'] = name;
    data['file_name'] = fileName;
    data['mime_type'] = mimeType;
    data['disk'] = disk;
    data['conversions_disk'] = conversionsDisk;
    data['size'] = size;
    if (manipulations != null) {
      data['manipulations'] =
          manipulations!.map((v) => v.toJson()).toList();
    }
    if (customProperties != null) {
      data['custom_properties'] =
          customProperties!.map((v) => v.toJson()).toList();
    }
    if (generatedConversions != null) {
      data['generated_conversions'] =
          generatedConversions!.map((v) => v.toJson()).toList();
    }
    if (responsiveImages != null) {
      data['responsive_images'] =
          responsiveImages!.map((v) => v.toJson()).toList();
    }
    data['order_column'] = orderColumn;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['original_url'] = originalUrl;
    data['preview_url'] = previewUrl;
    return data;
  }
}