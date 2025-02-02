import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/profile_cubit/profile_cubit.dart';
import 'package:glad/cubit/project_cubit/project_cubit.dart';
import 'package:glad/screen/custom_widget/container_border.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_dropdown.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class KYCUpdate extends StatefulWidget {
  const KYCUpdate({super.key});

  @override
  State<KYCUpdate> createState() => _KYCUpdateState();
}

class _KYCUpdateState extends State<KYCUpdate> {

  String type = 'company';
  String docOne= 'Certificate of Incorporation';
  String docTwo= 'Trade License';
  String docThree= 'Latest Annual Return';
  String docFour= 'Bank Statement (Last 6 Months - stamped)';
  String docFive= 'MOA & AOA (Optional)';
  String docSix= 'ID Proof';

  TextEditingController docOneController = TextEditingController();
  TextEditingController docTwoController = TextEditingController();
  TextEditingController docThreeController = TextEditingController();
  TextEditingController docFourController = TextEditingController();
  TextEditingController docFiveController = TextEditingController();
  TextEditingController docSixController = TextEditingController();

  TextEditingController docExpiryOneController = TextEditingController();
  TextEditingController docExpiryTwoController = TextEditingController();
  TextEditingController docExpiryThreeController = TextEditingController();
  TextEditingController docExpiryFourController = TextEditingController();
  TextEditingController docExpiryFiveController = TextEditingController();
  TextEditingController docExpirySixController = TextEditingController();

