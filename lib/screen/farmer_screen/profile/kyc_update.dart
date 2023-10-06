import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/screen/custom_widget/container_border.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_dropdown.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/screen/dde_screen/dashboard/dashboard_dde.dart';
import 'package:glad/screen/dde_screen/dde_profile.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:shimmer/shimmer.dart';

class KYCUpdate extends StatefulWidget {
  const KYCUpdate({super.key});

  @override
  State<KYCUpdate> createState() => _KYCUpdateState();
}

class _KYCUpdateState extends State<KYCUpdate> {
  String profilePicture = '';
  String? addressProof;
  String? idProof;

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
                titleText1: 'KYC documents',
                titleText1Style:
                    figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                centerTitle: true,
                leading: arrowBackButton(),
                action: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Save',
                      style: figtreeMedium.copyWith(
                          color: ColorResources.maroon, fontSize: 14),
                    )),
                description: 'Provide the following details',
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      10.verticalSpace(),
                      Center(
                        child: InkWell(
                          onTap: () {
                            imgFromCamera().then((value) async {
                              setState(() {
                                profilePicture = value;
                              });
                            });
                          },
                          child: ClipOval(
                            clipper: MyClip(),
                            child: SizedBox(
                              height: 180,
                              width: 190,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.transparent,
                                    )),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    File(profilePicture),
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, url, error) =>
                                        SvgPicture.asset(Images.uploadPP),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      /*InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              showPicker(context, cameraFunction: () {
                                var image = imgFromCamera();
                                image.then((value) async{
                                  context.read<ProfileCubit>().profilePicture(value);
                                });
                              }, galleryFunction: () {
                                var image =  imgFromGallery();
                                image.then((value) async{
                                  context.read<ProfileCubit>().profilePicture(value);
                                });
                              });
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(18.0, 0, 18, 0),
                              child: SvgPicture.asset(Images.uploadPP),
                            )),*/
                      15.verticalSpace(),
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
                        'Max size 5 MB',
                        style: figtreeMedium.copyWith(
                            fontSize: 12, color: Colors.grey),
                      ),
                      40.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomDropdown(
                                hint: 'Select Address Proof',
                                dropdownValue: addressProof,
                                itemList: const ["Utility Bill","Bank Statement","Lease Agreement"],
                                onChanged: (String? value) {
                                  setState(() {
                                    addressProof = value;
                                  });
                                },
                                icon: Images.arrowDropdown,
                                iconColor: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                hint: 'Doc. No.',
                                hintStyle: figtreeMedium.copyWith(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ),
                            10.horizontalSpace(),
                            Expanded(
                              child: CustomTextField(
                                hint: 'Exp. Date',
                                hintStyle: figtreeMedium.copyWith(
                                    fontSize: 16, color: Colors.black),
                                image2: Images.calender,
                                image2Colors: ColorResources.maroon,
                                readOnly: true,
                                onTap: () {
                                  showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now());
                                },
                                focusNode: FocusNode(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Stack(
                          children: [
                            ContainerBorder(
                              margin: 0.marginVertical(),
                              padding: 10.paddingOnly(top: 15, bottom: 15),
                              borderColor: 0xffD9D9D9,
                              backColor: 0xffFFFFFF,
                              radius: 10,
                              widget: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  5.horizontalSpace(),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 2, bottom: 2),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text: 'Choose ',
                                                style: figtreeMedium.copyWith(
                                                    fontSize: 16,
                                                    color: Color(0xFFFC5E60))),
                                            TextSpan(
                                                text: 'you file here',
                                                style: figtreeMedium.copyWith(
                                                    fontSize: 16,
                                                    color: ColorResources
                                                        .fieldGrey))
                                          ])),
                                          Text('Max size 20 MB',
                                              style: figtreeMedium.copyWith(
                                                  fontSize: 12,
                                                  color:
                                                      ColorResources.fieldGrey))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (null != null)
                              Visibility(
                                visible: '' == '' ? false : true,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5.0, top: 7),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        Images.errorIcon,
                                        width: 20,
                                        height: 20,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 7.0),
                                          child: Text(
                                            ''.toString(),
                                            style: figtreeRegular.copyWith(
                                              color: const Color(0xff929292),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            Positioned(
                              right: 13,
                              top: 0,
                              bottom: 0,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    Images.attachment,
                                    colorFilter: ColorFilter.mode(
                                        ColorResources.fieldGrey,
                                        BlendMode.srcIn),
                                  ),
                                  10.horizontalSpace(),
                                  SvgPicture.asset(
                                    Images.camera,
                                    colorFilter: ColorFilter.mode(
                                        ColorResources.fieldGrey,
                                        BlendMode.srcIn),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            20.verticalSpace(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                documentImage('', () {}),
                                10.horizontalSpace(),
                                documentImage('', () {}),
                              ],
                            ),
                          ],
                        ),
                      ),
                      40.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomDropdown(
                                hint: 'Select ID Proof',
                                dropdownValue: idProof,
                                itemList: const ["Passport","NIC"],
                                onChanged: (String? value) {
                                  setState(() {
                                    idProof = value;
                                  });
                                },
                                icon: Images.arrowDropdown,
                                iconColor: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                hint: 'Doc. No.',
                                hintStyle: figtreeMedium.copyWith(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ),
                            10.horizontalSpace(),
                            Expanded(
                              child: CustomTextField(
                                hint: 'Exp. Date',
                                hintStyle: figtreeMedium.copyWith(
                                    fontSize: 16, color: Colors.black),
                                image2: Images.calender,
                                image2Colors: ColorResources.maroon,
                                readOnly: true,
                                onTap: () {
                                  showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now());
                                },
                                focusNode: FocusNode(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Stack(
                          children: [
                            ContainerBorder(
                              margin: 0.marginVertical(),
                              padding: 10.paddingOnly(top: 15, bottom: 15),
                              borderColor: 0xffD9D9D9,
                              backColor: 0xffFFFFFF,
                              radius: 10,
                              widget: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  5.horizontalSpace(),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10.0, top: 2, bottom: 2),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                              text: TextSpan(children: [
                                            TextSpan(
                                                text: 'Choose ',
                                                style: figtreeMedium.copyWith(
                                                    fontSize: 16,
                                                    color: Color(0xFFFC5E60))),
                                            TextSpan(
                                                text: 'you file here',
                                                style: figtreeMedium.copyWith(
                                                    fontSize: 16,
                                                    color: ColorResources
                                                        .fieldGrey))
                                          ])),
                                          Text('Max size 20 MB',
                                              style: figtreeMedium.copyWith(
                                                  fontSize: 12,
                                                  color:
                                                      ColorResources.fieldGrey))
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (null != null)
                              Visibility(
                                visible: '' == '' ? false : true,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5.0, top: 7),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        Images.errorIcon,
                                        width: 20,
                                        height: 20,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 7.0),
                                          child: Text(
                                            ''.toString(),
                                            style: figtreeRegular.copyWith(
                                              color: const Color(0xff929292),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            Positioned(
                              right: 13,
                              top: 0,
                              bottom: 0,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    Images.attachment,
                                    colorFilter: ColorFilter.mode(
                                        ColorResources.fieldGrey,
                                        BlendMode.srcIn),
                                  ),
                                  10.horizontalSpace(),
                                  SvgPicture.asset(
                                    Images.camera,
                                    colorFilter: ColorFilter.mode(
                                        ColorResources.fieldGrey,
                                        BlendMode.srcIn),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      40.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: customButton(
                          'Save',
                          onTap: () {},
                          radius: 40,
                          width: double.infinity,
                          height: 60,
                          style: figtreeMedium.copyWith(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                      20.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: customButton('Cancel',
                            onTap: () {},
                            radius: 40,
                            width: double.infinity,
                            height: 60,
                            style: figtreeMedium.copyWith(
                                color: Colors.black, fontSize: 16),
                            color: 0xFFDCDCDC),
                      ),
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
