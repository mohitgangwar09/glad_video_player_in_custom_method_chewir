import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/widget/add_remark_loan_approval.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/styles.dart';

import 'add_remark_confirm_loan.dart';
import '../../../data/model/farmer_project_detail_model.dart';

class TermsAndCondition extends StatelessWidget {
  FarmerMaster projectData;
  final int farmerProjectId;
  final String navigateFrom;
  TermsAndCondition({super.key,required this.projectData,required this.farmerProjectId,required this.navigateFrom});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            context: context,
            titleText1: 'Terms and conditions',
            leading: arrowBackButton(),
            centerTitle: true,
            titleText1Style: figtreeMedium.copyWith(
                fontSize: 20, color: Colors.black),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(25),
              child: Column(
                children: [

                  Align(
                    alignment: Alignment.centerLeft,
                    child: "Lorem Ipsum is simply dummy".textMedium(fontSize: 18,color: Colors.black),
                  ),

                  8.verticalSpace(),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: "Lorem Ipsum is simply dummy text Construct a water tank and water trough in night paddock plus water pump Construct a water tank and water trough in night Construct a water tank and water trough in night paddock plus water pump Construct a water tank and water trough in night paddock plus water pump Construct a water tank and water trough in pump.".textMedium(fontSize: 14,color: Colors.black),
                  ),

                  35.verticalSpace(),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: "Lorem Ipsum is simply dummy".textMedium(fontSize: 18,color: Colors.black),
                  ),

                  8.verticalSpace(),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: "Lorem Ipsum is simply dummy text Construct a water tank and water trough in night paddock plus water pump Construct a water tank and water trough in night Construct a water tank and water trough in night paddock plus water pump Construct a water tank and water trough in night paddock plus water pump Construct a water tank and water trough in pump.".textMedium(fontSize: 14,color: Colors.black),
                  ),

                  35.verticalSpace(),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: "Lorem Ipsum is simply dummy".textMedium(fontSize: 18,color: Colors.black),
                  ),

                  8.verticalSpace(),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: "Lorem Ipsum is simply dummy text Construct a water tank and water trough in night paddock plus water pump Construct a water tank and water trough in night Construct a water tank and water trough in night paddock plus water pump Construct a water tank and water trough in night paddock plus water pump Construct a water tank and water trough in pump. Lorem Ipsum is simply dummy text Construct a water tank and water trough in night paddock plus water pump Construct a water tank and water trough in night Construct a water tank.Water trough in night paddock plus water pump Construct a water tank and water trough in night paddock plus water pump Construct a water tank and water trough in pump.Water trough in night paddock plus water pump Construct a water tank and water trough in night paddock plus water pump Construct a water tank and water trough in pump.Water trough in night paddock plus water pump Construct a water tank and water trough in night.".textMedium(fontSize: 14,color: Colors.black),
                  ),

                  20.verticalSpace(),

                  SwipeButton(
                    width: 287,
                    // trackPadding: EdgeInsets.all(6),
                    activeTrackColor: const Color(0xff6A0030),
                    activeThumbColor: const Color(0xffFC5E60),
                    // elevationThumb: 2,
                    child: Text(
                      "Swipe right to agree!",
                      style: figtreeMedium.copyWith(
                        fontSize: 16,
                        color: Colors.white
                      )
                    ),
                    onSwipe: () {
                      AddRemarkLoanApproval(projectData: projectData,farmerProjectId:farmerProjectId,navigateFrom: navigateFrom).navigate();
                      /*ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Swipped"),
                          backgroundColor: Colors.green,
                        ),
                      );*/
                    },
                  )

                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}