  List<String> docOneFile = [];
  List<String> docTwoFile = [];
  List<String> docThreeFile = [];
  List<String> docFourFile = [];
  List<String> docFiveFile = [];
  List<String> docSixFile = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileCubit,ProfileCubitState>(
        builder: (context,state) {
          return Stack(
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
                          // 20.verticalSpace(),
                          /*Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      type = 'company';
                                      setState(() {});
                                    },
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: ColorResources.maroon),
                                              padding: const EdgeInsets.all(8),
                                              child: const Icon(
                                                Icons.done,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                            ),
                                            10.horizontalSpace(),
                                            'Company'.textMedium(fontSize: 14)
                                          ],
                                        ),
                                        10.verticalSpace(),
                                        Container(
                                          height: 4,
                                          // width: screenWidth() * 0.4,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(110),
                                            color: ColorResources.maroon,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                20.horizontalSpace(),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      type = 'director';
                                      setState(() {});
                                    },
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: type == 'director'
                                                      ? ColorResources.maroon
                                                      : const Color(0xFFD2D2D2)),
                                              padding: const EdgeInsets.all(8),
                                              child: const Icon(
                                                Icons.done,
                                                color: Colors.white,
                                                size: 18,
                                              ),
                                            ),
                                            10.horizontalSpace(),
                                            'Director'.textMedium(fontSize: 14)
                                          ],
                                        ),
                                        10.verticalSpace(),
                                        Container(
                                          height: 4,
                                          // width: screenWidth() * 0.4,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(110),
                                            color: type == 'director'
                                                ? ColorResources.maroon
                                                : const Color(0xFFD2D2D2),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),*/
                          company(),
                          // if (type == 'company') company(),
                          // if (type == 'director') director(),
                          40.verticalSpace(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: customButton(
                              type == 'director' ? 'Save' : 'Continue',
                              onTap: () {
                                if(docOneFile.isEmpty) {
                                  showCustomToast(
                                      context, 'Please upload certificate of incorporation');
                                }else if(docTwoFile.isEmpty){
                                  showCustomToast(
                                      context, 'Please upload trade license');
                                }else if(docThreeFile.isEmpty){
                                  showCustomToast(
                                      context, 'Please upload latest annual return');
                                }else if(docFourFile.isEmpty){
                                  showCustomToast(
                                      context, 'Please upload bank statement');
                                }
                                // else if(docFiveFile.isEmpty){
                                //   showCustomToast(
                                //       context, 'Please upload MOA & AOA');
                                // }
                                else if(docSixFile.isEmpty){
                                  showCustomToast(
                                      context, 'Please upload select iD proof');
                                }else{
                                  BlocProvider.of<ProfileCubit>(context).supplierKycDocumentApi(context, state.responseProfile!.data!.user!.id!, docOne, docTwo, docThree, docFour, docFive, docSix, docOneController.text, docTwoController.text, docThreeController.text, docFourController.text, docFiveController.text, docSixController.text, docExpiryOneController.text, docExpiryTwoController.text, docExpiryThreeController.text, docExpiryFourController.text, docExpiryFiveController.text, docExpirySixController.text, docOneFile, docTwoFile, docThreeFile, docFourFile, docFiveFile, docSixFile,);
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
                                onTap: () {pressBack();},
                                radius: 40,
                                width: double.infinity,
                                height: 60,
                                style: figtreeMedium.copyWith(
                                    color: Colors.black, fontSize: 16),
                                color: 0xFFDCDCDC),
                          ),
                          20.verticalSpace()
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        }
      ),
    );
  }

  Widget company() {
    return Column(
      children: [
        20.verticalSpace(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                child: CustomDropdown(
                  hint: '',
                  dropdownValue: docOne,
                  itemList: const [
                    "Certificate of Incorporation"
                  ],
                  icon: Images.arrowDropdown,
                  iconColor: Colors.black, onChanged: (String? value) {  },
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
                  controller: docOneController,
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
                  controller: docExpiryOneController,
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
                        docExpiryOneController.text =
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
        docOneFile.length < 2 ? Padding(
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
                        docOneFile.addAll(image);
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
                        docOneFile.add(image);
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
                  for (String image in docOneFile)
                    Row(
                      children: [
                        documentImage(image, () {
                          setState(() {
                            docOneFile.remove(image);
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


        20.verticalSpace(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                child: CustomDropdown(
                  hint: '',
                  dropdownValue: docTwo,
                  itemList: const [
                    "Trade License"
                  ],
                  icon: Images.arrowDropdown,
                  iconColor: Colors.black, onChanged: (String? value) {  },
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
                  controller: docTwoController,
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
                  controller: docExpiryTwoController,
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
                        docExpiryTwoController.text =
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
        docTwoFile.length < 2 ? Padding(
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
                        docTwoFile.addAll(image);
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
                        docTwoFile.add(image);
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
                  for (String image in docTwoFile)
                    Row(
                      children: [
                        documentImage(image, () {
                          setState(() {
                            docTwoFile.remove(image);
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


        20.verticalSpace(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                child: CustomDropdown(
                  hint: '',
                  dropdownValue: docThree,
                  itemList: const [
                    "Latest Annual Return"
                  ],
                  icon: Images.arrowDropdown,
                  iconColor: Colors.black, onChanged: (String? value) {  },
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
                  controller: docThreeController,
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
                  controller: docExpiryThreeController,
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
                        docExpiryThreeController.text =
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
        docThreeFile.length < 2 ? Padding(
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
                        docThreeFile.addAll(image);
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
                        docThreeFile.add(image);
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
                  for (String image in docThreeFile)
                    Row(
                      children: [
                        documentImage(image, () {
                          setState(() {
                            docThreeFile.remove(image);
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



        //
        20.verticalSpace(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                child: CustomDropdown(
                  hint: '',
                  dropdownValue: docFour,
                  itemList: const [
                    "Bank Statement (Last 6 Months - stamped)"
                  ],
                  icon: Images.arrowDropdown,
                  iconColor: Colors.black, onChanged: (String? value) {  },
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
                  controller: docFourController,
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
                  controller: docExpiryFourController,
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
                        docExpiryFourController.text =
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
        docFourFile.length < 2 ? Padding(
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
                        docFourFile.addAll(image);
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
                        docFourFile.add(image);
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
                  for (String image in docFourFile)
                    Row(
                      children: [
                        documentImage(image, () {
                          setState(() {
                            docFourFile.remove(image);
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

        20.verticalSpace(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                child: CustomDropdown(
                  hint: '',
                  dropdownValue: docFive,
                  itemList: const [
                    "MOA & AOA (Optional)"
                  ],
                  icon: Images.arrowDropdown,
                  iconColor: Colors.black, onChanged: (String? value) {  },
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
                  controller: docFiveController,
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
                  controller: docExpiryFiveController,
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
                        docExpiryFiveController.text =
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
        docFiveFile.length < 2 ? Padding(
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
                        docFiveFile.addAll(image);
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
                        docFiveFile.add(image);
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
                  for (String image in docFiveFile)
                    Row(
                      children: [
                        documentImage(image, () {
                          setState(() {
                            docFiveFile.remove(image);
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



        20.verticalSpace(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: [
              Expanded(
                child: CustomDropdown(
                  hint: '',
                  dropdownValue: docSix,
                  itemList: const [
                    "ID Proof"
                  ],
                  icon: Images.arrowDropdown,
                  iconColor: Colors.black, onChanged: (String? value) {  },
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
                  controller: docSixController,
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
                  controller: docExpirySixController,
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
                        docExpirySixController.text =
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
        docSixFile.length < 2 ? Padding(
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
                        docSixFile.addAll(image);
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
                        docSixFile.add(image);
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
                  for (String image in docSixFile)
                    Row(
                      children: [
                        documentImage(image, () {
                          setState(() {
                            docSixFile.remove(image);
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
        20.verticalSpace()
      ],
    );
  }

  // Widget director() {
  //   return Column(
  //     children: [
  //       20.verticalSpace(),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //         child: Row(
  //           children: [
  //             Expanded(
  //               child: CustomDropdown(
  //                 hint: '',
  //                 dropdownValue: docFive,
  //                 itemList: const [
  //                   "MOA & AOA (Optional)"
  //                 ],
  //                 icon: Images.arrowDropdown,
  //                 iconColor: Colors.black, onChanged: (String? value) {  },
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       10.verticalSpace(),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //         child: Row(
  //           children: [
  //             Expanded(
  //               child: CustomTextField(
  //                 hint: 'Doc. No.',
  //                 controller: docFiveController,
  //                 hintStyle: figtreeMedium.copyWith(
  //                     fontSize: 16, color: Colors.black),
  //               ),
  //             ),
  //             10.horizontalSpace(),
  //             Expanded(
  //               child: CustomTextField(
  //                 hint: 'Exp. Date',
  //                 hintStyle: figtreeMedium.copyWith(
  //                     fontSize: 16, color: Colors.black),
  //                 image2: Images.calender,
  //                 controller: docExpiryFiveController,
  //                 image2Colors: ColorResources.maroon,
  //                 readOnly: true,
  //                 onTap: () {
  //                   showDatePicker(
  //                       context: context,
  //                       initialDate: DateTime.now(),
  //                       firstDate: DateTime.now(),
  //                       lastDate: DateTime(2100))
  //                       .then((value) {
  //                     setState(() {
  //                       docExpiryFiveController.text =
  //                       "${value!.year}/${value.month}/${value.day}";
  //                     });
  //                   });
  //                 },
  //                 focusNode: FocusNode(),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       10.verticalSpace(),
  //       docFiveFile.length < 2 ? Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //         child: Stack(
  //           children: [
  //             ContainerBorder(
  //               margin: 0.marginVertical(),
  //               padding: 10.paddingOnly(top: 15, bottom: 15),
  //               borderColor: 0xffD9D9D9,
  //               backColor: 0xffFFFFFF,
  //               radius: 10,
  //               widget: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   5.horizontalSpace(),
  //                   Expanded(
  //                     child: Padding(
  //                       padding: const EdgeInsets.only(
  //                           left: 10.0, top: 2, bottom: 2),
  //                       child: Column(
  //                         crossAxisAlignment:
  //                         CrossAxisAlignment.start,
  //                         children: [
  //                           RichText(
  //                               text: TextSpan(children: [
  //                                 TextSpan(
  //                                     text: 'Choose ',
  //                                     style: figtreeMedium.copyWith(
  //                                         fontSize: 16,
  //                                         color: const Color(
  //                                             0xFFFC5E60))),
  //                                 TextSpan(
  //                                     text: 'you file here',
  //                                     style: figtreeMedium.copyWith(
  //                                         fontSize: 16,
  //                                         color: ColorResources
  //                                             .fieldGrey))
  //                               ])),
  //                           Text('Max size 5 MB',
  //                               style: figtreeMedium.copyWith(
  //                                   fontSize: 12,
  //                                   color:
  //                                   ColorResources.fieldGrey))
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Positioned(
  //               right: 13,
  //               top: 0,
  //               bottom: 0,
  //               child: Row(
  //                 children: [
  //                   InkWell(
  //                     onTap: () async{
  //                       var image = await imgFromGallery();
  //                       docFiveFile.add(image);
  //                       setState(() {});
  //                     },
  //                     child: SvgPicture.asset(
  //                       Images.attachment,
  //                       colorFilter: const ColorFilter.mode(
  //                           ColorResources.fieldGrey,
  //                           BlendMode.srcIn),
  //                     ),
  //                   ),
  //                   10.horizontalSpace(),
  //                   InkWell(
  //                     onTap: () async{
  //                       var image = await imgFromCamera();
  //                       docFiveFile.add(image);
  //                       setState(() {});
  //                     },
  //                     child: SvgPicture.asset(
  //                       Images.camera,
  //                       colorFilter: const ColorFilter.mode(
  //                           ColorResources.fieldGrey,
  //                           BlendMode.srcIn),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ) : const SizedBox.shrink(),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //         child: Column(
  //           children: [
  //             20.verticalSpace(),
  //             Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 for (String image in docFiveFile)
  //                   Row(
  //                     children: [
  //                       documentImage(image, () {
  //                         setState(() {
  //                           docFiveFile.remove(image);
  //                         });
  //                       }),
  //                       10.horizontalSpace(),
  //                     ],
  //                   )
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //
  //
  //
  //       20.verticalSpace(),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //         child: Row(
  //           children: [
  //             Expanded(
  //               child: CustomDropdown(
  //                 hint: '',
  //                 dropdownValue: docSix,
  //                 itemList: const [
  //                   "ID Proof"
  //                 ],
  //                 icon: Images.arrowDropdown,
  //                 iconColor: Colors.black, onChanged: (String? value) {  },
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       10.verticalSpace(),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //         child: Row(
  //           children: [
  //             Expanded(
  //               child: CustomTextField(
  //                 hint: 'Doc. No.',
  //                 controller: docSixController,
  //                 hintStyle: figtreeMedium.copyWith(
  //                     fontSize: 16, color: Colors.black),
  //               ),
  //             ),
  //             10.horizontalSpace(),
  //             Expanded(
  //               child: CustomTextField(
  //                 hint: 'Exp. Date',
  //                 hintStyle: figtreeMedium.copyWith(
  //                     fontSize: 16, color: Colors.black),
  //                 image2: Images.calender,
  //                 controller: docExpirySixController,
  //                 image2Colors: ColorResources.maroon,
  //                 readOnly: true,
  //                 onTap: () {
  //                   showDatePicker(
  //                       context: context,
  //                       initialDate: DateTime.now(),
  //                       firstDate: DateTime.now(),
  //                       lastDate: DateTime(2100))
  //                       .then((value) {
  //                     setState(() {
  //                       docExpirySixController.text =
  //                       "${value!.year}/${value.month}/${value.day}";
  //                     });
  //                   });
  //                 },
  //                 focusNode: FocusNode(),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       10.verticalSpace(),
  //       docSixFile.length < 2 ? Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //         child: Stack(
  //           children: [
  //             ContainerBorder(
  //               margin: 0.marginVertical(),
  //               padding: 10.paddingOnly(top: 15, bottom: 15),
  //               borderColor: 0xffD9D9D9,
  //               backColor: 0xffFFFFFF,
  //               radius: 10,
  //               widget: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   5.horizontalSpace(),
  //                   Expanded(
  //                     child: Padding(
  //                       padding: const EdgeInsets.only(
  //                           left: 10.0, top: 2, bottom: 2),
  //                       child: Column(
  //                         crossAxisAlignment:
  //                         CrossAxisAlignment.start,
  //                         children: [
  //                           RichText(
  //                               text: TextSpan(children: [
  //                                 TextSpan(
  //                                     text: 'Choose ',
  //                                     style: figtreeMedium.copyWith(
  //                                         fontSize: 16,
  //                                         color: const Color(
  //                                             0xFFFC5E60))),
  //                                 TextSpan(
  //                                     text: 'you file here',
  //                                     style: figtreeMedium.copyWith(
  //                                         fontSize: 16,
  //                                         color: ColorResources
  //                                             .fieldGrey))
  //                               ])),
  //                           Text('Max size 5 MB',
  //                               style: figtreeMedium.copyWith(
  //                                   fontSize: 12,
  //                                   color:
  //                                   ColorResources.fieldGrey))
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Positioned(
  //               right: 13,
  //               top: 0,
  //               bottom: 0,
  //               child: Row(
  //                 children: [
  //                   InkWell(
  //                     onTap: () async{
  //                       var image = await imgFromGallery();
  //                       docSixFile.add(image);
  //                       setState(() {});
  //                     },
  //                     child: SvgPicture.asset(
  //                       Images.attachment,
  //                       colorFilter: const ColorFilter.mode(
  //                           ColorResources.fieldGrey,
  //                           BlendMode.srcIn),
  //                     ),
  //                   ),
  //                   10.horizontalSpace(),
  //                   InkWell(
  //                     onTap: () async{
  //                       var image = await imgFromCamera();
  //                       docSixFile.add(image);
  //                       setState(() {});
  //                     },
  //                     child: SvgPicture.asset(
  //                       Images.camera,
  //                       colorFilter: const ColorFilter.mode(
  //                           ColorResources.fieldGrey,
  //                           BlendMode.srcIn),
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ) : const SizedBox.shrink(),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //         child: Column(
  //           children: [
  //             20.verticalSpace(),
  //             Row(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 for (String image in docSixFile)
  //                   Row(
  //                     children: [
  //                       documentImage(image, () {
  //                         setState(() {
  //                           docSixFile.remove(image);
  //                         });
  //                       }),
  //                       10.horizontalSpace(),
  //                     ],
  //                   )
  //               ],
  //             ),
  //           ],
  //         ),
  //       ),
  //       20.verticalSpace()
  //
  //     ],
  //   );
  // }

  // Widget companyUploadType(String type, {String? description}) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         RichText(
  //             text: TextSpan(children: [
  //           TextSpan(
  //               text: type,
  //               style:
  //                   figtreeMedium.copyWith(fontSize: 16, color: Colors.black)),
  //           TextSpan(
  //               text: ' ${description ?? ''}',
  //               style:
  //                   figtreeMedium.copyWith(fontSize: 16, color: Colors.grey)),
  //         ])),
  //         5.verticalSpace(),
  //         Stack(
  //           children: [
  //             ContainerBorder(
  //               margin: 0.marginVertical(),
  //               padding: 10.paddingOnly(top: 15, bottom: 15),
  //               borderColor: 0xffD9D9D9,
  //               backColor: 0xffFFFFFF,
  //               radius: 10,
  //               widget: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 crossAxisAlignment: CrossAxisAlignment.center,
  //                 children: [
  //                   5.horizontalSpace(),
  //                   Expanded(
  //                     child: Padding(
  //                       padding: const EdgeInsets.only(
  //                           left: 10.0, top: 2, bottom: 2),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           RichText(
  //                               text: TextSpan(children: [
  //                             TextSpan(
  //                                 text: 'Choose ',
  //                                 style: figtreeMedium.copyWith(
  //                                     fontSize: 16,
  //                                     color: const Color(0xFFFC5E60))),
  //                             TextSpan(
  //                                 text: 'you file here',
  //                                 style: figtreeMedium.copyWith(
  //                                     fontSize: 16,
  //                                     color: ColorResources.fieldGrey))
  //                           ])),
  //                           Text('Max size 02 MB',
  //                               style: figtreeMedium.copyWith(
  //                                   fontSize: 12,
  //                                   color: ColorResources.fieldGrey))
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             if (null != null)
  //               Visibility(
  //                 visible: '' == '' ? false : true,
  //                 child: Padding(
  //                   padding: const EdgeInsets.only(left: 5.0, top: 7),
  //                   child: Row(
  //                     children: [
  //                       SvgPicture.asset(
  //                         Images.errorIcon,
  //                         width: 20,
  //                         height: 20,
  //                       ),
  //                       Expanded(
  //                         child: Padding(
  //                           padding: const EdgeInsets.only(left: 7.0),
  //                           child: Text(
  //                             ''.toString(),
  //                             style: figtreeRegular.copyWith(
  //                               color: const Color(0xff929292),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             Positioned(
  //               right: 13,
  //               top: 0,
  //               bottom: 0,
  //               child: Row(
  //                 children: [
  //                   SvgPicture.asset(
  //                     Images.attachment,
  //                     colorFilter: const ColorFilter.mode(
  //                         ColorResources.fieldGrey, BlendMode.srcIn),
  //                   ),
  //                   10.horizontalSpace(),
  //                   SvgPicture.asset(
  //                     Images.camera,
  //                     colorFilter: const ColorFilter.mode(
  //                         ColorResources.fieldGrey, BlendMode.srcIn),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
