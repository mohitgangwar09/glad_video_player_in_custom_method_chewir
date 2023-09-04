import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/data/repository/dde_repo.dart';
import 'package:glad/utils/extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/farmers_list.dart';
part 'dde_farmer_state.dart';

class DdeFarmerCubit extends Cubit<DdeState>{

  final SharedPreferences sharedPreferences;
  final DdeRepository apiRepository;

  DdeFarmerCubit({required this.apiRepository,required this.sharedPreferences}):super(DdeState.initial());

  void getFarmer(context) async{
    emit(state.copyWith(status: DdeFarmerStatus.loading));
    var response = await apiRepository.getFarmersList();
    if(response.status == 200){
      emit(state.copyWith(status: DdeFarmerStatus.success, response: response.data));
    }
    else{
      emit(state.copyWith(status: DdeFarmerStatus.error));
      showCustomToast(context, response.message.toString());
    }
    emit(state.copyWith(status: DdeFarmerStatus.success));
  }
}