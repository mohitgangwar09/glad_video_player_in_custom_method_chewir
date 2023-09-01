import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/data/model/farmer_dashboard_model.dart';
import 'package:glad/data/repository/landing_page_repo.dart';
import 'package:glad/utils/extension.dart';
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
    var response = await apiRepository.getFarmerDashboardApi();
    if (response.status == 200) {
      emit(state.copyWith(
          status: LandingPageStatus.success, response: response.data));
    } else {
      emit(state.copyWith(status: LandingPageStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }
}
