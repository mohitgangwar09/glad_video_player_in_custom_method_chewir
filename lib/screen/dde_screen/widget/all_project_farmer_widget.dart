import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:glad/data/model/dde_project_model.dart';
import 'package:glad/screen/custom_widget/circular_percent_indicator.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/dde_screen/project_details.dart';
import 'package:glad/screen/dde_screen/suggested_investment.dart';
import 'package:glad/screen/farmer_screen/common/suggested_project_details.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/images.dart';
import 'package:glad/utils/styles.dart';

class AllProjectFarmerWidget extends StatelessWidget {
  final bool status;
  final String name;
  final String category;
  final String projectStatus;
  final String description;
  final dynamic investment;
  final dynamic revenue;
  final dynamic roi;
  final dynamic loan;
  final dynamic emi;
  final dynamic balance;
  final String farmerName;
  final String farmerImage;
  final String farmerPhone;
  final String farmerAddress;
  final dynamic projectPercent;
  final int projectId;
  final FarmerMaster farmerDetail;

  const AllProjectFarmerWidget({Key? key, required this.status, required this.name, required this.category, required this.projectStatus, required this.description, required this.investment, required this.revenue, required this.roi, required this.loan, required this.emi, required this.balance, required this.farmerName, required this.farmerImage, required this.farmerPhone, required this.farmerAddress, required this.projectPercent,required this.projectId,required this.farmerDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            onTap: () {
              DDeFarmerInvestmentDetails(projectId: projectId,
                // farmerDetail:farmerDetail
              ).navigate();
              /*SuggestedProjectDetails(
                  projectId: projectId,
                  farmerDetail:farmerDetail).navigate();*/
              // const ProjectDetails().navigate();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                name.textMedium(
                  fontSize: 18,
                ),
                5.verticalSpace(),
                category.textMedium(fontSize: 12, color: const Color(0xFF808080)),
                10.verticalSpace(),
                description.textMedium(
                    fontSize: 14, color: const Color(0xFF808080), maxLines: 2),
                15.verticalSpace(),
                Container(
                  height: 60,
                  padding: 20.paddingHorizontal(),
                  decoration: boxDecoration(
                      backgroundColor: const Color(0xffFFF3F4),
                      borderRadius: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getCurrencyString(investment)
                              .textSemiBold(color: Colors.black, fontSize: 16),
                          "Investment".textMedium(
                              fontSize: 12, color: const Color(0xFF808080)),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getCurrencyString(revenue)
                              .textSemiBold(color: Colors.black, fontSize: 16),
                          "Revenue".textMedium(
                              fontSize: 12, color: const Color(0xFF808080)),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "$roi%".textSemiBold(color: Colors.black, fontSize: 16),
                          "ROI".textMedium(
                              fontSize: 12, color: const Color(0xFF808080)),
                        ],
                      ),
                    ],
                  ),
                ),
                20.verticalSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'Loan: ',
                              style: figtreeMedium.copyWith(
                                  fontSize: 12, color: const Color(0xFF808080))),
                          TextSpan(
                              text: getCurrencyString(loan),
                              style: figtreeMedium.copyWith(
                                  fontSize: 12, color: Colors.black))
                        ])),
                    RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'EMI/Mo: ',
                              style: figtreeMedium.copyWith(
                                  fontSize: 12, color: const Color(0xFF808080))),
                          TextSpan(
                              text: getCurrencyString(emi),
                              style: figtreeMedium.copyWith(
                                  fontSize: 12, color: Colors.black))
                        ])),
                    RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'Balance: ',
                              style: figtreeMedium.copyWith(
                                  fontSize: 12, color: const Color(0xFF808080))),
                          TextSpan(
                              text: '$balance%',
                              style: figtreeMedium.copyWith(
                                  fontSize: 12, color: Colors.black))
                        ])),
                  ],
                ),
                // 15.verticalSpace(),
                /*Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width * 0.6,
                      padding: 15.paddingHorizontal(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          networkImage(text: farmerImage,height: 46,width: 46,radius: 40),
                          10.horizontalSpace(),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                farmerName.textMedium(
                                    color: Colors.black,
                                    fontSize: 14,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                                1.verticalSpace(),
                                farmerPhone.textRegular(
                                    fontSize: 12, color: Colors.black),
                                4.verticalSpace(),
                                farmerAddress.textRegular(
                                    fontSize: 12,
                                    color: Colors.black,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    CircularPercentIndicator(
                      radius: 30,
                      percent: 0.25,
                      progressColor: const Color(0xFF12CE57),
                      backgroundColor: const Color(0xFFDCEAE5),
                      center: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: '$projectPercent',
                              style: figtreeBold.copyWith(
                                  color: Colors.black, fontSize: 16)),
                          TextSpan(
                              text: '%\n',
                              style: figtreeBold.copyWith(
                                  color: Colors.black, fontSize: 9)),
                          TextSpan(
                              text: 'completed',
                              style: figtreeBold.copyWith(
                                  color: const Color(0xFF808080), fontSize: 6))
                        ]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    1.horizontalSpace()
                  ],
                ),*/
              ],
            ),
          ),
        ),
        Visibility(
          visible: status,
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: 10.marginAll(),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 7),
              decoration: boxDecoration(
                borderRadius: 30,
                borderColor: const Color(0xff6A0030),
              ),
              child: Text(
                projectStatus,
                textAlign: TextAlign.center,
                style: figtreeMedium.copyWith(
                    color: const Color(0xff6A0030), fontSize: 10),
              ),
            ),
          ),
        )
      ],
    );
  }
}
