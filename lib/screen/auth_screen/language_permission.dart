import 'package:flutter/material.dart';
import 'package:glad/screen/auth_screen/introslider.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/app_constants.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class LanguagePermission extends StatelessWidget {
  const LanguagePermission({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(color: 0xffFFF3F4),
      backgroundColor: ColorResources.pinkMain,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Image.asset(
              Images.onboardingLogo,
              width: 108,
              height: 32,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0,bottom: 0),
            child: Stack(
              children: [

                Image.asset(Images.languageBg),

                Positioned(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30.0,right: 14, top: 60),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Choose',
                          style: figtreeBold.copyWith(fontSize: 34),
                        ),
                        Text(
                          'your language',
                          style: figtreeRegular.copyWith(fontSize: 34),
                        ),
                        40.verticalSpace(),
                        customGrid(context,
                            crossAxisSpacing: 20,
                            mainAxisExtent: 155,
                            child: (int index) {
                          return InkWell(
                            onTap: () async {
                              // await requestLocationPermission();
                              const IntroSlider().navigate(isRemove: true);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppConstants.languages.values.toList()[index],
                                    style:
                                        figtreeRegular.copyWith(fontSize: 20),
                                  ),
                                  20.verticalSpace(),
                                  Text(
                                    AppConstants.languages.keys.toList()[index],
                                    style: figtreeRegular.copyWith(
                                        fontSize: 17,
                                        color: ColorResources.pinkReg),
                                  ),

                                  0.verticalSpace(),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          InkWell(
            onTap: () async {
              await requestLocationPermission();
              const IntroSlider().navigate(isRemove: true);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Next',
                  style: figtreeRegular.copyWith(fontSize: 18),
                ),
                const Icon(Icons.arrow_forward)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
