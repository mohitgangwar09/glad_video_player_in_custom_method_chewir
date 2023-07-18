import 'dart:async';
import 'package:flutter/material.dart';
import 'package:glad/screen/auth_screen/login_with_password.dart';
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
      const LoginWithPassword().navigate(isRemove: true);
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
