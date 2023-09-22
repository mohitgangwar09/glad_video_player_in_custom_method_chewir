import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:glad/cubit/auth_cubit/auth_cubit.dart';
import 'package:glad/cubit/cowsandyieldsum/cowsandyieldcubit.dart';
import 'package:glad/cubit/dashboard_cubit/dashboard_cubit.dart';
import 'package:glad/cubit/dde_enquiry_cubit/dde_enquiry_cubit.dart';
import 'package:glad/cubit/drawer_cubit/drawer_cubit.dart';
import 'package:glad/cubit/dde_farmer_cubit/dde_farmer_cubit.dart';
import 'package:glad/cubit/improvement_area_cubit/improvement_area_cubit.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/screen/auth_screen/splash_screen.dart';
import 'package:glad/screen/dde_screen/cows_and_yield.dart';
import 'package:glad/screen/extra_screen/add_item_list.dart';
import 'package:glad/screen/extra_screen/cowsandyieldsum.dart';
import 'package:glad/screen/extra_screen/profile_navigate.dart';
import 'package:glad/screen/extra_screen/test_cows_and_yield.dart';
import 'package:glad/screen/extra_screen/test_cubit_yield.dart';
import 'package:glad/utils/extension.dart';
import 'di_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => di.sl<AuthCubit>()),
      BlocProvider(create: (context) => di.sl<ProfileCubit>()),
      BlocProvider(create: (context) => di.sl<DashboardCubit>()),
      BlocProvider(create: (context) => di.sl<LandingPageCubit>()),
      BlocProvider(create: (context) => di.sl<DrawerCubit>()),
      BlocProvider(create: (context) => di.sl<DdeFarmerCubit>()),
      BlocProvider(create: (context) => di.sl<CowsAndYieldCubit>()),
      BlocProvider(create: (context) => di.sl<DdeEnquiryCubit>()),
      BlocProvider(create: (context) => di.sl<ImprovementAreaCubit>()),
      BlocProvider(create: (context) => di.sl<CowsAndYieldCubitTest>()),
    ],
    child: const GetMaterialApp(
        debugShowCheckedModeBanner: false, home: MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    // return const TestCowAndYield();
    // return const CowsAndYieldsSum();
    // return const CowsAndYieldsDDEFarmer();
    return const SplashScreen();
  }
}