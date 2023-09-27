import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:glad/data/model/api_response.dart';
import 'package:glad/data/model/auth_models/mail_login_model.dart';
import 'package:glad/data/model/auth_models/response_otp_model.dart';
import 'package:glad/data/model/errors_model.dart';
import 'package:glad/data/model/farmer_profile_model.dart';
import 'package:glad/data/model/response_district.dart';
import 'package:glad/data/model/response_profile_model.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:glad/data/network/api_hitter.dart' as api_hitter;

class ProfileRepository {
  final SharedPreferences? sharedPreferences;

  ProfileRepository({this.sharedPreferences});

  ///////////////// userProfileApi //////////

  Future<ResponseProfile> getUserProfileApi() async {
    var userId = sharedPreferences?.getString(AppConstants.userId);

    var data = {"id": userId};

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.profileApi, queryParameters: data);

    if (apiResponse.status) {
      return ResponseProfile.fromJson(apiResponse.response!.data);
    }else
    {
      return ResponseProfile(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// updateProfileApi //////////
  Future<ResponseOtpModel> updateProfileImageAPi(File file) async {
    var userId = sharedPreferences!.getString(AppConstants.userId);

    FormData formData = FormData.fromMap(
        {"id": userId, "profile_pic": await MultipartFile.fromFile(file.path)});

    print(formData.fields);

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.updateProfileImageAPi, data: formData);

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(status: 422, message: apiResponse.msg);
    }
  }

  Future<FarmerProfileModel> getFarmerProfileApi(String userId) async {

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter().getApiResponse(
        '${AppConstants.farmerDetailsApi}/$userId', headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return FarmerProfileModel.fromJson(apiResponse.response!.data);
    } else {
      return FarmerProfileModel(
          status: 422,
          message: apiResponse.msg);
    }
  }

  Future<FarmerProfileModel> updateFarmerDetailApi(String gender,
      String landlineNumber,String file,String dob,String farmingExperience) async {

    FormData formData;
    var userId = sharedPreferences?.getString(AppConstants.userId);

    if(file == ""){
      if(dob == ""){
        formData = FormData.fromMap({
          "id": userId,
          "gender": gender,
          "phone": landlineNumber,
          "farming_experience": farmingExperience,

        });
      }else{
        formData = FormData.fromMap({
          "id": userId,
          "gender": gender,
          "phone": landlineNumber,
          "date_of_birth": dob,
          "farming_experience": farmingExperience,
        });
      }

    }else{
      File files = File(file);
      if(dob == ""){
        formData = FormData.fromMap({
          "id": userId,
          "gender": gender,
          "phone": landlineNumber,
          "photo": await MultipartFile.fromFile(files.path),
          "farming_experience": farmingExperience,
        });
      }else{
        formData = FormData.fromMap({
          "id": userId,
          "gender": gender,
          "phone": landlineNumber,
          "date_of_birth": dob,
          "photo": await MultipartFile.fromFile(files.path),
          "farming_experience": farmingExperience,
        });
      }
    }

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter().getPostApiResponse(
        AppConstants.updateFarmerApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'},
        data: formData
    );

    if (apiResponse.status) {
      return FarmerProfileModel.fromJson(apiResponse.response!.data);
    } else {
      return FarmerProfileModel(status: 422, message: apiResponse.msg);
    }
  }

  ////////////////////address UpdateApi////////////////
  Future<ResponseOtpModel> addressUpdateApi(
      String country,
      String districtId,
      String county,
      String parish,
      String village,
      String centreName,String userId) async {
    // var userId = sharedPreferences?.getString(AppConstants.userId);

    FormData formData = FormData.fromMap({
      "id": userId,
      "district": districtId,
      "country_id": 227,
      "county": county,
      "parish": parish,
      "village": village,
      "centreName": centreName,
    });
    print(formData.fields);

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.updateFarmerApi,
            headers: {'Authorization': 'Bearer ${getUserToken()}'},
            data: formData);

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(status: 422, message: apiResponse.msg);
    }
  }

  Future<FarmerProfileModel> updateFarmApi(String farmSize,String dairyArea,
      String staffQuantity, String managerName,String managerPhone,String userId) async {

    FormData formData = FormData.fromMap({
      "id": userId,
      "farm_size": farmSize,
      "dairy_area": dairyArea,
      "staff_quantity": staffQuantity,
      "manager_name": managerName,
      "manager_phone": managerPhone,
    });
    print(formData.fields);

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.updateFarmApi,
            data: formData,
            headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return FarmerProfileModel.fromJson(apiResponse.response!.data);
    } else {
      return FarmerProfileModel(status: 422, message: apiResponse.msg);
    }
  }

  Future<FarmerProfileModel> updateDdeFarmerDetail(String farmSize,String dairyArea,
      String staffQuantity, String managerName,String managerPhone,String userId,String landlineNumber,
      String farmingExperience,String gender,String dateOfBirth) async {

    FormData formData = FormData.fromMap({
      "id": userId,
      "farm_size": farmSize,
      "dairy_area": dairyArea,
      "staff_quantity": staffQuantity,
      "manager_name": managerName,
      "manager_phone": managerPhone,
      "landline_no": landlineNumber,
      "farming_experience": farmingExperience,
      "gender": gender,
      "date_of_birth": dateOfBirth,
    });
    print(formData.fields);

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.updateFarmApi,
        data: formData,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return FarmerProfileModel.fromJson(apiResponse.response!.data);
    } else {
      return FarmerProfileModel(status: 422, message: apiResponse.msg);
    }
  }


  ///////////////GetDistrict/////////////

  Future<ResponseDistrict> getDistrict() async {

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.getDistrict, headers: {
      'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseDistrict.fromJson(apiResponse.response!.data);
    }else
    {
      return ResponseDistrict(status: 422, message: apiResponse.msg);
    }
  }

  getUserToken() {
    return sharedPreferences?.getString(AppConstants.token);
  }
}
