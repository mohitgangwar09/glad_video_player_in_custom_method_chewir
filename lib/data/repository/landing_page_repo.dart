import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:glad/cubit/auth_cubit/auth_cubit.dart';
import 'package:glad/data/model/add_followup_remark_model.dart';
import 'package:glad/data/model/auth_models/invite_expert_model.dart';
import 'package:glad/data/model/farmer_dashboard_model.dart';
import 'package:glad/data/model/followup_remark_list_model.dart';
import 'package:glad/data/model/guest_dashboard_model.dart';
import 'package:glad/data/model/milk_production_chart.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/data/model/response_enquiry_detail.dart';
import 'package:glad/data/model/response_enquiry_model.dart';
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
    }else
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
      'lang': long,
    });
    print(formData.fields);

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.followupRemarkList, data: formData);

    if (apiResponse.status) {
      return InviteExpert.fromJson(apiResponse.response!.data);
    } else {
      return InviteExpert(status: 422, message: apiResponse.msg);
    }
  }

  ////////////////////followupRemarkList///////////////////////////
  Future<FollowupRemarkListModel> followupRemarkListApi(int enquiryId) async {
    Map<String, dynamic> data = {
      'enquiry_id': enquiryId,
    };

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.followupRemarkList, queryParameters: data);

    if (apiResponse.status) {
      return FollowupRemarkListModel.fromJson(apiResponse.response!.data);
    } else {
      return FollowupRemarkListModel(status: 422, message: apiResponse.msg);
    }
  }

  ////////////////////getGuestDashboardApi///////////////////////////
  Future<GuestDashboardModel> getGuestDashboardApi(double lat, double long) async {
    Map<String, dynamic> data = {
      'device_id': sharedPreferences!.getString(AppConstants.deviceImeiId),
      'lat': lat,
      'longitude': long,
    };

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.getGuestDashboard, queryParameters: data);

    if (apiResponse.status) {
      return GuestDashboardModel.fromJson(apiResponse.response!.data);
    } else {
      return GuestDashboardModel(status: 422, message: apiResponse.msg);
    }
  }


  ////////////////////InviteExpert///////////////////////////
  Future<AddFollowupRemarkModel> addFollowupRemarkApi(
      String enquiryId, String comments, bool isDDE) async {
    FormData formData = FormData.fromMap({
      'device_id': sharedPreferences!.getString(AppConstants.deviceImeiId),
      'enquiry_id': enquiryId,
      'comments': comments,
    });
    if(isDDE) {
      formData.fields.add(MapEntry('dde_id',
          sharedPreferences!.getString(AppConstants.userId).toString()));
    }
    print(formData.fields);

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.addFollowupRemark, data: formData);

    if (apiResponse.status) {
      return AddFollowupRemarkModel.fromJson(apiResponse.response!.data);
    } else {
      return AddFollowupRemarkModel(status: 422, message: apiResponse.msg);
    }
  }

  Future<Position> getCurrentPosition() async{
    return await getCurrentLocation();
  }

  ////////////////////enquiryListApi///////////////////////////
  Future<ResponseEnquiryModel> enquiryListApi(String type) async {

    var data = {
      "type": type
    };


    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.enquiryListApi,
        queryParameters: data,
        headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseEnquiryModel.fromJson(apiResponse.response!.data);
    } else {
      return ResponseEnquiryModel(status: 422, message: apiResponse.msg);
    }
  }


  ////////////////////enquiryDetailApi///////////////////////////
  Future<ResponseEnquiryDetail> enquiryDetailApi(String id) async {

    var data = {
      "id": id
    };

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.enquiryDetailsApi,
        queryParameters: data,headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseEnquiryDetail.fromJson(apiResponse.response!.data);
    } else {
      return ResponseEnquiryDetail(status: 422, message: apiResponse.msg);
    }
  }

  getUserToken() {
    return sharedPreferences?.getString(AppConstants.token);
  }
}
