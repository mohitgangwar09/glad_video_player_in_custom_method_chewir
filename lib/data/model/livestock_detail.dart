class LivestockDetail {
  String? message;
  dynamic status;
  Data? data;

  LivestockDetail({this.message, this.status, this.data});

  LivestockDetail.fromJson(Map<String, dynamic> json) {
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
  String? price;
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
  dynamic isInCart;
  List<LiveStockDocumentFiles>? liveStockDocumentFiles;
  NegotiatedPrice? negotiatedPrice;
  User? user;
  CowBreed? cowBreed;

  Data(
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
        this.isInCart,
        this.liveStockDocumentFiles,
        this.user,
        this.negotiatedPrice,
        this.cowBreed});

  Data.fromJson(Map<String, dynamic> json) {
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
    isInCart = json['is_in_cart'];
    if (json['live_stock_document_files'] != null) {
      liveStockDocumentFiles = <LiveStockDocumentFiles>[];
      json['live_stock_document_files'].forEach((v) {
        liveStockDocumentFiles!.add(LiveStockDocumentFiles.fromJson(v));
      });
    }
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    negotiatedPrice = json['live_stock_negotiation'] != null ? NegotiatedPrice.fromJson(json['live_stock_negotiation']) : null;
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
    data['is_in_cart'] = isInCart;
    if (liveStockDocumentFiles != null) {
      data['live_stock_document_files'] =
          liveStockDocumentFiles!.map((v) => v.toJson()).toList();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (negotiatedPrice != null) {
      data['live_stock_negotiation'] = negotiatedPrice!.toJson();
    }
    if (cowBreed != null) {
      data['cow_breed'] = cowBreed!.toJson();
    }
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
  List<Null>? manipulations;
  List<Null>? customProperties;
  List<Null>? generatedConversions;
  List<Null>? responsiveImages;
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

class User {
  dynamic id;
  String? userType;
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
  dynamic name;
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
  Address? address;

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
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
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
    if (address != null) {
      data['address'] = address!.toJson();
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
  dynamic dialCode;
  dynamic landlineNo;
  String? email;
  dynamic gstNumber;
  String? line1;
  dynamic line2;
  dynamic landmark;
  dynamic cityId;
  String? district;
  String? subCounty;
  dynamic centerName;
  dynamic village;
  dynamic parish;
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
  String? createdAt;
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

class NegotiatedPrice {
  dynamic id;
  dynamic liveStockId;
  dynamic userId;
  dynamic negotiatedPrice;
  dynamic status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic createdAt;
  dynamic updatedAt;

  NegotiatedPrice(
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

  NegotiatedPrice.fromJson(Map<String, dynamic> json) {
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
