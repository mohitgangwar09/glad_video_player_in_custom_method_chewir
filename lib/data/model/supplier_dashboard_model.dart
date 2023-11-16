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
  FarmerProjectSurvey? farmerProjectSurvey;
  FarmerProject? farmerProject;
  List<NewsEvent>? newsEvent;
  List<dynamic>? community;
  List<TrainingList>? trainingList;

  Data(
      {this.farmerProjectSurvey,
        this.farmerProject,
        this.newsEvent,
        this.community,
        this.trainingList});

  Data.fromJson(Map<String, dynamic> json) {
    farmerProjectSurvey = json['farmerProjectSurvey'] != null
        ? new FarmerProjectSurvey.fromJson(json['farmerProjectSurvey'])
        : null;
    farmerProject = json['farmerProject'] != null
        ? new FarmerProject.fromJson(json['farmerProject'])
        : null;

    if (json['newsEvent'] != null) {
      newsEvent = <NewsEvent>[];
      json['newsEvent'].forEach((v) {
        newsEvent!.add(new NewsEvent.fromJson(v));
      });
    }
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

class FarmerProjectSurvey {
  int? pending;
  int? completed;

  FarmerProjectSurvey({this.pending, this.completed});

  FarmerProjectSurvey.fromJson(Map<String, dynamic> json) {
    pending = json['pending'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pending'] = this.pending;
    data['completed'] = this.completed;
    return data;
  }
}

class FarmerProject {
  int? active;
  int? completed;

  FarmerProject({this.active, this.completed});

  FarmerProject.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    completed = json['completed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['completed'] = this.completed;
    return data;
  }
}
