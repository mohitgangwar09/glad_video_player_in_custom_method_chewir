class ResponseAddLivestock {
  String? message;
  int? status;
  Data? data;

  ResponseAddLivestock({this.message, this.status, this.data});

  ResponseAddLivestock.fromJson(Map<String, dynamic> json) {
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
  String? cowBreedId;
  String? yield;
  String? age;
  String? lactation;
  String? price;
  String? pregnant;
  String? cowQty;
  String? description;
  dynamic userId;
  String? userName;
  String? advertisementNo;
  dynamic createdBy;
  String? updatedAt;
  String? createdAt;
  dynamic id;
  CowBreed? cowBreed;
  List<LiveStockDocumentFiles>? liveStockDocumentFiles;

  Data(
      {this.cowBreedId,
        this.yield,
        this.age,
        this.lactation,
        this.price,
        this.pregnant,
        this.cowQty,
        this.description,
        this.userId,
        this.userName,
        this.advertisementNo,
        this.createdBy,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.cowBreed,
        this.liveStockDocumentFiles});

  Data.fromJson(Map<String, dynamic> json) {
    cowBreedId = json['cow_breed_id'];
    yield = json['yield'];
    age = json['age'];
    lactation = json['lactation'];
    price = json['price'];
    pregnant = json['pregnant'];
    cowQty = json['cow_qty'];
    description = json['description'];
    userId = json['user_id'];
    userName = json['user_name'];
    advertisementNo = json['advertisement_no'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    cowBreed = json['cow_breed'] != null
        ? CowBreed.fromJson(json['cow_breed'])
        : null;
    if (json['live_stock_document_files'] != null) {
      liveStockDocumentFiles = <LiveStockDocumentFiles>[];
      json['live_stock_document_files'].forEach((v) {
        liveStockDocumentFiles!.add(LiveStockDocumentFiles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cow_breed_id'] = cowBreedId;
    data['yield'] = yield;
    data['age'] = age;
    data['lactation'] = lactation;
    data['price'] = price;
    data['pregnant'] = pregnant;
    data['cow_qty'] = cowQty;
    data['description'] = description;
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['advertisement_no'] = advertisementNo;
    data['created_by'] = createdBy;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    if (cowBreed != null) {
      data['cow_breed'] = cowBreed!.toJson();
    }
    if (liveStockDocumentFiles != null) {
      data['live_stock_document_files'] =
          liveStockDocumentFiles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CowBreed {
  dynamic id;
  String? name;

  CowBreed({this.id, this.name});

  CowBreed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class LiveStockDocumentFiles {
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
  String? fullUrl;
  String? originalUrl;
  String? previewUrl;

  LiveStockDocumentFiles(
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
        this.fullUrl,
        this.originalUrl,
        this.previewUrl});

  LiveStockDocumentFiles.fromJson(Map<String, dynamic> json) {
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
    fullUrl = json['full_url'];
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
    data['order_column'] = orderColumn;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['full_url'] = fullUrl;
    data['original_url'] = originalUrl;
    data['preview_url'] = previewUrl;
    return data;
  }
}
