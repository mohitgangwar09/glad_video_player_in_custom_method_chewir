import 'package:glad/data/model/farmers_list.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:glad/data/network/api_hitter.dart' as api_hitter;

class DdeRepository {
  final SharedPreferences? sharedPreferences;

  DdeRepository({this.sharedPreferences});

  ///////////////// farmersList //////////


  Future<FarmersList> getFarmersList() async {
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter().getApiResponse(
        AppConstants.farmerList, headers: {'Authorization': 'Bearer ${getUserToken()}'});
    if (apiResponse.status) {
      return FarmersList.fromJson(apiResponse.response!.data);
    } {
      return FarmersList(
          status: 422,
          message: apiResponse.msg);
    }
  }

  getUserToken() {
    return sharedPreferences?.getString(AppConstants.token);
  }
}