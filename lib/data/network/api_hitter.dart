import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/helper.dart';
import 'package:talker_dio_logger/talker_dio_logger_interceptor.dart';
import 'package:talker_dio_logger/talker_dio_logger_settings.dart';

class ApiHitter {
  Dio? dio;
  static final ApiHitter singleton = ApiHitter._internal();
  factory ApiHitter() => singleton;

  ApiHitter._internal() {
    dio=getDio();
    (dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    dio?.interceptors.add(
      TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
          printResponseHeaders: true,
        ),
      ),
    );
  }
  Dio getDio({String baseurl = ''}) {
    if (dio == null) {
      BaseOptions options =   BaseOptions(
        baseUrl: baseurl.isEmpty ?AppConstants.baseUrl : baseurl,
        connectTimeout:const Duration(minutes: 2) ,
        receiveTimeout: const Duration(minutes: 2),
        sendTimeout: const Duration(minutes: 2)
      );
      return   Dio(options)
        ..interceptors.add(InterceptorsWrapper(
            onRequest:(options, handler){
              if (kDebugMode) {
                //    GbLogger.log(options.queryParameters);
                //print('options::::$options');
              }
              return handler.next(options); //continue
            },
            onResponse:(response,handler) async {

              if (kDebugMode) {
                // GbLogger.log(response.data);
                //      debugPrint('response::::$response',wrapWidth: 100000);
              }
              return handler.next(response); // continue
            },
            onError: (DioException e, handler) async {
              if (kDebugMode) {
                //   GbLogger.log(e.response);
                //   debugPrint('error response::::${e.response}');
                //  debugPrint('error message::::${e.message}');
              }

              return handler.next(e);

            }
        ));



    } else {
      return dio!;
    }
  }

  Future<ApiResponse> getPostApiResponse(
      String endPoint,
      {
        Map<String, dynamic>? headers,
        dynamic  data,
        String baseurl = '',
      }) async {

    bool value = await checkInternetConnection();
    if (value) {
      try {

        var response = await getDio(
          baseurl: baseurl,
        ).post(endPoint,
            options: Options(
              headers: headers,
              contentType: 'application/json',
              //  contentType: 'text/xml; charset=utf-8',
            ),
            data: data);
        return apiData(response);
      } on DioException catch (error) {
        return exception(error,  );
      }
    }
    else {
      return ApiResponse(false,msg: 'Check your internet connection and Please try again later.');
    }
  }

  Future<ApiResponse> getPutApiResponse(
      String endPoint,
      {
        Map<String, dynamic>? headers,
        dynamic data,
        String baseurl = '',
      }) async {

    bool value = await checkInternetConnection();
    if (value) {
      try {
        var response = await getDio(

          baseurl: baseurl,
        ).put(endPoint,
            options: Options(
              headers: headers,
              contentType: 'application/json',
            ),
            data: data);
        return apiData(response);
      } on DioException catch (error) {
        return exception(error,  );
      }
    } else {
      return ApiResponse(
        false,
        msg: 'Check your internet connection and Please try again later.',
      );
    }
  }

  Future<ApiResponse> getApiResponse(
      String endPoint,
      {
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
        String baseurl = '',
      }) async {

    bool value = await checkInternetConnection();
    if (value) {
      try {
        var response = await getDio(
          baseurl: baseurl,
        ).get(
          endPoint,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
            contentType: 'application/json',
          ),
        );
        return apiData(response);
      } on DioException catch (error) {
        return exception(error, );
      }
    } else {
      debugPrint('not connected ');

      return ApiResponse(false, msg: 'Check your internet connection and Please try again later.',response: null);
    }
  }

  deleteApiResponse(
      String endPoint,
      {
        Map<String, dynamic>? headers,
        Map<String, dynamic>? data,
        String baseurl = '',
      }) async {

    bool value = await checkInternetConnection();
    if (value) {
      try {
        var response = await getDio(
          baseurl: baseurl,
        ).delete(

          endPoint,
          data: data,
          options: Options(
            headers: headers,
            contentType: 'application/json',
          ),
        );
        return    apiData(response);
      } on DioException   catch (error) {
        return exception(error,  );
      }
    } else {
      return ApiResponse(false,msg: 'Check your internet connection and Please try again later.');
    }
  }



  Future<ApiResponse> getFormApiResponse(String endPoint,  {
    FormData? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters}) async {

    bool value = await checkInternetConnection();
    if (value) {
      try {
        var response = await getDio(
        ).post(endPoint,
            data: data,
            queryParameters: queryParameters,
            options: Options(
              headers: headers,
            ));
        return apiData(response);
      } on DioException catch (e) {
        return exception(e);
      }
    }
    else {
      return ApiResponse(false,msg: 'Check your internet connection and Please try again later.');
    }
  }

  ApiResponse exception(DioException e ) {
    if (e.response != null) {
      return ApiResponse(false, msg:e.response?.data['message'] ?? e.message,response:e.response);

    } else {
      return ApiResponse(false, msg: e.message??'Something went wrong',response: e.response);
    }

    // return ApiResponse(false, msg: NetworkExceptions.getErrorMessage(NetworkExceptions.getDioException(error)));
  }

  apiData(Response<dynamic> response) {
    return ApiResponse(response.statusCode == 200||response.statusCode == 201, response: response,
        msg: response.data['message']??'Success');
  }
}


