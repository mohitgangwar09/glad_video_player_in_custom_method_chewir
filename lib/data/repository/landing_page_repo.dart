import 'package:dio/dio.dart';
import 'package:glad/data/model/auth_models/invite_expert_model.dart';
import 'package:glad/data/model/farmer_dashboard_model.dart';
import 'package:glad/data/model/milk_production_chart.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:glad/data/network/api_hitter.dart' as api_hitter;

class LandingPageRepository {
  final SharedPreferences? sharedPreferences;

  LandingPageRepository({this.sharedPreferences});

  ///////////////// farmerDashboardApi //////////
  Future<FarmerDashboard> getFarmerDashboardApi() async {
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.farmerDashboardApi,
            headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return FarmerDashboard.fromJson(apiResponse.response!.data);
    }
    {
      return FarmerDashboard(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// milkProductionChartApi //////////
  Future<MilkProductionChart> getMilkProductionChartApi() async {
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.milkProductionChart, headers: {
      'Authorization': 'Bearer ${getUserToken()}'
    }, queryParameters: {
      'id': sharedPreferences!.getString(AppConstants.userId)
    });

    if (apiResponse.status) {
      return MilkProductionChart.fromJson(apiResponse.response!.data);
    }
    {
      return MilkProductionChart(status: 422, message: apiResponse.msg);
    }
  }

////////////////////InviteExpert///////////////////////////
  Future<InviteExpert> inviteExpertDetails(
      String name,
      String mobile,
      String address,
      String comment,
      String lat,
      String long) async {
    FormData formData = FormData.fromMap({
      "name": name,
      "mobile": mobile,
      "address": address,
      "comment": comment,
      'device_id': sharedPreferences!.getString(AppConstants.deviceImeiId),
      'lat': lat,
      'long': long,
    });
    print(formData.fields);

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.inviteExpertDetails, data: formData);

    if (apiResponse.status) {
      return InviteExpert.fromJson(apiResponse.response!.data);
    } else {
      return InviteExpert(status: 422, message: apiResponse.msg);
    }
  }

  ////////////////////followupRemarkList///////////////////////////
  Future<InviteExpert> followupRemarkListApi() async {
    Map<String, dynamic> data = {
      'device_id': sharedPreferences!.getString(AppConstants.deviceImeiId),
    };

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.followupRemarkList, queryParameters: data);

    if (apiResponse.status) {
      return InviteExpert.fromJson(apiResponse.response!.data);
    } else {
      return InviteExpert(status: 422, message: apiResponse.msg);
    }
  }

  ////////////////////InviteExpert///////////////////////////
  Future<InviteExpert> addFollowupRemarkApi(
      String enquiryId, String comments) async {
    FormData formData = FormData.fromMap({
      'device_id': sharedPreferences!.getString(AppConstants.deviceImeiId),
      'enquiry_id': enquiryId,
      'comments': comments,
    });
    print(formData.fields);

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.addFollowupRemark, data: formData);

    if (apiResponse.status) {
      return InviteExpert.fromJson(apiResponse.response!.data);
    } else {
      return InviteExpert(status: 422, message: apiResponse.msg);
    }
  }

  getUserToken() {
    return sharedPreferences?.getString(AppConstants.token);
  }
}
