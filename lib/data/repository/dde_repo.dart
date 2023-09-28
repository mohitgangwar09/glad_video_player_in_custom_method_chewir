import 'package:glad/data/model/auth_models/response_otp_model.dart';
import 'package:glad/data/model/farmers_list.dart';
import 'package:glad/data/model/improvement_area_list_model.dart';
import 'package:glad/data/model/improvement_area_update_response.dart';
import 'package:glad/data/model/response_breed.dart';
import 'package:glad/data/model/response_cow_breed_details.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:glad/data/network/api_hitter.dart' as api_hitter;

class DdeRepository {
  final SharedPreferences? sharedPreferences;

  DdeRepository({this.sharedPreferences});

  ///////////////// farmersList //////////


  Future<FarmersList> getFarmersList(String ragRatingType) async {
    Map<String,dynamic> param = {'rag_rating_type': ragRatingType};
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter().getApiResponse(
        AppConstants.farmerList, headers: {'Authorization': 'Bearer ${getUserToken()}'}, queryParameters: ragRatingType != '' ? param : {});
    if (apiResponse.status) {
      return FarmersList.fromJson(apiResponse.response!.data);
    } {
      return FarmersList(
          status: 422,
          message: apiResponse.msg);
    }
  }

  // cowBreedDetailsApi
  Future<ResponseCowBreedDetails> cowBreedDetailsApi({String? id}) async {
    var data = {
      "id": id
    };
    print(data);
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter().getApiResponse(
        AppConstants.getCowBreedDetailApi,queryParameters: data ,headers: {'Authorization': 'Bearer ${getUserToken()}'});
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
        data: requestData,headers: {'Authorization': 'Bearer ${getUserToken()}'});

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
        data: data,headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } {
      return ResponseOtpModel(
          status: 422,
          message: apiResponse.msg);
    }
  }

  Future<ResponseOtpModel> deleteMonthApi(String monthName,String farmerId) async {

    print("monthId$monthName ffff $farmerId");

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter().getPostApiResponse(
        AppConstants.deleteMonthApi,data: {
          "farmer_id": farmerId.toString(),
          "month": monthName,
          },headers: {'Authorization': 'Bearer ${getUserToken()}'});

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
          }, headers: {'Authorization': 'Bearer ${getUserToken()}'});
      // 'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseBreed.fromJson(apiResponse.response!.data);
    }else
    {
      return ResponseBreed(status: 422, message: apiResponse.msg);
    }
  }

  Future<ImprovementAreaListModel> getImprovementArea(int farmerId) async {
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter().getApiResponse(
        AppConstants.improvementAreaList, headers: {'Authorization': 'Bearer ${getUserToken()}'}, queryParameters: {'farmer_id': farmerId});
    if (apiResponse.status) {
      return ImprovementAreaListModel.fromJson(apiResponse.response!.data);
    } {
      return ImprovementAreaListModel(
          status: 422,
          message: apiResponse.msg);
    }
  }

  Future<ImprovementAreaUpdateResponse> updateImprovementArea(Map<String, dynamic> data) async {
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter().getPostApiResponse(
        AppConstants.improvementAreaUpdate, headers: {'Authorization': 'Bearer ${getUserToken()}'}, data :data);
    if (apiResponse.status) {
      return ImprovementAreaUpdateResponse.fromJson(apiResponse.response!.data);
    } {
      return ImprovementAreaUpdateResponse(
          status: 422,
          message: apiResponse.msg);
    }
  }

  getUserToken() {
    return sharedPreferences?.getString(AppConstants.token);
  }
}