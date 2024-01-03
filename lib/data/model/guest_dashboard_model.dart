import 'package:glad/data/model/dashboard_community.dart';
import 'package:glad/data/model/dashboard_news_event.dart';
import 'package:glad/data/model/dashboard_training.dart';

class GuestDashboardModel {
  String? message;
  dynamic status;
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
  dynamic photo;
  Mcc? mcc;

  DairyDevelopmentExecutive(
      {this.id,
        this.phone,
        this.name,
        this.createdAt,
        this.distance,
        this.image,
        this.photo,
        this.mcc});

  DairyDevelopmentExecutive.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    name = json['name'];
    createdAt = json['created_at'];
    distance = json['distance'];
    image = json['image'];
    photo = json['photo'];
    mcc = json['mcc'] != null ? Mcc.fromJson(json['mcc']) : null;
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

class Mcc {
  dynamic id;
  String? name;
  dynamic userId;
  String? contactPerson;
  String? phone;
  dynamic landlineNo;
  String? email;
  dynamic type;
  dynamic serviceRadius;
  String? status;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? photo;
  Address? address;

  Mcc(
      {this.id,
        this.name,
        this.userId,
        this.contactPerson,
        this.phone,
        this.landlineNo,
        this.email,
        this.type,
        this.serviceRadius,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.photo,
        this.address});

  Mcc.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['user_id'];
    contactPerson = json['contact_person'];
    phone = json['phone'];
    landlineNo = json['landline_no'];
    email = json['email'];
    type = json['type'];
    serviceRadius = json['service_radius'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    photo = json['photo'];
    address =
    json['address'] != null ? Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['user_id'] = userId;
    data['contact_person'] = contactPerson;
    data['phone'] = phone;
    data['landline_no'] = landlineNo;
    data['email'] = email;
    data['type'] = type;
    data['service_radius'] = serviceRadius;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['photo'] = photo;
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
  String? line2;
  dynamic landmark;
  dynamic cityId;
  String? district;
  String? subCounty;
  dynamic centerName;
  String? village;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
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
