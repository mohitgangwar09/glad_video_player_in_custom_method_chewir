part of 'weather_cubit.dart';


enum WeatherStatus{initial,submit,success,error}

class WeatherState extends Equatable{
  final WeatherStatus status;
  final ResponseWeather? responseWeather;

  const WeatherState({
    required this.status,
    this.responseWeather
  });

  factory WeatherState.initial() {
    return const WeatherState(
      status: WeatherStatus.initial,
      responseWeather: null
    );
  }

  WeatherState copyWith({
    WeatherStatus? status,
    ResponseWeather? responseWeather,
  }) {
    return WeatherState(
      status: status ?? this.status,
      responseWeather: responseWeather?? this.responseWeather
    );
  }

  @override
  List<Object?> get props => [
    status,
    responseWeather
  ];

}