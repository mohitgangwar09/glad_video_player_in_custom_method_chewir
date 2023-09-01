import 'package:glad/data/model/farmer_dashboard_model.dart';
import 'package:glad/data/model/response_profile_model.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:glad/data/network/api_hitter.dart' as api_hitter;

class FarmerRepository {
  final SharedPreferences? sharedPreferences;

  FarmerRepository({this.sharedPreferences});

  ///////////////// farmerDashboardApi //////////
  Future<FarmerDashboard> getFarmerDashboardApi() async {
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter().getApiResponse(
        AppConstants.farmerDashboardApi, headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return FarmerDashboard.fromJson(apiResponse.response!.data);
    } {
      return FarmerDashboard(
          status: 422,
          message: apiResponse.msg);
    }
  }

getUserToken() {
  return sharedPreferences?.getString(AppConstants.token);
}
}
