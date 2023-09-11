import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/data/model/response_cow_breed_details.dart';
import 'package:glad/data/repository/dde_repo.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/farmers_list.dart';
part 'dde_farmer_state.dart';

class DdeFarmerCubit extends Cubit<DdeState>{

  final SharedPreferences sharedPreferences;
  final DdeRepository apiRepository;

  DdeFarmerCubit({required this.apiRepository,required this.sharedPreferences}):super(DdeState.initial());

  void getFarmer(context) async{
    customDialog(widget: launchProgress());
    emit(state.copyWith(status: DdeFarmerStatus.loading));
    var response = await apiRepository.getFarmersList();
    if(response.status == 200){
      disposeProgress();
      emit(state.copyWith(status: DdeFarmerStatus.success, response: response.data));
    }
    else{
      emit(state.copyWith(status: DdeFarmerStatus.error));
      showCustomToast(context, response.message.toString());
    }
    emit(state.copyWith(status: DdeFarmerStatus.success));
  }

  // getCowBreedDetailsApi
  void getCowBreedDetailsApi(context) async{
    customDialog(widget: launchProgress());
    emit(state.copyWith(status: DdeFarmerStatus.loading));
    var response = await apiRepository.cowBreedDetailsApi();
    if(response.status == 200){
      disposeProgress();
      emit(state.copyWith(status: DdeFarmerStatus.success, responseMonthlyWiseData: response.data!.monthWiseData!));
    }
    else{
      emit(state.copyWith(status: DdeFarmerStatus.error));
      showCustomToast(context, response.message.toString());
    }
    emit(state.copyWith(status: DdeFarmerStatus.success));
  }

}