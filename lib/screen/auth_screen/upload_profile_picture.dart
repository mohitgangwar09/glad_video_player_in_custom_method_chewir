import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/guest_user/landing_page.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
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
            Align(
              alignment: Alignment.topRight,
              child: SvgPicture.asset(Images.ppBg),
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
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(
                            'Hello Abdullah,',
                            style: figtreeMedium.copyWith(fontSize: 20),
                          ),
                        ),
                        Positioned(
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.arrow_back)))
                      ],
                    ),
                    Text(
                      'Complete your profile',
                      style: figtreeMedium.copyWith(fontSize: 12),
                    ),
                    InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          showPicker(context, cameraFunction: () {
                            imgFromCamera();
                          }, galleryFunction: () {
                            imgFromGallery();
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(18.0, 18, 18, 0),
                          child: SvgPicture.asset(Images.uploadPP),
                        )),
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Tap to upload ',
                          style: figtreeMedium.copyWith(
                              color: ColorResources.redText, fontSize: 14)),
                      TextSpan(
                          text: 'your profile picture',
                          style: figtreeMedium.copyWith(
                              color: Colors.black, fontSize: 14))
                    ])),
                    Text(
                      'Max size 20 MB',
                      style: figtreeMedium.copyWith(
                          fontSize: 12, color: Colors.grey),
                    ),
                    80.verticalSpace(),
                    Text(
                      'Benefits of adding\nprofile photo',
                      style: figtreeMedium.copyWith(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    20.verticalSpace(),
                    Text(
                      'It makes your profile to look authentic.\nOthers can identify you easily.',
                      style: figtreeMedium.copyWith(
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    100.verticalSpace(),
                    customButton('Submit', onTap: () {
                      const GuestLandingPage().navigate(isRemove: true);
                    },
                        width: double.infinity,
                        style: figtreeMedium.copyWith(
                            color: Colors.white, fontSize: 16)),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: InkWell(
                        onTap: () {
                          const GuestLandingPage().navigate(isRemove: true);
                        },
                        child: Text(
                          'Skip',
                          style: figtreeMedium.copyWith(
                              fontSize: 16,
                              decoration: TextDecoration.underline),
                        ),
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
