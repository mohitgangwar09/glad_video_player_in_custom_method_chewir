import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/data/model/news_list_model.dart';
import 'package:glad/data/model/training_and_news_category_model.dart';
import 'package:glad/data/repository/others_repo.dart';
import 'package:glad/utils/extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'news_cubit_state.dart';

class NewsCubit extends Cubit<NewsCubitState>{

  final OthersRepository apiRepository;
  final SharedPreferences sharedPreferences;

  NewsCubit({required this.apiRepository,required this.sharedPreferences}) : super(NewsCubitState.initial());

  // newsListApi
  Future<void> newsListApi(context,String categoryId) async{
    var response = await apiRepository.getNewsListApi(categoryId);
    if (response.status == 200) {
      emit(state.copyWith(status: NewsStatus.success, responseNewsList: response));
    }
    else {
      emit(state.copyWith(status: NewsStatus.error));
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  // resendProjectStatusApiApi
  Future<void> newsCategoriesApi(context) async{
    emit(state.copyWith(status: NewsStatus.submit));
    var response = await apiRepository.getNewsCategoryApi();
    if (response.status == 200) {
      emit(state.copyWith(responseNewsCategories: response));
      newsListApi(context, '');
    }
    else {
      emit(state.copyWith(status: NewsStatus.error));
      if(response.message!=null){
        showCustomToast(context, response.message.toString());
      }
      // showCustomToast(context, response.message.toString());
    }
  }

  String getUserToken() {
    return apiRepository.getUserToken();}

}