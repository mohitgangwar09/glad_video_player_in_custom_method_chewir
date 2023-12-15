import 'dart:io';
import 'package:dio/dio.dart';
import 'package:glad/data/model/respone_weather.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:glad/data/network/api_hitter.dart' as api_hitter;

class WeatherRepository {
  final SharedPreferences? sharedPreferences;

  WeatherRepository({this.sharedPreferences});

  ///////////////// getFarmerProjectsApi //////////
  Future<ResponseWeather> weatherApi(double lat,double lon) async {

    String units = 'metric';
    String cnt = '4';

    var data = {
      'lat': lat,
      'lon': lon,
      'cnt': cnt,
      'appid': AppConstants.weatherKey,
      'units': units,
    };

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getApiResponse(AppConstants.weatherApi,
        headers: {'Authorization': 'Bearer ${getUserToken()}'}, queryParameters: data);

    if (apiResponse.status) {
      return ResponseWeather.fromJson(apiResponse.response!.data);
    } else {
      return ResponseWeather(lat: 0,lon: 0);
    }
  }

  getUserToken() {
    return sharedPreferences?.getString(AppConstants.token);
  }
}
