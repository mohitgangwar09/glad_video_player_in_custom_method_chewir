import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/farmer_screen/common/widegt/project_widget.dart';
import 'package:glad/screen/farmer_screen/dashboard/dashboard_farmer.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Column(
        children: [

          customAppBar('Hello ', 'Abdullah', onTapDrawer: (){
            farmerLandingKey.currentState?.openDrawer();
          }, onTapProfile: (){
            // const FarmerProfile().navigate();
          },drawerVisibility: true),

          25.verticalSpace(),

          Container(
            height: 50,
            margin: 20.marginHorizontal(),
            width: screenWidth(),
            decoration: boxDecoration(
                borderRadius: 62,
                borderColor: const Color(0xffDCDCDC)
            ),
            child: Row(
              children: [

                Expanded(
                  child: Container(
                    height: screenHeight(),
                    margin: const EdgeInsets.all(6),
                    decoration: boxDecoration(
                      backgroundColor: const Color(0xff6A0030),
                      borderRadius: 62
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        "Active".textMedium(color: Colors.white,fontSize: 14),

                        5.horizontalSpace(),

                        SvgPicture.asset(Images.suggestedProject)

                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: Container(
                    height: screenHeight(),
                    margin: const EdgeInsets.all(6),
                    decoration: boxDecoration(
                        backgroundColor: const Color(0xff6A0030),
                        borderRadius: 62
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        "Suggested".textMedium(color: Colors.white,fontSize: 14),

                        5.horizontalSpace(),

                        SvgPicture.asset(Images.activeProject,)

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 120),
              child: customList(child: (int i) {
                return Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: customProjectContainer(child: const ProjectWidget(status: true,),width: screenWidth()),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}