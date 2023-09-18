import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:device_information/device_information.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glad/cubit/auth_cubit/auth_cubit.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/screen/auth_screen/create_password.dart';
import 'package:glad/screen/auth_screen/login_with_password.dart';
import 'package:glad/screen/auth_screen/upload_profile_picture.dart';
import 'package:glad/screen/dde_screen/dashboard/dashboard_dde.dart';
import 'package:glad/screen/extra_screen/profile_navigate.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/screen/farmer_screen/profile/edit_profile.dart';
import 'package:glad/screen/mcc_screen/dashboard/dashboard_mcc.dart';
import 'package:glad/screen/supplier_screen/dashboard/dashboard_supplier.dart';
import 'package:glad/translation/change_language.dart';
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
    // await imei();
    await initPlatformState();
    Timer(const Duration(seconds: 2), () async {
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

        }

      }else{
        const LanguagePermission().navigate(isRemove: true);
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
  imei() async{
    await Permission.phone.request();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(!preferences.containsKey(AppConstants.deviceImeiId)) {
      preferences.setString(
          AppConstants.deviceImeiId, await DeviceInformation.deviceIMEINumber);
    }
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
