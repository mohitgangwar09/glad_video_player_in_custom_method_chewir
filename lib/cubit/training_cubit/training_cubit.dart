import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/data/model/auth_models/response_otp_model.dart';
import 'package:glad/data/model/training_category_model.dart';
import 'package:glad/data/model/training_detail_model.dart';
import 'package:glad/data/model/training_list_model.dart';
import 'package:glad/data/repository/others_repo.dart';
import 'package:glad/screen/auth_screen/create_password.dart';
import 'package:glad/screen/auth_screen/login_with_password.dart';
import 'package:glad/screen/auth_screen/otp.dart';
import 'package:glad/screen/auth_screen/upload_profile_picture.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/dashboard/dashboard_dde.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/screen/guest_user/dashboard/dashboard_guest.dart';
import 'package:glad/screen/mcc_screen/dashboard/dashboard_mcc.dart';
import 'package:glad/screen/supplier_screen/dashboard/dashboard_supplier.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'training_cubit_state.dart';

class TrainingCubit extends Cubit<TrainingCubitState>{

  final OthersRepository apiRepository;
  final SharedPreferences sharedPreferences;

  TrainingCubit({required this.apiRepository,required this.sharedPreferences}) : super(TrainingCubitState.initial());

  // trainingListApi
  Future<void> trainingListApi(context,String categoryName) async{
    emit(state.copyWith(status: TrainingStatus.submit));
    var response = await apiRepository.getTrainingListApi(categoryName);
    if (response.status == 200) {
      emit(state.copyWith(status: TrainingStatus.success, responseTrainingList: response));
    }
    else {
      emit(state.copyWith(status: TrainingStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // resendProjectStatusApiApi
  Future<void> trainingDetailApi(context,String categoryId) async{
    emit(state.copyWith(status: TrainingStatus.submit));
    var response = await apiRepository.getTrainingListApi(categoryName);
    if (response.status == 200) {
      emit(state.copyWith(status: TrainingStatus.success, responseTrainingList: response));
    }
    else {
      emit(state.copyWith(status: TrainingStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // resendProjectStatusApiApi
  Future<void> trainingListApi(context,String categoryName) async{
    emit(state.copyWith(status: TrainingStatus.submit));
    var response = await apiRepository.getTrainingListApi(categoryName);
    if (response.status == 200) {
      emit(state.copyWith(status: TrainingStatus.success, responseTrainingList: response));
    }
    else {
      emit(state.copyWith(status: TrainingStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  String getUserToken() {
    return apiRepository.getUserToken();}

}