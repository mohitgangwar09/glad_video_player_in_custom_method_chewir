import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/cubit/drawer_cubit/drawer_cubit.dart';
import 'package:glad/screen/custom_widget/container_border.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield2.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class AddTestimonial extends StatefulWidget {
  const AddTestimonial({super.key});

  @override
  State<AddTestimonial> createState() => _AddTestimonialState();
}

class _AddTestimonialState extends State<AddTestimonial> {

  String? type;
  String? path;
  TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DrawerCubit, DrawerState>(
        builder: (context, state) {
          return Stack(
            children: [
              landingBackground(),
              Column(
                children: [
                  CustomAppBar(
                    context: context,
                    titleText1: 'Add testimonial',
                    titleText1Style: figtreeMedium.copyWith(
                        fontSize: 20, color: Colors.black),
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
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            CustomTextField2(
                              title: 'Describe your feelings',
                              hint: 'Write..',
                              maxLine: 7,
                              minLine: 7,
                              height: null,
                              controller: description,
                            ),
                            20.verticalSpace(),
                            Visibility(
                              visible: path == null,
                              child: InkWell(
                                onTap: () async{
                                  showTestimonialPicker(context, videoFunction: () async {
                                    path = await videoFromGallery();
                                    type = 'video';
                                    setState(() {});
                                    pressBack();
                                  }, photoFunction: () async {
                                    path = await imgFromGallery();
                                    type = 'image';
                                    setState(() {});
                                    pressBack();
                                  });
                                },
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
                                                            text: 'Upload ',
                                                            style: figtreeMedium.copyWith(
                                                                fontSize: 16,
                                                                color:
                                                                const Color(0xFFFC5E60))),
                                                        TextSpan(
                                                            text: 'video/photo here',
                                                            style: figtreeMedium.copyWith(
                                                                fontSize: 16,
                                                                color: ColorResources
                                                                    .fieldGrey))
                                                      ])),
                                                  Text('Max size 20 MB',
                                                      style: figtreeMedium.copyWith(
                                                          fontSize: 12,
                                                          color: ColorResources
                                                              .fieldGrey))
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
                                          padding: const EdgeInsets.only(
                                              left: 5.0, top: 7),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                Images.errorIcon,
                                                width: 20,
                                                height: 20,
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 7.0),
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
                                            colorFilter: const ColorFilter.mode(
                                                ColorResources.fieldGrey,
                                                BlendMode.srcIn),
                                          ),
                                          10.horizontalSpace(),
                                          SvgPicture.asset(
                                            Images.camera,
                                            colorFilter: const ColorFilter.mode(
                                                ColorResources.fieldGrey,
                                                BlendMode.srcIn),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            20.verticalSpace(),
                            path!= null ?
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                    child: Image.file(File(path!), fit: BoxFit.fitWidth, width: screenWidth(), height: 200,)),
                                Positioned(
                                  right: 5,
                                  top: 5,
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        path = null;
                                        type = null;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(200),
                                          color: Colors.white),
                                      child: SvgPicture.asset(
                                        Images.cancelImage,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ) : const SizedBox.shrink(),
                            40.verticalSpace(),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: customButton(
                                'Save',
                                onTap: () {
                                  if(description.text.isEmpty) {
                                    showCustomToast(context, 'Description is required');
                                  }else if(path == null) {
                                    showCustomToast(context, 'Video/Image is required');
                                  }else {
                                    BlocProvider.of<DrawerCubit>(context)
                                        .addTestimonials(
                                        context, path!, description.text, type);
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
}
