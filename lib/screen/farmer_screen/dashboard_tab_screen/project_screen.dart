import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/farmer_screen/common/widegt/project_widget.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/screen/farmer_screen/profile/farmer_profile.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/helper.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        landingBackground(),
        Column(
          children: [
            CustomAppBar(
              context: context,
              titleText1: 'Projects',
              titleText1Style:
                  figtreeMedium.copyWith(fontSize: 20, color: Colors.black),
              centerTitle: true,
              leading: openDrawer(
                  onTap: () {
                    farmerLandingKey.currentState?.openDrawer();
                  },
                  child: SvgPicture.asset(Images.drawer)),
            ),
            10.verticalSpace(),
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
                          "Active"
                              .textMedium(color: Colors.white, fontSize: 14),
                          5.horizontalSpace(),
                          SvgPicture.asset(Images.activeSelected)
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: screenHeight(),
                      margin: const EdgeInsets.all(6),
                      decoration: boxDecoration(
                          backgroundColor: Colors.white, borderRadius: 62),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          "Suggested".textMedium(
                              color: ColorResources.black, fontSize: 14),
                          5.horizontalSpace(),
                          SvgPicture.asset(
                            Images.completed,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 120, left: 10),
                child: customList(child: (int i) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: customProjectContainer(
                        child: ProjectWidget(
                          showStatus: true,
                          name: 'Dam',
                          targetYield: 10,
                          investment: 10000,
                          revenue: 10000,
                          index: i + 1,
                          incrementalProduction: 180,
                          roi: 40,
                        ),
                        width: screenWidth()),
                  );
                }),
              ),
            )
          ],
        ),
      ],
    );
  }
}