class ApiResponse {
  final bool status;
  final String msg;
  final Response ?response;

  ApiResponse(this.status, {this.msg = 'Success',  this.response});
}
/*
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'  as route;
import 'package:glad/data/repository/auth_repo.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/helper.dart';
import 'network_exception.dart';

class ApiHitter {
  Dio? dio;
  // final SharedPreferences? sharedPreferences;
  static final ApiHitter singleton = ApiHitter._internal();
  factory ApiHitter() => singleton;


  ApiHitter._internal() {
    dio = getDio();
    (dio!.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      final client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }
  Dio getDio({String baseurl = ''}) {
    if (dio == null) {
      BaseOptions options = BaseOptions(
        baseUrl: baseurl.isEmpty ? AppConstants.baseUrl : baseurl,
        connectTimeout: const Duration(milliseconds: 30000),
        receiveTimeout: const Duration(milliseconds: 30000),
        sendTimeout: const Duration(milliseconds: 30000),
      );
      return Dio(options)
          ..interceptors.add(InterceptorsWrapper(
          onRequest:(options, handler){
            // Do something before request is sent
            return handler.next(options); //continue
            // If you want to resolve the request with some custom data，
            // you can resolve a `Response` object eg: return `dio.resolve(response)`.
            // If you want to reject the request with a error message,
            // you can reject a `DioError` object eg: return `dio.reject(dioError)`
          },
          onResponse:(response,handler) {
            // Do something with response data
            return handler.next(response); // continue
            // If you want to reject the request with a error message,
            // you can reject a `DioError` object eg: return `dio.reject(dioError)`
          },
          onError: (DioError e, handler) {
            // Do something with response error
            return  handler.next(e);//continue
            // If you want to resolve the request with some custom data，
            // you can resolve a `Response` object eg: return `dio.resolve(response)`.
          }
      ))
        // ..interceptors.add(RetryOnConnectionChangeInterceptor(dio: Dio(options)))
        // ..options.headers ={
        // 'Content-Type': 'application/json; charset=UTF-8',
        // 'Authorization': 'Bearer ${AuthRepository().getUserToken()}'}
        // ..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        //   return handler.next(options); //continue
        // }, onResponse: (response, handler) async {
        //   if (kDebugMode) {
        //     print('response::::$response');
        //   }
        //   return handler.next(response); // continue
        // }, onError: (DioException e, handler) async {
        //   if (kDebugMode) {
        //     debugPrint('error response::::${e.response}');
        //     debugPrint('error message::::${e.message}');
        //   }
        //
        //   return handler.next(e);
        // }))
      ;
    } else {
      return dio!;
        // ..interceptors.add(RetryOnConnectionChangeInterceptor(dio: dio!));
    }
  }

  Future<ApiResponse> getPostApiResponse(
    String endPoint, {
    Map<String, dynamic>? headers,
    dynamic data,
    String baseurl = '',
  }) async {
    bool value = await checkInternetConnection();
    if (value) {
      try {
        debugPrint('Post URL Request--------------- $endPoint $data ${route.Get.currentRoute}');
        var response = await getDio(
          baseurl: baseurl,
        ).post(endPoint,
            options: Options(
              headers: headers,
              contentType: 'application/json',
            ),
            data: data);
        debugPrint('Post URL Response---------------$endPoint ${response.data.toString()}');
        return ApiResponse(response.statusCode == 200,
            response: response, msg: response.statusMessage!);
      } on DioException catch (error) {
        return exception(
          error,
        );
      }
    } else {
      return ApiResponse(false,
          msg: 'Check your internet connection and Please try again later.');
    }
  }

  Future<ApiResponse> getPutApiResponse(
    String endPoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
    String baseurl = '',
  }) async {
    bool value = await checkInternetConnection();
    if (value) {
      try {
        debugPrint('Put URL Request--------------- $endPoint $data ${route.Get.currentRoute}');
        var response = await getDio(
          baseurl: baseurl,
        ).put(endPoint,
            options: Options(
              headers: headers,
              contentType: 'application/json',
            ),
            data: data);
        debugPrint('Put URL Response---------------$endPoint ${response.data.toString()}');
        return ApiResponse(response.statusCode == 200,
            response: response, msg: response.statusMessage!);
      } on DioException catch (error) {
        return exception(
          error,
        );
      }
    } else {
      return ApiResponse(
        false,
        msg: 'Check your internet connection and Please try again later.',
      );
    }
  }

  Future<ApiResponse> getApiResponse(
    String endPoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    String baseurl = '',
  }) async {
    bool value = await checkInternetConnection();
    if (value) {
      try {
        debugPrint('Get URL Request--------------- $endPoint ${route.Get.currentRoute} $queryParameters');
        var response = await getDio(
          baseurl: baseurl,
        ).get(
          endPoint,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
            contentType: 'application/json',
          ),
        );
        debugPrint('Get URL Response---------------$endPoint ${response.data.toString()}');
        return ApiResponse(response.statusCode == 200,
            response: response, msg: response.statusMessage!);
      } on DioException catch (error) {
        print(error.type.toString());
        return exception(
          error,
        );
      }
    } else {
      debugPrint('not connected ');

      return ApiResponse(false,
          msg: 'Check your internet connection and Please try again later.',
          response: null);
    }
  }

  Future<ApiResponse> deleteApiResponse(
    String endPoint, {
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
    String baseurl = '',
  }) async {
    bool value = await checkInternetConnection();
    if (value) {
      try {
        debugPrint('Delete URL Request--------------- $endPoint $data ${route.Get.currentRoute}');
        var response = await getDio(
          baseurl: baseurl,
        ).delete(
          endPoint,
          data: data,
          options: Options(
            headers: headers,
            contentType: 'application/json',
          ),
        );
        debugPrint('Delete URL Response---------------$endPoint ${response.data.toString()}');
        return ApiResponse(response.statusCode == 200,
            response: response, msg: response.statusMessage!);
      } on DioException catch (error) {
        return exception(
          error,
        );
      }
    } else {
      return ApiResponse(false,
          msg: 'Check your internet connection and Please try again later.');
    }
  }

  Future<ApiResponse> getFormApiResponse(String endPoint, BuildContext context,
      {FormData? data,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      var response = await getDio().post(endPoint,
          data: data,
          queryParameters: queryParameters,
          options: Options(
            headers: headers,
          ));
      return ApiResponse(response.statusCode == 200,
          response: response, msg: response.statusMessage!);
    } on DioException catch (e) {
      return exception(e);
    }
  }

  ApiResponse exception(DioException error) {
    debugPrint('URL Error Response---------------${error.requestOptions.baseUrl} ${error.requestOptions.path} ${error.response != null ? error.response!.data['message'].toString() : 'Network Error'}');
    debugPrint(error.toString());
    return ApiResponse(false,
        msg: error.response != null ? error.response!.data['message'].toString() : 'Network Error',
      statusCode: NetworkExceptions.getErrorMessage(
        NetworkExceptions.getDioException(error),
      )
    );
  }
}

class ApiResponse {
  final bool status;
  final String? statusCode;
  final String msg;
  final Response? response;

  ApiResponse(this.status ,{this.msg = 'Success', this.response, this.statusCode});
}*/
