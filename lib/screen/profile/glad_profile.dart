import 'package:flutter/material.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';

class GladProfile extends StatelessWidget {
  const GladProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          landingBackground(),
        ],
      ),
    );
  }
}
