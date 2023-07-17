import 'package:flutter/material.dart';
import 'package:glad/utils/color_resources.dart';


class LanguagePermission extends StatelessWidget {
  const LanguagePermission({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.pinkMain,
      body: Column(
        children: [
          Image.asset('assets/images/onboarding_logo.png'),
        ],
      ),
    );
  }
}
