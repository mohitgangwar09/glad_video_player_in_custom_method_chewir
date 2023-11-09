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
  List<FarmerProjetSurvey>? farmerProjetSurvey;
  List<dynamic>? farmerProjet;
  List<NewsEvent>? newsEvent;
  List<dynamic>? community;
  List<TrainingList>? trainingList;

  Data(
      {this.farmerProjetSurvey,
        this.farmerProjet,
        this.newsEvent,
        this.community,
        this.trainingList});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['farmerProjetSurvey'] != null) {
      farmerProjetSurvey = <FarmerProjetSurvey>[];
      json['farmerProjetSurvey'].forEach((v) {
        farmerProjetSurvey!.add(new FarmerProjetSurvey.fromJson(v));
      });
    }
    // if (json['farmerProjet'] != null) {
    //   farmerProjet = <Null>[];
    //   json['farmerProjet'].forEach((v) {
    //     farmerProjet!.add(new Null.fromJson(v));
    //   });
    // }
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
    if (this.farmerProjetSurvey != null) {
      data['farmerProjetSurvey'] =
          this.farmerProjetSurvey!.map((v) => v.toJson()).toList();
    }
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

class FarmerProjetSurvey {
  String? surveyStatus;
  dynamic count;

  FarmerProjetSurvey({this.surveyStatus, this.count});

  FarmerProjetSurvey.fromJson(Map<String, dynamic> json) {
    surveyStatus = json['survey_status'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['survey_status'] = this.surveyStatus;
    data['count'] = this.count;
    return data;
  }
}
