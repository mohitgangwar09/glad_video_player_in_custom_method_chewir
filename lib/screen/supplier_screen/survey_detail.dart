import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/custom_widget/custom_textfield2.dart';
import 'package:glad/screen/dde_screen/dde_farmer_detail.dart';
import 'package:glad/screen/farmer_screen/common/add_remark.dart';
import 'package:glad/screen/farmer_screen/common/suggested_project_milestone_detail.dart';
import 'package:glad/screen/supplier_screen/accept_screen.dart';
import 'package:glad/screen/supplier_screen/add_milestone.dart';
import 'package:glad/screen/supplier_screen/milestone_detail.dart';
import 'package:glad/screen/supplier_screen/project_timeline.dart';
import 'package:glad/screen/supplier_screen/survey_finished.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

import 'reject_screen.dart';

class SurveyDetails extends StatelessWidget {
  const SurveyDetails({super.key});

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
                titleText1: 'Dam construction',
                leading: arrowBackButton(),
                centerTitle: true,
                titleText1Style:
                    figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        description(),
                        30.verticalSpace(),
                        farmer(context),
                        dde(context),
                        projectMilestones(context),
                        20.verticalSpace(),
                        customShadowContainer(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 12),
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Payment Terms',
                                      style:
                                          figtreeMedium.copyWith(fontSize: 18),
                                    ),
                                    SvgPicture.asset(Images.drop)
                                  ],
                                ),
                              ),
                              20.verticalSpace(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 14),
                                decoration: BoxDecoration(
                                    color: const Color(0xFFE4FFE3),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Advance',
                                      style:
                                          figtreeMedium.copyWith(fontSize: 16),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: Text(
                                        '20%',
                                        style: figtreeMedium.copyWith(
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              10.verticalSpace(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 14),
                                decoration: BoxDecoration(
                                    color: const Color(0xFFE4FFE3),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Advance',
                                      style:
                                          figtreeMedium.copyWith(fontSize: 16),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: Text(
                                        '20%',
                                        style: figtreeMedium.copyWith(
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              10.verticalSpace(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 14),
                                decoration: BoxDecoration(
                                    color: const Color(0xFFE4FFE3),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Advance',
                                      style:
                                          figtreeMedium.copyWith(fontSize: 16),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: Text(
                                        '20%',
                                        style: figtreeMedium.copyWith(
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              10.verticalSpace(),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 14),
                                decoration: BoxDecoration(
                                    color: const Color(0xFFE4FFE3),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Advance',
                                      style:
                                          figtreeMedium.copyWith(fontSize: 16),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      child: Text(
                                        '20%',
                                        style: figtreeMedium.copyWith(
                                            fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                        20.verticalSpace(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35.0),
                          child: Text(
                            'This survey is required to be completed before 16 June, 2023.',
                            style: figtreeMedium.copyWith(fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                  margin: 18.marginAll(),
                                  height: 55,
                                  width: screenWidth(),
                                  child: customButton("Reject",
                                      fontColor: 0xffffffff,
                                      color: 0xff999999,
                                      onTap: () {
                                        modalBottomSheetMenu(context,
                                            radius: 40,
                                            child: SizedBox(
                                              height: 320,
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(23, 40, 25, 10),
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Center(
                                                        child: Text(
                                                          'Remarks',
                                                          style: figtreeMedium.copyWith(fontSize: 22),
                                                        ),
                                                      ),
                                                      30.verticalSpace(),
                                                      TextField(
                                                        maxLines: 4,
                                                        minLines: 4,
                                                        decoration: InputDecoration(
                                                            hintText: 'Write...',
                                                            hintStyle:
                                                            figtreeMedium.copyWith(fontSize: 18),
                                                            border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(12),
                                                                borderSide: const BorderSide(
                                                                  width: 1,
                                                                  color: Color(0xff999999),
                                                                ))),
                                                      ),
                                                      30.verticalSpace(),
                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(28, 0, 29, 0),
                                                        child: customButton(
                                                          'Submit',
                                                          fontColor: 0xffFFFFFF,
                                                          onTap: () {
                                                            const RejectScreen().navigate();
                                                          },
                                                          height: 60,
                                                          width: screenWidth(),
                                                        ),
                                                      )
                                                    ]),
                                              ),
                                            ));
                                      })),
                            ),
                            Expanded(
                              child: Container(
                                  margin: 18.marginAll(),
                                  height: 55,
                                  width: screenWidth(),
                                  child: customButton("Accept",
                                      fontColor: 0xffffffff, onTap: () {
                                        modalBottomSheetMenu(context,
                                            radius: 40,
                                            child: SizedBox(
                                              height: 320,
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(23, 40, 25, 10),
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Center(
                                                        child: Text(
                                                          'Remarks',
                                                          style: figtreeMedium.copyWith(fontSize: 22),
                                                        ),
                                                      ),
                                                      30.verticalSpace(),
                                                      TextField(
                                                        maxLines: 4,
                                                        minLines: 4,
                                                        decoration: InputDecoration(
                                                            hintText: 'Write...',
                                                            hintStyle:
                                                            figtreeMedium.copyWith(fontSize: 18),
                                                            border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(12),
                                                                borderSide: const BorderSide(
                                                                  width: 1,
                                                                  color: Color(0xff999999),
                                                                ))),
                                                      ),
                                                      30.verticalSpace(),
                                                      Padding(
                                                        padding: const EdgeInsets.fromLTRB(28, 0, 29, 0),
                                                        child: customButton(
                                                          'Submit',
                                                          fontColor: 0xffFFFFFF,
                                                          onTap: () {
                                                            const AcceptScreen().navigate();
                                                          },
                                                          height: 60,
                                                          width: screenWidth(),
                                                        ),
                                                      )
                                                    ]),
                                              ),
                                            ));
                                      })),
                            )
                          ],
                        ),
                        Center(
                          child: customButton("Submit Survey",
                              fontColor: 0xffffffff, onTap: () {
                                modalBottomSheetMenu(context,
                                    radius: 40,
                                    child: SizedBox(
                                      height: 320,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(23, 40, 25, 10),
                                        child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                child: Text(
                                                  'Remarks',
                                                  style: figtreeMedium.copyWith(fontSize: 22),
                                                ),
                                              ),
                                              30.verticalSpace(),
                                              TextField(
                                                maxLines: 4,
                                                minLines: 4,
                                                decoration: InputDecoration(
                                                    hintText: 'Write...',
                                                    hintStyle:
                                                    figtreeMedium.copyWith(fontSize: 18),
                                                    border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(12),
                                                        borderSide: const BorderSide(
                                                          width: 1,
                                                          color: Color(0xff999999),
                                                        ))),
                                              ),
                                              30.verticalSpace(),
                                              Padding(
                                                padding: const EdgeInsets.fromLTRB(28, 0, 29, 0),
                                                child: customButton(
                                                  'Submit',
                                                  fontColor: 0xffFFFFFF,
                                                  onTap: () {
                                                    const SurveyFinishedScreen().navigate();
                                                  },
                                                  height: 60,
                                                  width: screenWidth(),
                                                ),
                                              )
                                            ]),
                                      ),
                                    ));
                              }),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                Images.messageChat,
                width: 100,
                height: 100,
              ))
        ],
      ),
    );
  }

