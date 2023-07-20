import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/extra_screen/navigation.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class UploadProfilePicture extends StatelessWidget {
  const UploadProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50.0),
              child: SvgPicture.asset(Images.ppBg, fit: BoxFit.fitWidth),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 40,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Hello Abdullah,',
                      style: figtreeMedium.copyWith(fontSize: 22),
                    ),
                    Text(
                      'Complete your profile',
                      style: figtreeMedium.copyWith(fontSize: 14),
                    ),
                    svgIconWithOnTap(image: Images.uploadPP, onTap: () {}),
                    customButton('Submit',
                        onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (builder)=>Navigation()));
                        },
                        width: double.infinity,
                        height: 60,
                        radius: 88,
                        style: figtreeMedium.copyWith(
                            color: Colors.white, fontSize: 16)),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        'Skip',
                        style: figtreeMedium.copyWith(
                            fontSize: 16,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
