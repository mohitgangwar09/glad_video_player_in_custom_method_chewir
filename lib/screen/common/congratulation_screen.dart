import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';

class CongratulationScreen extends StatelessWidget {
  const CongratulationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(35.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SvgPicture.asset(Images.congratulation),

            15.verticalSpace(),

            "Congratulations!".toString().textMedium(fontSize: 34),

            10.verticalSpace(),

            "The project Dam construction has been approved on behalf of the farmer. Our designated service provider will start the work as per schedule.".textRegular(fontSize: 16,
            textAlign: TextAlign.center),

            const SizedBox(height: 210,
            child: Stack(
              children: [

              ],
            ),),


            "You can track the status of your application from project section.".textRegular(fontSize: 14,textAlign: TextAlign.center),
            40.verticalSpace(),

            customButton("Go to Home", fontColor: 0xffffffff, onTap: () {
             /* if(navigateFrom == "dde"){
                const DashboardDDE(initialNavigateIndex: 0,).navigate(isInfinity: true);
              }else{
                const DashboardFarmer().navigate(isInfinity: true);
              }*/
            })


          ],
        ),
      ),
    );
  }
}
