import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/screen/farmer_screen/drawer_screen/chat_screen.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class Earnings extends StatelessWidget {
  const Earnings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          landingBackground(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                context: context,
                centerTitle: true,
                titleText1: '',
                titleText1Style:
                    figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                leading: arrowBackButton(),
                action: Row(
                  children: [
                    InkWell(
                        onTap: () {}, child: SvgPicture.asset(Images.filter2)),
                    13.horizontalSpace(),
                    InkWell(
                        onTap: () {}, child: SvgPicture.asset(Images.filter1)),
                    18.horizontalSpace(),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 18.0, right: 18, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: 'My Earnings'.textMedium(
                              fontSize: 14, color: ColorResources.fieldGrey),
                        ),
                        Center(
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                                text: 'UGX',
                                style: figtreeRegular.copyWith(
                                    fontSize: 40, color: Colors.black)),
                            TextSpan(
                                text: ' 3.2M',
                                style: figtreeBold.copyWith(
                                    fontSize: 40, color: Colors.black)),
                          ])),
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
                                child: Container(
                                  height: screenHeight(),
                                  margin: const EdgeInsets.all(6),
                                  decoration: boxDecoration(
                                      backgroundColor: const Color(0xff6A0030),
                                      borderRadius: 62),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      "Earned".textMedium(
                                          color: Colors.white, fontSize: 14),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: screenHeight(),
                                  margin: const EdgeInsets.all(6),
                                  decoration: boxDecoration(
                                      backgroundColor: Colors.white,
                                      borderRadius: 62),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      "Due".textMedium(
                                          color: Colors.black, fontSize: 14),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: screenHeight(),
                                  margin: const EdgeInsets.all(6),
                                  decoration: boxDecoration(
                                      backgroundColor: Colors.white,
                                      borderRadius: 62),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      "Pending".textMedium(
                                          color: Colors.black, fontSize: 14),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        40.verticalSpace(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            'Earnings'.textSemiBold(
                                fontSize: 22, color: ColorResources.black),
                            10.verticalSpace(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                '01/03/2023 - 31/03/2023'.textMedium(
                                    fontSize: 14, color: ColorResources.black),
                                SvgPicture.asset(
                                  Images.calender,
                                  color: Colors.black,
                                )
                              ],
                            ),
                            20.verticalSpace(),
                            Container(
                              padding: EdgeInsets.all(25),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xffDCDCDC)),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: 4,
                                    controller: ScrollController(),
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              'Dam Construction'.textSemiBold(
                                                  fontSize: 18,
                                                  color: ColorResources.black),
                                              '01/03/2023'.textMedium(
                                                  fontSize: 14,
                                                  color: ColorResources.black),
                                            ],
                                          ),
                                          15.verticalSpace(),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(
                                                      Images.sampleUser),
                                                  10.horizontalSpace(),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      'Francesca Doe'
                                                          .textMedium(
                                                              fontSize: 14,
                                                              color:
                                                                  ColorResources
                                                                      .black),
                                                      'Rwoozi, Kampala'
                                                          .textMedium(
                                                              fontSize: 14,
                                                              color:
                                                                  ColorResources
                                                                      .black),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Container(
                                                padding: EdgeInsets.all(12),
                                                decoration: boxDecoration(
                                                    backgroundColor:
                                                        Color(0xFFFFF3F4),
                                                    borderColor:
                                                        Color(0xffF6B51D),
                                                    borderRadius: 40,
                                                    borderWidth: 1),
                                                child: 'UGX 500K'.textBold(
                                                    fontSize: 18,
                                                    color:
                                                        ColorResources.black),
                                              )
                                            ],
                                          ),
                                        ]),
                                    separatorBuilder: (context, index) =>
                                        const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10.0),
                                      child: Divider(),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    child: Divider(),
                                  ),
                                  'Show more'.textSemiBold(
                                      fontSize: 16,
                                      color: ColorResources.maroon,
                                      underLine: TextDecoration.underline),
                                ],
                              ),
                            ),
                            20.verticalSpace(),
                          ],
                        )
                      ],
                    ),
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
