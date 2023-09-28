import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:glad/cubit/auth_cubit/auth_cubit.dart';
import 'package:glad/data/model/add_followup_remark_model.dart';
import 'package:glad/data/model/auth_models/invite_expert_model.dart';
import 'package:glad/data/model/auth_models/response_otp_model.dart';
import 'package:glad/data/model/farmer_dashboard_model.dart';
import 'package:glad/data/model/farmer_project_model.dart';
import 'package:glad/data/model/followup_remark_list_model.dart';
import 'package:glad/data/model/guest_dashboard_model.dart';
import 'package:glad/data/model/milk_production_chart.dart';
import 'package:glad/data/model/response_dde_dashboard.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/data/model/response_enquiry_detail.dart';
import 'package:glad/data/model/response_enquiry_model.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:glad/data/network/api_hitter.dart' as api_hitter;

class ProjectRepository {
  final SharedPreferences? sharedPreferences;

  ProjectRepository({this.sharedPreferences});

  ///////////////// getFarmerProjectsApi //////////
  Future<FarmerProjectModel> getFarmerProjectsApi(String projectStatus) async {
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.farmerProjectListApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'}, queryParameters: {'project_status': projectStatus});

    if (apiResponse.status) {
      return FarmerProjectModel.fromJson(apiResponse.response!.data);
    } else {
      return FarmerProjectModel(status: 422, message: apiResponse.msg);
    }
  }

  getUserToken() {
    return sharedPreferences?.getString(AppConstants.token);
  }
}
