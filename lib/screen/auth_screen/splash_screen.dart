import 'dart:async';
import 'package:flutter/material.dart';
import 'package:glad/screen/auth_screen/login_with_password.dart';
import 'package:glad/screen/extra_screen/profile_navigate.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/screen/farmer_screen/dashboard/milk_production_yield.dart';
import 'package:glad/screen/farmer_screen/dashboard_tab_screen/landing_page.dart';
import 'package:glad/screen/farmer_screen/drawer_screen/add_testimonial.dart';
import 'package:glad/screen/farmer_screen/profile/edit_profile.dart';
import 'package:glad/translation/change_language.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'language_permission.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _route() async {
    Timer(const Duration(seconds: 2), () async {
      const DashboardFarmer().navigate(isRemove: true);
    });
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
