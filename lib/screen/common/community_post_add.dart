import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/screen/custom_widget/container_border.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield2.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class CommunityPostAdd extends StatelessWidget {
  const CommunityPostAdd({super.key});

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
                titleText1: 'Add New Post',
                titleText1Style:
                figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                centerTitle: true,
                leading: arrowBackButton(),
              ),
              listviewDetails(),
            ],
          ),
        ],
      ),
    );
  }

  Widget listviewDetails() {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              20.verticalSpace(),
              const CustomTextField2(
                title: 'What do you want to talk about...',
                hint: 'Write..',
                maxLine: 7,
                minLine: 7,
              ),
              20.verticalSpace(),
              Row(
                children: [
                  5.horizontalSpace(),
                  'Add Photo (s)'.textMedium(color: Colors.black, fontSize: 12),
                ],
              ),
              5.verticalSpace(),
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
                                          text: 'Choose ',
                                          style: figtreeMedium.copyWith(
                                              fontSize: 16,
                                              color:
                                              const Color(0xFFFC5E60))),
                                      TextSpan(
                                          text: 'your file here',
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
              40.verticalSpace(),
              customButton('Post', onTap: (){}, fontColor: 0xFFFFFFFF, width: screenWidth(), height: 60)
            ],
          ),
        ),
      ),
    );
  }
}
