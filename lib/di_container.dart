import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:glad/cubit/auth_cubit/auth_cubit.dart';
import 'package:glad/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/data/repository/profile_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/repository/auth_repo.dart';


final sl = GetIt.instance;

Future<void> init() async {

 // sl.registerLazySingleton(() => DioClient(AppConstants.baseUrl.toString(), sl(), loggingInterceptor: sl(), sharedPreferences: sl()));

  ///////////////////repo////////////////////
  sl.registerLazySingleton(() => AuthRepository(sharedPreferences: sl()));
  sl.registerLazySingleton(() => ProfileRepository(sharedPreferences: sl()));

  ////////////////////bloc_provider///////////////
  sl.registerFactory(() => AuthCubit(apiRepository: sl(),sharedPreferences: sl()));
  sl.registerFactory(() => ProfileCubit(apiRepository: sl(),sharedPreferences: sl()));
  sl.registerFactory(() => DashboardCubit());

  // External
  var sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => Dio());

}