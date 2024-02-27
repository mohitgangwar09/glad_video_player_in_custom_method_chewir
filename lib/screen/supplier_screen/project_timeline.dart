import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:stepper_list_view/stepper_list_view.dart';

class ProjectTimeline extends StatefulWidget {
  const ProjectTimeline({super.key});

  @override
  State<ProjectTimeline> createState() => _ProjectTimelineState();
}

class _ProjectTimelineState extends State<ProjectTimeline> {
  final _stepperData = [
    StepperItemData(
      id: '1',
      content: {
        'title': 'Applied',
        'description': 'Application submitted by the farmer.',
        'date': '21 Feb, 2023',
        'check': true,
        'status': '',
        'remarks':
            'Construct a water tank and water trough in night paddock plus water pump Construct a water tank and water trough in night Construct a water tank and water trough in night paddock'
      },
      avatar: '',
    ),
    StepperItemData(
      id: '2',
      content: {
        'title': 'Pre-approved',
        'description':
            'Application pre-approved by the Credit Committee and survey is in progress.',
        'date': '21 Feb, 2023',
        'check': true,
        'status': '',
        'remarks':
            'Construct a water tank and water trough in night paddock plus water pump Construct a water tank and water trough in night Construct a water tank and water trough in night paddock'
      },
      avatar: '',
    ),
    StepperItemData(
      id: '3',
      content: {
        'title': 'Survey Completed',
        'description': 'Survey of the site completed by the service provider.',
        'date': '21 Feb, 2023',
        'check': true,
        'status': '',
        'remarks':
            'Construct a water tank and water trough in night paddock plus water pump Construct a water tank and water trough in night Construct a water tank and water trough in night paddock'
      },
      avatar: '',
    ),
    StepperItemData(
      id: '4',
      content: {
        'title': 'Verified',
        'description': 'Details verified and accepted by the farmer.',
        'date': '21 Feb, 2023',
        'check': true,
        'status': '',
        'remarks':
            'Construct a water tank and water trough in night paddock plus water pump Construct a water tank and water trough in night Construct a water tank and water trough in night paddock'
      },
      avatar: '',
    ),
    StepperItemData(
      id: '5',
      content: {
        'title': 'Approved',
        'description': 'Approved by the Credit Committee.',
        'date': '21 Feb, 2023',
        'check': true,
        'status': '',
        'remarks':
            'Construct a water tank and water trough in night paddock plus water pump Construct a water tank and water trough in night Construct a water tank and water trough in night paddock'
      },
      avatar: '',
    ),
    StepperItemData(
      id: '6',
      content: {
        'title': 'Accepted',
        'description': 'Project is active and work is in progress.',
        'date': '21 Feb, 2023',
        'check': true,
        'status': '',
        'remarks':
            'Construct a water tank and water trough in night paddock plus water pump Construct a water tank and water trough in night Construct a water tank and water trough in night paddock'
      },
      avatar: '',
    ),
    StepperItemData(
      id: '7',
      content: <String, dynamic>{
        'title': 'Completed',
        'description': 'Project is completed.',
        'date': '',
        'check': false,
        'status': 'Pending',
        'remarks': '',
      },
      avatar: '',
    ),
  ];

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
                titleText1: 'Project timeline',
                titleText1Style:
                    figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
                centerTitle: true,
                leading: arrowBackButton(),
                description: 'You can check the status below:',
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 10, bottom: 20),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: StepperListView(
                          shrinkWrap: true,
                          showStepperInLast: true,
                          stepperData: _stepperData,
                          stepAvatar: (_, data) {
                            return const PreferredSize(
                              preferredSize: Size.fromRadius(0),
                              child: SizedBox.shrink(),
                            );
                          },
                          stepContentWidget: (_, data) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, bottom: 10),
                              child: Container(
                                height: 110,
                                width: screenWidth(),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    border:
                                        Border.all(color: ColorResources.grey)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(data.content["title"],
                                                  style: figtreeMedium.copyWith(
                                                      fontSize: 18,
                                                      color: ColorResources
                                                          .black)),
                                              5.verticalSpace(),
                                              Text(data.content["description"],
                                                  style:
                                                      figtreeRegular.copyWith(
                                                          fontSize: 12,
                                                          color: ColorResources
                                                              .black)),
                                            ],
                                          ),
                                          data.content['check']
                                              ? Text(data.content["date"],
                                                  style:
                                                      figtreeRegular.copyWith(
                                                          fontSize: 12,
                                                          color: ColorResources
                                                              .black))
                                              : Text(data.content["status"],
                                                  style:
                                                      figtreeRegular.copyWith(
                                                          fontSize: 12,
                                                          color: const Color(
                                                              0xFFFC5E60))),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        data.content['check']
                                            ? Container(
                                                height: 30,
                                                width: 30,
                                                decoration: boxDecoration(
                                                    borderRadius: 8,
                                                    borderColor:
                                                        ColorResources.maroon,
                                                    borderWidth: 2),
                                                child: SvgPicture.asset(
                                                  Images.doneTimelineIcon,
                                                  fit: BoxFit.none,
                                                ),
                                              )
                                            : Container(
                                                height: 30,
                                                width: 30,
                                                decoration: boxDecoration(
                                                    borderRadius: 8,
                                                    borderColor: ColorResources
                                                        .fieldGrey,
                                                    borderWidth: 2),
                                              ),
                                        data.content["check"]
                                            ? 'Remarks'.textRegular(
                                                fontSize: 12,
                                                underLine:
                                                    TextDecoration.underline,
                                                color: ColorResources.maroon)
                                            : const SizedBox.shrink(),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          stepperThemeData: const StepperThemeData(
                              lineWidth: 1, lineColor: Color(0xFFDCDCDC)),
                          physics: const BouncingScrollPhysics(),
                        ),
                      ),
                      for (int count = 0; count < 7; count++)
                        Positioned(
                            top: 120 * count + 65,
                            child: SvgPicture.asset(Images.timelineApplied)),
                    ],
                  ),
                ),
              )),
            ],
          )
        ],
      ),
    );
  }
}
