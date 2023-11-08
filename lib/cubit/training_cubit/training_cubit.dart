import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/data/model/training_and_news_category_model.dart';
import 'package:glad/data/model/training_detail_model.dart';
import 'package:glad/data/model/training_list_model.dart';
import 'package:glad/data/model/youtube_video_statistics_model.dart';
import 'package:glad/data/repository/others_repo.dart';
import 'package:glad/utils/extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'training_cubit_state.dart';

class TrainingCubit extends Cubit<TrainingCubitState>{

  final OthersRepository apiRepository;
  final SharedPreferences sharedPreferences;

  TrainingCubit({required this.apiRepository,required this.sharedPreferences}) : super(TrainingCubitState.initial());

  // trainingListApi
  Future<void> trainingListApi(context,String categoryId) async{
    var response = await apiRepository.getTrainingListApi(categoryId);
    if (response.status == 200) {
      emit(state.copyWith(status: TrainingStatus.success, responseTrainingList: response));
    }
    else {
      emit(state.copyWith(status: TrainingStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // resendProjectStatusApiApi
  Future<void> trainingDetailApi(context,String trainingId) async{
    emit(state.copyWith(status: TrainingStatus.submit));
    var response = await apiRepository.getTrainingDetailApi(trainingId);
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
      emit(state.copyWith(responseTrainingCategories: response));
      trainingListApi(context, '');
    }
    else {
      emit(state.copyWith(status: TrainingStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  Future<void> getVideoStatistics(context, String videoId) async{
    // emit(state.copyWith(status: TrainingStatus.submit));
    var response = await apiRepository.getVideoStatisticsApi(videoId);
    if (response!= null) {
      emit(state.copyWith(responseVideoStatistics: response));
    }
    else {
      // emit(state.copyWith(status: TrainingStatus.error));
      showCustomToast(context, 'Error getting statistics');
    }
  }

  String getUserToken() {
    return apiRepository.getUserToken();}

}