
import 'package:glad/data/model/news_list_model.dart';
import 'package:glad/data/model/training_and_news_category_model.dart';
import 'package:glad/data/model/training_detail_model.dart';
import 'package:glad/data/model/training_list_model.dart';
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
        .getApiResponse(AppConstants.trainingListApi, queryParameters: data,
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
        .getApiResponse(AppConstants.trainingCategoryApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return TrainingAndNewsCategoryModel.fromJson(apiResponse.response!.data);
    } else {
      return TrainingAndNewsCategoryModel(status: 422, message: apiResponse.msg);
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

    if (apiResponse.status) {
      return TrainingAndNewsCategoryModel.fromJson(apiResponse.response!.data);
    } else {
      return TrainingAndNewsCategoryModel(status: 422, message: apiResponse.msg);
    }
  }

  getUserToken() {
    return sharedPreferences?.getString(AppConstants.token);
  }
}
