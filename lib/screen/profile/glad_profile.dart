import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class GladProfile extends StatelessWidget {
  const GladProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          landingBackground(),
          Padding(
            padding: const EdgeInsets.only(top:60.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 32,
                ),

                Center(
                  child: Stack(
                    children: [
                      Container(
                        height: 180,
                        width: 165,
                        child: ClipOval(
                          clipBehavior: Clip.hardEdge,
                          child: Image.asset(
                            Images.sampleLivestock,
                            fit: BoxFit.fill,
                          ),
                          // clipper: MyClip(),
                        ),
                      ),
                      Positioned(
                          right: 0,
                          bottom: 24,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: ColorResources.primary,
                              child: Icon(Icons.camera_alt,
                                  color: Colors.white, size: 20),
                            ),
                          )),
                    ],
                  ),
                ),
                30.verticalSpace(),
                Center(
                    child: Text(
                  'Begumanya Charles',
                  style: figtreeSemiBold.copyWith(fontSize: 22),
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyClip extends CustomClipper<Rect> {
  Rect getClip(Size size) {
    return Rect.fromLTRB(10, 10, 10, 10);
  }

  bool shouldReclip(oldClipper) {
    return false;
  }
}
