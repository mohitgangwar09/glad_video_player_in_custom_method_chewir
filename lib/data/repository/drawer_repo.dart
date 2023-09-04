import 'dart:io';
import 'package:dio/dio.dart';
import 'package:glad/data/model/response_testimonial_model.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:glad/data/network/api_hitter.dart' as api_hitter;

class DrawerRepository {
  final SharedPreferences? sharedPreferences;

  DrawerRepository({this.sharedPreferences});

  ///////////////// addTestimonialApi //////////
  Future<ResponseTestimonial> addTestimonialApi(File file, String fileType, String description) async {

    FormData formData = FormData.fromMap({
      "type": fileType,
      "attachment": await MultipartFile.fromFile(file.path),
      "description": description,
    });

    print(formData.fields);

    api_hitter.ApiResponse apiResponse = await api_hitter.ApiHitter()
        .getPostApiResponse(AppConstants.addTestimonialApi,
        data: formData, headers: {'Authorization': 'Bearer ${getUserToken()}'});

    if (apiResponse.status) {
      return ResponseTestimonial.fromJson(apiResponse.response!.data);
    } else {
      return ResponseTestimonial(
          status: 422,
          message: apiResponse.msg);
    }
  }

  getUserToken() {
    return sharedPreferences?.getString(AppConstants.token);
  }
}
