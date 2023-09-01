import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/data/model/farmer_dashboard_model.dart';
import 'package:glad/data/repository/farmer_repo.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'farmer_state.dart';

class FarmerCubit extends Cubit<FarmerState>{

  final SharedPreferences sharedPreferences;
  final FarmerRepository apiRepository;

  FarmerCubit({required this.apiRepository,required this.sharedPreferences}) : super(FarmerState.initial());

  void getFarmerDashboard(context) async{
    emit(state.copyWith(status: FarmerStatus.loading));
    var response = await apiRepository.getFarmerDashboardApi();
    if(response.status == 200){

      emit(state.copyWith(status: FarmerStatus.success, response: response.data));
    }
    else{
      emit(state.copyWith(status: FarmerStatus.error));
      showCustomToast(context, response.message.toString());
    }
    emit(state.copyWith(status: FarmerStatus.success));
  }

}