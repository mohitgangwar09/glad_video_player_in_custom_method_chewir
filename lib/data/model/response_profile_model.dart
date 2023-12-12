class ResponseProfile {
  String? message;
  int? status;
  Data? data;

  ResponseProfile({this.message, this.status, this.data});

  ResponseProfile.fromJson(Map<String, dynamic> json) {
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
  User? user;
  SupplierDocument? supplierDocument;

  Data({this.user,this.supplierDocument});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    supplierDocument = json['supplierKycDocument'] != null ? SupplierDocument.fromJson(json['supplierKycDocument']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (supplierDocument != null) {
      data['supplierKycDocument'] = supplierDocument!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? firstName;
  dynamic middleName;
  dynamic lastName;

  String? userType;
  dynamic userCode;
  int? hasPassword;
  dynamic mobile;
  int? isMobileVerified;
  dynamic dateOfBirth;
  dynamic gender;
  String? status;
  String? deviceToken;
  dynamic loginAt;
  dynamic logoutAt;
  String? email;
  // String? address;
  dynamic emailVerifiedAt;
  dynamic twoFactorConfirmedAt;
  String? createdAt;
  String? updatedAt;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  int? isFirst;
  String? name;
  dynamic profilePic;
  dynamic badge;
  dynamic kycStatus;
  dynamic kycRemarks;
  List<Roles>? roles;
  Address? address;

  User(
      {this.id,
        this.firstName,
        this.middleName,
        this.lastName,
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
        this.email,
        this.emailVerifiedAt,
        this.twoFactorConfirmedAt,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.isFirst,
        this.name,
        this.profilePic,
        this.roles,
        this.badge,
        this.kycStatus,
        this.kycRemarks,
        this.address});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
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
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    twoFactorConfirmedAt = json['two_factor_confirmed_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    isFirst = json['is_first'];
    name = json['name'];
    badge = json['badge'];
    kycStatus = json['kyc_status'];
    kycRemarks = json['kyc_remarks'];
    profilePic = json['profile_pic'];
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(Roles.fromJson(v));
      });
    }
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
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
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['two_factor_confirmed_at'] = twoFactorConfirmedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['is_first'] = isFirst;
    data['name'] = name;
    data['badge'] = name;
    data['kyc_remarks'] = kycRemarks;
    data['kyc_status'] = kycStatus;
    data['profile_pic'] = profilePic;
    if (roles != null) {
      data['roles'] = roles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Roles {
  int? id;
  String? name;
  String? alias;
  dynamic parentId;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic createdAt;
  dynamic updatedAt;
  Pivot? pivot;

  Roles(
      {this.id,
        this.name,
        this.alias,
        this.parentId,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.pivot});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    alias = json['alias'];
    parentId = json['parent_id'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['alias'] = alias;
    data['parent_id'] = parentId;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? userId;
  int? roleId;

  Pivot({this.userId, this.roleId});

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    roleId = json['role_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['role_id'] = roleId;
    return data;
  }
}


class Address {
  int? id;
  int? addressableId;
  String? addressableType;
  String? name;
  String? mobile;
  String? email;
  dynamic gstNumber;
  String? line1;
  dynamic line2;
  dynamic landmark;
  int? cityId;
  dynamic district;
  dynamic stateId;
  dynamic countryId;
  String? postalCode;
  String? address;
  dynamic type;
  String? createdAt;
  String? updatedAt;
  String? dialCode;

  Address(
      {this.id,
        this.addressableId,
        this.addressableType,
        this.name,
        this.mobile,
        this.email,
        this.gstNumber,
        this.line1,
        this.line2,
        this.landmark,
        this.cityId,
        this.district,
        this.stateId,
        this.countryId,
        this.postalCode,
        this.address,
        this.type,
        this.createdAt,
        this.dialCode,
        this.updatedAt});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addressableId = json['addressable_id'];
    addressableType = json['addressable_type'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    gstNumber = json['gst_number'];
    line1 = json['line_1'];
    line2 = json['line_2'];
    landmark = json['landmark'];
    cityId = json['city_id'];
    district = json['district'];
    stateId = json['state_id'];
    countryId = json['country_id'];
    postalCode = json['postal_code'];
    address = json['address'];
    type = json['type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    dialCode = json['dial_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['addressable_id'] = addressableId;
    data['addressable_type'] = addressableType;
    data['name'] = name;
    data['dial_code'] = dialCode;
    data['mobile'] = mobile;
    data['email'] = email;
    data['gst_number'] = gstNumber;
    data['line_1'] = line1;
    data['line_2'] = line2;
    data['landmark'] = landmark;
    data['city_id'] = cityId;
    data['district'] = district;
    data['state_id'] = stateId;
    data['country_id'] = countryId;
    data['postal_code'] = postalCode;
    data['address'] = address;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class SupplierDocument {
  int? id;
  int? supplierId;
  String? doc1Name;
  String? doc1No;
  String? doc1ExpiryDate;
  String? doc2Name;
  String? doc2No;
  String? doc2ExpiryDate;
  String? doc3Name;
  String? doc3No;
  String? doc3ExpiryDate;
  String? doc4Name;
  String? doc4No;
  String? doc4ExpiryDate;
  String? doc5Name;
  String? doc5No;
  String? doc5ExpiryDate;
  String? doc6Name;
  String? doc6No;
  String? doc6ExpiryDate;
  String? status;
  int? createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  List<DocFile1>? docFile1;
  List<DocFile1>? docFile2;
  List<DocFile1>? docFile3;
  List<DocFile1>? docFile4;
  List<DocFile1>? docFile5;
  List<DocFile1>? docFile6;
  List<DocFile1>? media;

  SupplierDocument(
      {this.id,
        this.supplierId,
        this.doc1Name,
        this.doc1No,
        this.doc1ExpiryDate,
        this.doc2Name,
        this.doc2No,
        this.doc2ExpiryDate,
        this.doc3Name,
        this.doc3No,
        this.doc3ExpiryDate,
        this.doc4Name,
        this.doc4No,
        this.doc4ExpiryDate,
        this.doc5Name,
        this.doc5No,
        this.doc5ExpiryDate,
        this.doc6Name,
        this.doc6No,
        this.doc6ExpiryDate,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.docFile1,
        this.docFile2,
        this.docFile3,
        this.docFile4,
        this.docFile5,
        this.docFile6,
        this.media});

  SupplierDocument.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    supplierId = json['supplier_id'];
    doc1Name = json['doc_1_name'];
    doc1No = json['doc_1_no'];
    doc1ExpiryDate = json['doc_1_expiry_date'];
    doc2Name = json['doc_2_name'];
    doc2No = json['doc_2_no'];
    doc2ExpiryDate = json['doc_2_expiry_date'];
    doc3Name = json['doc_3_name'];
    doc3No = json['doc_3_no'];
    doc3ExpiryDate = json['doc_3_expiry_date'];
    doc4Name = json['doc_4_name'];
    doc4No = json['doc_4_no'];
    doc4ExpiryDate = json['doc_4_expiry_date'];
    doc5Name = json['doc_5_name'];
    doc5No = json['doc_5_no'];
    doc5ExpiryDate = json['doc_5_expiry_date'];
    doc6Name = json['doc_6_name'];
    doc6No = json['doc_6_no'];
    doc6ExpiryDate = json['doc_6_expiry_date'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['doc_file_1'] != null) {
      docFile1 = <DocFile1>[];
      json['doc_file_1'].forEach((v) {
        docFile1!.add(DocFile1.fromJson(v));
      });
    }
    if (json['doc_file_2'] != null) {
      docFile2 = <DocFile1>[];
      json['doc_file_2'].forEach((v) {
        docFile2!.add(DocFile1.fromJson(v));
      });
    }
    if (json['doc_file_3'] != null) {
      docFile3 = <DocFile1>[];
      json['doc_file_3'].forEach((v) {
        docFile3!.add(DocFile1.fromJson(v));
      });
    }
    if (json['doc_file_4'] != null) {
      docFile4 = <DocFile1>[];
      json['doc_file_4'].forEach((v) {
        docFile4!.add(DocFile1.fromJson(v));
      });
    }
    if (json['doc_file_5'] != null) {
      docFile5 = <DocFile1>[];
      json['doc_file_5'].forEach((v) {
        docFile5!.add(DocFile1.fromJson(v));
      });
    }
    if (json['doc_file_6'] != null) {
      docFile6 = <DocFile1>[];
      json['doc_file_6'].forEach((v) {
        docFile6!.add(DocFile1.fromJson(v));
      });
    }
    if (json['media'] != null) {
      media = <DocFile1>[];
      json['media'].forEach((v) {
        media!.add(DocFile1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['supplier_id'] = supplierId;
    data['doc_1_name'] = doc1Name;
    data['doc_1_no'] = doc1No;
    data['doc_1_expiry_date'] = doc1ExpiryDate;
    data['doc_2_name'] = doc2Name;
    data['doc_2_no'] = doc2No;
    data['doc_2_expiry_date'] = doc2ExpiryDate;
    data['doc_3_name'] = doc3Name;
    data['doc_3_no'] = doc3No;
    data['doc_3_expiry_date'] = doc3ExpiryDate;
    data['doc_4_name'] = doc4Name;
    data['doc_4_no'] = doc4No;
    data['doc_4_expiry_date'] = doc4ExpiryDate;
    data['doc_5_name'] = doc5Name;
    data['doc_5_no'] = doc5No;
    data['doc_5_expiry_date'] = doc5ExpiryDate;
    data['doc_6_name'] = doc6Name;
    data['doc_6_no'] = doc6No;
    data['doc_6_expiry_date'] = doc6ExpiryDate;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (docFile1 != null) {
      data['doc_file_1'] = docFile1!.map((v) => v.toJson()).toList();
    }
    if (docFile2 != null) {
      data['doc_file_2'] = docFile2!.map((v) => v.toJson()).toList();
    }
    if (docFile3 != null) {
      data['doc_file_3'] = docFile3!.map((v) => v.toJson()).toList();
    }
    if (docFile4 != null) {
      data['doc_file_4'] = docFile4!.map((v) => v.toJson()).toList();
    }
    if (docFile5 != null) {
      data['doc_file_5'] = docFile5!.map((v) => v.toJson()).toList();
    }
    if (docFile6 != null) {
      data['doc_file_6'] = docFile6!.map((v) => v.toJson()).toList();
    }
    if (media != null) {
      data['media'] = media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DocFile1 {
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
  dynamic manipulations;
  dynamic customProperties;
  dynamic generatedConversions;
  dynamic responsiveImages;
  int? orderColumn;
  String? createdAt;
  String? updatedAt;
  String? originalUrl;
  String? previewUrl;

  DocFile1(
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

  DocFile1.fromJson(Map<String, dynamic> json) {
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
      manipulations = <String>[];
      json['manipulations'].forEach((v) {
        manipulations!.add(v);
      });
    }
    if (json['custom_properties'] != null) {
      customProperties = <String>[];
      json['custom_properties'].forEach((v) {
        customProperties!.add(v);
      });
    }
    if (json['generated_conversions'] != null) {
      generatedConversions = <String>[];
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
          manipulations!.map((v) => v).toList();
    }
    if (customProperties != null) {
      data['custom_properties'] =
          customProperties!.map((v) => v).toList();
    }
    if (generatedConversions != null) {
      data['generated_conversions'] =
          generatedConversions!.map((v) => v).toList();
    }
    if (responsiveImages != null) {
      data['responsive_images'] =
          responsiveImages!.map((v) => v).toList();
    }
    data['order_column'] = orderColumn;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['original_url'] = originalUrl;
    data['preview_url'] = previewUrl;
    return data;
  }
}
