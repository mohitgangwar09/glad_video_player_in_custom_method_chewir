class ResponseFarmerFilterDropdownList {
  String? message;
  int? status;
  List<DataFarmerFilterList>? data;

  ResponseFarmerFilterDropdownList({this.message, this.status, this.data});

  ResponseFarmerFilterDropdownList.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataFarmerFilterList>[];
      json['data'].forEach((v) {
        data!.add(DataFarmerFilterList.fromJson(v));
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

class DataFarmerFilterList {
  dynamic id;
  String? name;
  String? photo;
  dynamic achievement;
  dynamic farmerRating;
  dynamic framerRatingCount;

  DataFarmerFilterList(
      {this.id,
        this.name,
        this.photo,
        this.achievement,
        this.farmerRating,
        this.framerRatingCount});

  DataFarmerFilterList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    photo = json['photo'];
    achievement = json['achievement'];
    farmerRating = json['farmer_rating'];
    framerRatingCount = json['framer_rating_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['photo'] = photo;
    data['achievement'] = achievement;
    data['farmer_rating'] = farmerRating;
    data['framer_rating_count'] = framerRatingCount;
    return data;
  }
}