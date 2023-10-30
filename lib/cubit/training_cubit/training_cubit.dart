import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/data/model/training_category_model.dart';
import 'package:glad/data/model/training_detail_model.dart';
import 'package:glad/data/model/training_list_model.dart';
import 'package:glad/data/repository/others_repo.dart';
import 'package:glad/utils/extension.dart';
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
    var response = await apiRepository.getTrainingDetailApi(categoryId);
    if (response.status == 200) {
      emit(state.copyWith(status: TrainingStatus.success, responseTrainingDetail: response));
    }
    else {
      emit(state.copyWith(status: TrainingStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // resendProjectStatusApiApi
  Future<void> trainingCategoriesApi(context) async{
    emit(state.copyWith(status: TrainingStatus.submit));
    var response = await apiRepository.getTrainingCategoryApi();
    if (response.status == 200) {
      emit(state.copyWith(status: TrainingStatus.success, responseTrainingCategories: response));
    }
    else {
      emit(state.copyWith(status: TrainingStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  String getUserToken() {
    return apiRepository.getUserToken();}

}