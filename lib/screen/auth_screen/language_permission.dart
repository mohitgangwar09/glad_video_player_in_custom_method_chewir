import 'package:flutter/material.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class LanguagePermission extends StatelessWidget {
  const LanguagePermission({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorResources.pinkMain,
        body: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(Images.languageBg))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Image.asset(
                    Images.onboardingLogo,
                  ),
                ),
                SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text(
                        'Choose',
                        style: figtreeBold.copyWith(fontSize: 38),
                      ),
                      Text(
                        'your language',
                        style: figtreeRegular.copyWith(fontSize: 38),
                      )
                    ],),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
