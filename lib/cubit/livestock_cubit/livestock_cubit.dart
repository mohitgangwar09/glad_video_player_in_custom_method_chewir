import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/data/model/response_breed.dart';
import 'package:glad/data/model/training_and_news_category_model.dart';
import 'package:glad/data/model/training_detail_model.dart';
import 'package:glad/data/model/training_list_model.dart';
import 'package:glad/data/model/youtube_video_statistics_model.dart';
import 'package:glad/data/repository/others_repo.dart';
import 'package:glad/utils/extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'livestock_cubit_state.dart';

class LivestockCubit extends Cubit<LivestockCubitState>{

  final OthersRepository apiRepository;
  final SharedPreferences sharedPreferences;

  LivestockCubit({required this.apiRepository,required this.sharedPreferences}) : super(LivestockCubitState.initial());

  // trainingListApi
  Future<void> livestockBreedApi(context) async{
    var response = await apiRepository.getLivestockBreedApi();
    if (response.status == 200) {
      emit(state.copyWith(status: LivestockStatus.success, breed: response));
    }
    else {
      emit(state.copyWith(status: LivestockStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }


  String getUserToken() {
    return apiRepository.getUserToken();}

}