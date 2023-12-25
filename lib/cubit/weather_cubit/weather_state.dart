part of 'weather_cubit.dart';


enum WeatherStatus{initial,submit,success,error}

class WeatherState extends Equatable{
  final WeatherStatus status;
  final ResponseWeather? responseWeather;
  final GoogleGeocodingResponse? responseAddress;

  const WeatherState({
    required this.status,
    this.responseWeather,
    this.responseAddress
  });

  factory WeatherState.initial() {
    return const WeatherState(
      status: WeatherStatus.initial,
      responseWeather: null,
      responseAddress: null,
    );
  }

  WeatherState copyWith({
    WeatherStatus? status,
    ResponseWeather? responseWeather,
    GoogleGeocodingResponse? responseAddress,
  }) {
    return WeatherState(
      status: status ?? this.status,
      responseWeather: responseWeather?? this.responseWeather,
      responseAddress: responseAddress ?? this.responseAddress,
    );
  }

  @override
  List<Object?> get props => [
    status,
    responseWeather
  ];

}