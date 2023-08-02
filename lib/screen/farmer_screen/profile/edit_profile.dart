import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield2.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          landingBackground(),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const BackButton(),
                      Text('Edit profile',
                          style: figtreeMedium.copyWith(
                              fontWeight: FontWeight.w100,
                              fontSize: 20,
                              color: Colors.black)),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            'Save',
                            style: figtreeMedium.copyWith(
                                color: ColorResources.maroon, fontSize: 14),
                          )),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
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
                              padding:
                                  const EdgeInsets.fromLTRB(18.0, 18, 18, 0),
                              child: SvgPicture.asset(Images.uploadPP),
                            )),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: 'Tap to change ',
                              style: figtreeMedium.copyWith(
                                  color: ColorResources.redText, fontSize: 14)),
                          TextSpan(
                              text: 'your photo',
                              style: figtreeMedium.copyWith(
                                  color: Colors.black, fontSize: 14))
                        ])),
                        Text(
                          'Max size 20 MB',
                          style: figtreeMedium.copyWith(
                              fontSize: 12, color: Colors.grey),
                        ),
                        40.verticalSpace(),
                        Container(
                          height: 50,
                          margin: 20.marginHorizontal(),
                          width: screenWidth(),
                          decoration: boxDecoration(
                              borderRadius: 62,
                              borderColor: const Color(0xffDCDCDC)
                          ),
                          child: Row(
                            children: [

                              Expanded(
                                child: Container(
                                  height: screenHeight(),
                                  margin: const EdgeInsets.all(6),
                                  decoration: boxDecoration(
                                      backgroundColor: const Color(0xff6A0030),
                                      borderRadius: 62
                                  ),
                                  alignment: Alignment.center,
                                  child: "Personal information".textMedium(color: Colors.white,fontSize: 13),
                                ),
                              ),

                              Expanded(
                                child: Container(
                                  height: screenHeight(),
                                  margin: const EdgeInsets.all(6),
                                  decoration: boxDecoration(
                                      backgroundColor: const Color(0xff6A0030),
                                      borderRadius: 62
                                  ),
                                  alignment: Alignment.center,
                                  child: "Farm details".textMedium(color: Colors.white,fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                        20.verticalSpace(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              const CustomTextField2(title: 'Name'),
                              20.verticalSpace(),
                              const CustomTextField2(title: 'Email'),
                              20.verticalSpace(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
