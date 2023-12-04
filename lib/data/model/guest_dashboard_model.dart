import 'package:glad/data/model/dashboard_community.dart';
import 'package:glad/data/model/dashboard_news_event.dart';
import 'package:glad/data/model/dashboard_training.dart';

class GuestDashboardModel {
  String? message;
  int? status;
  Data? data;

  GuestDashboardModel({this.message, this.status, this.data});

  GuestDashboardModel.fromJson(Map<String, dynamic> json) {
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
  DairyDevelopmentExecutive? dairyDevelopmentExecutive;
  Enquiry? enquiry;
  List<NewsEvent>? newsEvent;
  List<Community>? community;
  List<TrainingList>? trainingList;

  Data({this.dairyDevelopmentExecutive, this.enquiry, this.newsEvent,
    this.community,
    this.trainingList});

  Data.fromJson(Map<String, dynamic> json) {
    dairyDevelopmentExecutive = json['dairyDevelopmentExecutive'] != null
        ? DairyDevelopmentExecutive.fromJson(
        json['dairyDevelopmentExecutive'])
        : null;
    enquiry =
    json['enquiry'] != null ? Enquiry.fromJson(json['enquiry']) : null;
    if (json['newsEvent'] != null) {
      newsEvent = <NewsEvent>[];
      json['newsEvent'].forEach((v) {
        newsEvent!.add(NewsEvent.fromJson(v));
      });
    }
    if (json['community'] != null) {
      community = <Community>[];
      json['community'].forEach((v) {
        community!.add(Community.fromJson(v));
      });
    }
    if (json['trainingList'] != null) {
      trainingList = <TrainingList>[];
      json['trainingList'].forEach((v) {
        trainingList!.add(TrainingList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dairyDevelopmentExecutive != null) {
      data['dairyDevelopmentExecutive'] =
          dairyDevelopmentExecutive!.toJson();
    }
    if (enquiry != null) {
      data['enquiry'] = enquiry!.toJson();
    }
    return data;
  }
}

class DairyDevelopmentExecutive {
  dynamic id;
  dynamic phone;
  String? name;
  dynamic createdAt;
  dynamic distance;
  dynamic image;

  DairyDevelopmentExecutive(
      {this.id,
        this.phone,
        this.name,
        this.createdAt,
        this.distance,
        this.image});

  DairyDevelopmentExecutive.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    name = json['name'];
    createdAt = json['created_at'];
    distance = json['distance'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['phone'] = phone;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['distance'] = distance;
    data['image'] = image;
    return data;
  }
}

class Enquiry {
  dynamic id;
  dynamic farmerId;
  dynamic ddeId;
  String? deviceId;
  dynamic supplierCode;
  dynamic userId;
  String? name;
  String? mobile;
  String? address;
  dynamic lat;
  dynamic lang;
  String? comment;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  dynamic closedAt;

  Enquiry(
      {this.id,
        this.farmerId,
        this.ddeId,
        this.deviceId,
        this.supplierCode,
        this.userId,
        this.name,
        this.mobile,
        this.address,
        this.lat,
        this.lang,
        this.comment,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.closedAt});

  Enquiry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    farmerId = json['farmer_id'];
    ddeId = json['dde_id'];
    deviceId = json['device_id'];
    supplierCode = json['supplier_code'];
    userId = json['user_id'];
    name = json['name'];
    mobile = json['mobile'];
    address = json['address'];
    lat = json['lat'];
    lang = json['lang'];
    comment = json['comment'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    closedAt = json['closed_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['farmer_id'] = farmerId;
    data['dde_id'] = ddeId;
    data['device_id'] = deviceId;
    data['supplier_code'] = supplierCode;
    data['user_id'] = userId;
    data['name'] = name;
    data['mobile'] = mobile;
    data['address'] = address;
    data['lat'] = lat;
    data['lang'] = lang;
    data['comment'] = comment;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['closed_at'] = closedAt;
    return data;
  }
}
