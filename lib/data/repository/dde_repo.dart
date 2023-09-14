import 'dart:convert';

import 'package:glad/data/model/auth_models/mail_login_model.dart';
import 'package:glad/data/model/auth_models/response_otp_model.dart';
import 'package:glad/data/model/farmers_list.dart';
import 'package:glad/data/model/response_breed.dart';
import 'package:glad/data/model/response_cow_breed_details.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:glad/data/network/api_hitter.dart' as api_hitter;

class DdeRepository {
  final SharedPreferences? sharedPreferences;

  DdeRepository({this.sharedPreferences});

  ///////////////// farmersList //////////


  Future<FarmersList> getFarmersList() async {
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter().getApiResponse(
        AppConstants.farmerList, headers: {'Authorization': 'Bearer ${getUserToken()}'});
    if (apiResponse.status) {
      return FarmersList.fromJson(apiResponse.response!.data);
    } {
      return FarmersList(
          status: 422,
          message: apiResponse.msg);
    }
  }

  // cowBreedDetailsApi
  Future<ResponseCowBreedDetails> cowBreedDetailsApi() async {
    var data = {
      "id": "1847"
    };
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter().getApiResponse(
        AppConstants.getCowBreedDetailApi,queryParameters: data ,headers: {'Authorization': 'Bearer ${"144|laravel_sanctum_rsyRvi0F174XacxAdUqkqZN9zAXerLowjgQVEKRn14b390ea"}'});
        // AppConstants.getCowBreedDetailApi,queryParameters: data ,headers: {'Authorization': 'Bearer ${getUserToken()}'});
    if (apiResponse.status) {
      return ResponseCowBreedDetails.fromJson(apiResponse.response!.data);
    } {
      return ResponseCowBreedDetails(
          status: 422,
          message: apiResponse.msg);
    }
  }

  Future<ResponseOtpModel> updateCowBreedRecordApi(String requestData) async {

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter().getPostApiResponse(
        AppConstants.updateCowBreedDetailApi,
        data: requestData,headers: {'Authorization': 'Bearer ${"144|laravel_sanctum_rsyRvi0F174XacxAdUqkqZN9zAXerLowjgQVEKRn14b390ea"}'});
        // data: requestData,headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } {
      return ResponseOtpModel(
          status: 422,
          message: apiResponse.msg);
    }
  }

  Future<ResponseOtpModel> addMonthApi(String farmerId) async {

    var data = {
      "farmer_id": farmerId
    };

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter().getPostApiResponse(
        AppConstants.addMonthApi,
        data: data,headers: {'Authorization': 'Bearer ${"144|laravel_sanctum_rsyRvi0F174XacxAdUqkqZN9zAXerLowjgQVEKRn14b390ea"}'});

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } {
      return ResponseOtpModel(
          status: 422,
          message: apiResponse.msg);
    }
  }

  Future<ResponseOtpModel> deleteMonthApi(String monthName,String farmerId) async {

    print("monthId$monthName");

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter().getPostApiResponse(
        AppConstants.deleteMonthApi,data: {
          "farmer_id": farmerId.toString(),
          "month": monthName,
          },headers: {'Authorization': 'Bearer ${"144|laravel_sanctum_rsyRvi0F174XacxAdUqkqZN9zAXerLowjgQVEKRn14b390ea"}'});

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } {
      return ResponseOtpModel(
          status: 422,
          message: apiResponse.msg);
    }
  }


  ///////////////getBreedList/////////////

  Future<ResponseBreed> getBreedApi() async {

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.getBreedListApi,queryParameters: {
          "id":"1847"
          }, headers: {'Authorization': 'Bearer ${"144|laravel_sanctum_rsyRvi0F174XacxAdUqkqZN9zAXerLowjgQVEKRn14b390ea"}'});
      // 'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseBreed.fromJson(apiResponse.response!.data);
    }else
    {
      return ResponseBreed(status: 422, message: apiResponse.msg);
    }
  }

  getUserToken() {
    print(sharedPreferences?.getString(AppConstants.token));
    return sharedPreferences?.getString(AppConstants.token);
  }
}