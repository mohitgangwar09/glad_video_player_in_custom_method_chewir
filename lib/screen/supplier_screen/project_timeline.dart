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

  final _stepperData = List.generate(10, (index) => StepperItemData(
    id: '$index',
    content: ({
      'name': 'Subhash Chandra Shukla',
      'occupation': 'Flutter Development',
      'mobileNumber': '7318459902',
      'email': 'subhashchandras7318@gmail.com',
      'born_date': '12\nAug',
      "contact_list": {
        "LinkedIn": "https://www.linkedin.com/in/subhashcs/",
        "Portfolio": "https://subhashdev121.github.io/subhash/#/",
      }
    }),
    avatar: 'https://avatars.githubusercontent.com/u/70679949?v=4',
  )).toList();

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
                child:  StepperListView(
                  shrinkWrap: true,
                  showStepperInLast: true,
                  stepperData: _stepperData,
                  stepAvatar: (_, data) {
                    return PreferredSize(
                      preferredSize: const Size.fromRadius(30),
                      child: SvgPicture.asset(Images.timelineApplied),
                    );
                  },
                  stepContentWidget: (_, data) {
                    return  Container(
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
                    );
                  },
                  stepperThemeData: StepperThemeData(
                    // lineColor: theme.primaryColor,
                    lineWidth: 5,
                  ),
                  physics: const BouncingScrollPhysics(),
                ),
              )),
            ],
          )
        ],
      ),
    );
  }
}