///////DescriptionDetails///////////
  Widget description() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Description',
              style: figtreeMedium.copyWith(fontSize: 18),
            ),
            05.horizontalSpace(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
              decoration: boxDecoration(
                borderWidth: 1,
                borderRadius: 30,
                borderColor: const Color(0xff6A0030),
              ),
              child: Text(
                "Processing",
                textAlign: TextAlign.center,
                style: figtreeMedium.copyWith(
                    color: const Color(0xff6A0030), fontSize: 10),
              ),
            )
          ],
        ),
        10.verticalSpace(),
        ExpandableText(
          'Construct a water tank and water trough in night paddock plus water pump Construct a water tank and water trough in night Construct a water tank and water trough in night paddock plus water pump Construct a water tank and water trough in night paddock plus water pump Construct a water tank and water trough in pump',
          expandText: 'Read More',
          linkColor: ColorResources.maroon,
          style: figtreeMedium.copyWith(fontSize: 14),
          collapseText: 'Show Less',
        ),
        10.verticalSpace(),
        customProjectContainer(
            width: screenWidth(),
            marginTop: 10,
            marginLeft: 0,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: 'Project Value: ',
                        style: figtreeRegular.copyWith(
                            color: ColorResources.fieldGrey, fontSize: 18)),
                    TextSpan(
                        text: 'UGX 2.2M',
                        style: figtreeBold.copyWith(
                            color: ColorResources.black, fontSize: 18)),
                  ])),
                ],
              ),
            ))
      ],
    );
  }

