import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:glad/cubit/auth_cubit/auth_cubit.dart';
import 'package:glad/cubit/cowsandyieldsum/cowsandyieldcubit.dart';
import 'package:glad/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:glad/cubit/drawer_cubit/drawer_cubit.dart';
import 'package:glad/cubit/dde_Farmer_cubit/dde_farmer_cubit.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/data/repository/drawer_repo.dart';
import 'package:glad/data/repository/landing_page_repo.dart';
import 'package:glad/data/repository/dde_repo.dart';
import 'package:glad/data/repository/profile_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cubit/dde_enquiry_cubit/dde_enquiry_cubit.dart';
import 'data/repository/auth_repo.dart';


final sl = GetIt.instance;

Future<void> init() async {

 // sl.registerLazySingleton(() => DioClient(AppConstants.baseUrl.toString(), sl(), loggingInterceptor: sl(), sharedPreferences: sl()));

  ///////////////////repo////////////////////
  sl.registerLazySingleton(() => AuthRepository(sharedPreferences: sl()));
  sl.registerLazySingleton(() => ProfileRepository(sharedPreferences: sl()));
  sl.registerLazySingleton(() => DdeRepository(sharedPreferences: sl()));
  sl.registerLazySingleton(() => LandingPageRepository(sharedPreferences: sl()));
  sl.registerLazySingleton(() => DrawerRepository(sharedPreferences: sl()));

  ////////////////////bloc_provider///////////////
  sl.registerFactory(() => AuthCubit(apiRepository: sl(),sharedPreferences: sl()));
  sl.registerFactory(() => ProfileCubit(apiRepository: sl(),sharedPreferences: sl()));
  sl.registerFactory(() => DashboardCubit());
  sl.registerFactory(() => DdeFarmerCubit(apiRepository: sl(),sharedPreferences: sl()));
  sl.registerFactory(() => CowsAndYieldCubit(apiRepository: sl(),sharedPreferences: sl()));
  sl.registerFactory(() => LandingPageCubit(apiRepository: sl(),sharedPreferences: sl()));
  sl.registerFactory(() => DrawerCubit(apiRepository: sl(),sharedPreferences: sl()));
  sl.registerFactory(() => DdeEnquiryCubit(apiRepository: sl(),sharedPreferences: sl()));

  // External
  var sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => Dio());

}