import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/suggested_investment.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';
import 'package:stepper_list_view/stepper_list_view.dart';

class ImprovementAreas extends StatefulWidget {
  const ImprovementAreas({super.key});

  @override
  State<ImprovementAreas> createState() => _ImprovementAreasState();
}

class _ImprovementAreasState extends State<ImprovementAreas> {
  final _stepperData = [
    StepperItemData(
      id: '0',
      content: {
        'title': 'Source of Water Availability',
        'description': 'Dam with Water Tank'
      },
      avatar: Images.waterDrop,
    ),
    StepperItemData(
      id: '1',
      content: {'title': 'Distance to the Source', 'description': '04 KM'},
      avatar: 'dot',
    ),
    StepperItemData(
      id: '2',
      content: {'title': 'Frequency of rounds', 'description': '02'},
      avatar: 'dot',
    ),
    StepperItemData(
      id: '3',
      content: {'title': 'Water cost(monthly)', 'description': 'UGX 1,000'},
      avatar: 'dot',
    ),
    StepperItemData(
      id: '4',
      content: {'title': 'Nature of pasture land', 'description': 'Steep'},
      avatar: 'dot',
    ),
    StepperItemData(
      id: '5',
      content: {'title': 'Total Distance Travelled', 'description': '16 KM'},
      avatar: 'dot',
    ),
    StepperItemData(
      id: '6',
      content: {
        'title': 'Loss of Milk Yield /cow /day',
        'description': '8 Ltr.'
      },
      avatar: 'dot',
    ),
    StepperItemData(
      id: '7',
      content: {
        'title': 'Loss of Milk Yield /cow /day',
        'description': '8 Ltr.'
      },
      avatar: 'dot',
    ),
    StepperItemData(
      id: '8',
      content: {
        'title': 'Loss of Milk Yield /cow /day',
        'description': '8 Ltr.'
      },
      avatar: 'dot',
    ),
    StepperItemData(
      id: '9',
      content: {
        'title': 'Loss of Milk Yield /cow /day',
        'description': '8 Ltr.'
      },
      avatar: 'dot',
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
                titleText1: "Improvement areas",
                action: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: InkWell(
                        onTap: () {},
                        child: SvgPicture.asset(Images.profileEdit))),
                description: 'See the details of 06 improvement areas.',
                leading: arrowBackButton(),
                centerTitle: true,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      30.verticalSpace(),
                      SizedBox(
                        height: screenWidth() * 0.6,
                        child: ListView.separated(
                          itemCount: 10,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(left: index == 0 ? 20.0 : 0),
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16.0),
                                    child: Image.asset(
                                      Images.facilities,
                                      width: screenWidth() * 0.7,
                                      height: screenWidth() * 0.6,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    right: 10,
                                    left: 10,
                                    child: Text(
                                      'Water Facility',
                                      style: figtreeMedium.copyWith(
                                          color: Colors.white, fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return 10.horizontalSpace();
                          },
                        ),
                      ),
                      30.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: 'Survey details'
                            .textMedium(color: Colors.black, fontSize: 18),
                      ),
                      10.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child:
                            'Details captured by dairy development expert (DDE) during the survey of the farm.'
                                .textRegular(color: Colors.black, fontSize: 14),
                      ),
                      20.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: StepperListView(
                                shrinkWrap: true,
                                showStepperInLast: true,
                                stepperData: _stepperData,
                                stepAvatar: (_, data) {
                                  return data.id == '0'
                                      ? PreferredSize(
                                          preferredSize: const Size.fromRadius(3),
                                          child: SizedBox(),
                                        )
                                      : PreferredSize(
                                          preferredSize: const Size.fromRadius(3),
                                          child: Container(
                                            height: 7,
                                            width: 7,
                                            decoration: const BoxDecoration(
                                                color: Color(0xFFDCDCDC),
                                                shape: BoxShape.circle),
                                          ),
                                        );
                                },
                                stepContentWidget: (_, data) {
                                  return Container(
                                    height: 80,
                                    padding: EdgeInsets.only(
                                        left: 40),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(data.content["title"],
                                            style: figtreeRegular.copyWith(
                                                fontSize: 12,
                                                color: ColorResources.fieldGrey)),
                                        10.verticalSpace(),
                                        Text(data.content["description"],
                                            style: figtreeMedium.copyWith(
                                                fontSize: 16, color: Colors.black)),
                                      ],
                                    ),
                                  );
                                },
                                stepperThemeData: const StepperThemeData(
                                    lineWidth: 1, lineColor: Color(0xFFDCDCDC)),
                                physics: const BouncingScrollPhysics(),
                              ),
                            ),
                            Positioned(
                              top: 30,
                                child: SvgPicture.asset(Images.waterDrop)),
                          ],
                        ),
                      ),
                      30.verticalSpace(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: 'Suggested investment'
                            .textMedium(color: Colors.black, fontSize: 18),
                      ),
                      10.verticalSpace(),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: InkWell(
                          onTap: () {
                            const SuggestedInvestment().navigate();
                          },
                          child: customProjectContainer(
                              marginLeft: 0,
                              marginTop: 0,
                              width: screenWidth(),
                              child: Container(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    'Dam Construction'.textMedium(
                                        color: Colors.black, fontSize: 18),
                                    10.verticalSpace(),
                                    'Construct a water tank and water trough in night paddock plus water pump'
                                        .textRegular(
                                            color: Color(0xFF808080),
                                            fontSize: 14),
                                    20.verticalSpace(),
                                    Container(
                                      decoration: BoxDecoration(color: Color(0xFFFFF3F4), borderRadius: BorderRadius.circular(10)),
                                      padding: EdgeInsets.all(20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('UGX 3.2M',
                                                  style: figtreeSemiBold.copyWith(fontSize: 16)),
                                              Text('Investment',
                                                  style: figtreeRegular.copyWith(fontSize: 12, color: Color(0xFF808080))),

                                            ],
                                          ),
                                          10.horizontalSpace(),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('UGX 4.5M',
                                                  style: figtreeSemiBold.copyWith(fontSize: 16)),
                                              Text('Revenue',
                                                  style: figtreeRegular.copyWith(fontSize: 12, color: Color(0xFF808080))),

                                            ],
                                          ),
                                          10.horizontalSpace(),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('40%',
                                                  style: figtreeSemiBold.copyWith(fontSize: 16)),
                                              Text('ROI',
                                                  style: figtreeRegular.copyWith(fontSize: 12, color: Color(0xFF808080))),

                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    20.verticalSpace(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('UGX 2.5M',
                                                style: figtreeMedium.copyWith(fontSize: 12)),
                                            Text('Loan',
                                                style: figtreeRegular.copyWith(fontSize: 12, color: ColorResources.fieldGrey)),

                                          ],
                                        ),
                                        10.horizontalSpace(),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('UGX 700K',
                                                style: figtreeMedium.copyWith(fontSize: 12)),
                                            Text('Farmer share',
                                                style: figtreeRegular.copyWith(fontSize: 12, color: ColorResources.fieldGrey)),

                                          ],
                                        ),
                                        10.horizontalSpace(),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('12 Months',
                                                style: figtreeMedium.copyWith(fontSize: 12)),
                                            Text('Repayment',
                                                style: figtreeRegular.copyWith(fontSize: 12, color: ColorResources.fieldGrey)),

                                          ],
                                        ),
                                        10.horizontalSpace(),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('UGX 200K',
                                                style: figtreeMedium.copyWith(fontSize: 12)),
                                            Text('EMI',
                                                style: figtreeRegular.copyWith(fontSize: 12, color: ColorResources.fieldGrey)),

                                          ],
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              )),
                        ),
                      ),
                      40.verticalSpace()
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
