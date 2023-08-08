import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield2.dart';
import 'package:glad/screen/farmer_screen/profile/farm_details.dart';
import 'package:glad/screen/farmer_screen/profile/personal_details.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.section});
  final String section;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String? section;

  @override
  void initState() {
    section = widget.section;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          landingBackground(),
          Column(
            children: [
              CustomAppBar(
                context: context,
                richTitle: false,
                titleText1: 'Edit Profile',
                centerTitle: true,
                leading: arrowBackButton(),
                action: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Save',
                      style: figtreeMedium.copyWith(
                          color: ColorResources.maroon, fontSize: 14),
                    )),
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
                                const EdgeInsets.fromLTRB(18.0, 0, 18, 0),
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
                            borderColor: const Color(0xffDCDCDC),
                            backgroundColor: Colors.white),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  section = 'personal';
                                  setState(() {});
                                },
                                child: Container(
                                  height: screenHeight(),
                                  margin: const EdgeInsets.all(6),
                                  decoration: boxDecoration(
                                      backgroundColor: section == 'personal'
                                          ? const Color(0xff6A0030)
                                          : Colors.white,
                                      borderRadius: 62),
                                  alignment: Alignment.center,
                                  child: "Personal information".textMedium(
                                      color: section == 'personal'
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 13),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  section = 'farm';
                                  setState(() {});
                                },
                                child: Container(
                                  height: screenHeight(),
                                  margin: const EdgeInsets.all(6),
                                  decoration: boxDecoration(
                                      backgroundColor: section == 'farm'
                                          ? const Color(0xff6A0030)
                                          : Colors.white,
                                      borderRadius: 62),
                                  alignment: Alignment.center,
                                  child: "Farm details".textMedium(
                                      color: section == 'farm'
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 13),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      20.verticalSpace(),
                      if (section == 'personal') const PersonalDetails(),
                      if (section == 'farm') const FarmDetails()
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
