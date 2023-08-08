import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/dashboard/dashboard_dde.dart';
import 'package:glad/screen/extra_screen/navigation.dart';
import 'package:glad/screen/guest_user/dashboard_tab_screen/landing_page.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class UploadProfilePicture extends StatelessWidget {
  const UploadProfilePicture({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          landingBackground(),
          Column(
            children: [

              CustomAppBar(context: context, richTitle: false, titleText1: 'Hello Abdullah,', description: 'Complete your profile', centerTitle: true, leading: arrowBackButton(),),


              uploadProfilePhoto(context),

              actionButton()
            ],
          ),
        ],
      ),
    );
  }

  ///////// profile Photo /////////
  Widget uploadProfilePhoto(BuildContext context){
    return Column(
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
          style:
          figtreeMedium.copyWith(fontSize: 12, color: Colors.grey),
        ),
        // 80.verticalSpace(),
        screenHeight()<750?50.verticalSpace():80.verticalSpace(),
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
        screenHeight()<750? 40.verticalSpace():100.verticalSpace(),
      ],
    );
  }

  ///// Submit & Skip Button //////
  Widget actionButton(){
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: customButton('Submit', onTap: () {
            const Navigation().navigate();
          },
              width: double.infinity,
              style: figtreeMedium.copyWith(
                  color: Colors.white, fontSize: 16)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: InkWell(
            onTap: () {
              const Navigation().navigate();
            },
            child: Text(
              'Skip',
              style: figtreeMedium.copyWith(
                  fontSize: 16, decoration: TextDecoration.underline),
            ),
          ),
        )
      ],
    );
  }

}