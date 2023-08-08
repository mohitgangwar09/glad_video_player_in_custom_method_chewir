import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/screen/custom_widget/container_border.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield2.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class AddTestimonial extends StatelessWidget {
  const AddTestimonial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          landingBackground(),
          Padding(
            padding: EdgeInsets.only(top: getStatusBarHeight(context)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    arrowBackButton(),
                    Column(
                      children: [
                        Text('Add testimonial',
                            style: figtreeMedium.copyWith(
                                fontWeight: FontWeight.w100,
                                fontSize: 20,
                                color: Colors.black)),
                        Text(
                          'Provide the following details',
                          style: figtreeMedium.copyWith(fontSize: 14),
                        ),
                      ],
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Save',
                          style: figtreeMedium.copyWith(
                              color: ColorResources.maroon, fontSize: 14),
                        )),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const CustomTextField2(
                            title: 'Describe your feelings',
                            hint: 'Write..',
                            maxLine: 7,
                            minLine: 7,
                          ),
                          20.verticalSpace(),
                          Stack(
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
                          20.verticalSpace(),
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                  child: Image.asset(Images.sampleVideo, fit: BoxFit.fitWidth, width: screenWidth(), height: 200,)),
                              Positioned(
                                right: 5,
                                top: 5,
                                child: InkWell(
                                  onTap: () {},
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
                          ),
                          40.verticalSpace(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: customButton(
                              'Save',
                              onTap: () { },
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
