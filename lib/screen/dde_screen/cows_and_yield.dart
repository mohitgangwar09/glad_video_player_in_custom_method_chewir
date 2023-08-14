import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class CowsAndYield extends StatelessWidget {
  const CowsAndYield({super.key});

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
                titleText1: 'Cows and Yield',
                leading: arrowBackButton(),
                centerTitle: true,
                description: 'Provide the following details',
                action: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Save',
                    style: figtreeMedium.copyWith(
                        fontSize: 14, color: ColorResources.maroon),
                  ),
                ),
                titleText1Style:
                    figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
              ),
              Column(
                children: [
                  addMore(),
                  addMoreCard(),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget addMore() {
    return Column(
      children: [
        50.verticalSpace(),
        customButton('+ Add More',
            height: 60,
            width: 200,
            onTap: () {},
            color: 0xffFFFFFF,
            borderColor: 0xff6A0030,
            fontColor: 0xff6A0030),
      ],
    );
  }

  Widget addMoreCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        10.verticalSpace(),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 13, 0),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 150,
                    child: Column(
                      children: [
                        Container(
                          width: screenWidth(),
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(.100),
                                blurRadius: 15),
                          ]),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            color: const Color(0xffFFB300),
                            child: Column(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 15, 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'Mar, 2023',
                                          style: figtreeBold.copyWith(
                                              fontSize: 18),
                                        ),
                                        05.horizontalSpace(),
                                        const Icon(
                                          Icons.keyboard_arrow_down,
                                          size: 30,
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              ExpansionTile(
                                                title: Text('cjnn'),
                                                children: [
                                                  Column(
                                                    children: [
                                                      Text('vnjcncvaxdn')
                                                    ],
                                                  )
                                                ],
                                                onExpansionChanged: (isEpanded){}
                                              );
                                            },
                                            child: SvgPicture.asset(
                                              Images.less1,
                                              height: 40,
                                              width: 40,
                                            )),
                                        10.horizontalSpace(),
                                        SvgPicture.asset(
                                          Images.deleteCows,
                                          height: 40,
                                          width: 40,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              10.verticalSpace(),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 10, 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '23',
                                              style: figtreeSemiBold.copyWith(
                                                  fontSize: 18),
                                            ),
                                            Text(
                                              'Herd Size',
                                              style: figtreeMedium.copyWith(
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                        05.horizontalSpace(),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '3800 Ltr.',
                                              style: figtreeSemiBold.copyWith(
                                                  fontSize: 18),
                                            ),
                                            Text(
                                              'Production',
                                              style: figtreeMedium.copyWith(
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                        05.horizontalSpace(),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '16',
                                              style: figtreeSemiBold.copyWith(
                                                  fontSize: 18),
                                            ),
                                            Text(
                                              'Milking Cows',
                                              style: figtreeMedium.copyWith(
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                        05.horizontalSpace(),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '8 Ltr.',
                                              style: figtreeSemiBold.copyWith(
                                                  fontSize: 18),
                                            ),
                                            Text(
                                              'Yield/day',
                                              style: figtreeMedium.copyWith(
                                                  fontSize: 12),
                                            )
                                          ],
                                        ),
                                        05.horizontalSpace(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 25,
                    left: 25,
                    child: SvgPicture.asset(Images.cardImage),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
