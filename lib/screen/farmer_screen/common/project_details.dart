import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/styles.dart';

import '../../../utils/images.dart';
import '../../extra_screen/navigation.dart';

class ProjectDetails extends StatelessWidget {
  const ProjectDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          landingBackground(),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Center(
                      child: Text(
                        'Dam construction',
                        style: figtreeMedium.copyWith(fontSize: 22),
                      ),
                    ),
                    Positioned(
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back))),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            description(),
                            30.verticalSpace(),
                            dde(context),
                            kpi(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                "Applied",
                textAlign: TextAlign.center,
                style: figtreeMedium.copyWith(
                    color: const Color(0xff6A0030), fontSize: 10),
              ),
            )
          ],
        ),
        10.verticalSpace(),
        RichText(
            text: TextSpan(children: [
          TextSpan(
              text:
                  'Construct a water tank and water trough in night paddock plus water pump Construct a water tank and water trough in night Construct a water tank and water trough in night paddock plus water pump Construct a water tank and water trough in night paddock plus water pump Construct a water tank and water trough in pump...',
              style: figtreeMedium.copyWith(
                  fontSize: 14, color: ColorResources.black)),
          TextSpan(
              text: 'read more',
              style: figtreeMedium.copyWith(
                  fontSize: 14, color: ColorResources.maroon))
        ])),
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
                      ],
                    )),
                Positioned(
                    bottom: -2,
                    child: Text(
                      'View Timeline',
                      style: figtreeSemiBold.copyWith(
                          fontSize: 14,
                          color: ColorResources.maroon,
                          decoration: TextDecoration.underline,
                          decorationColor: ColorResources.maroon,
                          decorationThickness: 3.0),
                    ))
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget kpi(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "KPI's",
          style: figtreeMedium.copyWith(
            fontSize: 18,
          ),
        ),
        customGrid(
            context,
            list: [1,2,3,4,5,6,7],
            crossAxisCount: 3,
            mainAxisExtent: 140,
            crossAxisSpacing:0,
            child: (int index) {
          return customProjectContainer(
            width: screenWidth(),
              child: Column());
        })
      ],
    );
  }
}
