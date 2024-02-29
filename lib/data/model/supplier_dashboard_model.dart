import 'package:glad/data/model/dashboard_community.dart';
import 'package:glad/data/model/dashboard_news_event.dart';
import 'package:glad/data/model/dashboard_training.dart';

class SupplierDashboardModel {
  String? message;
  int? status;
  Data? data;

  SupplierDashboardModel({this.message, this.status, this.data});

  SupplierDashboardModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  FarmerProjectSurvey? farmerProjectSurvey;
  FarmerProject? farmerProject;
  List<NewsEvent>? newsEvent;
  List<Community>? community;
  List<TrainingList>? trainingList;
  Supplier? supplier;
  Supplier? supplierTeam;

  Data(
      {this.farmerProjectSurvey,
        this.farmerProject,
        this.newsEvent,
        this.community,
        this.trainingList,
        this.supplierTeam,
        this.supplier});

  Data.fromJson(Map<String, dynamic> json) {
    farmerProjectSurvey = json['farmerProjectSurvey'] != null
        ? FarmerProjectSurvey.fromJson(json['farmerProjectSurvey'])
        : null;
    farmerProject = json['farmerProject'] != null
        ? FarmerProject.fromJson(json['farmerProject'])
        : null;
    supplier = json['supplier'] != null
        ? Supplier.fromJson(json['supplier'])
        : null;
    supplierTeam = json['supplierTeam'] != null
        ? Supplier.fromJson(json['supplierTeam'])
        : null;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    // if (this.farmerProjetSurvey != null) {
    //   data['farmerProjetSurvey'] =
    //       this.farmerProjetSurvey!.map((v) => v.toJson()).toList();
    // }
    // if (this.farmerProjet != null) {
    //   data['farmerProjet'] = this.farmerProjet!.map((v) => v.toJson()).toList();
    // }
    if (this.newsEvent != null) {
      data['newsEvent'] = this.newsEvent!.map((v) => v.toJson()).toList();
    }
    // if (this.community != null) {
    //   data['community'] = this.community!.map((v) => v.toJson()).toList();
    // }
    if (this.trainingList != null) {
      data['trainingList'] = this.trainingList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Supplier {
  dynamic id;
  String? name;
  dynamic userId;
  dynamic mccId;
  String? contactPerson;
  String? phone;
  String? email;
  String? status;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? createdAt;
  String? updatedAt;
  dynamic? image;
  dynamic photo;

  Supplier(
      {this.id,
        this.name,
        this.userId,
        this.mccId,
        this.contactPerson,
        this.phone,
        this.email,
        this.status,
        this.createdBy,
        this.updatedBy,
        this.deletedBy,
        this.createdAt,
        this.updatedAt,
        this.image,
      this.photo});

  Supplier.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    userId = json['user_id'];
    mccId = json['mcc_id'];
    contactPerson = json['contact_person'];
    phone = json['phone'];
    email = json['email'];
    status = json['status'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    deletedBy = json['deleted_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['user_id'] = this.userId;
    data['mcc_id'] = this.mccId;
    data['contact_person'] = this.contactPerson;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['status'] = this.status;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['deleted_by'] = this.deletedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    return data;
  }
}

class FarmerProjectSurvey {
  dynamic pending;
  dynamic completed;

  FarmerProjectSurvey({this.pending, this.completed});

  FarmerProjectSurvey.fromJson(Map<String, dynamic> json) {
    pending = json['pending'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['pending'] = this.pending;
    data['completed'] = this.completed;
    return data;
  }
}

class FarmerProject {
  dynamic active;
  dynamic completed;

  FarmerProject({this.active, this.completed});

  FarmerProject.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['active'] = this.active;
    data['completed'] = this.completed;
    return data;
  }
}
