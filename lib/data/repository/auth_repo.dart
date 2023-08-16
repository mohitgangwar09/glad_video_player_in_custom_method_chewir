import 'package:flutter/foundation.dart';
import 'package:glad/data/model/api_response.dart';
import 'package:glad/data/model/auth_models/mail_login_model.dart';
import 'package:glad/data/model/errors_model.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:glad/data/network/api_hitter.dart' as api_hitter;

class AuthRepository {
   final SharedPreferences? sharedPreferences;


  AuthRepository({this.sharedPreferences});

  ///////////////// loginApi //////////

  Future<MobileLoginModel> loginWithPasswordApi(String email,String password) async {

    var data = {
      "email": email,
      "password": password,
      "device_id": password,
      "device_name": password,
      "device_token": password,
    };

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter().getPostApiResponse(
      AppConstants.loginWithPasswordApi,
      data: data);

    print(apiResponse.response);
    if (apiResponse.status) {
      return MobileLoginModel.fromJson(apiResponse.response!.data);
    } {
    return MobileLoginModel(
          status: 422,
          message: apiResponse.msg);
    }
  }


   ///////////////// verifyOtpApi //////////
   Future verifyOtpApi(String otp, String id) async {
     api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
         .getPostApiResponse(AppConstants.verifyOtpApi,
         data: {
           'otp': otp,
           'id': id});

     return apiResponse.response!.data;
   }
     /*if (apiResponse.status) {
       // return VerifyPasswordModel.fromJson(apiResponse.response!.data);
       return apiResponse.response!.data;
     } else {
       return apiResponse.response!.data;
   }*/

   /*Future<ResendModel> resendOtpApi(String token) async {
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.resendAPi,
        headers: {'Authorization': 'Bearer $token'});
    if (apiResponse.status) {
      return ResendModel.fromJson(apiResponse.response!.data);
    } else {
      return ResendModel(
          statusCode: 422,
          errors: [ErrorModel(message: apiResponse.msg)],
          message: apiResponse.msg);
    }
  }*/


  ///////////////// resetPasswordApi //////////
  Future createPasswordApi(String id,String password,String confirmPassword) async {

    var data = {
      "id": id,
      "password": password,
      "password_confirmation": confirmPassword,
    };

    print(data);
    api_hitter.ApiResponse response = await api_hitter.ApiHitter().getPostApiResponse(
        AppConstants.createPasswordPasswordApi,
        data: data);

    return response;


  }

  /*Future<MobileSignUpModel> loginAndSignUpWithPhoneApi(
      String phone, bool isTermsCondition, String countryCode,) async {
    String fcm=await SharedPrefManager.getPreferenceString(AppConstants.fcmToken,);
    if (kDebugMode) {
      print(fcm);
    }
    var data = {
      'mobileNo': phone,
      'isTermsCondition': isTermsCondition,
      'phoneCode': countryCode,
      'roleId': AppConstants.roleId,
     // 'timeZone': currentTimeZone(),
      'fcmToken':fcm};
    api_hitter.ApiResponse apiResponse =
        await api_hitter.ApiHitter().getPostApiResponse(
      AppConstants.loginAndSignUpWithPhoneApi,
      data: data,
    );
    if (apiResponse.status) {
      return MobileSignUpModel.fromJson(apiResponse.response!.data);
    } else {
      return MobileSignUpModel(
          statusCode: 422,
          errors: [ErrorModel(message: apiResponse.msg)],
          message: apiResponse.msg);
    }
  }

  Future<ResendModel> resendOtpApi(String token) async {
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.resendAPi,
            headers: {'Authorization': 'Bearer $token'});
    if (apiResponse.status) {
      return ResendModel.fromJson(apiResponse.response!.data);
    } else {
      return ResendModel(
          statusCode: 422,
          errors: [ErrorModel(message: apiResponse.msg)],
          message: apiResponse.msg);
    }
  }

  ///////////////// verifyOtpApi //////////
  Future<VerifyPasswordModel> verifyOtpApi(String otp, String token) async {
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.verifyOtpAPi,
            data: {'otp': otp,
             // 'timeZone': currentTimeZone(),
            }, headers: {'Authorization': 'Bearer $token'});
    if (apiResponse.status) {
      return VerifyPasswordModel.fromJson(apiResponse.response!.data);
    } else {
      return VerifyPasswordModel(
          statusCode: 422,
          errors: [ErrorModel(message: apiResponse.msg)],
          message: apiResponse.msg);
    }
  }


  Future<GetProfileModel> getProfileApi(String token) async {
    print(token);
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter().getApiResponse(
      AppConstants.profileApi,
      headers: {'Authorization': 'Bearer $token'},
    );
    if (apiResponse.status) {
      return GetProfileModel.fromJson(apiResponse.response!.data);
    } else {
      return GetProfileModel(
          statusCode: 422,
          errors: [ErrorModel(message: apiResponse.msg)],
          message: apiResponse.msg);
    }
  }*/

  // for  user token
  Future<void> saveUserToken(String token) async {
    await sharedPreferences?.setString(AppConstants.token, token);
  }

  String getUserToken() {
    return sharedPreferences?.getString(AppConstants.token) ?? '';
  }

  bool isLoggedIn() {
    return sharedPreferences!.containsKey(AppConstants.token);
  }

  Future<bool> clearSharedData() async {
    await sharedPreferences?.remove(AppConstants.token);
    await sharedPreferences?.remove(AppConstants.userId);
    return true;
  }
}
