import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:glad/cubit/auth_cubit/auth_cubit.dart';
import 'package:glad/data/model/add_followup_remark_model.dart';
import 'package:glad/data/model/auth_models/invite_expert_model.dart';
import 'package:glad/data/model/auth_models/response_otp_model.dart';
import 'package:glad/data/model/dde_project_model.dart';
import 'package:glad/data/model/farmer_dashboard_model.dart';
import 'package:glad/data/model/farmer_project_milestone_detail_model.dart';
import 'package:glad/data/model/farmer_project_model.dart';
import 'package:glad/data/model/followup_remark_list_model.dart';
import 'package:glad/data/model/guest_dashboard_model.dart';
import 'package:glad/data/model/milk_production_chart.dart';
import 'package:glad/data/model/response_dde_dashboard.dart';
import 'package:glad/data/model/farmer_project_detail_model.dart';
import 'package:glad/data/model/response_resource_type.dart';
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

  ///////////////// getDdeProjectsApi //////////
  Future<DdeProjectModel> getDdeProjectsApi(String projectStatus) async {
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.ddeProjectListApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'}, queryParameters: {'project_status': projectStatus});

    if (apiResponse.status) {
      return DdeProjectModel.fromJson(apiResponse.response!.data);
    } else {
      return DdeProjectModel(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getDdeProjectsApi //////////
  Future<FarmerProjectDetailModel> getFarmerProjectDetailApi(int projectId) async {
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.farmerProjectDetailApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'}, queryParameters: {'project_id': projectId});

    if (apiResponse.status) {
      return FarmerProjectDetailModel.fromJson(apiResponse.response!.data);
    } else {
      return FarmerProjectDetailModel(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getDdeProjectsApi //////////
  Future<FarmerProjectMilestoneDetailModel> getFarmerProjectMilestoneDetailApi(int milestoneId) async {
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.farmerProjectMilestoneDetailApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'}, queryParameters: {'id': milestoneId});

    if (apiResponse.status) {
      return FarmerProjectMilestoneDetailModel.fromJson(apiResponse.response!.data);
    } else {
      return FarmerProjectMilestoneDetailModel(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getDdeProjectsApi //////////
  Future<ResponseOtpModel> inviteExpertForSurveyApi(int ddeId, String date, String remark) async {
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.addInviteExpertForSurveyApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'}, data: {
          'dde_id' : ddeId,
          'date': date,
          'remark': remark,
        });

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(status: 422, message: apiResponse.msg);
    }
  }

  Future<ResponseOtpModel> suggestedProjectUpdateStatus(String projectStatus, int projectId) async {
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.updateProjectStatusApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'}, data: {
          'farmer_project_id' : projectId,
          'project_status': projectStatus,
        });

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getResourceTypeApi //////////
  Future<ResponseResourceType> getResourceTypeApi() async {
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.resourceTypeListApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseResourceType.fromJson(apiResponse.response!.data);
    } else {
      return ResponseResourceType(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getResourceCapacityApi //////////
  Future<ResponseResourceType> getResourceCapacityApi() async {
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.resourceCapacityListApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseResourceType.fromJson(apiResponse.response!.data);
    } else {
      return ResponseResourceType(status: 422, message: apiResponse.msg);
    }
  }


  ///////////////// projectUOMListApi //////////
  Future<ResponseResourceType> projectUOMListApi() async {
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.projectUOMListApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseResourceType.fromJson(apiResponse.response!.data);
    } else {
      return ResponseResourceType(status: 422, message: apiResponse.msg);
    }
  }

  getUserToken() {
    return sharedPreferences?.getString(AppConstants.token);
  }
}
