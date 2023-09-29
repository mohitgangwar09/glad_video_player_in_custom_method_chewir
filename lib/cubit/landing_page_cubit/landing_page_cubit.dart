import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:glad/cubit/dde_enquiry_cubit/dde_enquiry_cubit.dart';
import 'package:glad/data/model/farmer_dashboard_model.dart' as dashboard;
import 'package:glad/data/model/followup_remark_list_model.dart';
import 'package:glad/data/model/guest_dashboard_model.dart';
import 'package:glad/data/model/milk_production_chart.dart';
import 'package:glad/data/model/response_dde_dashboard.dart';
import 'package:glad/data/repository/landing_page_repo.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/guest_user/thankyou_screen.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'landing_page_state.dart';

class LandingPageCubit extends Cubit<LandingPageState> {
  final SharedPreferences sharedPreferences;
  final LandingPageRepository apiRepository;

  LandingPageCubit(
      {required this.apiRepository, required this.sharedPreferences})
      : super(LandingPageState.initial());

  void getFarmerDashboard(context) async {
    emit(state.copyWith(status: LandingPageStatus.loading));
    // customDialog(widget: launchProgress());
    var response = await apiRepository.getFarmerDashboardApi();
    if (response.status == 200) {
      emit(state.copyWith(
          status: LandingPageStatus.success, response: response.data));
      // disposeProgress();
    } else {
      emit(state.copyWith(status: LandingPageStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  void getMilkProductionChart(context) async {
    emit(state.copyWith(status: LandingPageStatus.loading));
    // customDialog(widget: launchProgress());
    var response = await apiRepository.getMilkProductionChartApi();
    if (response.status == 200) {
      emit(state.copyWith(
          status: LandingPageStatus.success,
          milkProductionChartResponse: response));
      // disposeProgress();
    } else {
      emit(state.copyWith(status: LandingPageStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  Future<void> inviteExpertDetails(context, String name,
      String mobile, String address, String comment, String lat, String long, String district, String supplierId) async {
    customDialog(widget: launchProgress());
    var response = await apiRepository.inviteExpertDetails(name, mobile, address, comment, lat, long, district, supplierId);

    disposeProgress();

    if (response.status == 200) {
      ThankYou(expert: response).navigate(isInfinity: true);

    } else {
      emit(state.copyWith(status: LandingPageStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  Future<void> getFollowUpDetails(context, bool isOnScreen) async {
    if(!isOnScreen){
      emit(state.copyWith(status: LandingPageStatus.loading));
    }
    var response = await apiRepository.followupRemarkListApi(int.parse(state.guestDashboardResponse!.data!.enquiry!.id!.toString()));

    if (response.status == 200) {

      emit(state.copyWith(status: LandingPageStatus.success, followupRemarkListResponse: response));
    } else {
      emit(state.copyWith(status: LandingPageStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  Future<void> addFollowUpRemark(context, isDDE, String comment,{String? enquiryId,String? type}) async {
    var response = await apiRepository.addFollowupRemarkApi(enquiryId==null?state.guestDashboardResponse!.data!.enquiry!.id!.toString():enquiryId.toString(),
        comment, isDDE,type.toString());

    if (response.status == 200) {
      if(isDDE){
        await BlocProvider.of<DdeEnquiryCubit>(context).enquiryDetailApi(context, enquiryId.toString());
      }else{
        await getFollowUpDetails(context, true);
      }
    } else {
      emit(state.copyWith(status: LandingPageStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  Future<void> getGuestDashboard(context) async {
    emit(state.copyWith(status: LandingPageStatus.loading));
    // customDialog(widget: launchProgress());
    var response = await apiRepository.getGuestDashboardApi(state.currentPosition!.latitude, state.currentPosition!.longitude);
    if (response.status == 200) {
      emit(state.copyWith(
          status: LandingPageStatus.success, guestDashboardResponse: response));
      // disposeProgress();
    } else {
      emit(state.copyWith(status: LandingPageStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // ddeDashboardApi
  Future<void> ddeDashboardApi(context) async {
    emit(state.copyWith(status: LandingPageStatus.loading));
    var response = await apiRepository.ddeDashboardApi();
    if (response.status == 200) {
      emit(state.copyWith(status: LandingPageStatus.success,responseDdeDashboard: response));
    } else {
      emit(state.copyWith(status: LandingPageStatus.error));
      showCustomToast(context, response.message.toString(),);
    }
  }

  Future<void> getCurrentLocation() async{
    await Permission.location.request();
    Position position = await apiRepository.getCurrentPosition();
    emit(state.copyWith(currentPosition: position));
  }

  // Future<GeocoderResponse> getAddressFromLatLngDescription(latitude,longitude) async{
  //   var response = await GoogleGeocoderKrutus.reverseGeoCode(apiKey: AppConstants.gMapsApiKey,
  //       coordinates: Coordinates(latitude: latitude, longitude: longitude));
  //
  //   print(response!.locality.toString());
  //   return response;
  // }

}
