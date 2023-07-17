import 'package:flutter/foundation.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final SharedPreferences sharedPreferences;

  AuthRepository({required this.sharedPreferences});

  ///////////////// loginApi //////////
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
    await sharedPreferences.setString(AppConstants.token, token);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.token) ?? '';
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.token);
  }

  Future<bool> clearSharedData() async {
    await sharedPreferences.remove(AppConstants.token);
    await sharedPreferences.remove(AppConstants.userId);
    return true;
  }
}
