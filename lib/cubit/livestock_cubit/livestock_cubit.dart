import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/data/model/livestock_detail.dart';
import 'package:glad/data/model/livestock_list_model.dart';
import 'package:glad/data/model/response_breed.dart';
import 'package:glad/data/model/training_and_news_category_model.dart';
import 'package:glad/data/model/training_detail_model.dart';
import 'package:glad/data/model/training_list_model.dart';
import 'package:glad/data/model/youtube_video_statistics_model.dart';
import 'package:glad/data/repository/others_repo.dart';
import 'package:glad/screen/common/thankyou_livestock.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
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

  // trainingListApi
  Future<void> livestockListApi(context) async{
    emit(state.copyWith(status: LivestockStatus.submit));
    var response = await apiRepository.getLivestockListApi();
    if (response.status == 200) {
      emit(state.copyWith(status: LivestockStatus.success, responseLivestockList: response));
    }
    else {
      emit(state.copyWith(status: LivestockStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // trainingListApi
  Future<void> myLivestockListApi(context) async{
    emit(state.copyWith(status: LivestockStatus.submit));
    var response = await apiRepository.getMyLivestockListApi();
    if (response.status == 200) {
      emit(state.copyWith(status: LivestockStatus.success, responseMyLivestockList: response));
    }
    else {
      emit(state.copyWith(status: LivestockStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  // trainingListApi
  Future<void> livestockDetailApi(context, String id) async{
    emit(state.copyWith(status: LivestockStatus.submit));
    var response = await apiRepository.getLivestockDetailApi(id);
    if (response.status == 200) {
      emit(state.copyWith(status: LivestockStatus.success, responseLivestockDetail: response));
    }
    else {
      emit(state.copyWith(status: LivestockStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  Future<void> livestockAddApi(context, String breedId, List<String> paths, String milk, String lactation, String price, String pregnant, String cowQty, String age, String description) async{
    var response = await apiRepository.addLivestockApi(breedId, paths, milk, lactation, price, pregnant, cowQty, age, description);
    if (response.status == 200) {
      showCustomToast(context, response.message.toString(), isSuccess: true);
      print('desc : ${response.data!.description}');
      ThankYouLivestock(response: response).navigate();
    }
    else {
      emit(state.copyWith(status: LivestockStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  Future<void> livestockUpdateApi(context, String id, String breedId, List<String> paths, String milk, String lactation, String price, String pregnant, String cowQty, String age, String description) async{
    customDialog(widget: launchProgress());
    var response = await apiRepository.updateLivestockApi(id, breedId, paths, milk, lactation, price, pregnant, cowQty, age, description);
    if (response.status == 200) {
      showCustomToast(context, response.message.toString(), isSuccess: true);
      livestockDetailApi(context, id);
      myLivestockListApi(context);
      disposeProgress();
      pressBack();
    }
    else {
      disposeProgress();
      emit(state.copyWith(status: LivestockStatus.error));
      showCustomToast(context, response.message.toString());
    }
  }

  Future<void> livestockDeleteMediaApi(context, String id, String livestockId) async{
    var response = await apiRepository.deleteMediaApi(id);
    if (response.status == 200) {
      showCustomToast(context, response.message.toString(), isSuccess: true);
      livestockDetailApi(context, livestockId);
      myLivestockListApi(context);
    }
    else {
      showCustomToast(context, response.message.toString());
    }
  }


  String getUserToken() {
    return apiRepository.getUserToken();}

}