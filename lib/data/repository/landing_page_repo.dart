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
    } {
      return FarmerDashboard(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// milkProductionChartApi //////////
  Future<MilkProductionChart> getMilkProductionChartApi() async {
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.milkProductionChart,
        headers: {'Authorization': 'Bearer ${getUserToken()}'},
        queryParameters: {'id': sharedPreferences!.getString(AppConstants.userId)});

    if (apiResponse.status) {
      return MilkProductionChart.fromJson(apiResponse.response!.data);
    } {
      return MilkProductionChart(status: 422, message: apiResponse.msg);
    }
  }

  getUserToken() {
    return sharedPreferences?.getString(AppConstants.token);
  }
}
