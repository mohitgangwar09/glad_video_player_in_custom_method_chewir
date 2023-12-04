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


  Future<FarmersList> getFarmersList(String ragRatingType,
  {String? orderBy,
  String? milkingCowsFrom,
  String? milkingCowsTo,
  String? milkSupplyFrom,
  String? milkSupplyTo,
  String? yieldPerCowFrom,
  String? yieldPerCowTo,
  String? farmSizeFrom,
  String? farmSizeTo,
  String? herdSizeFrom,
  String? herdSizeTo,
  }
) async {
    Map<String,dynamic> param;
    if(ragRatingType != ''){
      param = {
        'rag_rating_type': ragRatingType,
        "order_by": orderBy,
        "milking_cows_from": milkingCowsFrom,
        "milking_cows_upto": milkingCowsTo,
        "milk_supply_from": milkSupplyFrom,
        "milk_supply_upto": milkSupplyTo,
        "yield_per_cow_from": yieldPerCowFrom,
        "yield_per_cow_upto": yieldPerCowTo,
        "farm_size_from": farmSizeFrom,
        "farm_size_upto": farmSizeTo,
        "herd_size_from": herdSizeFrom,
        "herd_size_upto": herdSizeTo
      };
    }else{
      param = {
        "order_by": orderBy,
        "milking_cows_from": milkingCowsFrom,
        "milking_cows_upto": milkingCowsTo,
        "milk_supply_from": milkSupplyFrom,
        "milk_supply_upto": milkSupplyTo,
        "yield_per_cow_from": yieldPerCowFrom,
        "yield_per_cow_upto": yieldPerCowTo,
        "farm_size_from": farmSizeFrom,
        "farm_size_upto": farmSizeTo,
        "herd_size_from": herdSizeFrom,
        "herd_size_upto": herdSizeTo
      };
    }
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter().getApiResponse(
        AppConstants.farmerList, headers: {'Authorization': 'Bearer ${getUserToken()}'},
        queryParameters: param);
        // queryParameters: ragRatingType != '' ? param : {});
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

  Future<ResponseBreed> getBreedApi(String userId) async {

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.getBreedListApi,queryParameters: {
          "id":userId
          // "id":"1847"
          }, headers: {'Authorization': 'Bearer ${getUserToken()}'});
      // 'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseBreed.fromJson(apiResponse.response!.data);
    }else
    {
      return ResponseBreed(status: 422, message: apiResponse.msg);
    }
  }

  // Future<ImprovementAreaListModel> getImprovementArea(int farmerId) async {
  //   api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter().getApiResponse(
  //       AppConstants.improvementAreaList, headers: {'Authorization': 'Bearer ${getUserToken()}'}, queryParameters: {'farmer_id': farmerId});
  //   if (apiResponse.status) {
  //     return ImprovementAreaListModel.fromJson(apiResponse.response!.data);
  //   } {
  //     return ImprovementAreaListModel(
  //         status: 422,
  //         message: apiResponse.msg);
  //   }
  // }
  //
  // Future<ImprovementAreaUpdateResponse> updateImprovementArea(Map<String, dynamic> data) async {
  //   api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter().getPostApiResponse(
  //       AppConstants.improvementAreaUpdate, headers: {'Authorization': 'Bearer ${getUserToken()}'}, data :data);
  //   if (apiResponse.status) {
  //     return ImprovementAreaUpdateResponse.fromJson(apiResponse.response!.data);
  //   } {
  //     return ImprovementAreaUpdateResponse(
  //         status: 422,
  //         message: apiResponse.msg);
  //   }
  // }

  getUserToken() {
    return sharedPreferences?.getString(AppConstants.token);
  }
}