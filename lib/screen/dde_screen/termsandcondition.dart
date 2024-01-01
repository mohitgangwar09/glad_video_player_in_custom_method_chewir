import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:glad/screen/custom_widget/custom_appbar.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/widget/add_remark_loan_approval.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/styles.dart';

import 'add_remark_confirm_loan.dart';
import '../../../data/model/farmer_project_detail_model.dart';

class TermsAndCondition extends StatefulWidget {
  FarmerMaster projectData;
  final int farmerProjectId;
  final String navigateFrom;
  TermsAndCondition({super.key,required this.projectData,required this.farmerProjectId,required this.navigateFrom});

  @override
  State<TermsAndCondition> createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {

  bool swipe = false;

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

                  // swipe == false?
                  SwipeButton(
                    width: 287,
                    // trackPadding: EdgeInsets.all(6),
                    activeTrackColor: swipe ? const Color(0xffF6B51D) :const Color(0xff6A0030),
                    activeThumbColor: swipe ? Colors.white :const Color(0xffFC5E60),
                    // elevationThumb: 2,
                    child: swipe ? Text(
                        "I agree!",
                        style: figtreeMedium.copyWith(
                            fontSize: 16,
                            color: Colors.black
                        )
                    ) : Text(
                        "Swipe right to agree!",
                        style: figtreeMedium.copyWith(
                            fontSize: 16,
                            color: Colors.white
                        )
                    ),
                    onSwipe: () {
                      setState(() {
                        swipe = true;
                      });
                      Future.delayed(const Duration(milliseconds: 80), () {
                        AddRemarkLoanApproval(projectData: widget.projectData,farmerProjectId:widget.farmerProjectId,navigateFrom: widget.navigateFrom).navigate();
                      });

                      /*ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Swipped"),
                          backgroundColor: Colors.green,
                        ),
                      );*/
                    },
                  )
                  //     :
                  // InkWell(
                  //   onTap: (){
                  //     AddRemarkLoanApproval(projectData: widget.projectData,farmerProjectId:widget.farmerProjectId,navigateFrom: widget.navigateFrom).navigate();
                  //   },
                  //   child: Stack(
                  //     children: [
                  //       Container(
                  //         height: 58,
                  //         width: 300,
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(100),
                  //             color: const Color(0xffF6B51D)
                  //         ),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.end,
                  //           children: [
                  //             Container(
                  //               height: 52,
                  //               width: 55,
                  //               decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(100),
                  //                   color: Colors.white
                  //               ),
                  //               child: const Icon(Icons.arrow_forward),
                  //             ),
                  //             3.horizontalSpace()
                  //           ],
                  //         ),
                  //       ),
                  //       const SizedBox(width: 300,height:58,child: Center(child: Text("I agree!")))
                  //     ],
                  //   ),
                  // ),

                  /*SwipeButton.expand(
                    thumb: Icon(
                      Icons.double_arrow_rounded,
                      color: Colors.white,
                    ),
                    child: Text(
                      "Swipe to ...",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    activeThumbColor: Colors.red,
                    activeTrackColor: Colors.grey.shade300,
                    onSwipe: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Swipped"),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                  ),
*/

                  /*swipe == false?
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
                      *//*setState(() {
                        swipe = true;
                      });*//*
                      AddRemarkLoanApproval(projectData: projectData,farmerProjectId:farmerProjectId,navigateFrom: navigateFrom).navigate();
                      *//*ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Swipped"),
                          backgroundColor: Colors.green,
                        ),
                      );*//*
                    },
                  ):
                      Container(
                        height: 58,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          color: const Color(0xffF6B51D)
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.white
                              ),
                              child: const Icon(Icons.arrow_forward),
                            ),
                          ],
                        ),
                      )*/

                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}
