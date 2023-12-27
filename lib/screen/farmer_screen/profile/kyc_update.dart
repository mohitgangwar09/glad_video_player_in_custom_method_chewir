import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/screen/custom_widget/container_border.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_dropdown.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/screen/dde_screen/dde_profile.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class KYCUpdate extends StatefulWidget {
  const KYCUpdate({super.key, required this.farmerId, required this.userId});
  final  int farmerId;
  final  String userId;

  @override
  State<KYCUpdate> createState() => _KYCUpdateState();
}

class _KYCUpdateState extends State<KYCUpdate> {
  String profilePicture = '';
  String? addressProof;
  String? idProof;
  TextEditingController addressDoc = TextEditingController();
  TextEditingController addressDate = TextEditingController();
  List<String> addressImg = [];
  TextEditingController idDoc = TextEditingController();
  TextEditingController idDate = TextEditingController();
  List<String> idImg = [];

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
                            // imgFromCamera().then((value) async {
                            imgFromGallery().then((value) async {
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
                                itemList: const [
                                  "Utility Bill",
                                  "Bank Statement",
                                  "Lease Agreement"
                                ],
                                onChanged: (String? value) {
                                  if(addressProof != value) {
                                    setState(() {
                                      addressProof = value;
                                      addressDoc.text = '';
                                      addressDate.text = '';
                                      addressImg.clear();
                                    });
                                  }
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
                                controller: addressDoc,
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
                                controller: addressDate,
                                image2Colors: ColorResources.maroon,
                                readOnly: true,
                                onTap: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2100))
                                      .then((value) {
                                    setState(() {
                                      addressDate.text =
                                          "${value!.year}/${value.month}/${value.day}";
                                    });
                                  });
                                },
                                focusNode: FocusNode(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.verticalSpace(),
                      addressImg.length < 2
                          ? !(addressProof == 'Bank Statement' && addressImg.length == 1) ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Stack(
                                children: [
                                  ContainerBorder(
                                    margin: 0.marginVertical(),
                                    padding:
                                        10.paddingOnly(top: 15, bottom: 15),
                                    borderColor: 0xffD9D9D9,
                                    backColor: 0xffFFFFFF,
                                    radius: 10,
                                    widget: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                                      style: figtreeMedium
                                                          .copyWith(
                                                              fontSize: 16,
                                                              color: const Color(
                                                                  0xFFFC5E60))),
                                                  TextSpan(
                                                      text: 'you file here',
                                                      style: figtreeMedium
                                                          .copyWith(
                                                              fontSize: 16,
                                                              color:
                                                                  ColorResources
                                                                      .fieldGrey))
                                                ])),
                                                Text('Max size 5 MB',
                                                    style:
                                                        figtreeMedium.copyWith(
                                                            fontSize: 12,
                                                            color:
                                                                ColorResources
                                                                    .fieldGrey))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    right: 13,
                                    top: 0,
                                    bottom: 0,
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            if(addressProof == 'Bank Statement') {
                                              FilePickerResult? result = await FilePicker.platform.pickFiles(type:  FileType.custom, allowedExtensions: ['pdf']);
                                              if(result!.files.first.extension == 'pdf') {
                                                addressImg.add(
                                                    result.files.first.path!);
                                                setState(() {});
                                              } else {
                                                showCustomToast(context, 'Please select only PDF');
                                              }
                                            } else {
                                              var image = await imgOrPdfFromGallery();
                                              addressImg.add(image);
                                              setState(() {});
                                            }
                                          },
                                          child: SvgPicture.asset(
                                            Images.attachment,
                                            colorFilter: const ColorFilter.mode(
                                                ColorResources.fieldGrey,
                                                BlendMode.srcIn),
                                          ),
                                        ),
                                        if(addressProof != 'Bank Statement')
                                        Row(children: [
                                          10.horizontalSpace(),
                                          InkWell(
                                            onTap: () async{
                                              var image = await imgFromCamera();
                                              addressImg.add(image);
                                              setState(() {});
                                            },
                                            child: SvgPicture.asset(
                                              Images.camera,
                                              colorFilter: const ColorFilter.mode(
                                                  ColorResources.fieldGrey,
                                                  BlendMode.srcIn),
                                            ),
                                          )
                                        ],),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink()
                          : const SizedBox.shrink(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            20.verticalSpace(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                for (String image in addressImg)
                                  Row(
                                    children: [
                                      documentImage(image, () {
                                        setState(() {
                                          addressImg.remove(image);
                                        });
                                      }, isPDF: image.endsWith('.pdf')),
                                      10.horizontalSpace(),
                                    ],
                                  )
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
                                itemList: const ["Passport", "NIC"],
                                onChanged: (String? value) {
                                  if(idProof != value) {
                                    setState(() {
                                      idProof = value;
                                      idDoc.text = '';
                                      idDate.text = '';
                                      idImg.clear();
                                    });
                                  }
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
                                controller: idDoc,
                                hintStyle: figtreeMedium.copyWith(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ),
                            10.horizontalSpace(),
                            Expanded(
                              child: CustomTextField(
                                hint: 'Exp. Date',
                                controller: idDate,
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
                                          lastDate: DateTime(2100))
                                      .then((value) {
                                    setState(() {
                                      idDate.text =
                                          "${value!.year}/${value.month}/${value.day}";
                                    });
                                  });
                                },
                                focusNode: FocusNode(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      10.verticalSpace(),
                      idImg.length < 2 ? Padding(
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
                                                    color: const Color(
                                                        0xFFFC5E60))),
                                            TextSpan(
                                                text: 'you file here',
                                                style: figtreeMedium.copyWith(
                                                    fontSize: 16,
                                                    color: ColorResources
                                                        .fieldGrey))
                                          ])),
                                          Text('Max size 5 MB',
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
                            Positioned(
                              right: 13,
                              top: 0,
                              bottom: 0,
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () async{
                                      var image = await imgOrPdfFromGallery();
                                      idImg.add(image);
                                      setState(() {});
                                    },
                                    child: SvgPicture.asset(
                                      Images.attachment,
                                      colorFilter: const ColorFilter.mode(
                                          ColorResources.fieldGrey,
                                          BlendMode.srcIn),
                                    ),
                                  ),
                                  10.horizontalSpace(),
                                  InkWell(
                                    onTap: () async{
                                      var image = await imgFromCamera();
                                      idImg.add(image);
                                      setState(() {});
                                    },
                                    child: SvgPicture.asset(
                                      Images.camera,
                                      colorFilter: const ColorFilter.mode(
                                          ColorResources.fieldGrey,
                                          BlendMode.srcIn),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ) : const SizedBox.shrink(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: [
                            20.verticalSpace(),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (String image in idImg)
                                  Row(
                                    children: [
                                      documentImage(image, () {
                                        setState(() {
                                          idImg.remove(image);
                                        });
                                      }, isPDF: image.endsWith('.pdf')),
                                      10.horizontalSpace(),
                                    ],
                                  )
                              ],
                            ),
                          ],
                        ),
                      ),
                      // 40.verticalSpace(),
                      40.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: customButton(
                          'Save',
                          onTap: () {
                            if (profilePicture.isEmpty) {
                              showCustomToast(
                                  context, 'Photo is required');
                            } else if (addressProof == null) {
                              showCustomToast(
                                  context, 'Address Proof is required');
                            // } else if (addressImg.length < 2 && !(addressProof == 'Bank Statement' && addressImg.length == 1)) {
                            //   showCustomToast(
                            //         context, '${addressProof == 'Bank Statement' ? '' : '2'}Address Proof image required');
                            // } else if (idProof == null) {
                            //   showCustomToast(context, 'Id Proof is required');
                            // } else if (idImg.length < 2) {
                            //   showCustomToast(
                            //       context, '2 Id Proof image required');
                            } else if (addressImg.isEmpty) {
                              showCustomToast(
                                  context, 'Address Proof image required');
                            } else if (idProof == null) {
                              showCustomToast(context, 'Id Proof is required');
                            } else if (idImg.isEmpty) {
                              showCustomToast(
                                  context, 'Id Proof image required');
                            } else {
                              BlocProvider.of<ProfileCubit>(context).updateFarmerKYC(context, widget.userId, widget.farmerId, addressProof!.toLowerCase().replaceAll(' ', '-'), addressDoc.text, addressDate.text, addressImg, idProof!.toLowerCase().replaceAll(' ', '-'), idDoc.text, idDate.text, idImg, profilePicture);
                            }
                          },
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
                            onTap: () {
                              pressBack();
                            },
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
