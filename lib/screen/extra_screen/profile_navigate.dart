import 'package:flutter/material.dart';
import 'package:glad/screen/farmer_screen/profile/farmer_profile.dart';
import 'package:glad/screen/mcc_screen/profile/mcc_profile.dart';
import 'package:glad/screen/supplier_screen/profile/service_provider_profile.dart';
import 'package:glad/utils/extension.dart';

class ProfileNavigate extends StatelessWidget {
  const ProfileNavigate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
        Center(
          child: ElevatedButton(onPressed: (){
            FarmerProfile().navigate();
          }, child: Text('ProfileNavigate ')),
        )
      ]),
    );
  }
}
