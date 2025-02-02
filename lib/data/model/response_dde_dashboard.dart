import 'package:glad/data/model/dashboard_community.dart';
import 'package:glad/data/model/dashboard_news_event.dart';
import 'package:glad/data/model/dashboard_training.dart';

class ResponseDdeDashboard {
  String? message;
  int? status;
  Data? data;

  ResponseDdeDashboard({this.message, this.status, this.data});

  ResponseDdeDashboard.fromJson(Map<String, dynamic> json) {
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
  Dde? dde;
  Mcc? mcc;
  RagratingTypeStatus? ragratingTypeStatus;
  List<NewsEvent>? newsEvent;
  List<TrainingList>? trainingList;
  List<Community>? community;
  TodayMilkPrice? todayMilkPrice;
  ProjectSummary? projectSummary;

  Data(
      {this.dde,
        this.mcc,
        this.ragratingTypeStatus,
        this.newsEvent,
        this.trainingList,
        this.community,
        this.todayMilkPrice,
        this.projectSummary,
      });

  Data.fromJson(Map<String, dynamic> json) {
    dde = json['dde'] != null ? Dde.fromJson(json['dde']) : null;
    mcc = json['mcc'] != null ? Mcc.fromJson(json['mcc']) : null;
    todayMilkPrice = json['today_milk_price'] != null ? TodayMilkPrice.fromJson(json['today_milk_price']) : null;
    ragratingTypeStatus = json['ragratingTypeStatus'] != null
        ? RagratingTypeStatus.fromJson(json['ragratingTypeStatus'])
        : null;
    if (json['newsEvent'] != null) {
      newsEvent = <NewsEvent>[];
      json['newsEvent'].forEach((v) {
        newsEvent!.add(NewsEvent.fromJson(v));
      });
    }
    if (json['trainingList'] != null) {
      trainingList = <TrainingList>[];
      json['trainingList'].forEach((v) {
        trainingList!.add(TrainingList.fromJson(v));
      });
    }
    if (json['community'] != null) {
      community = <Community>[];
      json['community'].forEach((v) {
        community!.add(Community.fromJson(v));
      });
    }
    projectSummary = json['project_summary'] != null
        ? new ProjectSummary.fromJson(json['project_summary'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (dde != null) {
      data['dde'] = dde!.toJson();
    }
    if (todayMilkPrice != null) {
      data['today_milk_price'] = todayMilkPrice!.toJson();
    }
    if (mcc != null) {
      data['mcc'] = mcc!.toJson();
    }
    if (ragratingTypeStatus != null) {
      data['ragratingTypeStatus'] = ragratingTypeStatus!.toJson();
    }
    if (newsEvent != null) {
      data['newsEvent'] = newsEvent!.map((v) => v.toJson()).toList();
    }
    if (trainingList != null) {
      data['trainingList'] = trainingList!.map((v) => v.toJson()).toList();
    }
    if (community != null) {
      data['community'] = community!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProjectSummary {
  int? pending;
  int? active;
  int? completed;
  int? totalProject;

  ProjectSummary(
      {this.pending, this.active, this.completed, this.totalProject});

  ProjectSummary.fromJson(Map<String, dynamic> json) {
    pending = json['pending'];
    active = json['active'];
    completed = json['completed'];
    totalProject = json['total_project'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pending'] = this.pending;
    data['active'] = this.active;
    data['completed'] = this.completed;
    data['total_project'] = this.totalProject;
    return data;
  }
}

class Dde {
  dynamic id;
  String? name;
  dynamic userId;
  dynamic mccId;
  dynamic latitude;
  dynamic longitude;
  String? phone;
  String? email;
  String? gender;
  String? dob;
  String? memberSince;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  String? photo;

  Dde(
      {this.id,
        this.name,
        this.userId,
        this.mccId,
        this.latitude,
        this.longitude,
        this.phone,
        this.email,
        this.gender,
        this.dob,
        this.memberSince,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.photo});

  Dde.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['user_id'];
    mccId = json['mcc_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    phone = json['phone'];
    email = json['email'];
    gender = json['gender'];
    dob = json['dob'];
    memberSince = json['member_since'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['user_id'] = userId;
    data['mcc_id'] = mccId;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['phone'] = phone;
    data['email'] = email;
    data['gender'] = gender;
    data['dob'] = dob;
    data['member_since'] = memberSince;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['photo'] = photo;
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
  dynamic image;
  dynamic photo;
  dynamic address;

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
        this.image,
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
    image = json['image'];
    photo = json['photo'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['image'] = image;
    return data;
  }
}

class RagratingTypeStatus {
  dynamic critical;
  dynamic average;
  dynamic satisfactory;
  dynamic mature;

  RagratingTypeStatus(
      {this.critical, this.average, this.satisfactory, this.mature});

  RagratingTypeStatus.fromJson(Map<String, dynamic> json) {
    critical = json['critical'];
    average = json['average'];
    satisfactory = json['satisfactory'];
    mature = json['mature'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['critical'] = critical;
    data['average'] = average;
    data['satisfactory'] = satisfactory;
    data['mature'] = mature;
    return data;
  }
}

class TodayMilkPrice {
  int? id;
  String? date;
  dynamic countryId;
  dynamic regionId;
  dynamic milkPrice;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  dynamic createdAt;
  dynamic updatedAt;

  TodayMilkPrice(
      {this.id,
        this.date,
        this.countryId,
        this.regionId,
        this.milkPrice,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt});

  TodayMilkPrice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    countryId = json['country_id'];
    regionId = json['region_id'];
    milkPrice = json['milk_price'];
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
    data['date'] = date;
    data['country_id'] = countryId;
    data['region_id'] = regionId;
    data['milk_price'] = milkPrice;
    data['status'] = status;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['deleted_by'] = deletedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}


// class ResponseDdeDashboard {
//   String? message;
//   dynamic status;
//   DataDdeDashboard? data;
//
//   ResponseDdeDashboard({this.message, this.status, this.data});
//
//   ResponseDdeDashboard.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     status = json['status'];
//     data = json['data'] != null ? DataDdeDashboard.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['message'] = message;
//     data['status'] = status;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class DataDdeDashboard {
//   Dde? dde;
//   RagratingTypeStatus? ragratingTypeStatus;
//
//   DataDdeDashboard({this.dde, this.ragratingTypeStatus});
//
//   DataDdeDashboard.fromJson(Map<String, dynamic> json) {
//     dde = json['dde'] != null ? Dde.fromJson(json['dde']) : null;
//     ragratingTypeStatus = json['ragratingTypeStatus'] != null
//         ? RagratingTypeStatus.fromJson(json['ragratingTypeStatus'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (dde != null) {
//       data['dde'] = dde!.toJson();
//     }
//     if (ragratingTypeStatus != null) {
//       data['ragratingTypeStatus'] = ragratingTypeStatus!.toJson();
//     }
//     return data;
//   }
// }
//
// class Dde {
//   dynamic id;
//   String? name;
//   dynamic userId;
//   dynamic mccId;
//   dynamic latitude;
//   dynamic longitude;
//   dynamic phone;
//   String? email;
//   String? gender;
//   dynamic dob;
//   dynamic memberSince;
//   String? status;
//   dynamic createdBy;
//   dynamic updatedBy;
//   dynamic deletedBy;
//   String? createdAt;
//   dynamic updatedAt;
//   dynamic image;
//   dynamic profilePic;
//   dynamic photo;
//
//   Dde(
//       {this.id,
//         this.name,
//         this.userId,
//         this.mccId,
//         this.latitude,
//         this.longitude,
//         this.phone,
//         this.email,
//         this.gender,
//         this.dob,
//         this.memberSince,
//         this.status,
//         this.createdBy,
//         this.updatedBy,
//         this.deletedBy,
//         this.createdAt,
//         this.updatedAt,
//         this.image,
//         this.profilePic,
//         this.photo});
//
//   Dde.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     userId = json['user_id'];
//     mccId = json['mcc_id'];
//     latitude = json['latitude'];
//     longitude = json['longitude'];
//     phone = json['phone'];
//     email = json['email'];
//     gender = json['gender'];
//     dob = json['dob'];
//     memberSince = json['member_since'];
//     status = json['status'];
//     createdBy = json['created_by'];
//     updatedBy = json['updated_by'];
//     deletedBy = json['deleted_by'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     image = json['image'];
//     profilePic = json['profile_pic'];
//     photo = json['photo'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['name'] = name;
//     data['user_id'] = userId;
//     data['mcc_id'] = mccId;
//     data['latitude'] = latitude;
//     data['longitude'] = longitude;
//     data['phone'] = phone;
//     data['email'] = email;
//     data['gender'] = gender;
//     data['dob'] = dob;
//     data['member_since'] = memberSince;
//     data['status'] = status;
//     data['created_by'] = createdBy;
//     data['updated_by'] = updatedBy;
//     data['deleted_by'] = deletedBy;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     data['image'] = image;
//     return data;
//   }
// }
//
// class RagratingTypeStatus {
//   dynamic critical;
//   dynamic average;
//   dynamic satisfactory;
//   dynamic mature;
//
//   RagratingTypeStatus(
//       {this.critical, this.average, this.satisfactory, this.mature});
//
//   RagratingTypeStatus.fromJson(Map<String, dynamic> json) {
//     critical = json['critical'];
//     average = json['average'];
//     satisfactory = json['satisfactory'];
//     mature = json['mature'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['critical'] = critical;
//     data['average'] = average;
//     data['satisfactory'] = satisfactory;
//     data['mature'] = mature;
//     return data;
//   }
// }
