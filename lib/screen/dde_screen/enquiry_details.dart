import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/g_map.dart';
import 'package:glad/screen/dde_screen/dde_farmer_filter.dart';
import 'package:glad/screen/dde_screen/project_widget.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/screen/farmer_screen/profile/farmer_profile.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class EnquiryDetailsScreen extends StatelessWidget {
  const EnquiryDetailsScreen({Key? key}) : super(key: key);

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
                titleText1: 'Enquiry details',
                titleText1Style:
                    figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                centerTitle: true,
                leading: arrowBackButton(),
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: SizedBox(
                                height: 20,
                                width: screenWidth(),
                              ),
                            ),
                            Container(
                              width: screenWidth(),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 20),
                              decoration: const BoxDecoration(
                                  color: Color(0xFFE4FFE3),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(20),
                                      bottomRight: Radius.circular(50),
                                      bottomLeft: Radius.circular(20))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Begumanya Charles',
                                          style: figtreeMedium.copyWith(
                                              fontSize: 18,
                                              color: Colors.black)),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 7, horizontal: 13),
                                        decoration: boxDecoration(
                                          backgroundColor:
                                              const Color(0xFFFFF3F4),
                                          borderRadius: 30,
                                          borderColor: ColorResources.maroon,
                                        ),
                                        child: Text(
                                          "Pending",
                                          textAlign: TextAlign.center,
                                          style: figtreeRegular.copyWith(
                                              color: ColorResources.maroon,
                                              fontSize: 14),
                                        ),
                                      )
                                    ],
                                  ),
                                  10.verticalSpace(),
                                  Text('+256 758711344',
                                      style: figtreeRegular.copyWith(
                                          fontSize: 14, color: Colors.black)),
                                  10.verticalSpace(),
                                  Text(
                                    "Enquiry date: 15 Jan, 2023",
                                    style: figtreeRegular.copyWith(
                                        color: ColorResources.black,
                                        fontSize: 14),
                                  ),
                                  30.verticalSpace(),
                                  Stack(
                                    children: [
                                      const GMap(
                                        lat: 28.4986,
                                        lng: 77.3999,
                                        height: 350,
                                        zoomGesturesEnabled: false,
                                        zoomControlsEnabled: false,
                                        myLocationEnabled: true,
                                        myLocationButtonEnabled: false,
                                      ),
                                      Positioned(
                                        bottom: 20,
                                        left: 30,
                                        right: 30,
                                        child: Container(
                                          height: 105,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                    Images.sampleLivestock),
                                                15.horizontalSpace(),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text('Address',
                                                        style: figtreeMedium
                                                            .copyWith(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black)),
                                                    4.verticalSpace(),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.38,
                                                      child: Text(
                                                        'Plot 11,Luwum St. Rwoozi, Kampala, Uganda 23489 Plot 11,Luwum St. Rwoozi, Kampala, Uganda 23489',
                                                        style: figtreeRegular
                                                            .copyWith(
                                                          fontSize: 14,
                                                          color: Colors.black,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        maxLines: 2,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 10,
                                        top: 10,
                                        child: InkWell(
                                            onTap: () {},
                                            child: SvgPicture.asset(
                                                Images.mapLocate)),
                                      ),
                                    ],
                                  ),
                                  30.verticalSpace(),
                                  'Farmer remarks'.textMedium(
                                      fontSize: 18,
                                      color: ColorResources.fieldGrey),
                                  10.verticalSpace(),
                                  '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'''
                                      .textMedium(
                                          fontSize: 16,
                                          color: ColorResources.black),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                            top: 0,
                            right: 10,
                            child: Row(
                              children: [
                                InkWell(
                                    onTap: () async {
                                      await callOnMobile(234567890);
                                    },
                                    child:
                                        SvgPicture.asset(Images.callPrimary)),
                                6.horizontalSpace(),
                                InkWell(
                                    onTap: () async {
                                      await launchWhatsApp(234567890);
                                    },
                                    child: SvgPicture.asset(Images.whatsapp)),
                                16.horizontalSpace(),
                              ],
                            )),
                      ],
                    ),
                    20.verticalSpace(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: screenWidth(),
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                            color: Color(0xFFFFF3F4),
                            border: Border.all(color: Color(0xFFC788A5)),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                                bottomLeft: Radius.circular(0))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Charles (Farmer)',
                                style: figtreeMedium.copyWith(
                                    fontSize: 20, color: Colors.black)),
                            10.verticalSpace(),
                            Text(
                                '''Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley.''',
                                style: figtreeMedium.copyWith(
                                    fontSize: 16, color: Colors.black)),
                            10.verticalSpace(),
                            '15 Jan, 2023 09:00 AM'.textRegular(
                                color: ColorResources.fieldGrey, fontSize: 14)
                          ],
                        ),
                      ),
                    ),
                    20.verticalSpace()
                  ],
                ),
              )),
              Container(
                height: AppBar().preferredSize.height * 1.5,
                width: screenWidth(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24)),
                    border: Border.all(color: ColorResources.grey)),
                child: Row(
                  children: [
                    const Expanded(
                        child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: 'Followup remarks...'),
                    )),
                    SvgPicture.asset(
                      Images.attachment,
                      colorFilter: ColorFilter.mode(
                          ColorResources.fieldGrey, BlendMode.srcIn),
                    ),
                    10.horizontalSpace(),
                    SvgPicture.asset(
                      Images.camera,
                      colorFilter: ColorFilter.mode(
                          ColorResources.fieldGrey, BlendMode.srcIn),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
