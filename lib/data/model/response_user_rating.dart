class ResponseUserRating {
  String? message;
  int? status;
  List<DataUserRating>? data;

  ResponseUserRating({this.message, this.status, this.data});

  ResponseUserRating.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <DataUserRating>[];
      json['data'].forEach((v) {
        data!.add(DataUserRating.fromJson(v));
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

class DataUserRating {
  dynamic totalRatings;
  dynamic rating;

  DataUserRating({this.totalRatings, this.rating});

  DataUserRating.fromJson(Map<String, dynamic> json) {
    totalRatings = json['total_ratings'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_ratings'] = totalRatings;
    data['rating'] = rating;
    return data;
  }
}
