class ResponseFriendList {
  String? message;
  int? status;
  List<Data>? data;

  ResponseFriendList({this.message, this.status, this.data});

  ResponseFriendList.fromJson(Map<String, dynamic> json) {
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
  dynamic userId;
  dynamic friendId;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  Friend? friend;

  Data(
      {this.id,
        this.userId,
        this.friendId,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.friend});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    friendId = json['friend_id'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    friend =
    json['friend'] != null ? Friend.fromJson(json['friend']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['friend_id'] = friendId;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (friend != null) {
      data['friend'] = friend!.toJson();
    }
    return data;
  }
}

class Friend {
  dynamic id;
  String? userType;
  dynamic hasPassword;
  String? mobile;
  dynamic isMobileVerified;
  dynamic dateOfBirth;
  dynamic gender;
  String? status;
  String? deviceToken;
  dynamic loginAt;
  dynamic logoutAt;
  String? name;
  String? email;
  dynamic supplierId;
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
  String? badge;
  String? kycStatus;
  String? kycRemarks;
  Address? address;

  Friend(
      {this.id,
        this.userType,
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

  Friend.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userType = json['user_type'];
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
    json['address'] != null ? Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_type'] = userType;
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
  dynamic country;
  dynamic countryId;
  String? region;
  String? postalCode;
  dynamic address;
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
    data['postal_code'] = postalCode;
    data['address'] = address;
    data['type'] = type;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['full_address'] = fullAddress;
    return data;
  }
}
