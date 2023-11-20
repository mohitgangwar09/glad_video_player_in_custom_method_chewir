import 'package:glad/data/model/dashboard_news_event.dart';
import 'package:glad/data/model/dashboard_training.dart';

class MCCDashboardModel {
  String? message;
  int? status;
  Data? data;

  MCCDashboardModel({this.message, this.status, this.data});

  MCCDashboardModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  FarmerProject? farmerProject;
  List<NewsEvent>? newsEvent;
  List<dynamic>? community;
  List<TrainingList>? trainingList;
  Mcc? mcc;

  Data(
      {this.farmerProject,
        this.newsEvent,
        this.community,
        this.trainingList,
        this.mcc});

  Data.fromJson(Map<String, dynamic> json) {
    farmerProject = json['farmerProject'] != null
        ? new FarmerProject.fromJson(json['farmerProject'])
        : null;
    if (json['newsEvent'] != null) {
      newsEvent = <NewsEvent>[];
      json['newsEvent'].forEach((v) {
        newsEvent!.add(new NewsEvent.fromJson(v));
      });
    }
    mcc = json['mcc'] != null ? new Mcc.fromJson(json['mcc']) : null;
    // if (json['community'] != null) {
    //   community = <Null>[];
    //   json['community'].forEach((v) {
    //     community!.add(new Null.fromJson(v));
    //   });
    // }
    if (json['trainingList'] != null) {
      trainingList = <TrainingList>[];
      json['trainingList'].forEach((v) {
        trainingList!.add(new TrainingList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // if (this.farmerProject != null) {
    //   data['farmerProject'] = this.farmerProject!.map((v) => v.toJson()).toList();
    // }
    // if (this.newsEvent != null) {
    //   data['newsEvent'] = this.newsEvent!.map((v) => v.toJson()).toList();
    // }
    // if (this.community != null) {
    //   data['community'] = this.community!.map((v) => v.toJson()).toList();
    // }
    // if (this.trainingList != null) {
    //   data['trainingList'] = this.trainingList!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class FarmerProject {
  dynamic pending;
  dynamic approved;

  FarmerProject({this.pending, this.approved});

  FarmerProject.fromJson(Map<String, dynamic> json) {
    pending = json['pending'];
    approved = json['approved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pending'] = this.pending;
    data['approved'] = this.approved;
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
  List<DairyDevelopmentExecutive>? dairyDevelopmentExecutive;
  dynamic photo;

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
        this.dairyDevelopmentExecutive,
        this.photo});

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
    photo = json["photo"];
    if (json['dairy_development_executive'] != null) {
      dairyDevelopmentExecutive = <DairyDevelopmentExecutive>[];
      json['dairy_development_executive'].forEach((v) {
        dairyDevelopmentExecutive!
            .add(new DairyDevelopmentExecutive.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['contact_person'] = this.contactPerson;
    data['phone'] = this.phone;
    data['landline_no'] = this.landlineNo;
    data['email'] = this.email;
    data['type'] = this.type;
    data['service_radius'] = this.serviceRadius;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_by'] = this.deletedBy;
    data['image'] = this.image;
    if (this.dairyDevelopmentExecutive != null) {
      data['dairy_development_executive'] =
          this.dairyDevelopmentExecutive!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DairyDevelopmentExecutive {
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
  List<FarmerMaster>? farmerMaster;

  DairyDevelopmentExecutive(
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
        this.photo,
        this.farmerMaster});

  DairyDevelopmentExecutive.fromJson(Map<String, dynamic> json) {
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
    if (json['farmer_master'] != null) {
      farmerMaster = <FarmerMaster>[];
      json['farmer_master'].forEach((v) {
        farmerMaster!.add(new FarmerMaster.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['mcc_id'] = this.mccId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['member_since'] = this.memberSince;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_by'] = this.deletedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['photo'] = this.photo;
    if (this.farmerMaster != null) {
      data['farmer_master'] =
          this.farmerMaster!.map((v) => v.toJson()).toList();
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
  dynamic photos;
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
        this.achievement});

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['f_address'] = this.fAddress;
    data['phone'] = this.phone;
    data['mcc_id'] = this.mccId;
    data['dde_id'] = this.ddeId;
    data['photos'] = this.photos;
    data['kyc_status'] = this.kycStatus;
    data['landline_no'] = this.landlineNo;
    data['date_of_birth'] = this.dateOfBirth;
    data['gender'] = this.gender;
    data['registration_date'] = this.registrationDate;
    data['supplier_id'] = this.supplierId;
    data['farm_size'] = this.farmSize;
    data['dairy_area'] = this.dairyArea;
    data['staff_quantity'] = this.staffQuantity;
    data['farming_experience'] = this.farmingExperience;
    data['manager_name'] = this.managerName;
    data['manager_phone'] = this.managerPhone;
    data['rag_rating'] = this.ragRating;
    data['lead_type'] = this.leadType;
    data['ideal_yield'] = this.idealYield;
    data['current_yield'] = this.currentYield;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['photo'] = this.photo;
    data['achievement'] = this.achievement;
    return data;
  }
}


// class MCCDashboardModel {
//   String? message;
//   int? status;
//   Data? data;
//
//   MCCDashboardModel({this.message, this.status, this.data});
//
//   MCCDashboardModel.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     status = json['status'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message;
//     data['status'] = this.status;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   List<FarmerProjet>? farmerProjet;
//   Mcc? mcc;
//
//   Data({this.farmerProjet, this.mcc});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['farmerProjet'] != null) {
//       farmerProjet = <FarmerProjet>[];
//       json['farmerProjet'].forEach((v) {
//         farmerProjet!.add(new FarmerProjet.fromJson(v));
//       });
//     }
//     mcc = json['mcc'] != null ? new Mcc.fromJson(json['mcc']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.farmerProjet != null) {
//       data['farmerProjet'] = this.farmerProjet!.map((v) => v.toJson()).toList();
//     }
//     if (this.mcc != null) {
//       data['mcc'] = this.mcc!.toJson();
//     }
//     return data;
//   }
// }
//
// class FarmerProjet {
//   String? projectStatus;
//   dynamic count;
//   String? projectFilter;
//
//   FarmerProjet({this.projectStatus, this.count, this.projectFilter});
//
//   FarmerProjet.fromJson(Map<String, dynamic> json) {
//     projectStatus = json['project_status'];
//     count = json['count'];
//     projectFilter = json['project_filter'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['project_status'] = this.projectStatus;
//     data['count'] = this.count;
//     data['project_filter'] = this.projectFilter;
//     return data;
//   }
// }
//
// class Mcc {
//   dynamic id;
//   String? name;
//   dynamic userId;
//   String? contactPerson;
//   String? phone;
//   dynamic landlineNo;
//   String? email;
//   dynamic type;
//   dynamic serviceRadius;
//   String? status;
//   dynamic createdAt;
//   dynamic updatedAt;
//   dynamic createdBy;
//   dynamic updatedBy;
//   dynamic deletedBy;
//   dynamic image;
//   List<DairyDevelopmentExecutive>? dairyDevelopmentExecutive;
//
//   Mcc(
//       {this.id,
//         this.name,
//         this.userId,
//         this.contactPerson,
//         this.phone,
//         this.landlineNo,
//         this.email,
//         this.type,
//         this.serviceRadius,
//         this.status,
//         this.createdAt,
//         this.updatedAt,
//         this.createdBy,
//         this.updatedBy,
//         this.deletedBy,
//         this.image,
//         this.dairyDevelopmentExecutive});
//
//   Mcc.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     userId = json['user_id'];
//     contactPerson = json['contact_person'];
//     phone = json['phone'];
//     landlineNo = json['landline_no'];
//     email = json['email'];
//     type = json['type'];
//     serviceRadius = json['service_radius'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     createdBy = json['created_by'];
//     updatedBy = json['updated_by'];
//     deletedBy = json['deleted_by'];
//     image = json['image'];
//     if (json['dairy_development_executive'] != null) {
//       dairyDevelopmentExecutive = <DairyDevelopmentExecutive>[];
//       json['dairy_development_executive'].forEach((v) {
//         dairyDevelopmentExecutive!
//             .add(new DairyDevelopmentExecutive.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['user_id'] = this.userId;
//     data['contact_person'] = this.contactPerson;
//     data['phone'] = this.phone;
//     data['landline_no'] = this.landlineNo;
//     data['email'] = this.email;
//     data['type'] = this.type;
//     data['service_radius'] = this.serviceRadius;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['created_by'] = this.createdBy;
//     data['updated_by'] = this.updatedBy;
//     data['deleted_by'] = this.deletedBy;
//     data['image'] = this.image;
//     if (this.dairyDevelopmentExecutive != null) {
//       data['dairy_development_executive'] =
//           this.dairyDevelopmentExecutive!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class DairyDevelopmentExecutive {
//   dynamic id;
//   String? name;
//   dynamic userId;
//   dynamic mccId;
//   dynamic latitude;
//   dynamic longitude;
//   String? phone;
//   String? email;
//   String? gender;
//   String? dob;
//   String? memberSince;
//   String? status;
//   dynamic createdBy;
//   dynamic updatedBy;
//   dynamic deletedBy;
//   String? createdAt;
//   String? updatedAt;
//   String? photo;
//   List<FarmerMaster>? farmerMaster;
//
//   DairyDevelopmentExecutive(
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
//         this.photo,
//         this.farmerMaster});
//
//   DairyDevelopmentExecutive.fromJson(Map<String, dynamic> json) {
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
//     photo = json['photo'];
//     if (json['farmer_master'] != null) {
//       farmerMaster = <FarmerMaster>[];
//       json['farmer_master'].forEach((v) {
//         farmerMaster!.add(new FarmerMaster.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['user_id'] = this.userId;
//     data['mcc_id'] = this.mccId;
//     data['latitude'] = this.latitude;
//     data['longitude'] = this.longitude;
//     data['phone'] = this.phone;
//     data['email'] = this.email;
//     data['gender'] = this.gender;
//     data['dob'] = this.dob;
//     data['member_since'] = this.memberSince;
//     data['status'] = this.status;
//     data['created_by'] = this.createdBy;
//     data['updated_by'] = this.updatedBy;
//     data['deleted_by'] = this.deletedBy;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     data['photo'] = this.photo;
//     if (this.farmerMaster != null) {
//       data['farmer_master'] =
//           this.farmerMaster!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class FarmerMaster {
//   dynamic id;
//   dynamic userId;
//   String? name;
//   String? email;
//   String? fAddress;
//   String? phone;
//   dynamic mccId;
//   dynamic ddeId;
//   dynamic photos;
//   String? kycStatus;
//   String? landlineNo;
//   String? dateOfBirth;
//   String? gender;
//   String? registrationDate;
//   String? supplierId;
//   dynamic farmSize;
//   dynamic dairyArea;
//   dynamic staffQuantity;
//   String? farmingExperience;
//   String? managerName;
//   String? managerPhone;
//   String? ragRating;
//   String? leadType;
//   dynamic idealYield;
//   dynamic currentYield;
//   String? status;
//   dynamic createdBy;
//   dynamic updatedBy;
//   String? createdAt;
//   String? photo;
//   dynamic achievement;
//
//   FarmerMaster(
//       {this.id,
//         this.userId,
//         this.name,
//         this.email,
//         this.fAddress,
//         this.phone,
//         this.mccId,
//         this.ddeId,
//         this.photos,
//         this.kycStatus,
//         this.landlineNo,
//         this.dateOfBirth,
//         this.gender,
//         this.registrationDate,
//         this.supplierId,
//         this.farmSize,
//         this.dairyArea,
//         this.staffQuantity,
//         this.farmingExperience,
//         this.managerName,
//         this.managerPhone,
//         this.ragRating,
//         this.leadType,
//         this.idealYield,
//         this.currentYield,
//         this.status,
//         this.createdBy,
//         this.updatedBy,
//         this.createdAt,
//         this.photo,
//         this.achievement});
//
//   FarmerMaster.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     userId = json['user_id'];
//     name = json['name'];
//     email = json['email'];
//     fAddress = json['f_address'];
//     phone = json['phone'];
//     mccId = json['mcc_id'];
//     ddeId = json['dde_id'];
//     photos = json['photos'];
//     kycStatus = json['kyc_status'];
//     landlineNo = json['landline_no'];
//     dateOfBirth = json['date_of_birth'];
//     gender = json['gender'];
//     registrationDate = json['registration_date'];
//     supplierId = json['supplier_id'];
//     farmSize = json['farm_size'];
//     dairyArea = json['dairy_area'];
//     staffQuantity = json['staff_quantity'];
//     farmingExperience = json['farming_experience'];
//     managerName = json['manager_name'];
//     managerPhone = json['manager_phone'];
//     ragRating = json['rag_rating'];
//     leadType = json['lead_type'];
//     idealYield = json['ideal_yield'];
//     currentYield = json['current_yield'];
//     status = json['status'];
//     createdBy = json['created_by'];
//     updatedBy = json['updated_by'];
//     createdAt = json['created_at'];
//     photo = json['photo'];
//     achievement = json['achievement'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['user_id'] = this.userId;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['f_address'] = this.fAddress;
//     data['phone'] = this.phone;
//     data['mcc_id'] = this.mccId;
//     data['dde_id'] = this.ddeId;
//     data['photos'] = this.photos;
//     data['kyc_status'] = this.kycStatus;
//     data['landline_no'] = this.landlineNo;
//     data['date_of_birth'] = this.dateOfBirth;
//     data['gender'] = this.gender;
//     data['registration_date'] = this.registrationDate;
//     data['supplier_id'] = this.supplierId;
//     data['farm_size'] = this.farmSize;
//     data['dairy_area'] = this.dairyArea;
//     data['staff_quantity'] = this.staffQuantity;
//     data['farming_experience'] = this.farmingExperience;
//     data['manager_name'] = this.managerName;
//     data['manager_phone'] = this.managerPhone;
//     data['rag_rating'] = this.ragRating;
//     data['lead_type'] = this.leadType;
//     data['ideal_yield'] = this.idealYield;
//     data['current_yield'] = this.currentYield;
//     data['status'] = this.status;
//     data['created_by'] = this.createdBy;
//     data['updated_by'] = this.updatedBy;
//     data['created_at'] = this.createdAt;
//     data['photo'] = this.photo;
//     data['achievement'] = this.achievement;
//     return data;
//   }
// }
