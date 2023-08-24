import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/color_resources.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

import 'application_widget.dart';

class ApplicationScreen extends StatelessWidget {
  const ApplicationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        landingBackground(),
        Column(
          children: [

            CustomAppBar(
              context: context,
              titleText1: 'Loan Applications',
              titleText1Style: figtreeMedium.copyWith(
                  fontSize: 20, color: Colors.black),
              centerTitle: true,
              leading: openDrawer(
                  onTap: () {
                    // farmerLandingKey.currentState?.openDrawer();
                  },
                  child: SvgPicture.asset(Images.arrowBack)),
            ),

            10.verticalSpace(),


            Container(
              height: 50,
              margin: 20.marginHorizontal(),
              width: screenWidth(),
              decoration: boxDecoration(
                  borderRadius: 62,
                  borderColor: const Color(0xffDCDCDC),
                backgroundColor: Colors.white
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

                          "Pending".textMedium(color: Colors.white,fontSize: 14),

                          5.horizontalSpace(),

                          SvgPicture.asset(Images.pendingSelected)

                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      height: screenHeight(),
                      margin: const EdgeInsets.all(6),
                      decoration: boxDecoration(
                          backgroundColor: Colors.white,
                          borderRadius: 62
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          "Approved".textMedium(color: Colors.black,fontSize: 14),

                          5.horizontalSpace(),

                          SvgPicture.asset(Images.completed,)

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 120.0),
                  child: customList(child: (index){
                    return const Padding(
                      padding: EdgeInsets.only(right: 20.0,left: 10),
                      child: MCCApplicationScreen(bottom: 25,),
                    );}),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
