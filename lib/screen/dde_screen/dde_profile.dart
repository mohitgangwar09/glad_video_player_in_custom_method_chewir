import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class GladProfile extends StatelessWidget {
  const GladProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          landingBackground(),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                arrowBackButton(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        profileImage(),
                        40.verticalSpace(),
                        ratingBar(),
                        profileInputField(),
                        earningCardDetails(),
                        20.verticalSpace(),
                      ],
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

  ///////ProfileInputField//////////
  Widget profileInputField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 0, 30, 0),
      child: Column(
        children: [
          40.verticalSpace(),
          CustomTextField(
            style: figtreeMedium.copyWith(fontSize: 14, color: Colors.black),
            hint: 'Phone',
            leadingImage: Images.textCall,
            imageColors: ColorResources.fieldGrey,
            enabled: true,
            
            withoutBorder: true,
            underLineBorderColor: ColorResources.grey,
          ),
          20.verticalSpace(),
          CustomTextField(
            hint: 'Email',
            leadingImage: Images.emailPhone,
            imageColors: ColorResources.fieldGrey,
            style: figtreeMedium.copyWith(fontSize: 14, color: Colors.black),
            enabled: true,
            
            withoutBorder: true,
            underLineBorderColor: ColorResources.grey,
          ),
          20.verticalSpace(),
          CustomTextField(
            maxLine: 2,
            hint: 'Address',
            leadingImage: Images.textEdit,
            imageColors: ColorResources.fieldGrey,
            style: figtreeMedium.copyWith(fontSize: 14, color: Colors.black),
            enabled: true,
            
            withoutBorder: true,
            underLineBorderColor: ColorResources.grey,
          ),
          40.verticalSpace(),
        ],
      ),
    );
  }

  ///////////EarningCardDetails/////////
  Widget earningCardDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 0, 0),
          child: Text(
            'Earning (30 days)',
            style: figtreeMedium.copyWith(fontSize: 18),
          ),
        ),
        10.verticalSpace(),
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 24, 0),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 152,
                    child: Column(
                      children: [
                        Container(
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Text(
                                      'UGX 3.2M',
                                      style: figtreeBold.copyWith(fontSize: 28),
                                    ),
                                  ),
                                  SvgPicture.asset(Images.arrowPercent)
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 20, 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 82,
                                          height: 38,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 2,
                                                  color: Colors.white),
                                              color: const Color(0xff12CE57),
                                              borderRadius:
                                                  BorderRadius.circular(40)),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                3, 0, 4, 0),
                                            child: Row(
                                              children: [
                                                Icon(Icons.trending_up,
                                                    size: 25),
                                                Text(
                                                  '+5.0%',
                                                  style: figtreeBold.copyWith(
                                                      fontSize: 13),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'Due:',
                                              style: figtreeSemiBold.copyWith(
                                                  fontSize: 14),
                                            ),
                                            05.horizontalSpace(),
                                            Text(
                                              '150K',
                                              style: figtreeSemiBold.copyWith(
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        10.horizontalSpace(),
                                        const CircleAvatar(
                                          radius: 4,
                                          backgroundColor: Colors.black,
                                        ),
                                        10.horizontalSpace(),
                                        Row(
                                          children: [
                                            Text(
                                              'Pending:',
                                              style: figtreeSemiBold.copyWith(
                                                  fontSize: 14),
                                            ),
                                            05.horizontalSpace(),
                                            Text(
                                              '150K',
                                              style: figtreeSemiBold.copyWith(
                                                  fontSize: 14),
                                            )
                                          ],
                                        )
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
                    right: 10,
                    left: 10,
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

/////////RatingBar///////////
  Widget ratingBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 19, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                'Begumanya Charles',
                style: figtreeSemiBold.copyWith(fontSize: 22),
              ),
              RatingBar.builder(
                  initialRating: 0,
                  glowColor: Colors.amber,
                  minRating: 1,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) =>
                      const Icon(Icons.star, color: Color(0xffF6B51D)),
                  onRatingUpdate: (rating) {
                    print(rating);
                  })
            ],
          ),
          SvgPicture.asset(
            Images.silver,
            height: 55,
            width: 55,
          )
        ],
      ),
    );
  }

  /////////ProfileImage////////
  Widget profileImage() {
    return Center(
      child: Stack(
        children: [
          ClipOval(
            clipper: MyClip(),
            child: SizedBox(
              height: 180,
              width: 190,
              child: Image.asset(
                Images.profileDemo,
                fit: BoxFit.fill,
              ),
            ),
          ),
          const Positioned(
              right: 0,
              bottom: 24,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: ColorResources.primary,
                  child: Icon(Icons.camera_alt, color: Colors.white, size: 20),
                ),
              )),
        ],
      ),
    );
  }
}

class MyClip extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(0, 0,
        Platform.isAndroid ? size.width - 20 : size.width - 10, size.height);
  }

  @override
  bool shouldReclip(oldClipper) {
    return false;
  }
}
