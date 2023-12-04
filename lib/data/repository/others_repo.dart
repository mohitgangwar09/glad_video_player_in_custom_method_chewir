
import 'package:dio/dio.dart';
import 'package:glad/data/model/auth_models/response_otp_model.dart';
import 'package:glad/data/model/news_list_model.dart';
import 'package:glad/data/model/response_community_comment_list.dart';
import 'package:glad/data/model/response_community_like_list.dart';
import 'package:glad/data/model/response_community_list_model.dart';
import 'package:glad/data/model/training_and_news_category_model.dart';
import 'package:glad/data/model/training_detail_model.dart';
import 'package:glad/data/model/training_list_model.dart';
import 'package:glad/data/model/youtube_video_statistics_model.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:glad/data/network/api_hitter.dart' as api_hitter;

class OthersRepository {
  final SharedPreferences? sharedPreferences;

  OthersRepository({this.sharedPreferences});

  ///////////////// getTrainingListApi //////////
  Future<TrainingListModel> getTrainingListApi(String categoryId) async {
    var data = {"category_id": categoryId};

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(!sharedPreferences!.containsKey(AppConstants.userType) ? AppConstants.guestTrainingListApi : AppConstants.trainingListApi, queryParameters: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return TrainingListModel.fromJson(apiResponse.response!.data);
    } else {
      return TrainingListModel(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getTrainingDetailApi //////////
  Future<TrainingDetailModel> getTrainingDetailApi(String trainingId) async {
   var data = {"id": trainingId};

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.trainingDetailApi, queryParameters: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return TrainingDetailModel.fromJson(apiResponse.response!.data);
    } else {
      return TrainingDetailModel(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getTrainingCategoryApi //////////
  Future<TrainingAndNewsCategoryModel> getTrainingCategoryApi() async {
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(!sharedPreferences!.containsKey(AppConstants.userType) ? AppConstants.guestTrainingCategoryApi : AppConstants.trainingCategoryApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return TrainingAndNewsCategoryModel.fromJson(apiResponse.response!.data);
    } else {
      return TrainingAndNewsCategoryModel(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getTrainingCategoryApi //////////
  Future<YoutubeVideoStatisticsModel?> getVideoStatisticsApi(String videoId) async {
    String apiKey = 'AIzaSyDdkM0EySEulkkwqqB0c5Z29ddPYaY3FU0';
    String url = 'https://www.googleapis.com/youtube/v3/videos?part=statistics&id=$videoId&key=$apiKey';
    print(url);
    Response apiResponse = await Dio().get(url);

    print(apiResponse.data);
    if (apiResponse.statusCode == 200) {
      return YoutubeVideoStatisticsModel.fromJson(apiResponse.data);
    } else {
      return null;
    }
  }

  ///////////////// getNewsListApi //////////
  Future<NewsListModel> getNewsListApi(String categoryId) async {
    var data = {"category_id": categoryId};

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.newsListApi, queryParameters: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return NewsListModel.fromJson(apiResponse.response!.data);
    } else {
      return NewsListModel(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getTrainingCategoryApi //////////
  Future<TrainingAndNewsCategoryModel> getNewsCategoryApi() async {
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.newsCategoryApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});
print(apiResponse.response!.data);
    if (apiResponse.status) {
      return TrainingAndNewsCategoryModel.fromJson(apiResponse.response!.data);
    } else {
      return TrainingAndNewsCategoryModel(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getCommunityListApi //////////
  Future<ResponseCommunityList> getCommunityListApi() async {

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(!sharedPreferences!.containsKey(AppConstants.userType) ? AppConstants.guestCommunityListApi : AppConstants.communityListApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseCommunityList.fromJson(apiResponse.response!.data);
    } else {
      return ResponseCommunityList(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getCommunityDetailApi //////////
  Future<ResponseCommunityList> getCommunityDetailApi(String id) async {
    Map<String, dynamic> param = {
      'id': id
    };
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.communityDetailApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'},
        queryParameters: param);

    if (apiResponse.status) {
      return ResponseCommunityList.fromJson(apiResponse.response!.data);
    } else {
      return ResponseCommunityList(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getCommunityListApi //////////
  Future<ResponseCommunityLikeList> getLikeListApi(String communityId) async {
    var data = {'id': communityId};

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(!sharedPreferences!.containsKey(AppConstants.userType) ? AppConstants.guestLikeListApi : AppConstants.likeListApi, queryParameters: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseCommunityLikeList.fromJson(apiResponse.response!.data);
    } else {
      return ResponseCommunityLikeList(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getCommunityListApi //////////
  Future<ResponseCommunityCommentList> getCommentListApi(String communityId) async {
    var data = {'id': communityId};

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(!sharedPreferences!.containsKey(AppConstants.userType) ? AppConstants.guestCommentListApi : AppConstants.commentListApi, queryParameters: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseCommunityCommentList.fromJson(apiResponse.response!.data);
    } else {
      return ResponseCommunityCommentList(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getCommunityListApi //////////
  Future<ResponseOtpModel> addCommentApi(String communityId, String comment) async {
    var data = {'community_id': communityId, 'comment': comment};

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.addCommentApi, data: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(status: 422, message: apiResponse.msg);
    }
  }

 ///////////////// getCommunityListApi //////////
  Future<ResponseOtpModel> addPostApi(String remark, String path) async {
      var data = FormData.fromMap({'remark': remark});
      data.files.add(MapEntry(
          'community_document_files[]', await MultipartFile.fromFile(path)));

      api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
          .getPostApiResponse(AppConstants.addPostApi, data: data,
          headers: {'Authorization': 'Bearer ${getUserToken()}'});

      if (apiResponse.status) {
        return ResponseOtpModel.fromJson(apiResponse.response!.data);
      } else {
        return ResponseOtpModel(status: 422, message: apiResponse.msg);
      }
    }

  ///////////////// addLikeApi //////////
  Future<ResponseOtpModel> addLikeApi(String communityId) async {
    var data = {'community_id': communityId};

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.addLikeApi, data: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(status: 422, message: apiResponse.msg);
    }
  }

  getUserToken() {
    return sharedPreferences?.getString(AppConstants.token);
  }
}
