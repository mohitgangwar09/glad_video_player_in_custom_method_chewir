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

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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