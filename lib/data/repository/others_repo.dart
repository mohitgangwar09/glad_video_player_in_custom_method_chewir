import 'dart:io';

import 'package:dio/dio.dart';
import 'package:glad/data/model/auth_models/response_otp_model.dart';
import 'package:glad/data/model/farmer_profile_model.dart';
import 'package:glad/data/model/improvement_area_list_model.dart';
import 'package:glad/data/model/improvement_area_update_response.dart';
import 'package:glad/data/model/response_county_list.dart';
import 'package:glad/data/model/response_district.dart';
import 'package:glad/data/model/response_profile_model.dart';
import 'package:glad/data/model/response_sub_county.dart';
import 'package:glad/data/model/response_validate_country.dart';
import 'package:glad/data/model/training_category_model.dart';
import 'package:glad/data/model/training_detail_model.dart';
import 'package:glad/data/model/training_list_model.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:glad/data/network/api_hitter.dart' as api_hitter;

class OthersRepository {
  final SharedPreferences? sharedPreferences;

  OthersRepository({this.sharedPreferences});

  ///////////////// getTrainingListApi //////////
  Future<TrainingListModel> getTrainingListApi(String categoryName) async {
    var data = {"category_name": categoryName};

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.trainingListApi, queryParameters: data);

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
        .getApiResponse(AppConstants.trainingDetailApi, queryParameters: data);

    if (apiResponse.status) {
      return TrainingDetailModel.fromJson(apiResponse.response!.data);
    } else {
      return TrainingDetailModel(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getTrainingCategoryApi //////////
  Future<TrainingCategoryModel> getTrainingCategoryApi() async {
    var userId = sharedPreferences?.getString(AppConstants.userId);

    var data = {"id": userId};

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.trainingCategoryApi, queryParameters: data);

    if (apiResponse.status) {
      return TrainingCategoryModel.fromJson(apiResponse.response!.data);
    } else {
      return TrainingCategoryModel(status: 422, message: apiResponse.msg);
    }
  }

  getUserToken() {
    return sharedPreferences?.getString(AppConstants.token);
  }
}
