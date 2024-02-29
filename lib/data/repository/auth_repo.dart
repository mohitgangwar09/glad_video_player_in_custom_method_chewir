import 'package:glad/data/model/auth_models/mail_login_model.dart';
import 'package:glad/data/model/auth_models/response_otp_model.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/sharedprefrence.dart';
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
      "device_token": await SharedPrefManager.getPreferenceString(AppConstants.fcmToken),
    };

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter().getPostApiResponse(
      AppConstants.loginWithPasswordApi,
      data: data);

    if (apiResponse.status) {
      return MobileLoginModel.fromJson(apiResponse.response!.data);
    } {
    return MobileLoginModel(
          status: 422,
          message: apiResponse.msg);
    }
  }


   ///////////////// verifyOtpApi //////////
   Future<ResponseOtpModel> verifyOtpApi(String otp, String id) async {
     api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
         .getPostApiResponse(AppConstants.verifyOtpApi,
         data: {
           'otp': otp,
           'id': id});

     if (apiResponse.status) {
       return ResponseOtpModel.fromJson(apiResponse.response!.data);
     } else {
       return ResponseOtpModel(
           status: 422,
           message: apiResponse.msg);
     }
   }

   Future<ResponseOtpModel> resendOtpApi(String email) async {

     var data = {
       "email": email
     };

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.resendOtpApi,data: data);
    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(
          status: 422,
          message: apiResponse.msg);
    }
  }

  // forgot Password Api
   Future<MobileLoginModel> forgotPasswordApi(dynamic email) async {

     var data;

     if(int.tryParse(email) is int){
       data = {
         "mobile": int.tryParse(email) is int ? email : ""
       };
     }else{
       data = {
         "email": int.tryParse(email) is int ? "":email,
         // "mobile": int.tryParse(email) is int ? email : ""
       };
     }

     api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
         .getPostApiResponse(AppConstants.forgotPasswordApi,
     data: data);
     if (apiResponse.status) {
       return MobileLoginModel.fromJson(apiResponse.response!.data);
     } else {
       return MobileLoginModel(
           status: 422,
           message: apiResponse.msg);
     }
   }


  ///////////////// resetPasswordApi //////////
  Future<ResponseOtpModel> createPasswordApi(String id,String password,String confirmPassword) async {

    var data = {
      "id": id,
      "password": password,
      "password_confirmation": confirmPassword,
    };

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter().getPostApiResponse(
        AppConstants.createPasswordPasswordApi,
        data: data);

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(
          status: 422,
          message: apiResponse.msg);
    }
  }

  Future<MobileLoginModel> loginWithPhoneApi(
      String phone) async {

    var data = {
      'user': phone};

    api_hitter.ApiResponse apiResponse =
        await api_hitter.ApiHitter().getPostApiResponse(
      AppConstants.loginWithMobileApi,
      data: data,
    );
    if (apiResponse.status) {
      return MobileLoginModel.fromJson(apiResponse.response!.data);
    } else {
      return MobileLoginModel(
          status: 422,
          message: apiResponse.msg);
    }
  }

  ///////////////// verifyOtpApi //////////
  Future<MobileLoginModel> verifyMobileOtpApi(String otp, String id) async {
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.verifyMobileApi,
            data: {'otp_number': otp,"user_id": id});
    if (apiResponse.status) {
      return MobileLoginModel.fromJson(apiResponse.response!.data);
    } else {
      return MobileLoginModel(
          status: 422,
          message: apiResponse.msg);
    }
  }

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
    await sharedPreferences?.remove(AppConstants.userType);
    return true;
  }
}
