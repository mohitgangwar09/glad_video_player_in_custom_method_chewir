import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/screen/dde_screen/dashboard/dashboard_dde.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class KYCUpdate extends StatelessWidget {
  const KYCUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: SvgPicture.asset(Images.ppBg),
          ),
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
                      1.horizontalSpace(),
                      Text('KYC documents',
                          style: figtreeRegular.copyWith(
                              fontWeight: FontWeight.w100,
                              fontSize: 22,
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
                Text(
                  'Provide the following details',
                  style: figtreeMedium.copyWith(fontSize: 14),
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
                      text: 'your photo',
                      style: figtreeMedium.copyWith(
                          color: Colors.black, fontSize: 14))
                ])),
                Text(
                  'Max size 20 MB',
                  style:
                      figtreeMedium.copyWith(fontSize: 12, color: Colors.grey),
                ),
                40.verticalSpace(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          hint: 'Doc. No.',
                          hintStyle: figtreeMedium.copyWith(
                              fontSize: 16, color: Colors.grey),
                        ),
                      ),
                      10.horizontalSpace(),
                      Expanded(
                        child: CustomTextField(
                          hint: 'Exp. Date',
                          hintStyle: figtreeMedium.copyWith(
                              fontSize: 16, color: Colors.grey),
                          suffixIcon: Icon(Icons.calendar_today),
                          suffixIconColor: ColorResources.maroon,
                        ),
                      ),
                    ],
                  ),
                ),
                10.verticalSpace(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          hint: 'Choose you file here',
                          hintStyle: figtreeMedium.copyWith(
                              fontSize: 16, color: Colors.grey),
                          image: Images.notification,
                          imageColors: Colors.black,
                          // suffixIconColor: ColorResources.fieldGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
