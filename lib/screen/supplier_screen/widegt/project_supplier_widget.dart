import 'package:flutter/material.dart';
import 'package:glad/data/model/dde_project_model.dart';
import 'package:glad/screen/custom_widget/custom_methods.dart';
import 'package:glad/screen/supplier_screen/survey_detail.dart';
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
  final FarmerMaster farmerDetail;
  final String selectedFilter;

  const ProjectSupplierWidget({Key? key, required this.status, required this.name, required this.category, required this.projectStatus, required this.description, required this.investment, required this.revenue, required this.roi, required this.loan, required this.emi, required this.balance, required this.farmerName, required this.farmerImage, required this.farmerPhone, required this.farmerAddress, required this.projectPercent,required this.projectId,required this.farmerDetail,required this.selectedFilter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        onTap: () {
          SurveyDetails(projectId: projectId,selectedFilter:selectedFilter).navigate();

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
                selectedFilter == "completed"?
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
                ):const SizedBox(height: 30,)
              ],
            ),
            // 10.verticalSpace(),
            status == false?10.verticalSpace():0.verticalSpace(),
            description.textMedium(
                fontSize: 14, color: const Color(0xFF808080), maxLines: 2,
            overflow: TextOverflow.ellipsis),

            20.verticalSpace(),

            Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              padding: 15.paddingHorizontal(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffFFF3F4)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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

                  networkImage(text: farmerImage,height: 46,width: 46,radius: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