///////////DDEContainerTimeline/////////////
  Widget dde(context) {
    return Column(
      children: [
        Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(height: 150, width: screenWidth()),
                Container(
                  height: 100,
                  width: screenWidth(),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: ColorResources.grey)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 20, 0, 10),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(Images.sampleUser),
                            15.horizontalSpace(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Begumanya Charles',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 16, color: Colors.black)),
                                10.verticalSpace(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Icon(
                                      Icons.call,
                                      color: Colors.black,
                                      size: 16,
                                    ),
                                    Text('+256 758711344',
                                        style: figtreeRegular.copyWith(
                                            fontSize: 12, color: Colors.black)),
                                  ],
                                ),
                                4.verticalSpace(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.black,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      child: Text(
                                        'Plot 11, street 09, Luwum St. Rwooz Plot 11, street 09, Luwum St. Rwooz',
                                        style: figtreeRegular.copyWith(
                                          fontSize: 12,
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                    top: -5,
                    left: 0,
                    child: Text(
                      'DDE',
                      style: figtreeMedium.copyWith(fontSize: 20),
                    )),
                Positioned(
                    top: 0,
                    right: 10,
                    child: Row(
                      children: [
                        SvgPicture.asset(Images.callPrimary),
                        6.horizontalSpace(),
                        SvgPicture.asset(Images.whatsapp),
                        6.horizontalSpace(),
                        SvgPicture.asset(Images.redirectLocation),
                        6.horizontalSpace(),
                      ],
                    )),
                Positioned(
                    bottom: -2,
                    child: InkWell(
                      onTap: () {
                        // const ProjectTimeline().navigate();
                      },
                      child: Text(
                        'View Timeline',
                        style: figtreeSemiBold.copyWith(
                            fontSize: 14,
                            color: ColorResources.maroon,
                            decoration: TextDecoration.underline,
                            decorationColor: ColorResources.maroon,
                            decorationThickness: 3.0),
                      ),
                    ))
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget farmer(context) {
    return InkWell(
      onTap: () {},
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(height: 150, width: screenWidth()),
          Container(
            height: 100,
            width: screenWidth(),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: ColorResources.grey)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 20, 0, 10),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(Images.sampleUser),
                      15.horizontalSpace(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Begumanya Charles',
                              style: figtreeMedium.copyWith(
                                  fontSize: 16, color: Colors.black)),
                          10.verticalSpace(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.call,
                                color: Colors.black,
                                size: 16,
                              ),
                              Text('+256 758711344',
                                  style: figtreeRegular.copyWith(
                                      fontSize: 12, color: Colors.black)),
                            ],
                          ),
                          4.verticalSpace(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.black,
                                size: 16,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width *
                                    0.5,
                                child: Text(
                                  'Plot 11, street 09, Luwum St. Rwooz Plot 11, street 09, Luwum St. Rwooz',
                                  style: figtreeRegular.copyWith(
                                    fontSize: 12,
                                    color: Colors.black,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: -5,
              left: 0,
              child: Text(
                'Farmer',
                style: figtreeMedium.copyWith(fontSize: 20),
              )),
          Positioned(
              top: 0,
              right: 10,
              child: Row(
                children: [
                  SvgPicture.asset(Images.callPrimary),
                  6.horizontalSpace(),
                  SvgPicture.asset(Images.whatsapp),
                  6.horizontalSpace(),
                  SvgPicture.asset(Images.redirectLocation),
                  6.horizontalSpace(),
                ],
              ))
        ],
      ),
    );
  }

  ///////////ProjectMilestones///////////
  Widget projectMilestones(context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      30.verticalSpace(),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Project milestones',
            style: figtreeMedium.copyWith(fontSize: 18),
          ),
          InkWell(
            onTap: () {
              const AddMilestone().navigate();
            },
              child: SvgPicture.asset(Images.add))
        ],
      ),
      15.verticalSpace(),
      InkWell(
        onTap: () {
          const MilestoneDetail().navigate();
        },
        child: customList(
            axis: Axis.vertical,
            child: (int index) {
              return Padding(
                padding: const EdgeInsets.only(
                  bottom: 20,
                ),
                child: customShadowContainer(
                    margin: 0,
                    backColor: ColorResources.grey,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Installation of water tank...',
                                style: figtreeMedium.copyWith(fontSize: 18),
                              ),
                              SvgPicture.asset(Images.cross)
                            ],
                          ),
                          Text(
                            '05 tasks included in this milestone.',
                            style: figtreeMedium.copyWith(fontSize: 12),
                          ),
                          20.verticalSpace(),
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Value',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 12,
                                        color: ColorResources.fieldGrey),
                                  ),
                                  Text(
                                    'UGX 600K',
                                    style: figtreeSemiBold.copyWith(
                                        fontSize: 16,
                                        color: ColorResources.maroon),
                                  )
                                ],
                              ),
                              40.horizontalSpace(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Duration',
                                    style: figtreeMedium.copyWith(
                                        fontSize: 12,
                                        color: ColorResources.fieldGrey),
                                  ),
                                  Text(
                                    '12 Days',
                                    style: figtreeSemiBold.copyWith(
                                        fontSize: 16,
                                        color: ColorResources.black),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
              );
            }),
      ),
    ]);
  }
}
