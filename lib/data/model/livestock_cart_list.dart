class LivestockCartList {
  String? message;
  int? status;
  List<Data>? data;

  LivestockCartList({this.message, this.status, this.data});

  LivestockCartList.fromJson(Map<String, dynamic> json) {
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
  dynamic livestockId;
  dynamic userId;
  dynamic sellerId;
  dynamic cowQty;
  dynamic cowPrice;
  dynamic loanStatus;
  dynamic statusDate;
  dynamic remarks;
  dynamic farmerParticipation;
  dynamic loanAmount;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  List<LiveStockCartDetails>? liveStockCartDetails;

  Data(
      {this.id,
        this.livestockId,
        this.userId,
        this.sellerId,
        this.cowQty,
        this.cowPrice,
        this.loanStatus,
        this.statusDate,
        this.remarks,
        this.farmerParticipation,
        this.loanAmount,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.liveStockCartDetails});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    livestockId = json['livestock_id'];
    userId = json['user_id'];
    sellerId = json['seller_id'];
    cowQty = json['cow_qty'];
    cowPrice = json['cow_price'];
    loanStatus = json['loan_status'];
    statusDate = json['status_date'];
    remarks = json['remarks'];
    farmerParticipation = json['farmer_participation'];
    loanAmount = json['loan_amount'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['live_stock_cart_details'] != null) {
      liveStockCartDetails = <LiveStockCartDetails>[];
      json['live_stock_cart_details'].forEach((v) {
        liveStockCartDetails!.add(LiveStockCartDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['livestock_id'] = livestockId;
    data['user_id'] = userId;
    data['seller_id'] = sellerId;
    data['cow_qty'] = cowQty;
    data['cow_price'] = cowPrice;
    data['loan_status'] = loanStatus;
    data['status_date'] = statusDate;
    data['remarks'] = remarks;
    data['farmer_participation'] = farmerParticipation;
    data['loan_amount'] = loanAmount;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (liveStockCartDetails != null) {
      data['live_stock_cart_details'] =
          liveStockCartDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LiveStockCartDetails {
  dynamic id;
  dynamic liveStockCartId;
  dynamic liveStockId;
  dynamic cowQty;
  dynamic cowPrice;
  String? deliveryStatus;
  dynamic remarks;
  dynamic deliveryDate;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  dynamic pictures;
  LiveStock? liveStock;
  List<dynamic>? media;

  LiveStockCartDetails(
      {this.id,
        this.liveStockCartId,
        this.liveStockId,
        this.cowQty,
        this.cowPrice,
        this.deliveryStatus,
        this.remarks,
        this.deliveryDate,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.pictures,
        this.liveStock,
        this.media});

  LiveStockCartDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    liveStockCartId = json['live_stock_cart_id'];
    liveStockId = json['live_stock_id'];
    cowQty = json['cow_qty'];
    cowPrice = json['cow_price'];
    deliveryStatus = json['delivery_status'];
    remarks = json['remarks'];
    deliveryDate = json['delivery_date'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pictures = json['pictures'];
    liveStock = json['live_stock'] != null
        ? LiveStock.fromJson(json['live_stock'])
        : null;
    if (json['media'] != null) {
      media = <Null>[];
      json['media'].forEach((v) {
        media!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['live_stock_cart_id'] = liveStockCartId;
    data['live_stock_id'] = liveStockId;
    data['cow_qty'] = cowQty;
    data['cow_price'] = cowPrice;
    data['delivery_status'] = deliveryStatus;
    data['remarks'] = remarks;
    data['delivery_date'] = deliveryDate;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['pictures'] = pictures;
    if (liveStock != null) {
      data['live_stock'] = liveStock!.toJson();
    }
    if (media != null) {
      data['media'] = media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LiveStock {
  dynamic id;
  dynamic userId;
  String? advertisementNo;
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
  CowBreed? cowBreed;
  User? user;
  LiveStockNegotiation? liveStockNegotiation;

  LiveStock(
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
        this.cowBreed,
        this.user,
        this.liveStockNegotiation});

  LiveStock.fromJson(Map<String, dynamic> json) {
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
    liveStockNegotiation = json['live_stock_negotiation'] != null
        ? new LiveStockNegotiation.fromJson(json['live_stock_negotiation'])
        : null;
    isInCart = json['is_in_cart'];
    cowBreed = json['cow_breed'] != null
        ? CowBreed.fromJson(json['cow_breed'])
        : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
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
    if (cowBreed != null) {
      data['cow_breed'] = cowBreed!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class LiveStockNegotiation {
  dynamic id;
  dynamic liveStockId;
  dynamic userId;
  dynamic negotiatedPrice;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic createdAt;
  dynamic updatedAt;

  LiveStockNegotiation(
      {this.id,
        this.liveStockId,
        this.userId,
        this.negotiatedPrice,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt});

  LiveStockNegotiation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    liveStockId = json['live_stock_id'];
    userId = json['user_id'];
    negotiatedPrice = json['negotiated_price'];
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
    data['live_stock_id'] = this.liveStockId;
    data['user_id'] = this.userId;
    data['negotiated_price'] = this.negotiatedPrice;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_by'] = this.deletedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
  List<dynamic>? manipulations;
  List<dynamic>? customProperties;
  List<dynamic>? generatedConversions;
  List<dynamic>? responsiveImages;
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

class CowBreed {
  dynamic id;
  String? name;
  String? price;
  String? yield;
  String? address;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic createdAt;
  String? updatedAt;

  CowBreed(
      {this.id,
        this.name,
        this.price,
        this.yield,
        this.address,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt});

  CowBreed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    yield = json['yield'];
    address = json['address'];
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
    data['name'] = name;
    data['price'] = price;
    data['yield'] = yield;
    data['address'] = address;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class User {
  dynamic id;
  dynamic userType;
  dynamic userCode;
  dynamic hasPassword;
  String? mobile;
  dynamic isMobileVerified;
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
  FarmerMaster? farmerMaster;

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
        this.farmerMaster});

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
    farmerMaster = json['farmer_master'] != null
        ? FarmerMaster.fromJson(json['farmer_master'])
        : null;
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
    if (farmerMaster != null) {
      data['farmer_master'] = farmerMaster!.toJson();
    }
    return data;
  }
}

class FarmerMaster {
  dynamic id;
  dynamic userId;
  String? name;
  String? email;
  String? fAddress;
  String? phone;
  dynamic mccId;
  dynamic ddeId;
  String? photos;
  String? kycStatus;
  String? landlineNo;
  String? dateOfBirth;
  String? gender;
  String? registrationDate;
  String? supplierId;
  dynamic farmSize;
  dynamic dairyArea;
  dynamic staffQuantity;
  String? farmingExperience;
  String? managerName;
  String? managerPhone;
  String? ragRating;
  String? leadType;
  dynamic idealYield;
  dynamic currentYield;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  String? createdAt;
  String? photo;
  dynamic achievement;
  dynamic farmerRating;
  dynamic framerRatingCount;
  Address? address;
  List<Media>? media;

  FarmerMaster(
      {this.id,
        this.userId,
        this.name,
        this.email,
        this.fAddress,
        this.phone,
        this.mccId,
        this.ddeId,
        this.photos,
        this.kycStatus,
        this.landlineNo,
        this.dateOfBirth,
        this.gender,
        this.registrationDate,
        this.supplierId,
        this.farmSize,
        this.dairyArea,
        this.staffQuantity,
        this.farmingExperience,
        this.managerName,
        this.managerPhone,
        this.ragRating,
        this.leadType,
        this.idealYield,
        this.currentYield,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.photo,
        this.achievement,
        this.farmerRating,
        this.framerRatingCount,
        this.address,
        this.media});

  FarmerMaster.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    fAddress = json['f_address'];
    phone = json['phone'];
    mccId = json['mcc_id'];
    ddeId = json['dde_id'];
    photos = json['photos'];
    kycStatus = json['kyc_status'];
    landlineNo = json['landline_no'];
    dateOfBirth = json['date_of_birth'];
    gender = json['gender'];
    registrationDate = json['registration_date'];
    supplierId = json['supplier_id'];
    farmSize = json['farm_size'];
    dairyArea = json['dairy_area'];
    staffQuantity = json['staff_quantity'];
    farmingExperience = json['farming_experience'];
    managerName = json['manager_name'];
    managerPhone = json['manager_phone'];
    ragRating = json['rag_rating'];
    leadType = json['lead_type'];
    idealYield = json['ideal_yield'];
    currentYield = json['current_yield'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    photo = json['photo'];
    achievement = json['achievement'];
    farmerRating = json['farmer_rating'];
    framerRatingCount = json['framer_rating_count'];
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['f_address'] = fAddress;
    data['phone'] = phone;
    data['mcc_id'] = mccId;
    data['dde_id'] = ddeId;
    data['photos'] = photos;
    data['kyc_status'] = kycStatus;
    data['landline_no'] = landlineNo;
    data['date_of_birth'] = dateOfBirth;
    data['gender'] = gender;
    data['registration_date'] = registrationDate;
    data['supplier_id'] = supplierId;
    data['farm_size'] = farmSize;
    data['dairy_area'] = dairyArea;
    data['staff_quantity'] = staffQuantity;
    data['farming_experience'] = farmingExperience;
    data['manager_name'] = managerName;
    data['manager_phone'] = managerPhone;
    data['rag_rating'] = ragRating;
    data['lead_type'] = leadType;
    data['ideal_yield'] = idealYield;
    data['current_yield'] = currentYield;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['photo'] = photo;
    data['achievement'] = achievement;
    data['farmer_rating'] = farmerRating;
    data['framer_rating_count'] = framerRatingCount;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (media != null) {
      data['media'] = media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Address {
  dynamic id;
  dynamic addressableId;
  String? addressableType;
  String? name;
  String? mobile;
  String? dialCode;
  dynamic landlineNo;
  String? email;
  dynamic gstNumber;
  String? line1;
  dynamic line2;
  dynamic landmark;
  dynamic cityId;
  String? district;
  String? subCounty;
  String? centerName;
  String? village;
  String? parish;
  String? county;
  dynamic poBoxNumber;
  dynamic coordinates;
  dynamic latitude;
  dynamic longitude;
  dynamic stateId;
  String? country;
  dynamic countryId;
  String? region;
  dynamic subCountyId;
  dynamic countyId;
  dynamic districtId;
  dynamic regionId;
  String? postalCode;
  String? address;
  dynamic type;
  dynamic createdAt;
  String? updatedAt;
  String? fullAddress;

  Address(
      {this.id,
        this.addressableId,
        this.addressableType,
        this.name,
        this.mobile,
        this.dialCode,
        this.landlineNo,
        this.email,
        this.gstNumber,
        this.line1,
        this.line2,
        this.landmark,
        this.cityId,
        this.district,
        this.subCounty,
        this.centerName,
        this.village,
        this.parish,
        this.county,
        this.poBoxNumber,
        this.coordinates,
        this.latitude,
        this.longitude,
        this.stateId,
        this.country,
        this.countryId,
        this.region,
        this.subCountyId,
        this.countyId,
        this.districtId,
        this.regionId,
        this.postalCode,
        this.address,
        this.type,
        this.createdAt,
        this.updatedAt,
        this.fullAddress});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressableId = json['addressable_id'];
    addressableType = json['addressable_type'];
    name = json['name'];
    mobile = json['mobile'];
    dialCode = json['dial_code'];
    landlineNo = json['landline_no'];
    email = json['email'];
    gstNumber = json['gst_number'];
    line1 = json['line_1'];
    line2 = json['line_2'];
    landmark = json['landmark'];
    cityId = json['city_id'];
    district = json['district'];
    subCounty = json['sub_county'];
    centerName = json['center_name'];
    village = json['village'];
    parish = json['parish'];
    county = json['county'];
    poBoxNumber = json['po_box_number'];
    coordinates = json['coordinates'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    stateId = json['state_id'];
    country = json['country'];
    countryId = json['country_id'];
    region = json['region'];
    subCountyId = json['sub_county_id'];
    countyId = json['county_id'];
    districtId = json['district_id'];
    regionId = json['region_id'];
    postalCode = json['postal_code'];
    address = json['address'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    fullAddress = json['full_address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['addressable_id'] = addressableId;
    data['addressable_type'] = addressableType;
    data['name'] = name;
    data['mobile'] = mobile;
    data['dial_code'] = dialCode;
    data['landline_no'] = landlineNo;
    data['email'] = email;
    data['gst_number'] = gstNumber;
    data['line_1'] = line1;
    data['line_2'] = line2;
    data['landmark'] = landmark;
    data['city_id'] = cityId;
    data['district'] = district;
    data['sub_county'] = subCounty;
    data['center_name'] = centerName;
    data['village'] = village;
    data['parish'] = parish;
    data['county'] = county;
    data['po_box_number'] = poBoxNumber;
    data['coordinates'] = coordinates;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['state_id'] = stateId;
    data['country'] = country;
    data['country_id'] = countryId;
    data['region'] = region;
    data['sub_county_id'] = subCountyId;
    data['county_id'] = countyId;
    data['district_id'] = districtId;
    data['region_id'] = regionId;
    data['postal_code'] = postalCode;
    data['address'] = address;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['full_address'] = fullAddress;
    return data;
  }
}

class Media {
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

  Media(
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

  Media.fromJson(Map<String, dynamic> json) {
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
