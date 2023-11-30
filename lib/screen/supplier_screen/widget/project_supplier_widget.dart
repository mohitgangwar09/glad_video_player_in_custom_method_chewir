import 'package:flutter/material.dart';
import 'package:glad/data/model/farmer_profile_model.dart';
import 'package:glad/data/model/supplier_project_model.dart';
import 'package:glad/screen/custom_widget/circular_percent_indicator.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/supplier_screen/project_details.dart';
import 'package:glad/utils/extension.dart';
import 'package:glad/utils/styles.dart';

class ProjectSupplierWidget extends StatelessWidget {
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
  // final FarmerMaster farmerDetail;
  final String selectedFilter;
  final List<FarmerProjectMilestones> milestones;
  // ,required this.farmerDetail
  const ProjectSupplierWidget({Key? key, required this.status, required this.name, required this.category, required this.projectStatus, required this.description, required this.investment, required this.revenue, required this.roi, required this.loan, required this.emi, required this.balance, required this.farmerName, required this.farmerImage, required this.farmerPhone, required this.farmerAddress, required this.projectPercent,required this.projectId,required this.selectedFilter, required this.milestones}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        onTap: () {
          // SurveyDetails(projectId: projectId,selectedFilter:selectedFilter).navigate();
          ProjectDetails(projectId: projectId,selectedFilter:selectedFilter).navigate();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [

                Expanded(child: name.textMedium(
                    fontSize: 18,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis
                ),),
                getCurrencyString(investment)
                    .textSemiBold(color: Colors.black, fontSize: 16),

              ],
            ),
            // 5.verticalSpace(),
            status == false?10.verticalSpace():0.verticalSpace(),
            Row(
              children: [
                category.textMedium(fontSize: 12, color: const Color(0xFF808080)),
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
            ),
            // 10.verticalSpace(),
            status == false?10.verticalSpace():0.verticalSpace(),
            description.textMedium(
                fontSize: 14, color: const Color(0xFF808080), maxLines: 2,
                overflow: TextOverflow.ellipsis),

            20.verticalSpace(),

            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width * 0.6,
                    padding: 15.paddingHorizontal(),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xffFFF3F4)
                    ),
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
                  Builder(
                    builder: (context) {
                      int count = 0;
                      for( FarmerProjectMilestones mile in milestones) {
                        if(mile.milestoneStatus != "pending") {
                          count++;
                        }
                      }
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularPercentIndicator(
                            radius: 30,
                            percent: count / milestones.length,
                            progressColor: const Color(0xFF12CE57),
                            backgroundColor: const Color(0xFFDCEAE5),
                          ),
                          RichText(
                            softWrap: false,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: removeZeroesInFraction(((count / milestones.length) * 100).toString()),
                                  style: figtreeBold.copyWith(
                                      color: Colors.black,
                                      fontSize: 16)),
                              TextSpan(
                                  text: '%\n',
                                  style: figtreeBold.copyWith(
                                      color: Colors.black,
                                      fontSize: 9)),
                              TextSpan(
                                  text: 'completed',
                                  style: figtreeBold.copyWith(
                                      color:
                                      const Color(0xFF808080),
                                      fontSize: 6))
                            ]),
                            textAlign: TextAlign.center,
                          )
                        ],
                      );
                    }
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
