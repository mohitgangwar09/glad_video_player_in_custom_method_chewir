import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/data/model/farmer_profile_model.dart';
import 'package:glad/data/model/farmer_project_detail_model.dart';
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

class ViewLoanKyc extends StatefulWidget {
  const ViewLoanKyc({super.key, required this.farmerDocuments,required this.rejectStatus, required this.farmerId, required this.farmerProjectId, required this.farmerMaster});
  final FarmerProjectKycDocument farmerDocuments;
  final  int farmerId;
  final  String farmerProjectId;
  final  FarmerMaster farmerMaster;
  final int rejectStatus;

  @override
  State<ViewLoanKyc> createState() => _ViewLoanKycState();
}

class _ViewLoanKycState extends State<ViewLoanKyc> {

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
  void initState() {
    if(widget.farmerDocuments.addressDocumentName!.contains('-')) {
      List address = widget.farmerDocuments.addressDocumentName!.split('-');
      address =
          address.map((e) => e = e.toString().substring(0, 1).toUpperCase() + e.toString().substring(1)).toList();
      addressProof = address.join(' ');
    } else{
      addressProof = widget.farmerDocuments.addressDocumentName!.substring(0, 1).toUpperCase() + widget.farmerDocuments.addressDocumentName!.substring(1);
    }
    print(widget.farmerDocuments.addressDocumentName);
    if(widget.farmerDocuments.idDocumentName!.contains('-')) {
      List address = widget.farmerDocuments.idDocumentName!.split('-');
      address =
          address.map((e) => e = e.toString().substring(0, 1).toUpperCase() + e.toString().substring(1)).toList();
      idProof = address.join(' ');
    } else{
      if(widget.farmerDocuments.idDocumentName != "nic") {
        idProof =
            widget.farmerDocuments.idDocumentName!.substring(0, 1).toUpperCase() +
                widget.farmerDocuments.idDocumentName!.substring(1);
      } else{
        idProof =
            widget.farmerDocuments.idDocumentName!.toUpperCase();
      }
    }
    if(widget.farmerDocuments.projectFarmerPhoto!=null){
      profilePicture = widget.farmerDocuments.projectFarmerPhoto!;
    }
    addressDoc = TextEditingController(text: widget.farmerDocuments.addressDocumentNumber);
    addressDate = TextEditingController(text: widget.farmerDocuments.addressExpiryDate! == '0000-00-00' ? '': widget.farmerDocuments.addressExpiryDate!);
    idDoc = TextEditingController(text: widget.farmerDocuments.idDocumentNumber);
    idDate = TextEditingController(text: widget.farmerDocuments.idExpiryDate! == '0000-00-00' ? '': widget.farmerDocuments.idExpiryDate);
    addressImg.addAll(Iterable.castFrom(widget.farmerDocuments.addressDocumentFile!.map((e) => e.fullUrl!)));
    idImg.addAll(Iterable.castFrom(widget.farmerDocuments.idDocumentFile!.map((e) => e.fullUrl!)));
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
                titleText1: 'View documents',
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
                                  child: isUrl(profilePicture) ? CachedNetworkImage(
                                    imageUrl: profilePicture, fit: BoxFit.cover, errorWidget: (context, url, error) =>
                                      SvgPicture.asset(Images.uploadPP),) :
                                  Image.file(
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
                      40.verticalSpace(),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         child: CustomTextField(
                      //           hint: 'Recommendation Letter"',
                      //           enabled: false,
                      //           controller: TextEditingController()..text = formatProjectStatus(widget.farmerDocuments.addressDocumentName!),
                      //           // itemList: const [
                      //           //   "Utility Bill",
                      //           //   "Bank Statement",
                      //           //   "Lease Agreement"
                      //           // ],
                      //           // onChanged: (String? value) {
                      //           // },
                      //           // image2: Images.arrowDropdown,
                      //           // image2Colors: Colors.black,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomDropdown(
                                hint: 'Recommendation Letter',
                                dropdownValue: addressProof,
                                itemList: const [
                                  "Recommendation from the LC"
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
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      //   child: Column(
                      //     children: [
                      //       20.verticalSpace(),
                      //       Row(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //
                      //           for (AddressDocumentFile image in widget.farmerDocuments.addressDocumentFile!)
                      //             Row(
                      //               children: [
                      //                 viewDocumentImage(image.fullUrl!, isPDF: widget.farmerDocuments.addressDocumentName == 'bank-statement'),
                      //                 10.horizontalSpace(),
                      //               ],
                      //             )
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
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
                                        var image = await imgFromGallery();
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
                                          if(isUrl(image)){
                                            addressImg.clear();
                                          }
                                        });
                                      }, isPDF: addressProof == 'Bank Statement'),
                                      10.horizontalSpace(),
                                    ],
                                  )
                              ],
                            ),
                          ],
                        ),
                      ),
                      40.verticalSpace(),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         child: CustomTextField(
                      //           hint: 'ID Proof',
                      //           readOnly: true,
                      //           controller: TextEditingController()..text = formatProjectStatus(widget.farmerDocuments.idDocumentName!),
                      //           // dropdownValue: widget.farmerDocuments.docType,
                      //           // itemList: const [
                      //           //   // "Passport", "NIC"
                      //           // ],
                      //           // onChanged: (String? value) {
                      //           // },
                      //           // icon: Images.arrowDropdown,
                      //           // iconColor: Colors.black,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),


                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomDropdown(
                                hint: 'Select ID Proof',
                                dropdownValue: idProof,
                                itemList: const ["National Card"],
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
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      //   child: Row(
                      //     children: [
                      //       Expanded(
                      //         child: CustomTextField(
                      //           hint: 'Doc. No.',
                      //           enabled: false,
                      //           controller: TextEditingController()..text = widget.farmerDocuments.idDocumentNumber.toString()??'',
                      //           hintStyle: figtreeMedium.copyWith(
                      //               fontSize: 16, color: Colors.black),
                      //           readOnly: true,
                      //         ),
                      //       ),
                      //       10.horizontalSpace(),
                      //       Expanded(
                      //         child: CustomTextField(
                      //           hint: 'Exp. Date',
                      //           enabled: false,
                      //           controller: TextEditingController()..text = widget.farmerDocuments.idExpiryDate.toString()=="0000-00-00"?'':widget.farmerDocuments.idExpiryDate.toString(),
                      //           hintStyle: figtreeMedium.copyWith(
                      //               fontSize: 16, color: Colors.black),
                      //           image2: Images.calender,
                      //           image2Colors: ColorResources.maroon,
                      //           readOnly: true,
                      //           focusNode: FocusNode(),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // 10.verticalSpace(),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      //   child: Column(
                      //     children: [
                      //       20.verticalSpace(),
                      //       Row(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           for (IdDocumentFile image in widget.farmerDocuments.idDocumentFile!)
                      //             Row(
                      //               children: [
                      //                 viewDocumentImage(image.fullUrl!),
                      //                 10.horizontalSpace(),
                      //               ],
                      //             )
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
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
                                      var image = await imgFromGallery();
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
                                          if(isUrl(image)){
                                            idImg.clear();
                                          }

                                        });
                                      }),
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

                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      //   child: customButton(
                      //     'Save',
                      //     onTap: () {
                      //
                      //         /*BlocProvider.of<ProjectCubit>(context).projectKycApi(context,
                      //             widget.farmerId.toString(), widget.farmerProjectId.toString(),
                      //             addressProof!.toLowerCase().replaceAll(' ', '-'),
                      //             addressDoc.text,
                      //             addressDate.text,
                      //             addressImg,
                      //             idProof!.toLowerCase().replaceAll(' ', '-'),
                      //             idDoc.text,
                      //             idDate.text,
                      //             idImg,
                      //             profilePicture,
                      //             widget.farmerMaster);*/
                      //
                      //     },
                      //     radius: 40,
                      //     width: double.infinity,
                      //     height: 60,
                      //     style: figtreeMedium.copyWith(
                      //         color: Colors.white, fontSize: 16),
                      //   ),
                      // ),


                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: customButton(
                          'Save',
                          onTap: () {
                            // AddLoanRemark(projectData: widget.farmerMaster,farmerProjectId:widget.farmerProjectId.toString()).navigate();
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
                              // } /*else if (idImg.length < 2) {
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
                              BlocProvider.of<ProjectCubit>(context).projectKycApi(context,
                                  widget.farmerId.toString(), widget.farmerProjectId.toString(),
                                  addressProof!.toLowerCase().replaceAll(' ', '-'),
                                  addressDoc.text,
                                  addressDate.text,
                                  addressImg,
                                  idProof!.toLowerCase().replaceAll(' ', '-'),
                                  idDoc.text,
                                  idDate.text,
                                  idImg,
                                  profilePicture,
                                  widget.farmerMaster);
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
