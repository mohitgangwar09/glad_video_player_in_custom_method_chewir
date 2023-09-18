import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/data/model/farmer_dashboard_model.dart' as dashboard;
import 'package:glad/data/model/milk_production_chart.dart';
import 'package:glad/data/repository/landing_page_repo.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/farmer_screen/thankyou_screen.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
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
      String mobile, String address, String comment, String lat, String long) async {
    customDialog(widget: launchProgress());
    var response = await apiRepository.inviteExpertDetails(name, mobile, address, comment, lat, long);

    disposeProgress();

    if (response.status == 200) {
      const ThankYou().navigate();

    } else {
      emit(state.copyWith(status: LandingPageStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  Future<void> getFollowUpDetails(context, String name,
      String mobile, String address, String comment, String lat, String long) async {
    customDialog(widget: launchProgress());
    var response = await apiRepository.inviteExpertDetails(name, mobile, address, comment, lat, long);

    disposeProgress();

    if (response.status == 200) {
      const ThankYou().navigate();

    } else {
      emit(state.copyWith(status: LandingPageStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }
}
