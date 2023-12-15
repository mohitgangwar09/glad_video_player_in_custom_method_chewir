import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/data/model/respone_weather.dart';
import 'package:glad/data/repository/weather_repo.dart';
import 'package:glad/utils/extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState>{

  final WeatherRepository apiRepository;
  final SharedPreferences sharedPreferences;

  WeatherCubit({required this.apiRepository,required this.sharedPreferences}) : super(WeatherState.initial());

  // weatherApi
  Future<void> weatherApi(context,double lat,double lng) async{

    var response = await apiRepository.weatherApi(lat,lng);

    print(response);
    emit(state.copyWith(responseWeather: response));

    /*if (response.s == 200) {
      emit(state.copyWith(status: TrainingStatus.success, responseTrainingList: response));
    }
    else {
      emit(state.copyWith(status: TrainingStatus.error));
      showCustomToast(context, response.message.toString());
    }*/
  }


}