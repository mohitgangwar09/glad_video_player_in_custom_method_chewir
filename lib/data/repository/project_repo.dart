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
import 'package:glad/data/model/response_capacity_list.dart';
import 'package:glad/data/model/response_dde_dashboard.dart';
import 'package:glad/data/model/farmer_project_detail_model.dart';
import 'package:glad/data/model/response_material_type.dart';
import 'package:glad/data/model/response_not_required.dart';
import 'package:glad/data/model/response_price_attribute.dart';
import 'package:glad/data/model/response_resource_name.dart';
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
  Future<FarmerProjectModel> getFarmerProjectsApi(String projectFilter) async {
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.farmerProjectListApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'}, queryParameters: {
          'project_filter': projectFilter
          // 'project_status': projectStatus
        });

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
  Future<ResponseOtpModel> inviteExpertForSurveyApi(int projectId, String date,
      String remark,String projectStatus,String farmerId) async {
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.addInviteExpertForSurveyApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'}, data: {
          // 'dde_id' : ddeId,
          'farmer_project_id': projectId,
          'date': date,
          'remarks': remark,
          'project_status': projectStatus,
          'farmer_id': farmerId,
        });

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(status: 422, message: apiResponse.msg);
    }
  }

  // Future<ResponseOtpModel> suggestedProjectUpdateStatus(String projectStatus, int projectId) async {
  //   api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
  //       .getPostApiResponse(AppConstants.updateProjectStatusApi,
  //       headers: {'Authorization': 'Bearer ${getUserToken()}'}, data: {
  //         'farmer_project_id' : projectId,
  //         'project_status': projectStatus,
  //       });
  //
  //   if (apiResponse.status) {
  //     return ResponseOtpModel.fromJson(apiResponse.response!.data);
  //   } else {
  //     return ResponseOtpModel(status: 422, message: apiResponse.msg);
  //   }
  // }

  ///////////////// getResourceTypeApi //////////
  Future<ResponseResourceType> getResourceTypeApi(String mileStoneId,String resourceName) async {
    var data = {
      "milestone_id": mileStoneId,
      "resource_name": resourceName,
    };
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.resourceTypeListApi,
        queryParameters: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseResourceType.fromJson(apiResponse.response!.data);
    } else {
      return ResponseResourceType(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getMaterialTypeApi //////////
  Future<ResponseResourceName> getResourceNameApi(String farmerId,String farmerProjectId,String farmerMileStoneId) async {

    var data = {
      "farmer_id" : farmerId,
      "farmer_project_id" : farmerProjectId,
      "farmer_milestone_id" : farmerMileStoneId,
    };

    print(data);

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.resourceNameListApi,
        queryParameters: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseResourceName.fromJson(apiResponse.response!.data);
    } else {
      return ResponseResourceName(status: 422, message: apiResponse.msg);
    }
  }

  ///////////////// getResourceCapacityApi //////////
  Future<ResponseCapacityList> getResourceCapacityApi(String mileStoneId,String resourceName,String resourceType) async {
    var data = {
      "milestone_id": mileStoneId,
      "resource_name": resourceName,
      "resource_type": resourceType,
    };
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.resourceCapacityListApi,
        queryParameters: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseCapacityList.fromJson(apiResponse.response!.data);
    } else {
      return ResponseCapacityList(status: 422, message: apiResponse.msg);
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

  ///////////////// projectUOMListApi //////////
  Future<ResponseNotRequiredData> notRequiredDataApi(String id) async {
    var data = {
      "id": id
    };

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.notRequiredDataApi,
        queryParameters: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseNotRequiredData.fromJson(apiResponse.response!.data);
    } else {
      return ResponseNotRequiredData(status: 422, message: apiResponse.msg);
    }
  }

  Future<ResponseOtpModel> updateAttributeApi(
      String farmerId,
      String farmerProjectId,
      String farmerMilestoneId,
      String resourceName,
      String resourceType,
      String resourceCapacity,
      String resourceSize,
      String resourceUom,
      String resourcePrice,
      String primaryId,
      ) async {

    var data = {
    'farmer_id' : farmerId,
    'farmer_project_id': farmerProjectId,
    'farmer_milestone_id': farmerMilestoneId,
    'resource_name' : resourceName,
    'resource_type' : resourceType,
    'resource_capacity': resourceCapacity,
    'resource_size': resourceSize,
    'resource_uom': resourceUom,
    'resource_price': resourcePrice,
    'id': primaryId,
    };

    print(data);
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.updateAttributeApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'},data: data);

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(status: 422, message: apiResponse.msg);
    }
  }

  Future<ResponseOtpModel> addAttributeApi(
      String farmerProjectId,
      String farmerMilestoneId,
      String resourceName,
      String resourceType,
      String resourceCapacity,
      String resourceSize,
      String resourceUom,
      ) async {

    var data = {
      'farmer_project_id': farmerProjectId,
      'farmer_milestone_id': farmerMilestoneId,
      // 'resource_name' : 'Plastic',
      // 'resource_type' : 'Plastic Pipe',
      'resource_name' : resourceName,
      'resource_type' : resourceType,
      'resource_capacity': resourceCapacity,
      'resource_size': resourceSize,
      'resource_uom': resourceUom,
    };

    print(data);
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.addAttributeApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'},data: data);

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(status: 422, message: apiResponse.msg);
    }
  }

  Future<ResponsePriceAttribute> getPriceAttributeApi(
      String materialName,
      String resourceTypeName,
      String resourceCapacity,
      String resourceQty,
      String projectId,
      String mileStoneId,
      ) async {
    var data = {
      'resource_name' : materialName,
      'resource_type': resourceTypeName,
      'resource_capacity': resourceCapacity,
      'quantity': resourceQty,
      'project_id': projectId,
      'milestone_id': mileStoneId,
    };
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.priceAttributeApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'},
        data: data);

    if (apiResponse.status) {
      return ResponsePriceAttribute.fromJson(apiResponse.response!.data);
    } else {
      return ResponsePriceAttribute(status: 422, message: apiResponse.msg);
    }
  }

  Future<ResponseOtpModel> deleteAttributeApi(
      String id,
      ) async {
    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.deleteAttributeApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'}, data: {
          'id' : id,
        });

    if (apiResponse.status) {
      return ResponseOtpModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseOtpModel(status: 422, message: apiResponse.msg);
    }
  }

  getUserToken() {
    return sharedPreferences?.getString(AppConstants.token);
  }
}
