class ResponseMyLivestock {
  String? message;
  int? status;
  List<DataMyLiveStock>? data;

  ResponseMyLivestock({this.message, this.status, this.data});

  ResponseMyLivestock.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataMyLiveStock>[];
      json['data'].forEach((v) {
        data!.add(DataMyLiveStock.fromJson(v));
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

class DataMyLiveStock {
  int? id;
  int? userId;
  dynamic advertisementNo;
  dynamic cowBreedId;
  dynamic userRole;
  String? userName;
  dynamic date;
  String? breedCode;
  String? breedName;
  dynamic cowQty;
  dynamic soldQty;
  dynamic loanAccepted;
  dynamic loanApproved;
  dynamic balanceCows;
  dynamic fileType;
  dynamic price;
  dynamic age;
  dynamic lactation;
  dynamic pregnant;
  String? yield;
  String? description;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  List<LiveStockDocumentFiles>? liveStockDocumentFiles;
  dynamic isInCart;
  User? user;
  CowBreed? cowBreed;

  DataMyLiveStock(
      {this.id,
        this.userId,
        this.advertisementNo,
        this.cowBreedId,
        this.userRole,
        this.userName,
        this.date,
        this.breedCode,
        this.breedName,
        this.cowQty,
        this.soldQty,
        this.loanAccepted,
        this.loanApproved,
        this.balanceCows,
        this.fileType,
        this.price,
        this.age,
        this.lactation,
        this.pregnant,
        this.yield,
        this.description,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.liveStockDocumentFiles,
        this.isInCart,
        this.user,
        this.cowBreed});

  DataMyLiveStock.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    advertisementNo = json['advertisement_no'];
    cowBreedId = json['cow_breed_id'];
    userRole = json['user_role'];
    userName = json['user_name'];
    date = json['date'];
    breedCode = json['breed_code'];
    breedName = json['breed_name'];
    cowQty = json['cow_qty'];
    soldQty = json['sold_qty'];
    loanAccepted = json['loan_accepted'];
    loanApproved = json['loan_approved'];
    balanceCows = json['balance_cows'];
    fileType = json['file_type'];
    price = json['price'];
    age = json['age'];
    lactation = json['lactation'];
    pregnant = json['pregnant'];
    yield = json['yield'];
    description = json['description'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['live_stock_document_files'] != null) {
      liveStockDocumentFiles = <LiveStockDocumentFiles>[];
      json['live_stock_document_files'].forEach((v) {
        liveStockDocumentFiles!.add(LiveStockDocumentFiles.fromJson(v));
      });
    }
    isInCart = json['is_in_cart'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    cowBreed = json['cow_breed'] != null
        ? CowBreed.fromJson(json['cow_breed'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['advertisement_no'] = advertisementNo;
    data['cow_breed_id'] = cowBreedId;
    data['user_role'] = userRole;
    data['user_name'] = userName;
    data['date'] = date;
    data['breed_code'] = breedCode;
    data['breed_name'] = breedName;
    data['cow_qty'] = cowQty;
    data['sold_qty'] = soldQty;
    data['loan_accepted'] = loanAccepted;
    data['loan_approved'] = loanApproved;
    data['balance_cows'] = balanceCows;
    data['file_type'] = fileType;
    data['price'] = price;
    data['age'] = age;
    data['lactation'] = lactation;
    data['pregnant'] = pregnant;
    data['yield'] = yield;
    data['description'] = description;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (liveStockDocumentFiles != null) {
      data['live_stock_document_files'] =
          liveStockDocumentFiles!.map((v) => v.toJson()).toList();
    }
    data['is_in_cart'] = isInCart;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (cowBreed != null) {
      data['cow_breed'] = cowBreed!.toJson();
    }
    return data;
  }
}

class LiveStockDocumentFiles {
  int? id;
  String? modelType;
  int? modelId;
  String? uuid;
  String? collectionName;
  String? name;
  String? fileName;
  String? mimeType;
  String? disk;
  String? conversionsDisk;
  int? size;
  List<dynamic>? manipulations;
  List<dynamic>? customProperties;
  List<dynamic>? generatedConversions;
  List<dynamic>? responsiveImages;
  int? orderColumn;
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
        this.manipulations,
        this.customProperties,
        this.generatedConversions,
        this.responsiveImages,
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
    if (json['manipulations'] != null) {
      manipulations = <Null>[];
      json['manipulations'].forEach((v) {
        manipulations!.add(v);
      });
    }
    if (json['custom_properties'] != null) {
      customProperties = <Null>[];
      json['custom_properties'].forEach((v) {
        customProperties!.add(v);
      });
    }
    if (json['generated_conversions'] != null) {
      generatedConversions = <Null>[];
      json['generated_conversions'].forEach((v) {
        generatedConversions!.add(v);
      });
    }
    if (json['responsive_images'] != null) {
      responsiveImages = <Null>[];
      json['responsive_images'].forEach((v) {
        responsiveImages!.add(v);
      });
    }
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
    data['full_url'] = fullUrl;
    data['original_url'] = originalUrl;
    data['preview_url'] = previewUrl;
    return data;
  }
}

class User {
  int? id;
  String? userType;
  dynamic userCode;
  dynamic hasPassword;
  String? mobile;
  int? isMobileVerified;
  dynamic dateOfBirth;
  dynamic gender;
  String? status;
  String? deviceToken;
  String? loginAt;
  dynamic logoutAt;
  String? name;
  String? email;
  String? supplierId;
  dynamic emailVerifiedAt;
  dynamic twoFactorConfirmedAt;
  dynamic currentTeamId;
  dynamic profilePhotoPath;
  String? createdAt;
  String? updatedAt;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic isFirst;
  String? profilePic;
  dynamic badge;
  dynamic kycStatus;
  dynamic kycRemarks;
  dynamic address;

  User(
      {this.id,
        this.userType,
        this.userCode,
        this.hasPassword,
        this.mobile,
        this.isMobileVerified,
        this.dateOfBirth,
        this.gender,
        this.status,
        this.deviceToken,
        this.loginAt,
        this.logoutAt,
        this.name,
        this.email,
        this.supplierId,
        this.emailVerifiedAt,
        this.twoFactorConfirmedAt,
        this.currentTeamId,
        this.profilePhotoPath,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.isFirst,
        this.profilePic,
        this.badge,
        this.kycStatus,
        this.kycRemarks,
        this.address});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
    userCode = json['user_code'];
    hasPassword = json['has_password'];
    mobile = json['mobile'];
    isMobileVerified = json['is_mobile_verified'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    status = json['status'];
    deviceToken = json['device_token'];
    loginAt = json['login_at'];
    logoutAt = json['logout_at'];
    name = json['name'];
    email = json['email'];
    supplierId = json['supplier_id'];
    emailVerifiedAt = json['email_verified_at'];
    twoFactorConfirmedAt = json['two_factor_confirmed_at'];
    currentTeamId = json['current_team_id'];
    profilePhotoPath = json['profile_photo_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    isFirst = json['is_first'];
    profilePic = json['profile_pic'];
    badge = json['badge'];
    kycStatus = json['kyc_status'];
    kycRemarks = json['kyc_remarks'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_type'] = userType;
    data['user_code'] = userCode;
    data['has_password'] = hasPassword;
    data['mobile'] = mobile;
    data['is_mobile_verified'] = isMobileVerified;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['status'] = status;
    data['device_token'] = deviceToken;
    data['login_at'] = loginAt;
    data['logout_at'] = logoutAt;
    data['name'] = name;
    data['email'] = email;
    data['supplier_id'] = supplierId;
    data['email_verified_at'] = emailVerifiedAt;
    data['two_factor_confirmed_at'] = twoFactorConfirmedAt;
    data['current_team_id'] = currentTeamId;
    data['profile_photo_path'] = profilePhotoPath;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['is_first'] = isFirst;
    data['profile_pic'] = profilePic;
    data['badge'] = badge;
    data['kyc_status'] = kycStatus;
    data['kyc_remarks'] = kycRemarks;
    data['address'] = address;
    return data;
  }
}

class CowBreed {
  int? id;
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
