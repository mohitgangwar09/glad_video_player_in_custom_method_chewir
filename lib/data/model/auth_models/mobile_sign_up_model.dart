import '../errors_model.dart';

class MobileSignUpModel {
  int? statusCode;
  Data? data;
  String? message;
  List<ErrorModel>? errors;
  String? version;

  MobileSignUpModel(
      {this.statusCode, this.data, this.message, this.errors, this.version});

  MobileSignUpModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    if (json['errors'] != null) {
      errors = <ErrorModel>[];
      json['errors'].forEach((v) {
        errors!.add(ErrorModel.fromJson(v));
      });
    }
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    if (errors != null) {
      data['errors'] = errors!.map((v) => v.toJson()).toList();
    }
    data['version'] = version;
    return data;
  }
}

class Data {
  String? userId;
  int? roleId;
  String? mobileNo;
  int? profileStatus;
  bool? isMobileVerify;
  String? token;

  Data(
      {this.userId,
      this.roleId,
      this.mobileNo,
      this.profileStatus,
      this.isMobileVerify,
      this.token});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    roleId = json['roleId'];
    mobileNo = json['mobileNo'];
    profileStatus = json['profileStatus'];
    isMobileVerify = json['isMobileVerify'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['roleId'] = roleId;
    data['mobileNo'] = mobileNo;
    data['profileStatus'] = profileStatus;
    data['isMobileVerify'] = isMobileVerify;
    data['token'] = token;
    return data;
  }
}
