import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/auth_cubit/auth_cubit.dart';
import 'package:glad/cubit/landing_page_cubit/landing_page_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/cubit/weather_cubit/weather_cubit.dart';
import 'package:glad/notification/fcm_helper.dart';
import 'package:glad/screen/auth_screen/introslider.dart';
import 'package:glad/screen/dde_screen/dashboard/dashboard_dde.dart';
import 'package:glad/screen/extra_screen/add_item_list.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/screen/mcc_screen/dashboard/dashboard_mcc.dart';
import 'package:glad/screen/supplier_screen/dashboard/dashboard_supplier.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/sharedprefrence.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'language_permission.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  void _route() async {
    await initPlatformState();
    if(!mounted)return;
    if(await SharedPrefManager.getPreferenceString(AppConstants.fcmToken)== ""){
      FcmHelper().initFirebase();
    }
    await BlocProvider.of<AuthCubit>(context).getLocation(context);
    if(!mounted)return;
    await BlocProvider.of<LandingPageCubit>(context).getCurrentLocation();
    if(!mounted)return;
    if(BlocProvider.of<LandingPageCubit>(context).state.currentPosition!=null){
      BlocProvider.of<WeatherCubit>(context).weatherApi(context, BlocProvider.of<LandingPageCubit>(context).state.currentPosition!.latitude, BlocProvider.of<LandingPageCubit>(context).state.currentPosition!.longitude);
    }
    Timer(const Duration(seconds: 1), () async {

      if(BlocProvider.of<AuthCubit>(context).isLoggedIn()){
        await BlocProvider.of<ProfileCubit>(context).profileApi(context);
        if(!mounted)return;
        if(BlocProvider.of<ProfileCubit>(context).state.responseProfile!.data!.user!.userType == "mcc"){
          const DashboardMCC().navigate(isInfinity: true);
        }else if(BlocProvider.of<ProfileCubit>(context).state.responseProfile!.data!.user!.userType == "dde"){
          const DashboardDDE().navigate(isInfinity: true);
        }else if(BlocProvider.of<ProfileCubit>(context).state.responseProfile!.data!.user!.userType == "supplier"){
          const DashboardSupplier().navigate(isInfinity: true);
        }else if(BlocProvider.of<ProfileCubit>(context).state.responseProfile!.data!.user!.userType == "farmer"){
          const DashboardFarmer().navigate(isInfinity: true);
        }else{
          "User Type not exist".toast();
        }

      }else{
        // const LanguagePermission().navigate(isRemove: true);
        const IntroSlider().navigate(isRemove: true);
      }
    });
  }

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      if (kIsWeb) {} else {
        if (Platform.isAndroid) {
          var build = await deviceInfoPlugin.androidInfo;
          print("deviceId ${build.id}");
          await SharedPrefManager.savePrefString(AppConstants.deviceImeiId, build.id.toString());

        } else if (Platform.isIOS) {
          var build = await deviceInfoPlugin.iosInfo;
          print("deviceId ${build.identifierForVendor}");
          await SharedPrefManager.savePrefString(AppConstants.deviceImeiId, build.identifierForVendor.toString());
        }
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
  }

  @override
  void initState() {
    _route();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(Images.splash,
        width: 225,
        height: 225,),
      ),
    );
  }
}
