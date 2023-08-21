import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:glad/data/model/api_response.dart';
import 'package:glad/data/model/auth_models/mail_login_model.dart';
import 'package:glad/data/model/auth_models/response_otp_model.dart';
import 'package:glad/data/model/errors_model.dart';
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

    var data = {
      "id": userId
    };

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter().getApiResponse(
        AppConstants.profileApi,
        queryParameters: data);

    if (apiResponse.status) {
      return ResponseProfile.fromJson(apiResponse.response!.data);
    } {
      return ResponseProfile(
          status: 422,
          message: apiResponse.msg);
    }
  }


  ///////////////// updateProfileApi //////////
  Future<ResponseOtpModel> updateProfileImageAPi(File file) async {

    var userId = sharedPreferences!.getString(AppConstants.userId);

    FormData formData = FormData.fromMap({
      "id": userId,
      "profile_pic": await MultipartFile.fromFile(file.path)
    });

    print(formData.fields);

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.updateProfileImageAPi,
        data: formData);

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(
          status: 422,
          message: apiResponse.msg);
    }
  }

}
