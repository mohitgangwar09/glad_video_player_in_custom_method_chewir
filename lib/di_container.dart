import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:glad/cubit/auth_cubit/auth_cubit.dart';
import 'package:glad/cubit/community_cubit/community_cubit.dart';
import 'package:glad/cubit/cowsandyieldDoneCubit/cowsandyielddonecubit.dart';
import 'package:glad/cubit/cowsandyieldsum/cowsandyieldcubit.dart';
import 'package:glad/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:glad/cubit/drawer_cubit/drawer_cubit.dart';
import 'package:glad/cubit/dde_farmer_cubit/dde_farmer_cubit.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/livestock_cubit/livestock_cubit.dart';
import 'package:glad/cubit/news_cubit/news_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/cubit/training_cubit/training_cubit.dart';
import 'package:glad/data/repository/drawer_repo.dart';
import 'package:glad/data/repository/landing_page_repo.dart';
import 'package:glad/data/repository/dde_repo.dart';
import 'package:glad/data/repository/others_repo.dart';
import 'package:glad/data/repository/profile_repo.dart';
import 'package:glad/data/repository/project_repo.dart';
import 'package:glad/screen/extra_screen/test_cubit_yield.dart';
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
  sl.registerLazySingleton(() => ProjectRepository(sharedPreferences: sl()));
  sl.registerLazySingleton(() => OthersRepository(sharedPreferences: sl()));

  ////////////////////bloc_provider///////////////
  sl.registerFactory(() => AuthCubit(apiRepository: sl(),sharedPreferences: sl()));
  sl.registerFactory(() => ProfileCubit(apiRepository: sl(),sharedPreferences: sl()));
  sl.registerFactory(() => DashboardCubit());
  sl.registerFactory(() => DdeFarmerCubit(apiRepository: sl(),sharedPreferences: sl()));
  sl.registerFactory(() => CowsAndYieldCubit(apiRepository: sl(),sharedPreferences: sl()));
  sl.registerFactory(() => CowsAndYieldDoneCubit(apiRepository: sl(),sharedPreferences: sl()));
  sl.registerFactory(() => LandingPageCubit(apiRepository: sl(),sharedPreferences: sl()));
  sl.registerFactory(() => DrawerCubit(apiRepository: sl(),sharedPreferences: sl()));
  sl.registerFactory(() => DdeEnquiryCubit(apiRepository: sl(),sharedPreferences: sl()));
  // sl.registerFactory(() => ImprovementAreaCubit(apiRepository: sl(),sharedPreferences: sl()));
  sl.registerFactory(() => ProjectCubit(apiRepository: sl(),sharedPreferences: sl()));
  sl.registerFactory(() => CowsAndYieldCubitTest(apiRepository: sl(),sharedPreferences: sl()));
  sl.registerFactory(() => TrainingCubit(apiRepository: sl(),sharedPreferences: sl()));
  sl.registerFactory(() => NewsCubit(apiRepository: sl(),sharedPreferences: sl()));
  sl.registerFactory(() => CommunityCubit(apiRepository: sl(),sharedPreferences: sl()));
  sl.registerFactory(() => LivestockCubit(apiRepository: sl(),sharedPreferences: sl()));


  // External
  var sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => Dio());

}